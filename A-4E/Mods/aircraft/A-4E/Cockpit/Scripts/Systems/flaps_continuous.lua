-- "continuous" flaps behavior, dofile() via flaps.lua
--
-- behavior documentation: NAVAIR 01-40AVC-1 section 1-30, 15 July 1969, "WING FLAPS"
-- flap blowback begins at 230kts IAS to prevent structural damage
--
-- design summary:
--   single key press for Up/Down starts motion, and a 2nd keypress of any flap command stops movement of the flaps
--   flaps takeoff command will begin a movement towards 50% extension as a shortcut
--   full extension (100%) through full retraction (0%)
--   executing Flaps Up/Down command moves to the other extreme position, alternate direction on next movement
--   if flaps were stopped manually, next Flaps Up/Down will continue in the direction they were moving before the stop

local dev = GetSelf()

local update_time_step = 0.006  -- ~166.667Hz matches AFM dll per SilentEagle
make_default_activity(update_time_step)

local sensor_data = get_base_data()  

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local Flaps  = 72 -- This is the number of the command from command_defs
local FlapsOn = 145
local FlapsOff = 146
local FlapsStop = Keys.PlaneFlapsStop
local FlapsTakeoff = Keys.PlaneFlapsTakeoff

local FlapExtensionTimeSeconds = 6      -- flaps take 6 seconds to extend/retract fully

--Creating local variables
local FLAPS_STATE	=	0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "current" flap position		
local FLAPS_TARGET  =   0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "future" flap position
local FLAPS_TARGET_LAST = 0
local MOVING = 0          -- 1 = we "want" movement to a new position

local FLAP_MAX_DEFLECTION = 50
local FLAP_BLOWBACK_PSI = 3650

dev:listen_command(Flaps)
dev:listen_command(FlapsOn)
dev:listen_command(FlapsOff)
dev:listen_command(FlapsStop)
dev:listen_command(FlapsTakeoff)


-- utility function, returns the effective frontal area ratio of the flap based on the animation state
function CalcFrontalAreaRatio(flap_state)
    local sin = 0
    local area = 0

    sin = math.sin( math.rad(flap_state * FLAP_MAX_DEFLECTION) )
    area = sin*sin -- frontal area = sin^2(theta)
    return area
end


-- utility function, based on openoffice table, calibrated to 3650psi at 230kts, blowback trigger point per NAVAIR manual
function RelativePressureOnFlaps(flap_state)
    local a = CalcFrontalAreaRatio(flap_state)
    local k = 8.504932 -- calculated ratio of v^2*a to 3650 (valve pressure limit) that initiates valve relief in A4 flap actuator
    local valve_pressure = 0

    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    valve_pressure = ias_knots * ias_knots * a / k
    return valve_pressure
end


function SetCommand(command,value)			
    if MOVING == 1 or command == FlapsStop then
        FLAPS_TARGET = FLAPS_STATE  -- halt movement on any new command
        FLAPS_TARGET_LAST = -1  -- special case for an explicit "halt"
        MOVING = 0
    else
        MOVING = 1
        if (command == Flaps) then
            if FLAPS_TARGET_LAST == 0 then
                FLAPS_TARGET = 1
            elseif FLAPS_TARGET_LAST == 1 then
                FLAPS_TARGET = 0
            elseif FLAPS_TARGET_LAST == -1 then
                -- flaps were explicitly stopped previously, next movement will be "retract"
                FLAPS_TARGET = 0
                FLAPS_TARGET_LAST = 1
            end
        elseif (command == FlapsOn) then
    		FLAPS_TARGET = 1        -- force to extension direction
            FLAPS_TARGET_LAST = 0
    	elseif (command == FlapsOff) then
    		FLAPS_TARGET = 0        -- force to retraction direction
            FLAPS_TARGET_LAST = 1
        elseif (command == FlapsTakeoff) then
            FLAPS_TARGET = 0.5
            if FLAPS_TARGET > FLAPS_STATE then
                FLAPS_TARGET_LAST = 0 -- coming from a more-retracted position
            elseif FLAPS_TARGET <= FLAPS_STATE then -- use <= incase they command takeoff while already in takeoff, next movement will be "retract"
                FLAPS_TARGET_LAST = 1 -- coming from a more-extended position
            end
        end
    end
end


function update()		
	local flaps_increment = update_time_step / FlapExtensionTimeSeconds -- sets the speed of flap animation
    local delta
    
    -- first test for velocity limit which triggers at ~230kts IAS
    if RelativePressureOnFlaps(FLAPS_STATE) > FLAP_BLOWBACK_PSI then
        FLAPS_STATE = FLAPS_STATE - flaps_increment -- force flaps in if too much pressure on them
    -- make primary adjustment if needed
    elseif FLAPS_STATE ~= FLAPS_TARGET then
        if MOVING == 1 then
            -- we intended to move the flaps, and they're out of position...
            if FLAPS_STATE < FLAPS_TARGET then
                FLAPS_STATE = FLAPS_STATE + flaps_increment
            else
                FLAPS_STATE = FLAPS_STATE - flaps_increment
            end

            if FLAPS_TARGET == 0.5 then
                delta = math.abs(FLAPS_STATE - FLAPS_TARGET)
                if delta < flaps_increment then
                    FLAPS_STATE = FLAPS_TARGET   -- snap to 0.5 if that was the target
                end
            end
        else
            -- moving == 0 because we reached our endpoint BUT high velocity retracted the flaps, so re-enable
            -- the intent to move because we still have more extension as our target.  Only triggers when desiring
            -- more extension and when last command wasn't an explicit halt
            if FLAPS_TARGET > FLAPS_STATE and FLAPS_TARGET_LAST ~= -1 then
                MOVING = 1
            end
        end
    else
        -- we reached our target, either via a stop command, a duplicate command, or completing extension/retraction...
        if FLAPS_TARGET == 0 or FLAPS_TARGET == 1 then
            FLAPS_TARGET_LAST = FLAPS_TARGET -- when you reach endpoint, reverse direction
        elseif FLAPS_TARGET == 0.5 then
            FLAPS_TARGET_LAST = 1 -- if you reach 0.5 via command, a "normal" Flaps Up/Down command will retract them, prevents errors during takeoff
        end
        MOVING = 0 -- reaching desired position disables the intent to move
	end
	
    -- handle rounding errors induced by non-modulo increment remainders
    if FLAPS_STATE < 0 then
        FLAPS_STATE = 0
    elseif FLAPS_STATE > 1 then
        FLAPS_STATE = 1
    end
            
	set_aircraft_draw_argument_value(9,FLAPS_STATE)
	set_aircraft_draw_argument_value(10,FLAPS_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization
