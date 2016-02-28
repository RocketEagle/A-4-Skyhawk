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

local GearNoseRetractTimeSec = 10 -- both gear take 10 seconds to retract
local GearMainRetractTimeSec = 10 -- both gear take 10 seconds to retract
local GearNoseExtendTimeSec = 10  -- nose gear sequencing is 10 seconds to extend fully
local GearMainExtendTimeSec = 6   -- main gear sequencing is 6 seconds to extend fully

--Creating local variables
local GEAR_NOSE_STATE = 0 -- 0 = retracted, 1.0 = extended -- "current" nose gear position
local GEAR_MAIN_STATE =	0 -- 0 = retracted, 1.0 = extended -- "current" main gear position

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
    if GEAR_MAIN_STATE > 0.2 then
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
    GEAR_MAIN_STATE = 1
    GEAR_TARGET = 1
  end
  
  set_aircraft_draw_argument_value(0,GEAR_NOSE_STATE) -- nose gear draw angle
  set_aircraft_draw_argument_value(3,GEAR_MAIN_STATE) -- right gear draw angle
  set_aircraft_draw_argument_value(5,GEAR_MAIN_STATE) -- left gear draw angle
  
end


function update()		
    local gear_nose_retract_increment = update_time_step / GearNoseRetractTimeSec
    local gear_main_retract_increment = update_time_step / GearMainRetractTimeSec

    local gear_nose_extend_increment = update_time_step / GearNoseExtendTimeSec
    local gear_main_extend_increment = update_time_step / GearMainExtendTimeSec

    --[[if ONCE then
        -- if the simulation starts with velocity = 0, then assume we're on the ground and extend gear
        if sensor_data.getSelfVelocity() == 0 then
            GEAR_NOSE_STATE = 1
            GEAR_MAIN_STATE = 1
            GEAR_TARGET = 1
        end
        ONCE = 0
    end]]

    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    if ias_knots > 280 then 
      if GEAR_MAIN_STATE > 0.2 then
        GEAR_MAIN_ERR = 1
      end
      if GEAR_NOSE_STATE > 0.2 then
        GEAR_NOSE_ERR = 1
      end
    end
  
    -- make primary adjustment if needed
    --[[if GEAR_TARGET == 1 then
        -- extending, use separate rates
        if GEAR_NOSE_STATE < GEAR_TARGET then
            GEAR_NOSE_STATE = GEAR_NOSE_STATE + gear_nose_extend_increment
    	end

        if GEAR_MAIN_STATE < GEAR_TARGET then
            GEAR_MAIN_STATE = GEAR_MAIN_STATE + gear_main_extend_increment
        end
    else
        -- retracting, both gear retract at same speed
        if GEAR_NOSE_STATE > GEAR_TARGET then
            GEAR_NOSE_STATE = GEAR_NOSE_STATE - gear_nose_retract_increment
        end
        if GEAR_MAIN_STATE > GEAR_TARGET then
            GEAR_MAIN_STATE = GEAR_MAIN_STATE - gear_main_retract_increment
        end
    end]]
    if GEAR_NOSE_ERR == 0 then
      if GEAR_TARGET ~= GEAR_NOSE_STATE then
        -- extending, use separate rates
        if GEAR_NOSE_STATE < GEAR_TARGET then
          GEAR_NOSE_STATE = GEAR_NOSE_STATE + gear_nose_extend_increment
        else
          GEAR_NOSE_STATE = GEAR_NOSE_STATE - gear_nose_retract_increment
        end
      end
    end

    if GEAR_MAIN_ERR == 0 then
      if GEAR_TARGET ~= GEAR_MAIN_STATE then
        -- extending, use separate rates
        if GEAR_MAIN_STATE < GEAR_TARGET then
          GEAR_MAIN_STATE = GEAR_MAIN_STATE + gear_main_extend_increment
        else
          GEAR_MAIN_STATE = GEAR_MAIN_STATE - gear_main_retract_increment
        end
      end
    end
            	
    -- handle rounding errors induced by non-modulo increment remainders
    if GEAR_NOSE_STATE < 0 then
        GEAR_NOSE_STATE = 0
    elseif GEAR_NOSE_STATE > 1 then
        GEAR_NOSE_STATE = 1
    end

    if GEAR_MAIN_STATE < 0 then
        GEAR_MAIN_STATE = 0
    elseif GEAR_MAIN_STATE > 1 then
        GEAR_MAIN_STATE = 1
    end

    set_aircraft_draw_argument_value(0,GEAR_NOSE_STATE) -- nose gear draw angle
	  set_aircraft_draw_argument_value(3,GEAR_MAIN_STATE) -- right gear draw angle
    set_aircraft_draw_argument_value(5,GEAR_MAIN_STATE) -- left gear draw angle
	
end

--need_to_be_closed = false -- close lua state after initialization

