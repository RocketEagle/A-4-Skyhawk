local dev 	    = GetSelf()

-- indication_page.lua wants these inputs:
--{"D_PITCH"}{"D_IAS"}{"D_AOA"}{"D_MACH"}{"current_G"}{"D_HDG"}{"D_ALT"}{"ALT_SOURCE"}{"D_VV"}{"D_RPMG"}

local current_mach  = get_param_handle("D_MACH") -- obtain shared parameter (created if not exist ), i.e. databus
local current_RPM=get_param_handle("D_RPMG")
local current_pitch=get_param_handle("D_PITCH")
local current_IAS=get_param_handle("D_IAS")
local current_AOA=get_param_handle("D_AOA")
local current_G=get_param_handle("current_G")
local current_HDG=get_param_handle("D_HDG")
local current_ALT=get_param_handle("D_ALT")
local current_ALT_SOURCE=get_param_handle("ALT_SOURCE")
local current_VV=get_param_handle("D_VV")
--local current_test1=get_param_handle("COCKPIT")
--local current_test2=get_param_handle("COCKPIT2")
--local current_piper=get_param_handle("WS_GUN_PIPER_AVAILABLE")

local sensor_data = get_base_data()

local update_time_step = 0.1

make_default_activity(update_time_step)
--update will be called 10 times per second

function update()
	current_mach:set(sensor_data.getMachNumber())
    current_RPM:set(sensor_data.getEngineLeftRPM())
    current_pitch:set(sensor_data.getPitch())
    current_IAS:set(sensor_data.getIndicatedAirSpeed())
    current_AOA:set(sensor_data.getAngleOfAttack())
    current_G:set(0) --TODO
    current_HDG:set(360.0-(sensor_data.getHeading()*360.0/(2.0*math.pi)))
    current_ALT:set(sensor_data.getBarometricAltitude())
    current_ALT_SOURCE:set("B") -- TODO
    current_VV:set(sensor_data.getVerticalVelocity())
--    current_test1:set(12.34)
--    current_test2:set(567.89)
--    current_piper:set(1.0)
end

-- sensor_data
-- http://forums.eagle.ru/showpost.php?p=1482517&postcount=51
--getAngleOfAttack
--getAngleOfSlide
--getBarometricAltitude
--getCanopyPos
--getCanopyState
--getEngineLeftFuelConsumption
--getEngineLeftRPM
--getEngineLeftTemperatureBeforeTurbine
--getEngineRightFuelConsumption
--getEngineRightRPM
--getEngineRightTemperatureBeforeTurbine
--getFlapsPos
--getFlapsRetracted
--getHeading
--getHelicopterCollective
--getHelicopterCorrection
--getHorizontalAcceleration
--getIndicatedAirSpeed
--getLandingGearHandlePos
--getLateralAcceleration
--getLeftMainLandingGearDown
--getLeftMainLandingGearUp
--getMachNumber
--getMagneticHeading
--getNoseLandingGearDown
--getNoseLandingGearUp
--getPitch
--getRadarAltitude
--getRateOfPitch
--getRateOfRoll
--getRateOfYaw
--getRightMainLandingGearDown
--getRightMainLandingGearUp
--getRoll
--getRudderPosition
--getSpeedBrakePos
--getStickPitchPosition
--getStickRollPosition
--getThrottleLeftPosition
--getThrottleRightPosition
--getTotalFuelWeight
--getTrueAirSpeed
--getVerticalAcceleration
--getVerticalVelocity
--getWOW_LeftMainLandingGear
--getWOW_NoseLandingGear
--getWOW_RightMainLandingGear