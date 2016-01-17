
declare_loadout({	--M-117	
	category		=	CAT_BOMBS,
	CLSID			= 	"{M-117}",
	Picture			=	"kmgu2.png", --
	wsTypeOfWeapon	=	{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER}, -- A - Dumbomb, 30 is the index of the bomb
	displayName		=	_("M-117"),
	attribute		=	{4,	5,	32,	wsType_PLACEHOLDER}, --9, 31
	Cx_pil			=	0.0025, --drag index
	Count			=	1, --How many instances
	Weight			=	340,  --6*241 + MER-7 (99.8 kg)
	Elements		=	
	{
		[1]	=	
		{
			Position	=	{0,	0,	0},  --Position on hardpoint
			ShapeName	=	"M-117_A4E", -Shap --Model
			IsAdapter   =   false, --Ejection rack?
		}, 	
    }, -- end of Elements	
})