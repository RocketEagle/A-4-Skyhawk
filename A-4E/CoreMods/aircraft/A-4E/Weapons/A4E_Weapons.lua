-- Weapons definitions here

print("WEAPON TEST")
-- Support Functions:

-- bombs that can go on MER or TER racks
local bomb_data = 
{
    --use shapename,        mass,       wstype,                 image,                  drag
    ["Mk-81"]           = { mass = 118, wstype = {4,5,9,30},    pic = 'mk81.png',       cx = 0.00018},
    ["Mk-82"]           = { mass = 241, wstype = {4,5,9,31},    pic = 'mk82.png',       cx = 0.00025},
    ["Mk-82 Snakeye"]   = { mass = 241, wstype = {4,5,9,79},    pic = 'mk82air.png',    cx = 0.00025},
    ["Mk-83"]           = { mass = 447, wstype = {4,5,9,32},    pic = 'mk83.png',       cx = 0.00035},
    --["ROCKEYE"]         = { mass = 222, wstype = {4,5,38,45},   pic = 'mk20.png',       cx = 0.00070},
    --["M-117"]           = { mass = 340, wstype = {4,5,9,34},    pic = 'kmgu2.png',      cx = 0.00030},
}

local rack_data =
{
    ["BRU_41"]          = {mass = 99.8, shapename = "mer_a4e",      wstype = {4, 5, 32, WSTYPE_PLACEHOLDER} },
    ["BRU_42"]          = {mass = 47.6, shapename = "BRU-42_LS",    wstype = {4, 5, 32, WSTYPE_PLACEHOLDER} },
}

local GALLON_TO_KG = 3.785 * 0.8

function rackme_a4e(element,count,side)
	if count <= 3 then
        return bru_42(element,count,side)
    elseif count <= 6 then
        return bru_41(element,count,side)
    end
end

function bru_41(element,count,side) -- build up to a 6x MER loadout of the specified bomb
    local bomb_variant = bomb_data[element] or bomb_data["MK-81"]
    local rack_variant = rack_data["BRU_41"]
    local sidestr = {"L","C","R"}
    local data = {}

    data.category           = CAT_BOMBS
    data.CLSID              = "{"..element.."_MER_"..tostring(count).."_"..sidestr[2+side].."}"
    data.attribute          = rack_variant.wstype
    data.Picture            = bomb_variant.pic
    data.Count              = count
    data.displayName        = element.." *"..tostring(count).." (MER)"
    data.wsTypeOfWeapon     = bomb_variant.wstype
    data.Weight             = rack_variant.mass + count * bomb_variant.mass
    data.Cx_pil             = 0.001887 + bomb_variant.cx*count
    data.Elements           =
    {
		{
			Position	=	{0,	0,	0},  
			ShapeName	=	rack_variant.shapename, 
			IsAdapter   =   true,
		},
    }

	local positions =  {{  1.101, -0.112,  0.13 }, -- front right
                        { -1.167, -0.112,  0.13 }, -- back right
                        {  1.101, -0.112, -0.13 }, -- front left
                        { -1.167, -0.112, -0.13 }, -- back left
                        {  1.101, -0.309,  0    }, -- front center
                        { -1.167, -0.309,  0    }} -- back center

    local rotations =  {{ -45, 0, 0}, -- right side
						{ -45, 0, 0},
						{  45, 0, 0}, -- left side
                        {  45, 0, 0},
						{  0,  0, 0}, -- center
						{  0,  0, 0}}

    local rightorder5 = {3,4,1,2,5,6}
    local centerorder4 = {5,6,1,2,3,4}
    local normalorder = {1,2,3,4,5,6}

    -- for center, mount up to 6 ... if 4, do left and right
    -- for left, mount up to 5 skipping front right
    -- for right, mount up to 5 skipping front left

    local offset = 6-count
    local order = normalorder

    if count == 4 and side == 0 then
        order = centerorder4
    elseif (count == 5 or count == 4) and side == 1 then
        order = rightorder5
    end

    for i = 1,count do
        local j = order[i+offset]
        data.Elements[#data.Elements + 1] = {DrawArgs	=	{{1,1},{2,1}},
											Position	=	positions[j],
											ShapeName	=	element,
											Rotation	=   rotations[j]}
    end

	return data
end


function bru_42(element,count,side) -- build a TER setup for the specified bombs
    local bomb_variant = bomb_data[element] or bomb_data["MK-82"]
    local rack_variant = rack_data["BRU_42"]
    local sidestr = {"L","C","R"}
    local data = {}

    data.category           = CAT_BOMBS
    data.CLSID              = "{"..element.."_TER_"..tostring(count).."_"..sidestr[2+side].."}"
    data.attribute          = rack_variant.wstype
    data.Picture            = bomb_variant.pic
    data.Count              = count
    data.displayName        = element.." *"..tostring(count).." (TER)"
    data.wsTypeOfWeapon     = bomb_variant.wstype
    data.Weight             = rack_variant.mass + count * bomb_variant.mass
    data.Cx_pil             = 0.001887 + bomb_variant.cx*count
    data.Elements           =
    {
        {
            Position	=	{0,	0,	0},  
            ShapeName	=	rack_variant.shapename, 
            IsAdapter   =   true,
        },
    }

    local positions_mk83 = {{0,	-0.144,	 0.148}, -- right
                            {0,	-0.144,	-0.148}, -- left
                            {0,	-0.37,	 0}}     -- center

    local positions =  {{0,  0,     0.13},  -- right
                        {0,  0,    -0.13},  -- left
                        {0, -0.18,  0}}     -- center

    local rotations =  {{ -45, 0, 0}, -- right
                        {  45, 0, 0}, -- left
                        {  0,  0, 0}} -- center

    local rightorder2 = {2,1,3}
    local centerorder2 = {3,1,2}
    local leftorder2 = {1,2,3}

    -- for center, mount up to 3 ... if 2, do left and right
    -- for left, mount up to 2 skipping front right
    -- for right, mount up to 2 skipping front left

    local offset = 3-count
    local order = leftorder2 -- default, includes 3 bombs

    if count == 2 then
        if side == 0 then
            order = centerorder2
        elseif  side == 1 then
            order = rightorder2
        end
    end

    for i = 1,count do
        local j = order[i+offset]
        data.Elements[#data.Elements + 1] = {DrawArgs	=	{{1,1},{2,1}},
                                            Position	=	positions[j],
                                            ShapeName	=	element,
                                            Rotation	=   rotations[j]}
    end

    return data
end




---------FUEL TANKS-----------
declare_loadout(	--400 gal tank
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{DFT-400gal}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 400 gallons"),
		Weight_Empty	= 94,
		Weight			= 94 +  GALLON_TO_KG * 400,
		Cx_pil			= 0.00145,
		shape_table_data = 
		{
			{
				name 	= "DFT_400_GAL_A4E",
				file	= "DFT_400gal_a4e";
				life	= 1;
				fire	= { 0, 1};
				username	= "DFT_400_GAL_A4E";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "DFT_400_GAL_A4E",
			}, 
		}, 
	}
)

