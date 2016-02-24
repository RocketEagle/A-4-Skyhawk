-- Weapons definitions here



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
		{	ShapeName	=	"AGM-45" , Position	=	{0,	-0.22,	0} }, --{0,	-0.22,	0}  
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
	Picture			=	"mk81.png",
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
	Picture			=	"mk81.png",
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
	Picture			=	"mk81.png",
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
	Picture			=	"mk81.png",
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
	Picture			=	"mk81.png",
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

declare_loadout({	--MER  MK82	SNAKEYE
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_6_MK82SE}",
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

declare_loadout({	--MER  MK82 SNAKEYE * 4 Pylon 2 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK82SE_P2}",
	Picture			=	"mk82air.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 79}, --
	displayName		=	_("MER,MK-82 Snakeye*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 256.3*4,   --6*241 + MER-7 (99.8 kg)
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
			ShapeName	=	"MK-82_Snakeye",
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
			ShapeName	=	"MK-82_Snakeye",
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
			ShapeName	=	"MK-82_Snakeye",
		}, 
		[5]	=	
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

declare_loadout({	--MER  MK82 SNAKEYE * 4 Pylon 4 
	category		=	CAT_BOMBS,
	CLSID			= 	"{MER_4_MK82SE_P4}",
	Picture			=	"mk82air.png",
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 79}, --31
	displayName		=	_("MER,MK-82 Snakeye*4"),
	attribute		=	{4,	5,	32,	114}, --9, 31
	Cx_pil			=	0.0025,
	Count			=	4,
	Weight			=	99.8 + 256.3*4,   --6*241 + MER-7 (99.8 kg)
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
			Position	=	{-1.167, -0.112, 0.13},
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
			Position	=	{1.101,	-0.309,	0},
			ShapeName	=	"MK-82_Snakeye",
		}, 
		[5]	=	
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

-- declare_loadout({	--MER  MK20	* 4 -- foireux ne s'ouvre pas
	-- category		=	CAT_BOMBS,
	-- CLSID			= 	"{M117}",
	-- Picture			=	"mk20.png",
	-- wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, 34}, --31
	-- displayName		=	_("M-117"),
	-- attribute		=	{4,	5,	32,	114}, --9, 31
	-- Cx_pil			=	0.0025,
	-- Count			=	1,
	-- Weight			=	340,  -- + MER-7 (99.8 kg)
	-- Elements		=	
	-- {
		-- [1]	=	
		-- {
			-- Position	=	{0,	0,	0},  
			-- ShapeName	=	"M-117_A4E", 
			-- IsAdapter   =   false,
		-- }, 
	-- }, -- end of Elements
-- })



declare_loadout(
	{
		category		= CAT_BOMBS,
		CLSID		=	"{M117}",
		Picture		=	"M64.png",
		displayName	=	_("M-117"),
		Weight	=	340,
		attribute	=	{4,	5,	9,	90},
		Elements	=	
		{
			[1]	=	
			{
				Position	=	{0,0,0},
				ShapeName	=	"M-117_A4E",
			}, 
		}, -- end of Elements
	}
)
