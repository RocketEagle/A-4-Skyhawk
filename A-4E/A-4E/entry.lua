local self_ID = "A-4E Skyhawk by Hoggit Dev"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("A-4E"),

fileMenuName = _("A-4E"),
update_id        = "A-4E",

version		 = "1.5.2 pre alpha",
state		 = "installed",
info		 = _("A-4E Skyhawk de l'EVAC, version Archy du 25/09/2015		              Cette version ne modifie pas les fichiers DCS."), 

--binaries	= { 'FC3', },

InputProfiles =
{
    ["A-4E"] = current_mod_path .. '/Input/A-4E',
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
		},
	},		

LogBook =
	{
		{
			name		= _("A-4E"),
			type		= "A-4E",
		},
	},		
}
)
----------------------------------------------------------------------------------------
--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})

--cockpit fonctionnel
make_flyable('A-4E' , current_mod_path..'/Cockpit/Scripts/',nil, current_mod_path..'/comm.lua') 
--make_flyable('A-4E', current_mod_path..'/Cockpit/Scripts/', {nil, old = 54}, current_mod_path..'/comm.lua')  --4 = su33, 54 = 25T
--make_flyable('A-4E', current_mod_path..'/Cockpit/KneeboardLeft/',{nil, old = 54}, current_mod_path..'/comm.lua')
--SU-25A
--make_flyable('A-4E', current_mod_path..'/Cockpit/KneeboardLeft/',{nil, old = 16}, current_mod_path..'/comm.lua') --SU-25A

----------------------------------------------------------------------------------------
dofile(current_mod_path..'/A-4E.lua')

make_view_settings('A-4E', ViewSettings, SnapViews)

plugin_done()-- finish declaration , clear temporal data
