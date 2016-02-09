local WeaponSystem     = GetSelf()
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."Systems/stores_config.lua")

local update_rate = 0.006
make_default_activity(update_rate)

------------------------------------------------
----------------  CONSTANTS  -------------------
------------------------------------------------
local iCommandPlaneWingtipSmokeOnOff = 78
local iCommandPlaneJettisonWeapons = 82
local iCommandPlaneChangeWeapon = 101
local iCommandActiveJamming = 136
local iCommandPlaneJettisonFuelTanks = 178
local iCommandPlanePickleOn = 350
local iCommandPlanePickleOff = 351
local iCommandPlaneDropFlareOnce = 357
local iCommandPlaneDropChaffOnce = 358

------------------------------------------------
--------------  END CONSTANTS  -----------------
------------------------------------------------

local selected_station = 1
local chaff_count = 0
local flare_count = 0
local ECM_status = false
local smoke_state = false
local smoke_equipped = false
local pickle = false

local smoke_actual_state = {}

------------------------------------------------
-----------  AIRCRAFT DEFINITION  --------------
------------------------------------------------

------------------------------------------------
---------  END AIRCRAFT DEFINITION  ------------
------------------------------------------------

WeaponSystem:listen_command(iCommandPlaneWingtipSmokeOnOff)
WeaponSystem:listen_command(iCommandPlaneJettisonWeapons)
WeaponSystem:listen_command(iCommandPlaneChangeWeapon)
WeaponSystem:listen_command(iCommandActiveJamming)
WeaponSystem:listen_command(iCommandPlaneJettisonFuelTanks)
WeaponSystem:listen_command(iCommandPlanePickleOn)
WeaponSystem:listen_command(iCommandPlanePickleOff)
WeaponSystem:listen_command(iCommandPlaneDropFlareOnce)
WeaponSystem:listen_command(iCommandPlaneDropChaffOnce)


function post_initialize()
	selected_station = 1
	chaff_count = 0
	flare_count = 0
	ECM_status = false
	smoke_state = false
    smoke_equipped = false
	pickle = false
	
	for i=1, num_stations, 1 do
		smoke_actual_state[i] = false
	end
end

function update()
	chaff_count = WeaponSystem:get_chaff_count()
	flare_count = WeaponSystem:get_flare_count()
	
	ECM_status = WeaponSystem:get_ECM_status()
	
	
	smoke_equipped = false
	for i=1, num_stations, 1 do
		local station = WeaponSystem:get_station_info(i-1)
		
		if station.count > 0 then
			if station.weapon.level3 == wsType_Smoke_Cont then	
				smoke_equipped = true	
				----Uncomment these lines when using EFM
				--if smoke_actual_state[i] ~= smoke_state then
				--	WeaponSystem:launch_station(i-1)
				--	smoke_actual_state[i] = smoke_state
				--end
			end
		end
	end	
	
	
	if pickle then
		local station = WeaponSystem:get_station_info(selected_station-1)
		if station.count > 0 then
			if station.weapon.level2 == wsType_Missile or station.weapon.level2 == wsType_Bomb or station.weapon.level2 == wsType_NURS then	
				WeaponSystem:launch_station(selected_station-1)
			end
		end
	end
	
end

function SetCommand(command,value)
	if command == iCommandPlaneWingtipSmokeOnOff then
		if smoke_equipped == true then
			if smoke_state == false then
				smoke_state = true
			else
				smoke_state = false
			end		
		else
			print_message_to_user("Smoke Not Equipped")
		end
	elseif command == iCommandPlaneJettisonWeapons then
		for i=1, num_stations, 1 do
			local station = WeaponSystem:get_station_info(i-1)
			
			if station.count > 0 and station.weapon.level1 == wsType_Weapon then
				WeaponSystem:emergency_jettison(i-1)
			end
		end
	elseif command == iCommandPlaneChangeWeapon then
		selected_station = selected_station + 1
		if selected_station > num_stations then
			selected_station = 1
		end
	elseif command == iCommandPlaneJettisonFuelTanks then
		for i=1, num_stations, 1 do
			local station = WeaponSystem:get_station_info(i-1)
			
			if station.count > 0 and station.weapon.level3 == wsType_FuelTank then
				WeaponSystem:emergency_jettison(i-1)
			end
		end
	elseif command == iCommandPlanePickleOn then
		pickle = true	
	elseif command == iCommandPlanePickleOff then
		pickle = false	
	elseif command == iCommandPlaneDropFlareOnce then
		WeaponSystem:drop_flare(1)
	elseif command == iCommandPlaneDropChaffOnce then
		WeaponSystem:drop_chaff(1)		
	elseif command == iCommandActiveJamming then
		if ECM_status then
			WeaponSystem:set_ECM_status(false)
		else
			WeaponSystem:set_ECM_status(true)
		end
		
	end
	
	
end