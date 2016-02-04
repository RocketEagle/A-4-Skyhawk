-- Simplified Aerodynamic Model by Helmo
-- mounting 3d model paths and texture paths 

mount_vfs_model_path    (current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures")

local function coltMK12(tbl)

    tbl.category = CAT_GUN_MOUNT 
    tbl.name      = "coltMK12"
    tbl.supply      = 
    {
        shells = {"M61_20_HE"},
        --shells = {"M61_20_HE","M61_20_AP"},
        --mixes  = {{1,1,1,1,1,2,2,2,2,2}}, --  
        count  = 100,
    }
    if tbl.mixes then 
       tbl.supply.mixes =  tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun = 
    {
        max_burst_length = 25,
        rates              = {1000},
        recoil_coeff      = 0.7*1.3,
        barrels_count      = 1,
    }
    if tbl.rates then 
       tbl.gun.rates    =  tbl.rates
       tbl.rates        = nil
    end    
    tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
    tbl.ejector_pos_connector    = tbl.ejector_pos_connector     or  "Gun_point"
    tbl.ejector_dir             = {-6, -2, 0}
    tbl.supply_position          = tbl.supply_position   or {0,  0.3, -0.3}
    tbl.aft_gun_mount             = false
    tbl.effective_fire_distance = 1500
    tbl.drop_cartridge             = 204    
    tbl.muzzle_pos                = tbl.muzzle_pos          or  {0,0,0} -- all position from connector
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector         or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial    or 0   
    tbl.elevation_initial         = tbl.elevation_initial  or 0   
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect"     , arg          = tbl.effect_arg_number or 436 },
                       { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
                       { name = "SmokeEffect"}}
    end
    return declare_weapon(tbl)
end



A_4E =  {
        
    Name                 =   'A-4E',
    DisplayName            = _('A-4E'),
    ViewSettings        = ViewSettings,
	Countries = {"USA","Isreal","Australia"},
    
    HumanCockpit         = false,
    HumanCockpitPath    = current_mod_path..'/Cockpit/',
    
    Picture             = "A-4E.png",
    Rate                 = 40, -- RewardPoint in Multiplayer
    Shape                 = "A-4E",
    
    shape_table_data     = 
    {
        {
            file       = 'A-4E';
            life       = 18; -- lifebar
            vis        = 3;  -- visibility gain.
            desrt    = 'Alphajet-destr'; -- Name of destroyed object file name Alphajet-destr
            fire       = {300, 3}; -- Fire on the ground after destoyed: 300sec 2m
            username = 'A-4E';
            index    =  WSTYPE_PLACEHOLDER;
        },
        {
            name  = "Alphajet-destr";
            file  = "Alphajet-destr";
            fire  = {240, 2};  -- 240  2
        },

    },
    
    -- add model draw args for network transmitting to this draw_args table (32 limit)
    net_animation ={38, -- canopy
                    0, -- gear
                    3,
                    5,
                    9,
                    10, 
                    11, -- aileron
                    15, -- stabilizer
                    20,  -- flaps
                    21, -- air brake
                    7, -- rat
                    13, -- prop slow
                    14, -- prop fast
                    130 -- Nose Light
                    },
                    
    mapclasskey         = "P0091000024",
    attribute              = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,
                        "Multirole fighters", "Refuelable",},
    Categories = {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},    
    -------------------------
    M_empty                     = 5242.17, -- kg
    M_nominal                     = 8318, -- kg
    M_max                         = 11136, -- kg
    M_fuel_max                     = 2498.4, -- kg --
    H_max                          = 12880, -- m

    length             = 12.22, -- full lenght in m        
    height             = 4.57, -- height in m                    
    wing_area         = 24.16, -- wing area in m2         **
    wing_span         = 8.38 , -- wing span in m        
    wing_tip_pos     = {-2.5, -0.38,    4.2}, -- wingtip coords for visual effects        
    wing_type         = 0,    -- FIXED_WING = 0 /VARIABLE_GEOMETRY = 1 /FOLDED_WING = 2 /ARIABLE_GEOMETRY_FOLDED = 3
    flaps_maneuver     = 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
    has_speedbrake    = true,
    
    RCS                     = 1, -- Radar Cross Section m2
    IR_emission_coeff         = 0.5, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
    IR_emission_coeff_ab    = 1.0, -- With afterburner
    
    stores_number    = 5,
    
    CAS_min            = 42, -- minimal indicated airspeed  m/s?
    V_opt            = 200, -- Cruise speed (for AI)
    V_take_off        = 49, -- Take off speed in m/s (for AI)    
    V_land            = 58, -- Land speed in m/s (for AI) (110 kn)
    V_max_sea_level = 300.83, -- Max speed at sea level in m/s (for AI) 
    V_max_h         = 300.8, -- Max speed at max altitude in m/s (for AI)    
    Vy_max             = 52, -- Max climb speed in m/s (for AI)    
    Mach_max         = 0.88, -- Max speed in Mach (for AI)    
    Ny_min             = -3.0, -- Min G (for AI)
    Ny_max             = 8.0, -- Max G (for AI)
    Ny_max_e         = 8.0, -- Max G (for AI)
    AOA_take_off     = 0.27, -- AoA in take off radians (for AI)   16 degrees 
    bank_angle_max     = 60, -- Max bank angle (for AI)
    range             = 3200, -- Max range in km (for AI)
    
    thrust_sum_max     = 4218.4, -- thrust in kg (J52 P8A: 9300 lb)    **
    has_afteburner  = false,    
    thrust_sum_ab   = 4218.4, -- thrust in kg (kN)    **
    average_fuel_consumption = 1,   -- 0.89 lb/lbf*hr = 1.246 kg/s for 100% thrust
    is_tanker       = false,
    tanker_type     = 2, -- Tanker type if the plane is tanker
    air_refuel_receptacle_pos = {6.966, -0.366, 0.486}, 
    
    nose_gear_pos = {2.72, -2.37, 0},    --      2.72,       -2.28,    0
    main_gear_pos = {-0.79, -2.42, 1.18},    --  0.79,   -2.35,    1.18
    tand_gear_max = 0.554, -- // tangent on maximum yaw angle of front wheel
    
    nose_gear_amortizer_direct_stroke    = 0.1, --1.878 - 1.878,  -- down from nose_gear_pos !!!
    nose_gear_amortizer_reversal_stroke  = -0.32, --1.348 - 1.878,  -- up 
    main_gear_amortizer_direct_stroke     = 0.1, --1.592 - 1.592, --  down from main_gear_pos !!!
    main_gear_amortizer_reversal_stroke  = -0.43, --1.192 - 1.592, --  up 
    
    nose_gear_amortizer_normal_weight_stroke = -0.18, -- 0.144
    main_gear_amortizer_normal_weight_stroke = -0.38, --
    
    nose_gear_wheel_diameter    =    0.441, --*
    main_gear_wheel_diameter    =    0.609, --*
    brakeshute_name    = 0, -- Landing - brake chute visual shape after separation
    
    engines_count    = 1,
    engines_nozzles = 
    {
        [1] = 
        {
            pos =     {-5.9,    0.163,    0}, -- nozzle coords
            elevation    =    0.0, -- AFB cone elevation
            diameter    =    0.6, -- AFB cone diameter
            exhaust_length_ab    =    4, -- lenght in m
            exhaust_length_ab_K    =    0.707, -- AB animation
            smokiness_level     =     0.03, 
        }, -- end of [1]
    }, -- end of engines_nozzles
    
    crew_size    = 1,
    crew_members = 
    {
        [1] = 
        {
            ejection_seat_name    =    17,
            drop_canopy_name    =    "A-4E_canopy", --23,
            pos =         {3.077,    -0.1,    0}, --changes the position of the cockpit view {3.077,    0.574,    0}
            canopy_pos = {3.077,    0.674,    0},
        }, -- end of [1]
    }, -- end of crew_members
    
    fires_pos = 
    {
        [1] =     {-0.232,    0.262,    0},
        [2] =     {-2.508,    0.08,    3.094},
        [3] =     {-2.815,    0.056,    -3.639},
        [4] =     {-0.82,    0.265,    2.774},        -- Wing center Right? {-0.82,    0.265,    2.774},
        [5] =     {-0.82,    0.265,    -2.774},    -- Wing center Left?  {-0.82,    0.265,    -2.774},
        [6] =     {-0.82,    0.255,    4.274},        -- Wing outer Right? {-0.82,    0.255,    4.274},
        [7] =     {-0.82,    0.255,    -4.274},    -- Wing outer Left?  {-0.82,    0.255,    -4.274},
        [8] =     {-5.6,    0.185,    0},            -- High Altitude Contrails
        [9] =     {-7.728,    0.039,    -0.5},    -- High Altitude Contrails
        [10] =     {-7.728,    0.039,    0.5},    -- Right Engine? {0.304,    -0.748,    0.442},
        [11] =     {-7.728,    0.039,    -0.5},    -- Left Engine? {0.304,    -0.748,    -0.442},
    }, -- end of fires_pos

    -- Countermeasures
    SingleChargeTotal         = 0,
    CMDS_Incrementation     = 1,
    ChaffDefault             = 0, 
    ChaffChargeSize         = 1,
    FlareDefault             = 0, 
    FlareChargeSize         = 1,
    CMDS_Edit                 = false,
    chaff_flare_dispenser     = {
    }, -- end of chaff_flare_dispenser
    
--sensors
    detection_range_max        = 250,        
    radar_can_see_ground    =    true,
    CanopyGeometry = {
        azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
        elevation = {-50.0, 90.0} -- pilot view vertical (AI)
    },
    Sensors = {
        RADAR = "AN/APG-53A", --en vrai : AN APG 53B
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
        { id = 'asc',         label = _('ASC'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'hydro',      label = _('HYDRO'),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'l_engine',  label = _('L-ENGINE'),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'r_engine',  label = _('R-ENGINE'),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'radar',      label = _('RADAR'),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'eos',          label = _('EOS'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'helmet',      label = _('HELMET'),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        --{ id = 'mlws',      label = _('MLWS'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'rws',          label = _('RWS'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ecm',       label = _('ECM'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'hud',          label = _('HUD'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'mfd',          label = _('MFD'),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },        
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
                rates = {1020},
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
                { CLSID    =     "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, --LAU-61, M151 HE
                { CLSID    =    "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, --LAU 68, MK5 HE
                { CLSID    =     "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, --LAU-10 Zuni
                
                --MISSILES--
                { CLSID    =     "{AGM45_SHRIKE}", connector = "Pylon1b", arg_value = 0.1 }, --AGM 45 SHRIKE   
				{ CLSID    =     "{AGM12_B}" }, --AGM-12B
				
                
                --BOMBS--                
                { CLSID    =     "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
                { CLSID    =     "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
                { CLSID    =     "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, --MK-20 ROCKEYEE
                { CLSID    =     "{M117}" },
				
				--SPECIAL--
				
            }
        ),    
        pylon(2, 0, -0.047, -0.97, -1.899,
            {
               use_full_connector_position = true, connector = "Pylon2", arg = 342, arg_value = 0,
            },
            {
                --FUEL TANKS--
                { CLSID    = "{DFT-300gal}" },
            
                --AIR AIR--
                { CLSID    =     "{AIM-9B}" },
                
                --MISSILES
                { CLSID =     "{AGM45_SHRIKE}", connector = "Pylon2b", arg_value = 0.1 }, --AGM 45 SHRIKE
				{ CLSID    =     "{AGM12_C}" }, --AGM-12C
                
                --BOMBS--
                { CLSID    =    "{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
                { CLSID    =     "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
                { CLSID    =     "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
                { CLSID    =     "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!
                { CLSID    =    "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
                { CLSID    =     "{MER_4_MK81_P2}" },
                { CLSID    =     "{MER_5_MK81_P2}" },
                { CLSID    =     "{MER_6_MK81}" },    --collision train
                { CLSID    =     "{MER_4_MK82_P2}" },    
                { CLSID    =     "{MER_6_MK82}" },    --collision train
                { CLSID    =     "{MER_6_MK82_SNAKEYE}" }, --foireux
            }
        ),    
        pylon(3, 0, 0.11, -0.90, 0, 
            {
               use_full_connector_position = true, connector = "Pylon3", arg = 343, arg_value = 0,
            },
            {
                --FUEL TANKS--
                { CLSID    = "{DFT-300gal}" },
                { CLSID    = "{D-704_BUDDY_POD}" },
                
                --ROCKETS--
                { CLSID    =    "{3*LAU-61}" },
                { CLSID    =    "{9BC82B3D-FE70-4910-B2B7-3E54EFE73262}" }, --3*LAU 68, MK5 HE
                
                --BOMBS--            
                { CLSID    =    "{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
                { CLSID    =     "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
                { CLSID    =     "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
                { CLSID    =     "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!            
                { CLSID    =    "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, --MK-84
                { CLSID    =    "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
                
                { CLSID    =    "{B83CB620-5BBE-4BEA-910C-EB605A327EF9}" }, --3*MK-20 ROCKEYE --foireux                            
                { CLSID =     "{BRU-42_3*Mk-82AIR}" },  -- TER MK-82AIR
                { CLSID =     "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- TER 3*MK82
                
                { CLSID    =     "{MER_6_MK81}" },
                { CLSID    =     "{MER_4_MK82}" },
                { CLSID    =     "{MER_6_MK82}" },
                { CLSID    =     "{MER_6_MK82_SNAKEYE}" }, --foireux
                { CLSID    =     "{MER_4_MK20}" },
                { CLSID    =     "{MER_6_MK20}" },
            }
        ),    
        pylon(4, 0, -0.047, -0.97, 1.899, 
            {
               use_full_connector_position = true, connector = "Pylon4", arg = 344, arg_value = 0,
            },
            {
                --FUEL TANKS--
                { CLSID    = "{DFT-300gal}" },
            
                --AIR AIR--
                { CLSID    =     "{AIM-9B}" },
                
                --MISSILES
                { CLSID =     "{AGM45_SHRIKE}", connector = "Pylon4b", arg_value = 0.1 }, --AGM 45 SHRIKE
				{ CLSID    =     "{AGM12_C}" }, --AGM-12C
                
                --BOMBS--
                { CLSID    =    "{C40A1E3A-DD05-40D9-85A4-217729E37FAE}" }, --AGM-62 WALLEYE
                { CLSID    =     "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
                { CLSID    =     "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
                { CLSID    =     "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" }, --MK-83 /!\ n'existe pas!!!
                { CLSID    =    "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, --M-117
                { CLSID    =     "{MER_4_MK81_P4}" },
                { CLSID    =     "{MER_5_MK81_P4}" },
                { CLSID    =     "{MER_6_MK81}" },    --collision train
                { CLSID    =     "{MER_4_MK82_P4}" },
                { CLSID    =     "{MER_6_MK82}" },    --collision train
                
            }
        ),    
        pylon(5, 0, -0.609, -0.762, 2.845, 
            {
               use_full_connector_position = true, connector = "Pylon5", arg = 345, arg_value = 0,
            },
            {
                --ROCKETS--
                { CLSID    =     "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, --LAU-61, M151 HE
                { CLSID    =    "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, --LAU 68, MK5 HE
                { CLSID    =     "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}" }, --LAU-10 Zuni
                
                --MISSILES--
                { CLSID =     "{AGM45_SHRIKE}", connector = "Pylon5b", arg_value = 0.1 }, --AGM 45 SHRIKE    
                
                --BOMBS--                
                { CLSID    =     "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, --MK-81
                { CLSID    =     "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, --MK-82
                { CLSID    =     "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, --MK-20 ROCKEYE

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
            Cy0            = 0,    -- zero AoA lift coefficient
            Mzalfa        = 5,    -- coefficients for pitch agility
            Mzalfadt    = 1,    -- coefficients for pitch agility
            kjx         = 2.25,    -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations) - smaller = massive inertia
            kjz         = 0.00125,    -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
            Czbe         = -0.016,    -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear        = 0.12,    -- coefficient, drag, gear ??
            cx_flap        = 0.07,    -- coefficient, drag, full flaps
            cy_flap        = 0.24,    -- coefficient, normal force, lift, flaps
            cx_brk         = 0.08,    -- coefficient, drag, breaks
            table_data = {
            --          M    Cx0    Cya    B    B4          Omxmax    Aldop        Cymax

                    {0.0,    0.012,    0.10,    0.04,    0.03,        1.0,    14,        1.0,    },
                    {0.1,    0.012,    0.11,    0.04,    0.03,        1.5,    14,        1.3,    },
                    {0.2,    0.013,    0.12,    0.04,    0.03,        2.3,    14,        1.3,    },
                    {0.3,    0.014,    0.11,    0.04,    0.03,        2.6,    14,        1.3,    },
                    {0.4,    0.0145,    0.10,    0.04,    0.03,        2.6,    14,        1.4,    },
                    {0.5,    0.015,    0.09,    0.04,    0.03,        2.3,    14,        1.5,    },
                    {0.6,    0.015,    0.08,    0.04,    0.03,        2.3,    14,        1.6,    },
                    {0.7,    0.015,    0.07,    0.04,    0.03,        2.3,    14,        1.5,    },
                    {0.8,    0.015,    0.06,    0.04,    0.03,        2.3,    14,      1.4,    }, -- Cx0
                    {0.85,    0.015,    0.06,    0.04,    0.03,        2.3,    14,      1.4,    }, -- 0.030
                    {0.9,    0.045,    0.05,    0.04,    0.03,        1.0,    14,        1.4,    }, -- 0.060
                    {0.95,    0.085,    0.04,    0.04,    0.03,        -2.0,    14,        1.4,    }, -- 0.060
                    {1.0,    0.115,    0.03,    0.04,    0.03,        -1.0,    14,        1.4        }, -- 0.100
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
            Nmg    =    55.0,    -- RPM at idle
            MinRUD    =    0,    -- Min state of the throttle
            MaxRUD    =    1,    -- Max state of the throttle
            MaksRUD    =    1,    -- Military power state of the throttle
            ForsRUD    =    1,    -- Afterburner state of the throttle
            typeng    =    0,    
            --[[
                E_TURBOJET = 0
                E_TURBOJET_AB = 1
                E_PISTON = 2
                E_TURBOPROP = 3
                E_TURBOFAN    = 4
                E_TURBOSHAFT = 5
            --]]
            hMaxEng    =    15,    -- Max altitude for safe engine operation in km
            dcx_eng    =    0.0114,    -- Engine drag coeficient
            -- Affects drag of engine when shutdown
            -- cemax/cefor affect sponginess of elevator/inertia at slow speed
            -- affects available g load apparently
            cemax    =    0.037,    -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            cefor    =    0.037,    -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            dpdh_m    =    6000,    --  altitude coefficient for max thrust
            dpdh_f    =    14000.0,    --  altitude coefficient for AB thrust
            table_data = 
            {
            --   M            Pmax
                {0.0,        41364.0}, -- 41,364 kN
                {0.1,        41364.0}, --
                {0.2,        39800.0}, -- 130 KTS = 3650 FT VS. 3800 FT MANUAL
                {0.3,        34800.0}, -- 12800 = 2 mins 40 sec vs. 4 mins
                {0.4,        36200.0}, --24800.0 22800.0 23800.0 21200.0 19500.0 14800.0 11700.0
                {0.5,        39100.0}, --26000.0 23000.0 24000.0 21800.0 19000.0 14700.0 14000.0
                {0.6,        39500.0}, --28200.0 23200.0 24200.0 22400.0 18000.0 14600.0 14500.0 30% (30 mins vs. 40 mins tables)
                {0.7,        39500.0}, --30400.0 23400.0 24400.0 23000.0 17500.0 14500.0 14500.0
                {0.8,        39500.0}, --32600.0 23600.0 24600.0 23600.0 17000.0 14400.0 14500.0
                {0.9,        39500.0}, --34800.0 23800.0 24800.0 24200.0 16000.0 14300.0 14500.0
                {1.0,        39500.0},  --36000.0 24000.0 25000.0 22000.0 15000.0 14200.0 14500.0
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
                [83]    = {critical_damage = 3, args = {134}}, -- nose wheel                                  
                [84]    = {critical_damage = 3, args = {136}}, -- left wheel                                  
                [85]    = {critical_damage = 3, args = {135}}, -- right wheel
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
    [3]    = {    typename = "collection",
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
--            lights = {
--                     {typename = "natostrobelight",connector = "WHITE_TOP",argument_1 = 999,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.0},
--                     {typename = "natostrobelight",connector = "WHITE_TOP",argument_1 = 998,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.5},
--             }
--        },
    [4]    = {typename = "collection", -- should be [4]? if not rename back to [5]
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
