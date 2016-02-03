local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")
join(res.keyCommands,{
{down = iCommandPlaneAutopilot, name = _('Autopilot - Attitude Hold'), category = 'Autopilot'},
{down = iCommandPlaneStabHbar, name = _('Autopilot - Altitude Hold'), category = 'Autopilot'},
{down = iCommandPlaneStabCancel, name = _('Autopilot Disengage'), category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_T_up, name = _('CAS Pitch'), category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_K_up, name = _('CAS Roll'), category = 'Autopilot'},
{down = iCommandHelicopter_PPR_button_H_up, name = _('CAS Yaw'), category = 'Autopilot'},

--Flight Control
{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('T/O Trim'), category = 'Flight Control'},

-- Systems
{down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = 'Systems'},
{down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = 'Systems'},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = 'Systems'},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Gear Steering Disengage'), category = 'Systems'},
{down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left On/Off'), category = 'Systems'},
{down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = 'Systems'},
{down = iCommandPlaneFSQuantityIndicatorSelectorMAIN, name = _('Fuel Quantity Selector'), category = 'Systems'},
{down = iCommandPlaneFSQuantityIndicatorTest, up = iCommandPlaneFSQuantityIndicatorSelectorINT, name = _('Fuel Quantity Test'), category = 'Systems'},
{down = iCommandPlaneHook, name = _('Tail Hook'), category = 'Systems'},
{down = iCommandPlanePackWing, name = _('Folding Wings'), category = 'Systems'},

-- Modes
{down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = 'Modes'},
{down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = 'Modes'},
{down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = 'Modes'},
--{down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = 'Modes'},
{down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'), category = 'Modes'},
--{down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = 'Modes'},
--{down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = 'Modes'},

-- Sensors
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = 'Sensors'},
{down = iCommandSensorReset, name = _('Radar - Return To Search/NDTWS'), category = 'Sensors'},
{down = iCommandRefusalTWS, name = _('Unlock TWS Target'), category = 'Sensors'},
{down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = 'Sensors'},
{down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = 'Sensors'},
{down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = 'Sensors'},
{down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = 'Sensors'},
--{down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = 'Sensors'},
--{down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = 'Sensors'},
--{down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = 'Sensors'},
{pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = 'Sensors'},
{pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = 'Sensors'},
{pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = 'Sensors'},
{pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = 'Sensors'},
{pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = _('Scan Zone Up'), category = 'Sensors'},
{pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'), category = 'Sensors'},
{pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'), category = 'Sensors'},
{pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = _('Scan Zone Right'), category = 'Sensors'},
{down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = 'Sensors'},
{down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = 'Sensors'},
{down = iCommandPlaneLaunchPermissionOverride, name = _('Launch Permission Override'), category = 'Sensors'},
{down = iCommandDecreaseRadarScanArea, name = _('Radar Scan Zone Decrease'), category = 'Sensors'},
{down = iCommandIncreaseRadarScanArea, name = _('Radar Scan Zone Increase'), category = 'Sensors'},
--{pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = 'Sensors'},
--{pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = 'Sensors'},
{down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = 'Sensors'},
{down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = 'Sensors'},
{down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = 'Sensors'},

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = 'Weapons'},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = 'Weapons'},
--{down = iCommandChangeGunRateOfFire, name = _('Cannon Rate Of Fire / Cut Of Burst select'), category = 'Weapons'},
})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs, name = _('TDC Slew Horizontal'},
{action = iCommandPlaneSelecterVerticalAbs	, name = _('TDC Slew Vertical'},
{action = iCommandPlaneRadarHorizontalAbs	, name = _('Radar Horizontal'},
{action = iCommandPlaneRadarVerticalAbs		, name = _('Radar Vertical'},

{action = iCommandPlaneMFDZoomAbs 			, name = _('MFD Range'},
{action = iCommandPlaneBase_DistanceAbs 	, name = _('Base/Distance'},

{action = iCommandWheelBrake,		name = _('Wheel Brake'},
{action = iCommandLeftWheelBrake,	name = _('Wheel Brake Left'},
{action = iCommandRightWheelBrake,	name = _('Wheel Brake Right'},
})
return res