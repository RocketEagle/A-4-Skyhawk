dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev 	    = GetSelf()

-- indication_page.lua wants these inputs:
--{"D_PITCH"}{"D_IAS"}{"D_AOA"}{"D_MACH"}{"current_G"}{"D_HDG"}{"D_ALT"}{"ALT_SOURCE"}{"D_VV"}{"D_RPMG"}

local current_mach  = get_param_handle("D_MACH") -- obtain shared parameter (created if not exist ), i.e. databus
local current_RPM=get_param_handle("D_RPMG")
--local current_pitch=get_param_handle("D_PITCH")
local current_IAS=get_param_handle("D_IAS")
local current_AOA=get_param_handle("D_AOA")
local current_G=get_param_handle("current_G")
local current_HDG=get_param_handle("D_HDG")
local current_ALT=get_param_handle("D_ALT")
local current_ALT_SOURCE=get_param_handle("ALT_SOURCE")
local current_VV=get_param_handle("D_VV")
local debug_enable=get_param_handle("D_ENABLE")
--local current_test1=get_param_handle("COCKPIT")
--local current_test2=get_param_handle("COCKPIT2")
--local current_piper=get_param_handle("WS_GUN_PIPER_AVAILABLE")


dev:listen_command(Keys.PlaneModeNAV)
dev:listen_command(Keys.PlaneModeBVR)
dev:listen_command(Keys.PlaneModeGround)
dev:listen_command(Keys.PlaneChgWeapon)

debug_enable:set(0)

local sensor_data = get_base_data()

local update_time_step = 0.1

make_default_activity(update_time_step)
--update will be called 10 times per second

function update()
	current_mach:set(sensor_data.getMachNumber())
    current_RPM:set(sensor_data.getEngineLeftRPM())
    --current_pitch:set(sensor_data.getPitch())
    current_IAS:set(sensor_data.getIndicatedAirSpeed()*3.6)
    current_AOA:set((sensor_data.getAngleOfAttack()*360.0/(2.0*math.pi)))
    current_G:set(sensor_data.getVerticalAcceleration())
    current_HDG:set(360.0-(sensor_data.getHeading()*360.0/(2.0*math.pi)))
    if sensor_data.getRadarAltitude() > 1200 then
		current_ALT:set(sensor_data.getBarometricAltitude())
		current_ALT_SOURCE:set(" ") -- TODO
	else
		current_ALT:set(sensor_data.getRadarAltitude())
		current_ALT_SOURCE:set("R") -- TODO
	end

    current_VV:set(sensor_data.getVerticalVelocity())
--    current_test1:set(12.34)
--    current_test2:set(567.89)
--    current_piper:set(1.0)
end

function SetCommand(command,value)
	if command == Keys.PlaneModeBVR then
        -- BVR = beyond visual range, abused here for debug, for stuff you cannot ordinarily see ;)
        if debug_enable:get()==0 then
            print_message_to_user("debug enable")
            debug_enable:set(1)
        end
    end
	if command == Keys.PlaneModeNAV then
        if debug_enable:get()==1 then
            print_message_to_user("debug disable")
            debug_enable:set(0)
        end
    end
	if command == Keys.PlaneModeGround then
        --print_message_to_user("A2G mode")
        --local weap=GetDevice(devices.WEAPON_SYSTEM)
        --weap:launch_station(0)
        --weap:launch_station(1)
        --weap:launch_station(2)
        --weap:launch_station(3)
        --weap:launch_station(4)
        --weap:emergency_jettison()
		--for i=0, 4, 1 do
		--	local station = weap:get_station_info(i)
            --print_message_to_user(i.." count:"..station.count)
        --    print_message_to_user(i.." w:"..station.weapon.level1..","..station.weapon.level2..","..station.weapon.level3.." "..station.CLSID)
            --print_message_to_user("n:"..station.weapon.)
            -- station: CLSID, container, count, weapon
            -- station.weapon: level1, level2, level3, level4
            --for key,value in pairs(station.weapon) do print_message_to_user(key..":"..value) end
            --print_message_to_user("s:"..station.container)
            --for key,value in pairs(getmetatable(station)) do print_message_to_user("weap:"..key) end
        --end
    end
	if command == Keys.PlaneChgWeapon then
    end
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