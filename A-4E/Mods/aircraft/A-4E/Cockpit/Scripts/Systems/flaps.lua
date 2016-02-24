dofile(LockOn_Options.script_path.."command_defs.lua")

-- Pick ONE of the following Flap behaviors and comment out the other:
--
-- flaps_discrete:  retracted (0%) / takeoff (50%) / extended (100%) using ctrl-F/alt-F/shift-F and F by default
-- flaps_continuous: continuous flap management, ctrl-F extends, shift-F retracts, a second click stops motion in the current position

--dofile(LockOn_Options.script_path.."Systems/flaps_discrete.lua")
dofile(LockOn_Options.script_path.."Systems/flaps_continuous.lua")

