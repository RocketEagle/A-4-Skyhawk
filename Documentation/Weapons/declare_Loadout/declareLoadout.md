#declare_loadout
Example: [declare_loadout.lua for MK-117](https://github.com/LevelPulse/A-4-Skyhawk/blob/master/Documentation/Weapons/declare_loadout.lua)

##Category
This stats the weapon category it is in. 

`category		=	CAT_BOMBS,`

Category Types:

* CAT_FUEL_TANKS
* CAT_AIR_TO_AIR
* CAT_MISSILES
* CAT_BOMBS

##CLSID
This will be the name used to enter the weapon in each pyon

`CLSID			= 	"{M-117}",`

CLSID: ~ You can name this whatever, as long as the name resembles the model.

##Picture
The picture is what will be used when inserting through the load-out menu

`Picture			=	"kmgu2.png",`

Images can be found: `DCS World\MissionEditor\data\images\Loadout\Weapon`

##Display Name
This will be the name that shows up on the load-out menu.

`displayName		=	_("M-117"),`

displayName: ~ You can name this whatever, as long as the name resembles the model.

##Attribute

##Cx_pil
This is the drag-index of the bomb.

Cx_pil			=	0.0025,

##Count
How many instances of the weapon you want for each hardpoint.

`Cx_pil			=	0.0025,`

Cx_pil: the higher the number, the higher the drag index.

##Weight
The weight of the weapon.

`Weight			=	340, `

Weight: the mass of the object in (kgs).

For ejector rack:
`Weight			=	145+340*3, `-- Weight of the rack, 145 and 340kg weapon*3 as the racket holds that much.

##Elements:
This draws the model onto the hard-point, if you have a rack, you must draw the element X amount of times.
