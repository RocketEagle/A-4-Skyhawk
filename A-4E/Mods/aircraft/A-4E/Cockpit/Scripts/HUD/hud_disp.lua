local dev 	    = GetSelf()

local current_MACH       = get_param_handle("D_MACH") -- obtain shared parameter (created if not exist ), i.e. databus
local current_RPM        = get_param_handle("D_RPMG")
local current_PITCH  	 = get_param_handle("D_PITCH")
local current_ROLL  	 = get_param_handle("D_ROLL")
local current_IAS        = get_param_handle("D_IAS")
local current_AOA        = get_param_handle("D_AOA")
local current_G          = get_param_handle("current_G")
local current_HDG        = get_param_handle("D_HDG")
local current_ALT        = get_param_handle("D_ALT")
local current_ALT_SOURCE = get_param_handle("ALT_SOURCE")
local current_VV         = get_param_handle("D_VV")

local sensor_data = get_base_data()

local update_time_step = 0.1
make_default_activity(update_time_step)
--update will be called 10 times per second

function post_initialize()
	current_PITCH:set(sensor_data.getPitch())
	current_ROLL:set(sensor_data.getRoll())
	current_MACH:set(sensor_data.getMachNumber())
	current_RPM:set(sensor_data.getEngineLeftRPM())
	current_IAS:set(sensor_data.getIndicatedAirSpeed()*3.6)
	current_AOA:set(sensor_data.getAngleOfAttack()/math.pi*180)
	current_G:set(sensor_data.getVerticalAcceleration())
	current_HDG:set(360 - sensor_data.getHeading()/math.pi*180)
end

function update()
	current_PITCH:set(sensor_data.getPitch())
	current_ROLL:set(sensor_data.getRoll())
	current_MACH:set(sensor_data.getMachNumber())
	current_RPM:set(sensor_data.getEngineLeftRPM())
	current_IAS:set(sensor_data.getIndicatedAirSpeed()*3.6)
	current_AOA:set(sensor_data.getAngleOfAttack()/math.pi*180)
	current_G:set(sensor_data.getVerticalAcceleration())
	current_HDG:set(360 - sensor_data.getHeading()/math.pi*180)
	--current_VV:set(sensor_data.getVerticalVelocity())
	
	if sensor_data.getRadarAltitude() > 1200 then
		current_ALT:set(sensor_data.getBarometricAltitude())
		current_ALT_SOURCE:set(" ") -- TODO
	else
		current_ALT:set(sensor_data.getRadarAltitude())
		current_ALT_SOURCE:set("R") -- TODO
	end

end
