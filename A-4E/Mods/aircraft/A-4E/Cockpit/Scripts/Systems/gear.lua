dofile(LockOn_Options.script_path.."command_defs.lua")

-- gear behavior / modeling
--
--
-- design summary:
--   When raising gear:
--     all gear occupy full 10 seconds
--   When extending gear:
--     both gear start simultaneously
--     main gear takes 6 seconds, nose gear takes 10 seconds
--

local dev = GetSelf()

local update_time_step = 0.006  -- ~166.667Hz matches AFM dll per SilentEagle
make_default_activity(update_time_step)

    
local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local Gear  = Keys.PlaneGear
local GearUp = Keys.PlaneGearUp
local GearDown = Keys.PlaneGearDown

local GearNoseRetractTimeSec = 8    -- 8 seconds to retract
local GearNoseExtendTimeSec = 6     -- 6 seconds to extend

local GearMainTimeSec = 5           -- 5 seconds to retract and extend main gear

local LeftSideLead = 0.7 / (GearMainTimeSec) -- left side main gear leads right side, both opening and closing, by 0.7 seconds

--Creating local variables
local GEAR_NOSE_STATE = 0 -- 0 = retracted, 1.0 = extended -- "current" nose gear position
local GEAR_LEFT_STATE =	0 -- 0 = retracted, 1.0 = extended -- "current" main left gear position
local GEAR_RIGHT_STATE = 0 -- 0 = retracted, 1.0 = extended -- "current" main right gear position
local GEAR_TARGET =     0 -- 0 = retracted, 1.0 = extended -- "future" gear position

local GEAR_NOSE_ERR   = 0
local GEAR_MAIN_ERR   = 0

local ONCE = 1

dev:listen_command(Gear)
dev:listen_command(GearUp)
dev:listen_command(GearDown)


function SetCommand(command,value)	
  local wown = sensor_data.getWOW_NoseLandingGear()
  local wowml = sensor_data.getWOW_LeftMainLandingGear()
  local wowmr = sensor_data.getWOW_RightMainLandingGear()
  if wown == 1 or wowml == 1 or wowmr == 1 then
    return
  end				
	
	if command == Gear then
        GEAR_TARGET = 1 - GEAR_TARGET
    elseif command == GearUp then
        GEAR_TARGET = 0
    elseif command == GearDown then
        GEAR_TARGET = 1
  end
  
  ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
  if ias_knots > 280 then 
    if GEAR_LEFT_STATE > 0.2 or GEAR_RIGHT_STATE > 0.2 then
      GEAR_MAIN_ERR = 1
    end
    if GEAR_NOSE_STATE > 0.2 then
      GEAR_NOSE_ERR = 1
    end
  end
  
end

function post_initialize()
  local wown = sensor_data.getWOW_NoseLandingGear()
  local wowml = sensor_data.getWOW_LeftMainLandingGear()
  local wowmr = sensor_data.getWOW_RightMainLandingGear()
  if wown == 1 or wowml == 1 or wowmr == 1 then
    GEAR_NOSE_STATE = 1
    GEAR_RIGHT_STATE = 1
    GEAR_LEFT_STATE = 1
    GEAR_TARGET = 1
  end
  
  set_aircraft_draw_argument_value(0,GEAR_NOSE_STATE) -- nose gear draw angle
  set_aircraft_draw_argument_value(3,GEAR_RIGHT_STATE) -- right gear draw angle
  set_aircraft_draw_argument_value(5,GEAR_LEFT_STATE) -- left gear draw angle
  
end


function update()		
    local gear_nose_retract_increment = update_time_step / GearNoseRetractTimeSec
    local gear_nose_extend_increment = update_time_step / GearNoseExtendTimeSec

    local gear_main_increment = update_time_step / GearMainTimeSec

    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    if ias_knots > 280 then 
      if GEAR_LEFT_STATE > 0.2 or GEAR_RIGHT_STATE > 0.2 then
        GEAR_MAIN_ERR = 1
      end
      if GEAR_NOSE_STATE > 0.2 then
        GEAR_NOSE_ERR = 1
      end
    end
  
    -- make primary nosegear adjustments if needed
    if GEAR_TARGET ~= GEAR_NOSE_STATE then
        if GEAR_NOSE_STATE < GEAR_TARGET then
            GEAR_NOSE_STATE = GEAR_NOSE_STATE + gear_nose_extend_increment
        else
            if GEAR_NOSE_ERR == 0 then
                GEAR_NOSE_STATE = GEAR_NOSE_STATE - gear_nose_retract_increment
            end
        end
    end

    -- make primary main gear adjustments if needed
    if GEAR_TARGET ~= GEAR_LEFT_STATE or GEAR_TARGET ~= GEAR_RIGHT_STATE then
        -- left gear moves first, both up and down
        if GEAR_LEFT_STATE < GEAR_TARGET then
            -- extending
            GEAR_LEFT_STATE = GEAR_LEFT_STATE + gear_main_increment
        else
            if GEAR_MAIN_ERR == 0 then
                GEAR_LEFT_STATE = GEAR_LEFT_STATE - gear_main_increment
            end
        end

        -- right gear lags left gear by LeftSideLead seconds
        if GEAR_RIGHT_STATE < GEAR_TARGET then
            if GEAR_LEFT_STATE > LeftSideLead then
                GEAR_RIGHT_STATE = GEAR_RIGHT_STATE + gear_main_increment
            end
        else
            if GEAR_LEFT_STATE < (1-LeftSideLead) then
                if GEAR_MAIN_ERR == 0 then
                    GEAR_RIGHT_STATE = GEAR_RIGHT_STATE - gear_main_increment
                end
            end
        end
    end
            	
    -- handle rounding errors induced by non-modulo increment remainders
    if GEAR_NOSE_STATE < 0 then
        GEAR_NOSE_STATE = 0
    elseif GEAR_NOSE_STATE > 1 then
        GEAR_NOSE_STATE = 1
    end

    if GEAR_LEFT_STATE < 0 then
        GEAR_LEFT_STATE = 0
    elseif GEAR_LEFT_STATE > 1 then
        GEAR_LEFT_STATE = 1
    end

    if GEAR_RIGHT_STATE < 0 then
        GEAR_RIGHT_STATE = 0
    elseif GEAR_RIGHT_STATE > 1 then
        GEAR_RIGHT_STATE = 1
    end

    set_aircraft_draw_argument_value(0,GEAR_NOSE_STATE) -- nose gear draw angle
    set_aircraft_draw_argument_value(3,GEAR_RIGHT_STATE) -- right gear draw angle
    set_aircraft_draw_argument_value(5,GEAR_LEFT_STATE) -- left gear draw angle

end

--need_to_be_closed = false -- close lua state after initialization

