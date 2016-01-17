local dev = GetSelf()

local update_time_step = 0.1
make_default_activity(update_time_step)--update will be called 10 times per second

local sensor_data = get_base_data()

-- Const

--local degrees_per_radian = 57.2957795
--local feet_per_meter_per_minute = 196.8

-- Variables
local ias = get_param_handle("D_IAS")

-- Initialisation
ias:set(0.0)

function post_initialize()
	
	--electric_system = GetDevice(3) --devices["ELECTRIC_SYSTEM"]
	-- print("post_initialize called")
end

function SetCommand(command,value)
			
end

function update()
	
	ias:set(sensor_data.getIndicatedAirSpeed()*1.9438444924574)
		
end

need_to_be_closed = false -- close lua state after initialization

-- getAngleOfAttack
-- getAngleOfSlide
-- getBarometricAltitude
-- getCanopyPos
-- getCanopyState
-- getEngineLeftFuelConsumption --
-- getEngineLeftRPM
-- getEngineLeftTemperatureBeforeTurbine
-- getEngineRightFuelConsumption
-- getEngineRightRPM
-- getEngineRightTemperatureBeforeTurbine
-- getFlapsPos
-- getFlapsRetracted
-- getHeading
-- getHelicopterCollective
-- getHelicopterCorrection
-- getHorizontalAcceleration
-- getIndicatedAirSpeed
-- getLandingGearHandlePos
-- getLateralAcceleration
-- getLeftMainLandingGearDown
-- getLeftMainLandingGearUp
-- getMachNumber
-- getMagneticHeading
-- getNoseLandingGearDown
-- getNoseLandingGearUp
-- getPitch
-- getRadarAltitude
-- getRateOfPitch
-- getRateOfRoll
-- getRateOfYaw
-- getRightMainLandingGearDown
-- getRightMainLandingGearUp
-- getRoll
-- getRudderPosition --
-- getSpeedBrakePos
-- getStickPitchPosition
-- getStickRollPosition
-- getThrottleLeftPosition
-- getThrottleRightPosition
-- getTotalFuelWeight  
-- getTrueAirSpeed
-- getVerticalAcceleration
-- getVerticalVelocity
-- getWOW_LeftMainLandingGear
-- getWOW_NoseLandingGear
-- getWOW_RightMainLandingGear



