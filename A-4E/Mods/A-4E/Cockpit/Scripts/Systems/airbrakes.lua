local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Airbrake  = 73 -- This is the number of the command from command_defs
local AirbrakeOn = 147
local AirbrakeOff = 148


--Creating local variables
local ABRAKE_COMMAND	=	0				
local ABRAKE_STATE	=	0		


dev:listen_command(Airbrake)
dev:listen_command(AirbrakeOn)
dev:listen_command(AirbrakeOff)


function SetCommand(command,value)			
	
	if (command == Airbrake) then
		if (ABRAKE_COMMAND == 1) then
			ABRAKE_COMMAND = 0
		else
			ABRAKE_COMMAND = 1
		end
	end
	
	if (command == AirbrakeOn) then
		ABRAKE_COMMAND = 1
	end
	
	if (command == AirbrakeOff) then
		ABRAKE_COMMAND = 0
	end
	
	
end

function update()		
	
	if (ABRAKE_COMMAND == 0 and ABRAKE_STATE > 0) then
		-- lower airbrake in increments of 0.02
		ABRAKE_STATE = ABRAKE_STATE - 0.01
	else
		if (ABRAKE_COMMAND == 1 and ABRAKE_STATE < 1) then
			-- raise airbrake in increment of 0.02
			ABRAKE_STATE = ABRAKE_STATE + 0.01
		end
	end
	
	
	set_aircraft_draw_argument_value(182,ABRAKE_STATE)
	set_aircraft_draw_argument_value(186,ABRAKE_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization