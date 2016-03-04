local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
--devices["AVIONICS"]					= counter()--1
devices["TEST"]						= counter()--1
devices["WEAPON_SYSTEM"]			= counter()--2
devices["ELECTRIC_SYSTEM"]			= counter()--3
devices["CLOCK"]					= counter()--4
devices["ADI"]						= counter()--5
devices["RADAR"]					= counter()--6
devices["EXTANIM"]					= counter()--7
devices["SLATS"]					= counter()--8
devices["AIRBRAKES"]				= counter()--9
devices["FLAPS"]                    = counter()--10
devices["GEAR"]                     = counter()--11
devices["SPOILERS"]                 = counter()--12
devices["CANOPY"]					= counter()--next
devices["HUFFER"]					= counter()--next


devices["HUD"] = counter()