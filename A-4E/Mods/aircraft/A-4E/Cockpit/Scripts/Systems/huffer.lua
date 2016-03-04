dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.5  --2 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--Creating local variables
local HUFFER_COMMAND	=	0				
local HUFFER_STATE	=	0		


--dev:listen_command(Engine_Start)

--function SetCommand(command,value)			

--end

function update()	

local gear_pos = get_aircraft_draw_argument_value(6)
local rpm = sensor_data.getEngineLeftRPM()
--local tas = sensor_data.getTrueAirSpeed()

local tmin = 0.55
local tmax = 1.00
	
	if ( (gear_pos >= 0.5) and (rpm < 54) ) then--and (tas < 1) 
		HUFFER_STATE = 1
	else
		HUFFER_STATE = 0
	end
	
	
	set_aircraft_draw_argument_value(402,HUFFER_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization