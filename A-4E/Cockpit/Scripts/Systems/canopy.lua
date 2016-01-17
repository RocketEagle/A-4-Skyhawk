local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Airbrake  = 73 -- This is the number of the command from command_defs
local AirbrakeOn = 147
local AirbrakeOff = 148


--Creating local variables
local CANOPY_COMMAND	=	0				
local CANOPY_STATE	=	0		


dev:listen_command(Canopy)

-- getCanopyPos
-- getCanopyState


function SetCommand(command,value)			
	
	if (command == Airbrake) then
		if (CANOPY_COMMAND == 1) then
			CANOPY_COMMAND = 0
		else
			CANOPY_COMMAND = 1
		end
	end
	
	if (command == AirbrakeOn) then
		CANOPY_COMMAND = 1
	end
	
	if (command == AirbrakeOff) then
		CANOPY_COMMAND = 0
	end
	
	
end

function update()		
	
	if (CANOPY_COMMAND == 0 and CANOPY_STATE > 0) then
		-- lower airbrake in increments of 0.02
		CANOPY_STATE = CANOPY_STATE - 0.01
	else
		if (CANOPY_COMMAND == 1 and CANOPY_STATE < 1) then
			-- raise airbrake in increment of 0.02
			CANOPY_STATE = CANOPY_STATE + 0.01
		end
	end
	
	
	set_aircraft_draw_argument_value(38,CANOPY_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization