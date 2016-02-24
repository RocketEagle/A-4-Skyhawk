-- "discrete" flaps behavior, dofile() via flaps.lua
--
-- behavior documentation: simplified to match FC3
-- flap blowback relief starts at ~230kts
--
-- design summary:
--   extended 100% / takeoff 50% / retracted 0% using single key press for each
--   repeated presses of the Flaps Up/Down command cycles: up -> down -> takeoff -> up
--   flaps stop command explicitly stops flaps where they are, otherwise keep moving

local dev = GetSelf()

local update_time_step = 0.006  -- ~166.667Hz matches AFM dll per SilentEagle
make_default_activity(update_time_step)

    
local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local Flaps  = 72 -- This is the number of the command from command_defs
local FlapsOn = 145
local FlapsOff = 146
local FlapsTakeoff = Keys.PlaneFlapsTakeoff    -- defined in command_defs.lua
local FlapsStop = Keys.PlaneFlapsStop

local FlapExtensionTimeSeconds = 6      -- flaps take 6 seconds to extend/retract fully

--Creating local variables
local FLAPS_STATE	=	0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "current" flap position		
local FLAPS_TARGET  =   0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "future" flap position

dev:listen_command(Flaps)
dev:listen_command(FlapsOn)
dev:listen_command(FlapsOff)
dev:listen_command(FlapsTakeoff)
dev:listen_command(FlapsStop)


function SetCommand(command,value)			
	
	if (command == Flaps) then
        if (FLAPS_TARGET == 0) then
            FLAPS_TARGET = 1
        elseif (FLAPS_TARGET == 0.5) then
            FLAPS_TARGET = 0
        else
            FLAPS_TARGET = 0.5
        end
    end

    if (command == FlapsOn) then
		FLAPS_TARGET = 1
	end

    if (command == FlapsTakeoff) then
		FLAPS_TARGET = 0.5
	end
	
	if (command == FlapsOff) then
		FLAPS_TARGET = 0
	end

    if (command == FlapsStop) then
        FLAPS_TARGET = FLAPS_STATE
    end

    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    if ias_knots > 350 then
      FLAPS_TARGET = 0
    elseif ias_knots > 260 then
      if FLAPS_TARGET > 0.5 then
        FLAPS_TARGET = 0.5
      end
    end
end

function update()		
	local flaps_increment = update_time_step / FlapExtensionTimeSeconds -- sets the speed of flap animation
    local delta

    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    if ias_knots > 350 then
      FLAPS_TARGET = 0
    elseif ias_knots > 260 then
      if FLAPS_TARGET > 0.5 then
        FLAPS_TARGET = 0.5
      end
    end
    
    -- make primary adjustment if needed
    if FLAPS_TARGET ~= FLAPS_STATE then
        if FLAPS_STATE < FLAPS_TARGET then
            FLAPS_STATE = FLAPS_STATE + flaps_increment
        else
            FLAPS_STATE = FLAPS_STATE - flaps_increment
        end
	end
	
    -- handle rounding errors induced by non-modulo increment remainders
    if FLAPS_STATE < 0 then
        FLAPS_STATE = 0
    elseif FLAPS_STATE > 1 then
        FLAPS_STATE = 1
    else
        if FLAPS_TARGET == 0.5 and FLAPS_STATE ~= 0.5 then
            delta = math.abs(FLAPS_TARGET-FLAPS_STATE)
            if delta < flaps_increment then
                FLAPS_STATE = 0.5
            end
        end
    end
     
	set_aircraft_draw_argument_value(9,FLAPS_STATE)
	set_aircraft_draw_argument_value(10,FLAPS_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization
