Keys =
{
	PlanePickleOn	= 350,
	PlanePickleOff	= 351,
	PlaneFireOn		= 84,
	PlaneFireOff	= 85,
	
	PlaneAirBrake = 73,		
	PlaneAirBrakeOn = 147,
	PlaneAirBrakeOff = 148,	
	
	PlaneFlaps = 72,
	PlaneFlapsOn = 145, -- Fully down
	PlaneFlapsOff = 146, -- Fully up
    	
	PlaneGear = 68,						-- Шасси
	PlaneGearUp	= 430,
	PlaneGearDown = 431,

    -- add custom commands here --
    PlaneFlapsTakeoff = 10001,
    PlaneFlapsStop = 10002,

}

start_command   = 3000
device_commands =
{
    Button_Test = start_command + 0;
}
