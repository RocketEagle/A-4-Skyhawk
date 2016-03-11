declare_plugin("A-4E Skyhawk AI by Hoggit Dev",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("A-4E"),

fileMenuName = _("A-4E"),
update_id        = "A-4E",
version		 = "1.5.2 Alpha",		 
state		 = "installed",
info		 = _("A-4E Skyhawk AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
})

mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-4E")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-4E-2")

dofile(current_mod_path..'/A-4E.lua')
dofile(current_mod_path..'/Weapons/A4E_Weapons.lua')

plugin_done()