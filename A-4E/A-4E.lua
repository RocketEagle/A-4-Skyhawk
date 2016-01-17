--mounting 3d model paths and texture paths 

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/Avionics")
--mount_vfs_texture_path  (current_mod_path.."/Textures/A-4E.zip")
--mount_vfs_texture_path  (current_mod_path.."/Textures/Textures_Cockpit_Rafale_M.zip")
--mount_vfs_model_path    (current_mod_path.."/Cockpit/Resources/Model/Shape")
--mount_vfs_texture_path  (current_mod_path.."/Cockpit/Resources/Model/Textures/Cockpit_MiG-31BM-CPT-TEXTURES")
mount_vfs_texture_path  (current_mod_path.."/Textures")

dofile(current_mod_path.."/Views.lua")

--Tail smoke color format {R, G, B, alpha}
--All values from 0 to 1
tail_solid = { 1, 1, 1, 1 };
tail_liquid = {0.9, 0.9, 0.9, 0.05 };

function coltMK12(tbl)

	tbl.category = CAT_GUN_MOUNT 
	tbl.name 	 = "coltMK12"
	tbl.supply 	 = 
	{
		shells = {"M61_20_HE"},
		--shells = {"M61_20_HE","M61_20_AP"},
		--mixes  = {{1,1,1,1,1,2,2,2,2,2}}, --  
		count  = 100,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 25,
		rates 			 = {1000},
		recoil_coeff 	 = 0.7*1.3,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {0, 0, 0}
	tbl.ejector_pos_connector	= tbl.ejector_pos_connector 	or  "Gun_point"
	tbl.ejector_dir 			= {-6, -2, 0}
	tbl.supply_position  		= tbl.supply_position   or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1500
	tbl.drop_cartridge 			= 204	
	tbl.muzzle_pos				= tbl.muzzle_pos 		 or  {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector 		or  "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
					   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
					   { name = "SmokeEffect"}}
	end
	return declare_weapon(tbl)
end


A_4E =  {
        
	Name 				=   'A-4E',
	DisplayName			= _('A-4E'),
	Cannon = "yes",
	HumanCockpit 		= false, --true,
	--HumanCockpitPath    = current_mod_path..'/Cockpit/Scripts/',
	HumanCockpitPath    = current_mod_path..'/Cockpit/',
	
	Picture 			= "A-4E.png",
	Rate 				= 40, -- RewardPoint in Multiplayer
	Shape 				= "A-4E",
	
	shape_table_data 	= 
	{
		{
			file  	 	= 'A-4E';
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'Rafale_M-oblomok'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destroyed: 300sec 2m
			username	= 'A-4E';
			index    	=  WSTYPE_PLACEHOLDER;
		},
		{
			name  = "Rafale_M-oblomok";
			file  = "Rafale_M-oblomok";
			fire  = { 240, 2};
		},

	},
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,
						"Multirole fighters", "Refuelable",},
	Categories = {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	---------------------
	M_empty		=	5242.17, --empty+oil+trapped fuel+pilot+armor+liquid oxy+2 cannons(no rounds)+J52-P8A+5 pylons+hump, sans spoilers  --11557lb 
	M_nominal	=	8318,-- kg
	M_max		=	11136,-- kg
	M_fuel_max	=	2498.4,-- kg  (810 gal, JP-5 => 6.8 lb per gal)
	H_max		=	12880,-- m
	
	length 			= 12.22, -- full lenght in m		
	height 			= 4.57, -- height in m					
	wing_area 		= 24.16, -- wing area in m2 		**
	wing_span 		= 8.38 , -- wing span in m		
	wing_tip_pos 	= {-2.5,	-0.38,	4.2}, -- wingtip coords for visual effects		
	wing_type 		= 0,	-- FIXED_WING = 0 /VARIABLE_GEOMETRY = 1 /FOLDED_WING = 2 /ARIABLE_GEOMETRY_FOLDED = 3
	flaps_maneuver 	= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	has_speedbrake	= true,
	
	RCS 					= 1, -- Radar Cross Section m2
	IR_emission_coeff 		= 0.5, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab	= 1.0, -- With afterburner
	
	stores_number	=	5,
	
	CAS_min			= 42, -- minimal indicated airspeed  m/s?
	V_opt			= 200, -- Cruise speed (for AI)
	V_take_off		= 49, -- Take off speed in m/s (for AI)	
	V_land			= 58, -- Land speed in m/s (for AI) (110 kn)
	V_max_sea_level = 300.83, -- Max speed at sea level in m/s (for AI) 
	V_max_h 		= 300.8, -- Max speed at max altitude in m/s (for AI)	
	Vy_max 			= 52, -- Max climb speed in m/s (for AI)	
	Mach_max 		= 0.88, -- Max speed in Mach (for AI)	
	Ny_min 			= -3.0, -- Min G (for AI)
	Ny_max 			= 8.0, -- Max G (for AI)
	Ny_max_e 		= 8.0, -- Max G (for AI)
	AOA_take_off 	= 0.27, -- AoA in take off radians (for AI)   16 degrees 
	bank_angle_max 	= 60, -- Max bank angle (for AI)
	range 			= 3200, -- Max range in km (for AI)
	
	thrust_sum_max 	= 4218.4, -- thrust in kg (J52 P8A: 9300 lb)	**
	has_afteburner	= false,	
	thrust_sum_ab 	= 4218.4, -- thrust in kg (kN)	**
	average_fuel_consumption	=	1,   -- 0.89 lb/lbf*hr = 1.246 kg/s for 100% thrust
	is_tanker	=	false,
	tanker_type 	= 2, -- Tanker type if the plane is tanker
	air_refuel_receptacle_pos = 	{6.966, -0.366, 0.486}, 
	
	nose_gear_pos = 	{2.72,	   -2.37,	0},	--      2.72,	   -2.28,	0
	main_gear_pos = 	{-0.79,   -2.42,	1.18},	--  0.79,   -2.35,	1.18
	tand_gear_max = 	0.554, -- // tangent on maximum yaw angle of front wheel
	
	nose_gear_amortizer_direct_stroke    = 0.1, --1.878 - 1.878,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  = -0.32, --1.348 - 1.878,  -- up 
	main_gear_amortizer_direct_stroke	 = 0.1, --1.592 - 1.592, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  = -0.43, --1.192 - 1.592, --  up 
	
	nose_gear_amortizer_normal_weight_stroke = -0.18, -- 0.144
	main_gear_amortizer_normal_weight_stroke = -0.38, --
	
	nose_gear_wheel_diameter	=	0.441, --*
	main_gear_wheel_diameter	=	0.609, --*
	brakeshute_name	=	0, -- Landing - brake chute visual shape after separation
	
	engines_count	=	1,
	engines_nozzles = 
	{
		[1] = 
		{
			pos = 	{-5.9,	0.163,	0}, -- nozzle coords
			elevation	=	0.0, -- AFB cone elevation
			diameter	=	0.6, -- AFB cone diameter
			exhaust_length_ab	=	4, -- lenght in m
			exhaust_length_ab_K	=	0.707, -- AB animation
			smokiness_level     = 	0.03, 
		}, -- end of [1]
	}, -- end of engines_nozzles
	
	crew_size	= 1,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	=	17,
			drop_canopy_name	=	"A-4E_canopy", --23,
			pos = 		{3.077,	-0.1,	0}, --changes the position of the cockpit view {3.077,	0.574,	0}
			canopy_pos = {3.077,	0.674,	0},
		}, -- end of [1]
	}, -- end of crew_members
	
	fires_pos = 
	{
		[1] = 	{-0.232,	0.262,	0},
		[2] = 	{-2.508,	0.08,	3.094},
		[3] = 	{-2.815,	0.056,	-3.639},
		[4] = 	{-0.82,	0.265,	2.774},		-- Wing center Right? {-0.82,	0.265,	2.774},
		[5] = 	{-0.82,	0.265,	-2.774},	-- Wing center Left?  {-0.82,	0.265,	-2.774},
		[6] = 	{-0.82,	0.255,	4.274},		-- Wing outer Right? {-0.82,	0.255,	4.274},
		[7] = 	{-0.82,	0.255,	-4.274},	-- Wing outer Left?  {-0.82,	0.255,	-4.274},
		[8] = 	{-5.6,	0.185,	0},			-- High Altitude Contrails
		[9] = 	{-7.728,	0.039,	-0.5},	-- High Altitude Contrails
		[10] = 	{-7.728,	0.039,	0.5},	-- Right Engine? {0.304,	-0.748,	0.442},
		[11] = 	{-7.728,	0.039,	-0.5},	-- Left Engine? {0.304,	-0.748,	-0.442},
	}, -- end of fires_pos

	-- Countermeasures
	SingleChargeTotal	 	= 0,
	CMDS_Incrementation 	= 1,
	ChaffDefault 			= 0, 
	ChaffChargeSize 		= 1,
	FlareDefault 			= 0, 
	FlareChargeSize 		= 1,
	CMDS_Edit 				= false,
	chaff_flare_dispenser 	= {
	}, -- end of chaff_flare_dispenser
	
