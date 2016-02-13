declare_plugin("A-4E Skyhawk by Hoggit Dev",
{
installed 	 = true,
dirName	  	 = current_mod_path,
version		 = "1.5.2 alpha",	-- 	 
state		 = "installed",
info		 = _("A-4E Skyhawk"),

binaries   =
{
--'ED_FM_Template',
nil,
},

Skins	=
	{
		{
			name	= _("A-4E"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		= _("A-4E"),
			dir			= "Missions",
			--CLSID		= "{CLSID5456456346CLSID}",	
		},
	},	
LogBook =
	{
		{
			name		= _("A-4E"),
			type		= "A-4E",
		},
	},	
InputProfiles =
	{
		["A-4E"]     = current_mod_path .. '/Input',
	},
})---------------------------------------------------------------------------------------

-- mounting 3d model paths and texture paths 

mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Cockpit/Textures")
mount_vfs_model_path	(current_mod_path.."/Cockpit/Shapes")

-- Option Cockpit operationnel, HUD partiel
make_flyable('A-4E'	, current_mod_path..'/Cockpit/Scripts/',nil, current_mod_path..'/comm.lua')

--make_flyable('A-4E', current_mod_path..'/Cockpit/Scripts/', {nil, old = 54}, current_mod_path..'/comm.lua')  --4 = su33, 54 = 25T
--make_flyable('A-4E', current_mod_path..'/Cockpit/KneeboardLeft/',{nil, old = 54}, current_mod_path..'/comm.lua')
--SU-25A
--make_flyable('A-4E', current_mod_path..'/Cockpit/KneeboardLeft/',{nil, old = 16}, current_mod_path..'/comm.lua') --SU-25A


dofile(current_mod_path.."/Views.lua")
make_view_settings('A-4E', ViewSettings, SnapViews)

plugin_done()-- finish declaration , clear temporal data
