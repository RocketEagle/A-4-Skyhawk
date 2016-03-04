dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


--local Engine_Start = 311 -- This is the number of the command from command_defs


--Creating local variables
local HUFFER_COMMAND	=	0				
local HUFFER_STATE	=	0		


--dev:listen_command(Engine_Start)

function SetCommand(command,value)			
	
	-- if (command == Engine_Start) then
		-- if (HUFFER_COMMAND == 0) then
			-- HUFFER_COMMAND = 1
		-- --else
		-- --	HUFFER_COMMAND = 1
		-- end
	-- end
	
	
end

function update()	

local gear_pos = get_aircraft_draw_argument_value(6)
local throttle = sensor_data.getThrottleLeftPosition()	
--local speed = 

local tmin = 0.55
local tmax = 1.00
	
	if (gear_pos >= 0.5 and throttle <= 0) then--throttle <= ((0.55 - tmin)/(tmax-tmin)) ) then
		HUFFER_STATE = 1
	else
		HUFFER_STATE = 0
	end
	
	
	set_aircraft_draw_argument_value(402,HUFFER_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization