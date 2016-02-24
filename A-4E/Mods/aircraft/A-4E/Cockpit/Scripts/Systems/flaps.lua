local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Flaps  = 72 -- This is the number of the command from command_defs
local FlapsOn = 145
local FlapsOff = 146
local FlapsTakeoff = 10001    -- must match PlaneFlapsTakeoff in command_defs.lua!


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
		FLAPS_TARGET = 1.0
	end

    if (command == FlapsTakeoff) then
		FLAPS_TARGET = 0.5
	end
	
	if (command == FlapsOff) then
		FLAPS_TARGET = 0.0
	end

end

function update()		
	
	if ((FLAPS_TARGET ~= FLAPS_STATE) and (FLAPS_TARGET > FLAPS_STATE)) then
		-- extend flaps in increments of 0.01
		FLAPS_STATE = FLAPS_STATE + 0.01
	else
        -- retract flaps in increments of 0.01
        FLAPS_STATE = FLAPS_STATE - 0.01
	end
	
	
	set_aircraft_draw_argument_value(9,FLAPS_STATE)
	set_aircraft_draw_argument_value(10,FLAPS_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization
