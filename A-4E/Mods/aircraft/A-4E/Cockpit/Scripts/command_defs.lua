Keys =
{
	PlanePickleOn	= 350,
	PlanePickleOff	= 351,
	PlaneFireOn		= 84,
	PlaneFireOff	= 85,
    PlaneChgWeapon  = 101,
    PlaneModeNAV    = 105,
    PlaneModeBVR    = 106,
    PlaneModeGround = 111,

	
	Canopy = 71,
	
	PlaneAirBrake = 73,		
	PlaneAirBrakeOn = 147,
	PlaneAirBrakeOff = 148,	
	
	PlaneFlaps = 72,
	PlaneFlapsOn = 145, -- Fully down
	PlaneFlapsOff = 146, -- Fully up
    	
	PlaneGear = 68,						-- Шасси
	PlaneGearUp	= 430,
	PlaneGearDown = 431,
	
	Engine_Start	= 311,
	Engine_Stop		= 312,
	
	-- LeftEngineStart = 311,			-- ?????? ?????? ?????????
	-- RightEngineStart = 312,			-- ?????? ??????? ?????????

	-- LeftEngineStop = 313,				-- ?????????? ?????? ?????????
	-- RightEngineStop = 314,			-- ?????????? ??????? ?????????

	PowerOnOff = 315,

    -- add custom commands here --
    PlaneFlapsTakeoff = 10001,
    PlaneFlapsStop = 10002,

    SpoilersArmToggle = 10003,
    SpoilersArmOn = 10004,
    SpoilersArmOff = 10005,

}

start_command   = 3000
device_commands =
{
    Button_Test = start_command + 0,
    Button_1 = start_command + 1,
}
