local self_ID = "A-4E Skyhawk by Hoggit Dev"

declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("A-4E"),
version		 = "1.5.2 Alpha",
state		 = "test",
info		 = _("A-4E Skyhawk"),

Skins	=
	{
		{
			name	= "A-4E",
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
