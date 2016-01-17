local dev = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step) -- enables call to update

local sensor_data = get_base_data()



function post_initialize()
	print("ext. anim. post_initialize called")

	for key,value in pairs(sensor_data) do
	    print("found member " .. key);
	end
end



function update()
	
	--Test set anim argument

	local ROLL_STATE = sensor_data:getStickPitchPosition() / 100
	set_aircraft_draw_argument_value(11, ROLL_STATE) -- right aileron
	set_aircraft_draw_argument_value(12, -ROLL_STATE) -- left aileron
	

	local PITCH_STATE = sensor_data:getStickRollPosition() / 100
	set_aircraft_draw_argument_value(15, (ROLL_STATE + PITCH_STATE) /2) -- right elevator
	set_aircraft_draw_argument_value(16, (-ROLL_STATE + PITCH_STATE) /2) -- left elevator

	local RUDDER_STATE = sensor_data:getRudderPosition() / 100
	set_aircraft_draw_argument_value(17, -RUDDER_STATE)
	
	
	print(ROLL_STATE)
	print(PITCH_STATE)
end