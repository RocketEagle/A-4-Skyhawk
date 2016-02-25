dofile(LockOn_Options.script_path.."command_defs.lua")

-- spoilers behavior / modeling
--
--
-- design summary:
--   Spoilers deploy automatically when:
--     Weight on left gear
--     Throttle below 70%
--     Spoiler ARM-OFF switch in the ARM position

local dev = GetSelf()

local update_time_step = 0.006  -- ~166.667Hz matches AFM dll per SilentEagle
make_default_activity(update_time_step)

    
local sensor_data = get_base_data()

local SpoilerToggle  = Keys.SpoilersArmToggle
local SpoilerOn  = Keys.SpoilersArmOn
local SpoilerOff  = Keys.SpoilersArmOff

local SpoilerExtendTimeSec = 0.15 -- spoiler extends quickly!
local SpoilerRetractTimeSec = 1  -- 1 sec to retract

--Creating local variables
local SPOILER_STATE = 0     -- 0 = retracted, 1.0 = extended -- "current" nose gear position
local SPOILER_TARGET = 0    -- 0 = retracted, 1.0 = extended -- "future" gear position
local SPOILER_ARMED = 0     -- 1 if switch is in the ARM position

dev:listen_command(SpoilerToggle)
dev:listen_command(SpoilerOn)
dev:listen_command(SpoilerOff)

function SetCommand(command,value)			
	
	if command == SpoilerToggle then
        SPOILER_ARMED = 1 - SPOILER_ARMED
    elseif command == SpoilerOn then
        SPOILER_ARMED = 1
    elseif command == SpoilerOff then
        SPOILER_ARMED = 0
    end

    --print_message_to_user("Command:"..command.." - Spoilers: "..SPOILER_ARMED)

end

function update()		
    local spoiler_retract_increment = update_time_step / SpoilerRetractTimeSec
    local spoiler_extend_increment = update_time_step / SpoilerExtendTimeSec

    local gear_pos = get_aircraft_draw_argument_value(6)
    local throttle = sensor_data.getThrottleLeftPosition()

    if gear_pos >= 0.5 and throttle < 0.7 and SPOILER_ARMED == 1 then
        SPOILER_TARGET = 1
    else
        SPOILER_TARGET = 0
    end


    -- make primary adjustment if needed
    if SPOILER_TARGET == 1 then
        SPOILER_STATE = SPOILER_STATE + spoiler_extend_increment
    else
        SPOILER_STATE = SPOILER_STATE - spoiler_retract_increment
    end
            	
    -- handle rounding errors induced by non-modulo increment remainders
    if SPOILER_STATE < 0 then
        SPOILER_STATE = 0
    elseif SPOILER_STATE > 1 then
        SPOILER_STATE = 1
    end

    set_aircraft_draw_argument_value(120,SPOILER_STATE) -- right spoiler draw angle
	set_aircraft_draw_argument_value(123,SPOILER_STATE) -- left spoiler draw angle
	
end

--need_to_be_closed = false -- close lua state after initialization

