local dev 	    = GetSelf()

local current_PITCH  	 = get_param_handle("D_PITCH")
local current_ROLL  	 = get_param_handle("D_ROLL")

local sensor_data = get_base_data()

local update_time_step = 0.02
make_default_activity(update_time_step)
--update will be called 50 times per second

function post_initialize()
	current_PITCH:set(sensor_data.getPitch())
	current_ROLL:set(sensor_data.getRoll())
end

function update()
	current_PITCH:set(sensor_data.getPitch())
	current_ROLL:set(sensor_data.getRoll())
end