--sensors
	detection_range_max		= 250,		
	radar_can_see_ground	=	true,
	CanopyGeometry = {
		azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation = {-50.0, 90.0} -- pilot view vertical (AI)
	},
	Sensors = {
		RADAR = "AN/APG-63", --en vrai : AN APG 53B
		IRST = "OLS-27",
		OPTIC = "Shkval",--necessite un profil 25T.
		RWR = "Abstract RWR"
	},
	Countermeasures = {
		ECM = "AN/ALQ-165"
	},
	HumanRadio = {
		frequency = 127.5,  -- Radio Freq
		editable = true,
		minFrequency = 100.000,
		maxFrequency = 156.000,
		modulation = MODULATION_AM
	},
	--InheriteCommonCallnames = true,
	
	LandRWCategories = 
	{
		[1] = 
		{
			Name = "AircraftCarrier",
		}, -- end of [1]
	}, -- end of LandRWCategories
	
	-- WingSpan = "8.38",--*
	-- MaxFuelWeight = "2498.4",
	-- MaxHeight = "12880",
	-- MaxSpeed = "300",
	-- MaxTakeOffWeight = "11136",
	-- Picture = "A-4E.png",
	-- Rate = "40",
	-- Shape = "A-4E",
	
	TakeOffRWCategories = 
	{
		[1] = 
		{
			Name = "AircraftCarrier With Catapult",
		}, -- end of [1]
		[2] = 
		{
			Name = "AircraftCarrier With Tramplin",
		}, -- end of [2]
	}, -- end of TakeOffRWCategories	
	WorldID = A_4E,
		
	Failures = {
		{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},

	Guns = {
			coltMK12({muzzle_pos_connector = "GUN_POINT_1",
				rates = {1020},
				--mixes = {{2,1,1,1,1,1}},
				effect_arg_number = 434,
				supply_position = {2, -0.3, -0.4},
				ejector_pos_connector = "GUN_EJECT_1",
				}), 			
			coltMK12({muzzle_pos_connector = "GUN_POINT_2",
				rates = {980},
				--mixes = {{2,1,1,1,1,1}},
				effect_arg_number = 434,
				supply_position = {2, -0.3, -0.4},
				ejector_pos_connector = "GUN_EJECT_2",
				}), 
	},
	
	-- ammo_type = { 
		-- _("CM Combat Mix"),
		-- _("HEI High Explosive Incendiary"),
		-- _("TP Target Practice"),
	-- },

	Pylons =     {
		pylon(1, 0, -0.609, -0.762, -2.845, -- 
			{
			   use_full_connector_position = true, connector = "Pylon1", arg = 341, arg_value = 0,
            },
            {
				--ROCKETS--
				{ CLSID	= 	"{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, --LAU-61, M151 HE
				{ CLSID	=	"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, --LAU 68, MK5 HE
				{ CLSID	= 	"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, --LAU-10 Zuni
				
				--MISSILES--
				{ CLSID = 	"{AGM45_SHRIKE}", connector = "Pylon1b", arg_value = 0.1 }, --AGM 45 SHRIKE	
				
				--BOMBS--				
				{ CLSID	= 	"{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
				{ CLSID	= 	"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
				{ CLSID	= 	"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, --MK-20 ROCKEYEE
            }
        ),	
		pylon(2, 0, -0.047, -0.97, -1.899,
			{
			   use_full_connector_position = true, connector = "Pylon2", arg = 342, arg_value = 0,
            },
            {
				--FUEL TANKS--
				{ CLSID	= "{DFT-300gal}" },
			
				--AIR AIR--
				{ CLSID	= 	"{AIM-9B}" },
				
				--MISSILES
				{ CLSID = 	"{AGM45_SHRIKE}", connector = "Pylon2b", arg_value = 0.1 }, --AGM 45 SHRIKE	
				
				--BOMBS--
				{ CLSID	=	"{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
				{ CLSID	= 	"{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
				{ CLSID	= 	"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
				{ CLSID	= 	"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!
				{ CLSID	=	"{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
				{ CLSID	= 	"{MER_4_MK81_P2}" },
				{ CLSID	= 	"{MER_5_MK81_P2}" },
				{ CLSID	= 	"{MER_6_MK81}" },	--collision train
				{ CLSID	= 	"{MER_4_MK82_P2}" },	
				{ CLSID	= 	"{MER_6_MK82}" },	--collision train
				{ CLSID	= 	"{MER_6_MK82_SNAKEYE}" }, --foireux
            }
        ),	
		pylon(3, 0, 0.11, -0.90, 0, 
			{
			   use_full_connector_position = true, connector = "Pylon3", arg = 343, arg_value = 0,
            },
			{
				--FUEL TANKS--
				{ CLSID	= "{DFT-300gal}" },
				{ CLSID	= "{D-704_BUDDY_POD}" },
				
				--ROCKETS--
				{ CLSID	=	"{3*LAU-61}" },
				{ CLSID	=	"{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, --3*LAU 68, MK5 HE
				
				--BOMBS--			
				{ CLSID	=	"{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
				{ CLSID	= 	"{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
				{ CLSID	= 	"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
				{ CLSID	= 	"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!			
				{ CLSID	=	"{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, --MK-84
				{ CLSID	=	"{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
				
				{ CLSID	=	"{B83CB620-5BBE-4BEA-910C-EB605A327EF9}" }, --3*MK-20 ROCKEYE --foireux							
				{ CLSID = 	"{BRU-42_3*Mk-82AIR}" },  -- TER MK-82AIR
				{ CLSID = 	"{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
				
				{ CLSID	= 	"{MER_6_MK81}" },
				{ CLSID	= 	"{MER_4_MK82}" },
				{ CLSID	= 	"{MER_6_MK82}" },
				{ CLSID	= 	"{MER_6_MK82_SNAKEYE}" }, --foireux
				{ CLSID	= 	"{MER_4_MK20}" },
				{ CLSID	= 	"{MER_6_MK20}" },
            }
        ),	
		pylon(4, 0, -0.047, -0.97, 1.899, 
			{
			   use_full_connector_position = true, connector = "Pylon4", arg = 344, arg_value = 0,
            },
            {
				--FUEL TANKS--
				{ CLSID	= "{DFT-300gal}" },
			
				--AIR AIR--
				{ CLSID	= 	"{AIM-9B}" },
				
				--MISSILES
				{ CLSID = 	"{AGM45_SHRIKE}", connector = "Pylon4b", arg_value = 0.1 }, --AGM 45 SHRIKE	
				
				--BOMBS--
				{ CLSID	=	"{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
				{ CLSID	= 	"{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
				{ CLSID	= 	"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
				{ CLSID	= 	"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!
				{ CLSID	=	"{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
				{ CLSID	= 	"{MER_4_MK81_P4}" },
				{ CLSID	= 	"{MER_5_MK81_P4}" },
				{ CLSID	= 	"{MER_6_MK81}" },	--collision train
				{ CLSID	= 	"{MER_4_MK82_P4}" },
				{ CLSID	= 	"{MER_6_MK82}" },	--collision train
				
            }
        ),	
		pylon(5, 0, -0.609, -0.762, 2.845, 
			{
			   use_full_connector_position = true, connector = "Pylon5", arg = 345, arg_value = 0,
            },
            {
				--ROCKETS--
				{ CLSID	= 	"{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, --LAU-61, M151 HE
				{ CLSID	=	"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, --LAU 68, MK5 HE
				{ CLSID	= 	"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, --LAU-10 Zuni
				
				--MISSILES--
				{ CLSID = 	"{AGM45_SHRIKE}", connector = "Pylon5b", arg_value = 0.1 }, --AGM 45 SHRIKE	
				
				--BOMBS--				
				{ CLSID	= 	"{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
				{ CLSID	= 	"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
				{ CLSID	= 	"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, --MK-20 ROCKEYE

            }
        ),			
	},
	
	Tasks = {
        aircraft_task(CAS),
		aircraft_task(SEAD),
		aircraft_task(Reconnaissance),
		aircraft_task(GroundAttack),
--      aircraft_task(AFAC),
	    aircraft_task(RunwayAttack),
		aircraft_task(AntishipStrike),
    },	
	DefaultTask = aircraft_task(CAS),

	SFM_Data = {
	aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0			= 0,	-- zero AoA lift coefficient
			Mzalfa		= 5,	-- coefficients for pitch agility
			Mzalfadt	= 1,	-- coefficients for pitch agility
			kjx 		= 2.25,	-- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations) - smaller = massive inertia
			kjz 		= 0.00125,	-- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe 		= -0.016,	-- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear		= 0.12,	-- coefficient, drag, gear ??
			cx_flap		= 0.07,	-- coefficient, drag, full flaps
			cy_flap		= 0.24,	-- coefficient, normal force, lift, flaps
			cx_brk 		= 0.08,	-- coefficient, drag, breaks
			table_data = {
			--      	M	Cx0	Cya	B	B4	      Omxmax	Aldop		Cymax

					{0.0,	0.012,	0.10,	0.04,	0.03,		1.0,	14,		1.0,	},
					{0.1,	0.012,	0.11,	0.04,	0.03,		1.5,	14,		1.3,    },
					{0.2,	0.013,	0.12,	0.04,	0.03,		2.3,	14,		1.3,    },
					{0.3,	0.014,	0.11,	0.04,	0.03,		2.6,	14,		1.3,    },
					{0.4,	0.0145,	0.10,	0.04,	0.03,		2.6,	14,		1.4,    },
					{0.5,	0.015,	0.09,	0.04,	0.03,		2.3,	14,		1.5,    },
					{0.6,	0.015,	0.08,	0.04,	0.03,		2.3,	14,		1.6,    },
					{0.7,	0.015,	0.07,	0.04,	0.03,		2.3,	14,		1.5,    },
					{0.8,	0.015,	0.06,	0.04,	0.03,		2.3,	14,  	1.4,    }, -- Cx0
					{0.85,	0.015,	0.06,	0.04,	0.03,		2.3,	14,  	1.4,    }, -- 0.030
					{0.9,	0.045,	0.05,	0.04,	0.03,		1.0,	14,		1.4,	}, -- 0.060
					{0.95,	0.085,	0.04,	0.04,	0.03,		-2.0,	14,		1.4,	}, -- 0.060
					{1.0,	0.115,	0.03,	0.04,	0.03,		-1.0,	14,		1.4		}, -- 0.100
			}
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B2 - Polar 2nd power coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	55.0,	-- RPM at idle
			MinRUD	=	0,	-- Min state of the throttle
			MaxRUD	=	1,	-- Max state of the throttle
			MaksRUD	=	1,	-- Military power state of the throttle
			ForsRUD	=	1,	-- Afterburner state of the throttle
			typeng	=	0,	
			--[[
				E_TURBOJET = 0
				E_TURBOJET_AB = 1
				E_PISTON = 2
				E_TURBOPROP = 3
				E_TURBOFAN	= 4
				E_TURBOSHAFT = 5
			--]]
			hMaxEng	=	15,	-- Max altitude for safe engine operation in km
			dcx_eng	=	0.0114,	-- Engine drag coeficient
			-- Affects drag of engine when shutdown
			-- cemax/cefor affect sponginess of elevator/inertia at slow speed
			-- affects available g load apparently
			cemax	=	0.037,	-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	0.037,	-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	6000,	--  altitude coefficient for max thrust
			dpdh_f	=	14000.0,	--  altitude coefficient for AB thrust
			table_data = 
			{
			--   M			Pmax
				{0.0,		41364.0}, -- 41,364 kN
				{0.1,		41364.0}, --
				{0.2,		39800.0}, -- 130 KTS = 3650 FT VS. 3800 FT MANUAL
				{0.3,		34800.0}, -- 12800 = 2 mins 40 sec vs. 4 mins
				{0.4,		36200.0}, --24800.0 22800.0 23800.0 21200.0 19500.0 14800.0 11700.0
				{0.5,		39100.0}, --26000.0 23000.0 24000.0 21800.0 19000.0 14700.0 14000.0
				{0.6,		39500.0}, --28200.0 23200.0 24200.0 22400.0 18000.0 14600.0 14500.0 30% (30 mins vs. 40 mins tables)
				{0.7,		39500.0}, --30400.0 23400.0 24400.0 23000.0 17500.0 14500.0 14500.0
				{0.8,		39500.0}, --32600.0 23600.0 24600.0 23600.0 17000.0 14400.0 14500.0
				{0.9,		39500.0}, --34800.0 23800.0 24800.0 24200.0 16000.0 14300.0 14500.0
				{1.0,		39500.0},  --36000.0 24000.0 25000.0 22000.0 15000.0 14200.0 14500.0
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power - kilo Newton
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},


	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
				[0] = {critical_damage = 5, args = {82}},
				[3] = {critical_damage = 10, args = {65}},
				[8] = {critical_damage = 10},
				[11] = {critical_damage = 3},
				[12] = {critical_damage = 3},
				[15] = {critical_damage = 10},
				[16] = {critical_damage = 10},
				[17] = {critical_damage = 3},
				[18] = {critical_damage = 3},
				[25] = {critical_damage = 5, args = {53}},
				[26] = {critical_damage = 5, args = {54}},
				[35] = {critical_damage = 10, args = {67}, deps_cells = {25, 37}},
				[36] = {critical_damage = 10, args = {68}, deps_cells = {26, 38}},
				[37] = {critical_damage = 4, args = {55}},
				[38] = {critical_damage = 4, args = {56}},
				[43] = {critical_damage = 4, args = {61}, deps_cells = {53}},
				[44] = {critical_damage = 4, args = {62}, deps_cells = {54}},
				[47] = {critical_damage = 5, args = {63}, deps_cells = {51}},
				[48] = {critical_damage = 5, args = {64}, deps_cells = {52}},
				[51] = {critical_damage = 2, args = {59}},
				[52] = {critical_damage = 2, args = {60}},
				[53] = {critical_damage = 2, args = {57}},
				[54] = {critical_damage = 2, args = {58}},
				[55] = {critical_damage = 5, args = {81}},
				[83]	= {critical_damage = 3, args = {134}}, -- nose wheel                                  
				[84]	= {critical_damage = 3, args = {136}}, -- left wheel                                  
				[85]	= {critical_damage = 3, args = {135}}, -- right wheel
	},
	
	DamageParts = 
	{  
		[1] = "Rafale_M-oblomok-wing-r", -- wing R
		[2] = "Rafale_M-oblomok-wing-l", -- wing L
		[3] = "Rafale_M-oblomok-noise", -- nose
		[4] = "Rafale_M-oblomok-tail-r", -- tail
		[5] = "Rafale_M-oblomok-tail-l", -- tail
	},
	
	lights_data = {
	typename = "collection",
	lights = {
    [1] = { typename = "collection",
						lights = {-- Top Anticollision Light (red)
								  {typename = "natostrobelight",
								   connector = "RED_BEACON_T",
								   argument_1 = 198,
								   period = 1.2,
								   phase_shift = 0
								  },
								  -- Bottom Anticollision Light (red)
								  {typename = "natostrobelight",
								   connector = "RED_BEACON_B",
								   argument_1 = 199,
								   period = 1.2,
								   phase_shift = 0
								  }
								 }
		  },
	[2] = { typename = "collection",
							lights = {-- Landing light
									  {typename = "spotlight",
									   connector = "MAIN_SPOT_PTR_02",
									   argument = 209,
									   dir_correction = {elevation = math.rad(-1)}
									  },
									  {-- Landing/Taxi light
									   typename = "spotlight",
									   connector = "MAIN_SPOT_PTR_01",
									   argument = 208,
									   dir_correction = {elevation = math.rad(3)}
									  }
									 }
						},
    [3]	= {	typename = "collection",
								lights = {-- Left Position Light (red)
								{typename = "omnilight",
								 connector = "RED_NAV_L",
								 color = {0.99, 0.11, 0.3},
								 pos_correction  = {0.0, 0, -0.2},
								 argument  = 190
								},
								 -- Right Position Light (green)
								{typename = "omnilight",
								connector = "GREEN_NAV_R",
								color = {0, 0.894, 0.6},
								pos_correction = {0.0, 0, 0.2},
								argument  = 191
								},
								-- Tail Position Light (white)
								{typename = "omnilight",
								connector = "WHITE_NAV_T",
								color = {1, 1, 1},
								pos_correction  = {0, 0, 0},
								argument  = 192
								}}
							},
--[4] = { typename = "collection", -- white strobe upper
--	        lights = {
--				     {typename = "natostrobelight",connector = "WHITE_TOP",argument_1 = 999,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.0},
--				     {typename = "natostrobelight",connector = "WHITE_TOP",argument_1 = 998,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.5},
--			 }
--		},
	[5]	= {typename = "collection",
			lights = {
						{typename = "collection",
						lights = {{
								-- Right Nacelle Floodlight
								typename = "spotlight",
								position  = {0.5, 1.2, 0},
								color = {1.0, 1.0, 1.0},
								intensity_max = 0.0,
								angle_max = 0.45,
								direction = {azimuth = math.rad(150), elevation = math.rad(5)},
								dont_change_color = false,
								angle_change_rate = 0
							   },
							   {
								-- Left Nacelle Floodlight
								typename = "spotlight",
								position  = {0.5, 1.2, 0},
								color = {1.0, 1.0, 1.0},
								intensity_max = 0.0,
								angle_max = 0.45,
								direction = {azimuth = math.rad(-150), elevation = math.rad(5)},
								dont_change_color = false,
								angle_change_rate = 0
							   },
							   {typename  = "argumentlight", argument = 212},
						},
					},
					{typename = "collection",
						lights = {{
								-- Left Nose Floodlight
								typename  = "spotlight",
								position  = {0, -0.3, -5.80},
								color = {1.0, 1.0, 1.0},
								intensity_max = 0.0, angle_max = 0.45,
								direction = {azimuth = math.rad(45)},
								argument = 211,
								dont_change_color = false,
								angle_change_rate = 0
							   },
							   {
								-- Right Nose Floodlight
								typename = "spotlight",
								position  = {0, -0.3, 5.80},
								color = {1.0, 1.0, 1.0},
								intensity_max = 0.0,
								angle_max = 0.45,
								direction = {azimuth = math.rad(-45)},
								argument = 210,
								dont_change_color = false,
								angle_change_rate = 0
							   }
						}
					},
					-- UARRSI light
					{
						typename = "omnilight", position  = {6.5, 0.4, 0}, color = {6, 6, 2}
					}
				  },
			}
		}
	},	
}
add_aircraft(A_4E)


---------FUEL TANKS-----------
declare_loadout(	--300 gal tank
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{DFT-300gal}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 300 gallons"),
		Weight_Empty	= 94,
		Weight			= 94 +  3.028 * 300,
		Cx_pil			= 0.00145,
		shape_table_data = 
		{
			{
				name 	= "DFT_300_GAL_A4E",
				file	= "DFT_300gal_A4E";
				life	= 1;
				fire	= { 0, 1};
				username	= "DFT_300_GAL_A4E";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "DFT_300_GAL_A4E",
			}, 
		}, 
	}
)

declare_loadout(	--D-704 BUDDY POD
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{D-704_BUDDY_POD}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("D-704 Refueling Pod"),
		Weight_Empty	= 323.9,
		Weight			= 323.9 +  3.028 * 300,
		Cx_pil			= 0.0030,
		shape_table_data = 
		{
			{
				name 	= "D-704_POD_A4E",
				file	= "D-704_pod_A4E";
				life	= 1;
				fire	= { 0, 1};
				username	= "D-704_POD_A4E";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "D-704_POD_A4E",
			}, 
		}, 
	}
)

---------AIR AIR--------------
local AIM9B_WPN =   {
		category		= CAT_AIR_TO_AIR,
		name			= "AIM9B-WPN",
		user_name		= _("AIM-9B"),
		wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
        Escort = 0,
        Head_Type = 1,
		sigma = {3, 3, 3},
        M = 88.0,
        H_max = 18000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 2.58,
        D_max = 7000.0,
        D_min = 300.0,
        Head_Form = 0,
        Life_Time = 60.0,
        Nr_max = 40,
        v_min = 140.0,
        v_mid = 350.0,
        Mach_max = 2.7,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 0.0,
        Range_max = 14000.0,
        H_min_t = 1.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.79,
        Fi_search = 0.09,
        OmViz_max = 0.61,
        --warhead = warheads["AIM_9"],
		warhead = enhanced_a2a_warhead(15.0),
        exhaust = { 0.7, 0.7, 0.7, 0.2 };
        X_back = -1.455,
        Y_back = -0.062,
        Z_back = 0,
        Reflection = 0.0182,
        KillDistance = 7.0,
		
		--seeker sensivity params
		SeekerSensivityDistance = 20000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		SeekerCooled			= true, -- True is cooled seeker and false is not cooled seeker.	

		shape_table_data =
		{
			{
				name	 = "AIM9B-SHAPE",
				file	 = "aim-9b", 	--fichier .EDM  Bazar/World/Shapes
				life	 = 1,
				fire	 = { 0, 1},
				username = "AIM-9B", 	--label 
				index = WSTYPE_PLACEHOLDER,
			},
		},
		
		ModelData = {   58 ,  -- model params count
						0.35 ,   -- characteristic square (характеристическая площадь)
						
						-- параметры зависимости Сx
						0.04 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.08 , -- Cx_k1 высота пика волнового кризиса
						0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.05, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						1.2 , -- Cx_k4 крутизна спада за волновым кризисом 
						1.2 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
						
						-- параметры зависимости Cy
						0.5 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.4	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
						
						0.4 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.0, --угловая скорость создаваймая моментом газовых рулей
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,		-1.0,	5.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	5.44,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	12802.0,	0.0,	0.0,			0.0,		0.0,           -- thrust, newtons
					
						 1.0e9, -- таймер самоликвидации, сек
						 60.0, -- время работы энергосистемы, сек
						 0, -- абсолютная высота самоликвидации, м
						 0.3, -- время задержки включения управления (маневр отлета, безопасности), сек
						 1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						 1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						 0.0,  -- синус угла возвышения траектории набора горки
						 30.0, -- продольное ускорения взведения взрывателя
						 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						 -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						 11000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						 5000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
						 5000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
						 0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
						 1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						 1.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},	
}
declare_weapon(AIM9B_WPN)

declare_loadout({	--AIM-9B
	category		=	CAT_AIR_TO_AIR,
	CLSID			= 	"{AIM-9B}",
	Picture			=	"aim9m.png",
	wsTypeOfWeapon	=	AIM9B_WPN.wsTypeOfWeapon,
	displayName		=	_("AIM-9B"),
	attribute		=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
	Cx_pil			=	0.001959765625,
	Count			=	1,
	Weight			=	100,
	Elements	=	
	{
		{	ShapeName	=	"AIM9B-SHAPE" ,	Position	=	{0,-0.124918,0}}, --name of the shape_table_data
	}, -- end of Elements
})

---------MISSILES-------------
declare_loadout({	--AGM 45 SHRIKE
	category	=	CAT_MISSILES,
	CLSID	=	"{AGM45_SHRIKE}",
	Picture	=	"agm45.png",
	wsTypeOfWeapon	=	{wsType_Weapon,wsType_Missile,wsType_AS_Missile, 60},
	displayName	=	_("AGM-45B"),
	attribute	=	{4,	4,	8,	60},
	Cx_pil	=	0.0007,
	Count	=	1,
	Weight	=	39.5 + 181, --AERO-5 + AGM 45
	Elements	=	
	{
		{	ShapeName	=	"AGM-45" , Position	=	{0,	-0.22,	0} }, 
	}, -- end of Elements
})

---------ROCKETS--------------
declare_loadout({	--TER LAU-61
				category=	CAT_ROCKETS, 
				CLSID	=	"{TER,LAU-61*3}",
				Picture	=	"LAU61.png",
				wsTypeOfWeapon	=	{wsType_Weapon, wsType_NURS, wsType_Rocket,	145},
				displayName	=	_("3*LAU-61"),
				--attribute	=	{4,	7,	32,	9},
				attribute	=	{wsType_Weapon,	wsType_NURS, wsType_Container,	9},
				Cx_pil	=	0.002,
				Count	=	57,
				Weight	=	98,
				Elements	=	
				{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"BRU-42_LS",
						IsAdapter 	= 	true, 
					}, 
					[2]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{0,	-0.35,	0},
						ShapeName	=	"LAU-61",
					}, 
					[3]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{0,	-0.13,	0.1253},
						ShapeName	=	"LAU-61",
						Rotation	= 	{-45,0,0},
					}, 
					[4]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{0,	-0.13,	-0.125},
						ShapeName	=	"LAU-61",
						Rotation	= 	{45,0,0},
					}, 
				}, -- end of Elements
})

---------BOMBS----------------
declare_loadout({	--TER MK82 --marche pas!
	category		=	CAT_BOMBS,
	CLSID			= 	"{TER_3_MK82}",
	Picture			=	"mk82.png",
	--wsTypeOfWeapon	=	GAR_8.wsTypeOfWeapon,
	displayName		=	_("TER,MK-82*3"),
	attribute		=	{4,	5,	9,	31},
	Cx_pil			=	0.001959765625,
	Count			=	3,
	Weight			=	723, --3*    + TER-7 (47.6 kg)
	Elements	=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},
			ShapeName	=	"BRU-42_LS",
			IsAdapter = true,
		}, 
		[2]	=	
		{
			Position	=	{0,	0,	0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			Position	=	{0,	0,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[4]	=	
		{
			Position	=	{0,	-0.18,	0},
			ShapeName	=	"mk-82",
		}, 
	}, -- end of Elements
})

declare_loadout({	--MER  MK81 * 6	
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_6_MK81}",
	Picture			=	"fab100.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 30}, --31
	displayName		=	_("MER,MK-81*6"),
	attribute		=	{4,	5,	32,	115}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	6,
	Weight			=	99.8 + 118*6,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[6]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-81",
		}, 
		[7]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-81",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK81 * 4 Pylon 2 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK81_P2}",
	Picture			=	"fab100.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 30}, --31
	displayName		=	_("MER,MK-81*4"),
	attribute		=	{4,	5,	32,	115}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 118*4,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 		
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-81",
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-81",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK81 * 5 Pylon 2
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_5_MK81_P2}",
	Picture			=	"fab100.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 30}, --31
	displayName		=	_("MER,MK-81*5"),
	attribute		=	{4,	5,	32,	115}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	5,
	Weight			=	99.8 + 118*5,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 		
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-81",
		}, 
		[6]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-81",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK81 * 4 Pylon 4 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK81_P4}",
	Picture			=	"fab100.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 30}, --31
	displayName		=	_("MER,MK-81*4"),
	attribute		=	{4,	5,	32,	115}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 118*4,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-81",
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-81",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK81	* 5 Pylon 4
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_5_MK81_P4}",
	Picture			=	"fab100.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 30}, --31
	displayName		=	_("MER,MK-81*5"),
	attribute		=	{4,	5,	32,	115}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	5,
	Weight			=	99.8 + 118*5,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-81",
			Rotation	= 	{-45,0,0},
		}, 		
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-81",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-81",
		}, 
		[6]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-81",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK82	* 6
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_6_MK82}",
	Picture			=	"mk82.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 31}, --31
	displayName		=	_("MER,MK-82*6"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	6,
	Weight			=	99.8 + 241*6,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[6]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-82",
		}, 
		[7]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-82",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK82	* 4
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK82}",
	Picture			=	"mk82.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 31}, --31
	displayName		=	_("MER,MK-82*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 241*4,  --4*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		},  				
	}, -- end of Elements
})

declare_loadout({	--MER  MK82 * 4 Pylon 2 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK82_P2}",
	Picture			=	"mk82.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 31}, --31
	displayName		=	_("MER,MK-82*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 241*4,   --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 		
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-82",
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-82",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK82 * 4 Pylon 4 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK82_P4}",
	Picture			=	"mk82.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 31}, --31
	displayName		=	_("MER,MK-82*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 241*4,   --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 		
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112, 0.13},
			ShapeName	=	"mk-82",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"mk-82",
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"mk-82",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK82	SNAKEYE	--foireux
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_6_MK82_SNAKEYE}",
	Picture			=	"mk82air.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 79},
	displayName		=	_("MER,MK-82 SNAKEYE*6"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	6,
	Weight			=	99.8 + 256.3*6,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"MK-82_Snakeye",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"MK-82_Snakeye",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.112,	-0.13},
			ShapeName	=	"MK-82_Snakeye",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167, -0.112,	-0.13},
			ShapeName	=	"MK-82_Snakeye",
			Rotation	= 	{45,0,0},
		}, 
		[6]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"MK-82_Snakeye",
		}, 
		[7]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.167,	 -0.309,	0},
			ShapeName	=	"MK-82_Snakeye",
		}, 				
	}, -- end of Elements
})

declare_loadout({	--MER  MK20	* 4 -- foireux ne s'ouvre pas
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK20}",
	Picture			=	"mk20.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, 45}, --31
	displayName		=	_("MER,MK-20 ROCKEYE*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 222*4,  -- + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	"mer_a4e", 
			IsAdapter   =   true,
		}, 	
		[2]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.131,	-0.112,	0.13},  -- 1.29
			ShapeName	=	"rockeye",
			Rotation	= 	{-45,0,0},
		}, 
		[3]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.177, -0.112,	0.13}, 	--	-1.01
			ShapeName	=	"rockeye",
			Rotation	= 	{-45,0,0},
		}, 
		[4]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{1.131,	-0.112,	-0.13},
			ShapeName	=	"rockeye",
			Rotation	= 	{45,0,0},
		}, 
		[5]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{-1.177, -0.112,	-0.13},
			ShapeName	=	"rockeye",
			Rotation	= 	{45,0,0},
		},  				
	}, -- end of Elements
})
