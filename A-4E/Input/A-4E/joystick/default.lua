local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")
join(res.keyCommands,{
{down = iCommandPlaneAutopilot, name = 'Autopilot - Attitude Hold', category = 'Autopilot'},
{down = iCommandPlaneStabHbar, name = 'Autopilot - Altitude Hold', category = 'Autopilot'},
{down = iCommandPlaneStabCancel, name = 'Autopilot Disengage', category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_T_up, name = 'CAS Pitch', category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_K_up, name = 'CAS Roll', category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_H_up, name = 'CAS Yaw', category = 'Autopilot'},

--Flight Control
{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = 'T/O Trim', category = 'Flight Control'},

-- Systems
{down = iCommandPlaneAirRefuel, name = 'Refueling Boom', category = 'Systems'},
{down = iCommandPlaneJettisonFuelTanks, name = 'Jettison Fuel Tanks', category = 'Systems'},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = 'Nose Gear Maneuvering Range', category = 'Systems'},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = 'Nose Gear Steering Disengage', category = 'Systems'},
{down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = 'Wheel Brake Left On/Off', category = 'Systems'},
{down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = 'Wheel Brake Right On/Off', category = 'Systems'},
{down = iCommandPlaneFSQuantityIndicatorSelectorMAIN, name = 'Fuel Quantity Selector', category = 'Systems'},
{down = iCommandPlaneFSQuantityIndicatorTest, up = iCommandPlaneFSQuantityIndicatorSelectorINT, name = 'Fuel Quantity Test', category = 'Systems'},
{down = iCommandPlaneHook, name = 'Tail Hook', category = 'Systems'},
{down = iCommandPlanePackWing, name = 'Folding Wings', category = 'Systems'},

-- Modes
{down = iCommandPlaneModeBVR, name = '(2) Beyond Visual Range Mode', category = 'Modes'},
{down = iCommandPlaneModeVS, name = '(3) Close Air Combat Vertical Scan Mode', category = 'Modes'},
{down = iCommandPlaneModeBore, name = '(4) Close Air Combat Bore Mode', category = 'Modes'},
--{down = iCommandPlaneModeHelmet, name = '(5) Close Air Combat HMD Helmet Mode', category = 'Modes'},
{down = iCommandPlaneModeFI0, name = '(6) Longitudinal Missile Aiming Mode/FLOOD mode', category = 'Modes'},
--{down = iCommandPlaneModeGround, name = '(7) Air-To-Ground Mode', category = 'Modes'},
--{down = iCommandPlaneModeGrid, name = '(8) Gunsight Reticle Switch', category = 'Modes'},

-- Sensors
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = 'Target Lock', category = 'Sensors'},
{down = iCommandSensorReset, name = 'Radar - Return To Search/NDTWS', category = 'Sensors'},
{down = iCommandRefusalTWS, name = 'Unlock TWS Target', category = 'Sensors'},
{down = iCommandPlaneRadarOnOff, name = 'Radar On/Off', category = 'Sensors'},
{down = iCommandPlaneRadarChangeMode, name = 'Radar RWS/TWS Mode Select', category = 'Sensors'},
{down = iCommandPlaneRadarCenter, name = 'Target Designator To Center', category = 'Sensors'},
{down = iCommandPlaneChangeRadarPRF, name = 'Radar Pulse Repeat Frequency Select', category = 'Sensors'},
--{down = iCommandPlaneEOSOnOff, name = 'Electro-Optical System On/Off', category = 'Sensors'},
--{down = iCommandPlaneLaserRangerOnOff, name = 'Laser Ranger On/Off', category = 'Sensors'},
--{down = iCommandPlaneNightTVOnOff, name = 'Night Vision (FLIR or LLTV) On/Off', category = 'Sensors'},
{pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = 'Target Designator Up', category = 'Sensors'},
{pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = 'Target Designator Down', category = 'Sensors'},
{pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = 'Target Designator Left', category = 'Sensors'},
{pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = 'Target Designator Right', category = 'Sensors'},
{pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = 'Scan Zone Up', category = 'Sensors'},
{pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = 'Scan Zone Down', category = 'Sensors'},
{pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = 'Scan Zone Left', category = 'Sensors'},
{pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = 'Scan Zone Right', category = 'Sensors'},
{down = iCommandPlaneZoomIn, name = 'Display Zoom In', category = 'Sensors'},
{down = iCommandPlaneZoomOut, name = 'Display Zoom Out', category = 'Sensors'},
{down = iCommandPlaneLaunchPermissionOverride, name = 'Launch Permission Override', category = 'Sensors'},
{down = iCommandDecreaseRadarScanArea, name = 'Radar Scan Zone Decrease', category = 'Sensors'},
{down = iCommandIncreaseRadarScanArea, name = 'Radar Scan Zone Increase', category = 'Sensors'},
--{pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = 'Target Specified Size Increase', category = 'Sensors'},
--{pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = 'Target Specified Size Decrease', category = 'Sensors'},
{down = iCommandChangeRWRMode, name = 'RWR/SPO Mode Select', category = 'Sensors'},
{down = iCommandPlaneThreatWarnSoundVolumeDown, name = 'RWR/SPO Sound Signals Volume Down', category = 'Sensors'},
{down = iCommandPlaneThreatWarnSoundVolumeUp, name = 'RWR/SPO Sound Signals Volume Up', category = 'Sensors'},

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = 'Salvo Mode', category = 'Weapons'},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = 'Weapon Release', category = 'Weapons'},
--{down = iCommandChangeGunRateOfFire, name = 'Cannon Rate Of Fire / Cut Of Burst select', category = 'Weapons'},
})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs, name = 'TDC Slew Horizontal'},
{action = iCommandPlaneSelecterVerticalAbs	, name = 'TDC Slew Vertical'},
{action = iCommandPlaneRadarHorizontalAbs	, name = 'Radar Horizontal'},
{action = iCommandPlaneRadarVerticalAbs		, name = 'Radar Vertical'},

{action = iCommandPlaneMFDZoomAbs 			, name = 'MFD Range'},
{action = iCommandPlaneBase_DistanceAbs 	, name = 'Base/Distance'},

{action = iCommandWheelBrake,		name = 'Wheel Brake'},
{action = iCommandLeftWheelBrake,	name = 'Wheel Brake Left'},
{action = iCommandRightWheelBrake,	name = 'Wheel Brake Right'},
})
return res