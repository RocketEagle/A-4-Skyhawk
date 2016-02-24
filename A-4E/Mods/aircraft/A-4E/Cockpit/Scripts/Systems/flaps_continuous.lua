-- "continuous" flaps behavior, dofile() via flaps.lua
--
-- behavior documentation: NAVAIR 01-40AVC-1 section 1-30, 15 July 1969, "WING FLAPS"
-- flap blowback begins at 230kts IAS to prevent structural damage
--
-- design summary:
--   single key press for Up/Down starts motion, and a 2nd keypress of any flap command stops movement of the flaps
--   flaps takeoff command is ignored
--   full extension (100%) through full retraction (0%)
--   executing Flaps Up/Down command moves to the other extreme position, alternate direction on next movement

local dev = GetSelf()

local update_time_step = 0.006  -- ~166.667Hz matches AFM dll per SilentEagle
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Flaps  = 72 -- This is the number of the command from command_defs
local FlapsOn = 145
local FlapsOff = 146
local FlapsTakeoff = Keys.PlaneFlapsTakeoff    -- defined in command_defs.lua

local FlapExtensionTimeSeconds = 6      -- flaps take 6 seconds to extend/retract fully

--Creating local variables
local FLAPS_STATE	=	0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "current" flap position		
local FLAPS_TARGET  =   0 -- 0 = retracted, 0.5 = takeoff, 1.0 = landing -- "future" flap position

dev:listen_command(Flaps)
dev:listen_command(FlapsOn)
dev:listen_command(FlapsOff)
dev:listen_command(FlapsTakeoff)

-- flaps value of -1 tells flaps to cycle:  up -> down -> takeoff -> up
-- flaps value of 0/0.5/1.0 sets the position directly
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

end

function update()		
	local flaps_increment = update_time_step / FlapExtensionTimeSeconds -- sets the speed of flap animation
    local delta

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