declare_loadout(	--300 gal tank
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{DFT-300gal}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 300 gallons"),
		Weight_Empty	= 94,
		Weight			= 94 +  GALLON_TO_KG * 300,
		Cx_pil			= 0.00145,
		shape_table_data = 
		{
			{
				name 	= "DFT_300_GAL_A4E",
				file	= "DFT_300gal_a4e_C";
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

declare_loadout(	--300 gal tank LEFT RIGHT
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{DFT-300gal_LR}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 300 gallons"),
		Weight_Empty	= 94,
		Weight			= 94 +  GALLON_TO_KG * 300,
		Cx_pil			= 0.00145,
		shape_table_data = 
		{
			{
				name 	= "DFT_300_GAL_A4E_LR",
				file	= "DFT_300gal_a4e_LR";
				life	= 1;
				fire	= { 0, 1};
				username	= "DFT_300_GAL_A4E_LR";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "DFT_300_GAL_A4E_LR",
			}, 
		}, 
	}
)

declare_loadout(	--150 gal tank
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{DFT-150gal}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 150 gallons"),
		Weight_Empty	= 94,
		Weight			= 94 +  GALLON_TO_KG * 150,
		Cx_pil			= 0.00145,
		shape_table_data = 
		{
			{
				name 	= "DFT_150_GAL_A4E",
				file	= "DFT_150gal_a4e";
				life	= 1;
				fire	= { 0, 1};
				username	= "DFT_150_GAL_A4E";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "DFT_150_GAL_A4E",
			}, 
		}, 
	}
)


declare_loadout(	--D-704 BUDDY POD
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{D-704_BUDDY_POD}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "d-704.png",
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
MK77 =
{
	category  		= CAT_BOMBS,
	name      		= "MK77-WPN",
	model     		= "mk-77",
	user_name 		= _("MK-77"),
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Fire, WSTYPE_PLACEHOLDER},
	scheme    		= "bomb-parashute",
	class_name		= "wAmmunitionBallute",
	type      		= 0,
	mass      		= 121,
	hMin      		= 50.0,
	hMax      		= 12000.0,
	Cx        		= 0.00018,
	VyHold    		= -100.0,
	Ag        		= -1.23,
	fm = {
            mass            = 340,
            caliber         = 0.2730000,
            cx_coeff        = {1.000000, 0.320000, 0.710000, 0.150000, 1.280000},
			cx_factor   	= 100,
            L               = 1.05,
            I               = 33.282267,
            Ma              = 2.746331,
            Mw              = 2.146083,
            wind_time       = 1000.000000,
            wind_sigma      = 80.000000,
	},
	control = 
    {
        open_delay = 0.2,
    },
	warhead 		 = simple_warhead(90),-- 44 + bonus of fragments
	shape_table_data =
	{
		{
			file     = "mk-77",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	targeting_data = 
	{	
		v0 = 200,
		data = 
		{
			{1.000000, 21.147949, 0.002807},
			{10.000000, 28.262668, -0.017193},
			{20.000000, 29.687629, -0.016767},
			{30.000000, 30.394407, -0.015892},
			{40.000000, 30.826322, -0.015080},
			{50.000000, 31.133114, -0.014428},
			{60.000000, 31.361560, -0.013889},
			{70.000000, 31.543970, -0.013440},
			{80.000000, 31.690640, -0.013045},
			{90.000000, 31.814418, -0.012713},
			{100.000000, 31.920050, -0.012425},
			{200.000000, 32.511629, -0.010723},
			{300.000000, 32.789778, -0.009863},
			{400.000000, 32.963413, -0.009307},
			{500.000000, 33.086372, -0.008907},
			{600.000000, 33.179450, -0.008596},
			{700.000000, 33.253103, -0.008346},
			{800.000000, 33.312920, -0.008139},
			{900.000000, 33.362577, -0.007968},
			{1000.000000, 33.404350, -0.007824},
			{1100.000000, 33.439925, -0.007702},
			{1200.000000, 33.470498, -0.007599},
			{1300.000000, 33.496988, -0.007513},
			{1400.000000, 33.520106, -0.007440},
			{1500.000000, 33.540403, -0.007378},
			{1600.000000, 33.558365, -0.007327},
			{1700.000000, 33.574326, -0.007285},
			{1800.000000, 33.588629, -0.007251},
			{1900.000000, 33.601489, -0.007224},
			{2000.000000, 33.613137, -0.007202},
			{3000.000000, 33.690673, -0.007191},
			{4000.000000, 33.737805, -0.007357},
			{5000.000000, 33.773738, -0.007590},
			{6000.000000, 33.802367, -0.007864},
			{7000.000000, 33.824277, -0.008170},
			{8000.000000, 33.839206, -0.008505},
			{9000.000000, 33.846586, -0.008868},
			{10000.000000, 33.845625, -0.009258},
		}    
	},
}
declare_weapon(MK77)


declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{MK-77}",
	attribute		= MK77.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= MK77.Cx,
	Picture			= "mk77.png",
	displayName		= MK77.user_name,
	Weight			= MK77.mass,
	Elements  		= {{ShapeName = MK77.model}},
})


declare_loadout(rackme_a4e("Mk-81", 6, 0))          -- {Mk-81_MER_6_C}
declare_loadout(rackme_a4e("Mk-81", 5,-1))          -- {Mk-81_MER_5_L}
declare_loadout(rackme_a4e("Mk-81", 5, 1))          -- {Mk-81_MER_5_R}
declare_loadout(rackme_a4e("Mk-81", 4,-1))          -- {Mk-81_MER_4_L}
declare_loadout(rackme_a4e("Mk-81", 4, 1))          -- {Mk-81_MER_4_R}
declare_loadout(rackme_a4e("Mk-81", 4, 0))          -- {Mk-81_MER_4_C}

declare_loadout(rackme_a4e("Mk-82", 6, 0))          -- {Mk-82_MER_6_C}
declare_loadout(rackme_a4e("Mk-82", 4, 0))          -- {Mk-82_MER_4_C}
declare_loadout(rackme_a4e("Mk-82", 3, 0))          -- {Mk-82_TER_3_C}

declare_loadout(rackme_a4e("Mk-82 Snakeye", 6, 0))  -- {Mk-82 Snakeye_MER_6_C}
declare_loadout(rackme_a4e("Mk-82 Snakeye", 4, 0))  -- {Mk-82 Snakeye_MER_4_C}
declare_loadout(rackme_a4e("Mk-82 Snakeye", 3, 0))  -- {Mk-82 Snakeye_TER_3_C}

declare_loadout(rackme_a4e("Mk-83", 3, 0))          -- {Mk-83_TER_3_C}
declare_loadout(rackme_a4e("Mk-83", 2, 0))          -- {Mk-83_TER_2_C}

