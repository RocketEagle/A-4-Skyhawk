local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Engine_Start = 311 -- This is the number of the command from command_defs


--Creating local variables
local HUFFER_COMMAND	=	0				
local HUFFER_STATE	=	0		


dev:listen_command(Engine_Start)

function SetCommand(command,value)			
	
	if (command == Engine_Start) then
		if (HUFFER_COMMAND == 0) then
			HUFFER_COMMAND = 1
		--else
		--	HUFFER_COMMAND = 1
		end
	end
	
	
end

function update()		
	
	if (HUFFER_COMMAND == 1 and HUFFER_STATE < 1) then
		-- lower airbrake in increments of 0.002
		HUFFER_STATE = 0.9 + 0.001
	else
		if (HUFFER_COMMAND == 1 and HUFFER_STATE == 1) then --HUFFER_STATE == 0.90 is fully open / HUFFER_STATE == 1 is HUFFER jettisoned
			-- raise airbrake in increment of 0.02
			--HUFFER_STATE = HUFFER_STATE + 0.01
			HUFFER_COMMAND == 0
		end
	end
	
	
	set_aircraft_draw_argument_value(75,HUFFER_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization