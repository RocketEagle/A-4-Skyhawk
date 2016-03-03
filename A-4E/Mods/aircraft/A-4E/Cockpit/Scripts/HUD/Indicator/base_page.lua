dofile(LockOn_Options.script_path.."HUD/Indicator/definitions.lua")

local TST  		 = MakeMaterial(nil,{255,255,0,120})
local GUNSIGHT_GLASS 		 = MakeMaterial(nil,{0,120,0,128})
local SHOW_MASKS = false   -- tres interessant sur true
local SHOW_DEBUG = true

arc_sectors           = 16;
arc_shift             = -10;  -- ?
arc_radius  	  	  = 60  -- 105 taille de l'arc exterieur!
half_width			  = arc_radius
down_border			  =-3.0 * arc_radius

clip_mesh_verts    = {}
clip_mesh_indices  = {}
clip_mesh_verts[1] = { 0, arc_shift}
clip_mesh_verts[2] = { -half_width , down_border}
clip_mesh_verts[3] = { -half_width ,   arc_shift}

local ellipse_a = arc_radius
local ellipse_b = arc_radius  

for i = 1,arc_sectors do
	local alpha        	   				  = math.pi - (math.pi/arc_sectors) * i;
    clip_mesh_verts[#clip_mesh_verts + 1] = {math.cos(alpha) * ellipse_a,
											 math.sin(alpha) * ellipse_b + arc_shift}
end
clip_mesh_verts[#clip_mesh_verts + 1] = {  half_width , down_border}

local number_of_triangles = #clip_mesh_verts - 1

for i = 1,number_of_triangles do

	clip_mesh_indices[3 * (i - 1)  + 1] = 0
	clip_mesh_indices[3 * (i - 1)  + 2] = i
	if i < number_of_triangles then
		clip_mesh_indices[3 * (i - 1)  + 3] = i + 1
	else
		clip_mesh_indices[3 * (i - 1)  + 3] = 1
	end
	
end

glass 			 	 = CreateElement "ceMeshPoly"
glass.name 			 = "glass"
glass.vertices 		 = clip_mesh_verts
glass.indices 		 = clip_mesh_indices
glass.init_pos		 = {0, 0,  -0.40/GetScale()}
glass.init_rot		 = {0, 0, -30}
glass.material		 = GUNSIGHT_GLASS
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = HUD_NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.isvisible		 = SHOW_MASKS
Add(glass)


local DEBUG_COLOR = {0,255,0,200}
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_usa"},DEBUG_COLOR,50,"test_font")
local ias_output = CreateElement "ceStringPoly"
ias_output.name = ("ias_" .. create_guid_string())
ias_output.material = FONT_
ias_output.init_pos = {-55,-100}
ias_output.alignment = "LeftCenter"
ias_output.stringdefs = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0}
ias_output.formats = {"%3.0fm/s","%s"}
ias_output.element_params = {"D_IAS", "D_ENABLE"}
ias_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
ias_output.collimated = true
ias_output.use_mipfilter    = true
ias_output.additive_alpha   = true
ias_output.isvisible		= SHOW_DEBUG
ias_output.parent_element = "glass"
Add(ias_output)

local AOA_output = CreateElement "ceStringPoly"
AOA_output.name = create_guid_string()
AOA_output.material = FONT_
AOA_output.init_pos = {-55,-60}
AOA_output.alignment = "LeftCenter"
AOA_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
AOA_output.formats = {"i %-2.1f","%s"}
AOA_output.element_params = {"D_AOA", "D_ENABLE"}
AOA_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
AOA_output.additive_alpha = true
AOA_output.use_mipfilter = true
AOA_output.collimated = true
AOA_output.isvisible		= SHOW_DEBUG
AOA_output.parent_element = "glass"
Add(AOA_output)

local mach_output = CreateElement "ceStringPoly"
mach_output.name = create_guid_string()
mach_output.material = FONT_
mach_output.init_pos = {-55,-70}
mach_output.alignment = "LeftCenter"
mach_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
mach_output.formats = {"M %.2f","%s"}
mach_output.element_params = {"D_MACH", "D_ENABLE"}
mach_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
mach_output.additive_alpha = true
mach_output.collimated = true
mach_output.use_mipfilter = true
mach_output.isvisible		= SHOW_DEBUG
mach_output.parent_element = "glass"
Add(mach_output)

local G_output = CreateElement "ceStringPoly"
G_output.name = create_guid_string()
G_output.material = FONT_
G_output.init_pos = {-55,-80}
G_output.alignment = "LeftCenter"
G_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
G_output.formats = {"G %2.1f","%s"}
G_output.element_params = {"current_G", "D_ENABLE"}
G_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
G_output.additive_alpha = true
G_output.collimated = true
G_output.use_mipfilter = true
G_output.isvisible		= SHOW_DEBUG
G_output.parent_element = "glass"
Add(G_output)

local HDG_output = CreateElement "ceStringPoly"
HDG_output.name = create_guid_string()
HDG_output.material = FONT_
HDG_output.init_pos = {0,-120}
HDG_output.alignment = "CenterCenter"
HDG_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
HDG_output.formats = {"H:%3.1f","%s"}
HDG_output.element_params = {"D_HDG", "D_ENABLE"}
HDG_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
HDG_output.additive_alpha = true
HDG_output.collimated = true
HDG_output.use_mipfilter = true
HDG_output.isvisible = SHOW_DEBUG
HDG_output.parent_element = "glass"
Add(HDG_output)

local ALT_output = CreateElement "ceStringPoly"
ALT_output.name = create_guid_string()
ALT_output.material = FONT_
ALT_output.init_pos = {45,-100}
ALT_output.alignment = "RightCenter"
ALT_output.stringdefs = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}
ALT_output.formats = {"%.0fm","%s"}
ALT_output.element_params = {"D_ALT", "D_ENABLE"}
ALT_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
ALT_output.additive_alpha = true
ALT_output.collimated = true
ALT_output.use_mipfilter = true
ALT_output.isvisible = SHOW_DEBUG
ALT_output.parent_element = "glass"
Add(ALT_output)

local altitude_source           = CreateElement "ceStringPoly"
altitude_source.name            = create_guid_string()
altitude_source.material        = FONT_
altitude_source.init_pos        = {55,-100}
altitude_source.alignment       = "RightCenter"
altitude_source.stringdefs      = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}
altitude_source.formats         = {"%s","%s"}
altitude_source.element_params  = {"ALT_SOURCE", "D_ENABLE"}
altitude_source.controllers     = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}} --first index of text_using_parameter is for element_params (starting with 0) , second for formats ( starting with 0)
altitude_source.additive_alpha  = true
altitude_source.collimated     = true
altitude_source.use_mipfilter = true
altitude_source.isvisible = SHOW_DEBUG
altitude_source.parent_element = "glass"
Add(altitude_source)

local VV_output = CreateElement "ceStringPoly"
VV_output.name = create_guid_string()
VV_output.material = FONT_
VV_output.init_pos = {55,-80}
VV_output.alignment = "RightCenter"
VV_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
VV_output.formats = {"VV:%3.0f","%s"}
VV_output.element_params = {"D_VV", "D_ENABLE"}
VV_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
VV_output.additive_alpha = true
VV_output.collimated = true
VV_output.use_mipfilter = true
VV_output.isvisible = SHOW_DEBUG
VV_output.parent_element = "glass"
Add(VV_output)

local RPM_output = CreateElement "ceStringPoly"
RPM_output.name = create_guid_string()
RPM_output.material = FONT_
RPM_output.init_pos = {55,-60}
RPM_output.alignment = "RightCenter"
RPM_output.stringdefs = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}
RPM_output.formats = {"RPM:%0.1f%%","%s"}
RPM_output.element_params = {"D_RPMG", "D_ENABLE"}
RPM_output.controllers = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}
RPM_output.additive_alpha = true
RPM_output.collimated = true
RPM_output.use_mipfilter = true
RPM_output.isvisible = SHOW_DEBUG
RPM_output.parent_element = "glass"
Add(RPM_output)

--[[
local GUNSIGHT_COLOR = {255,128,0,192} --128,165,0,120
local GunsightTexture   		= MakeMaterial("gunsight.tga",GUNSIGHT_COLOR) -- image of the fixed net
function create_textured_box(UL_X,UL_Y,DR_X,DR_Y) -- function that creates textured square. This function is called 2 times in below code.

local size_per_pixel = 1/3
local texture_size_x = 200
local texture_size_y = 200
local W = DR_X - UL_X
local H = DR_Y - UL_Y

local half_x = 0.5 * W * size_per_pixel
local half_y = 0.5 * H * size_per_pixel
local ux 	 = UL_X / texture_size_x
local uy 	 = UL_Y / texture_size_y
local w  	 = W / texture_size_x
local h 	 = H / texture_size_y

local object = CreateElement "ceTexPoly"
object.vertices =  {{-half_x, half_y},
				    { half_x, half_y},
				    { half_x,-half_y},
				    {-half_x,-half_y}}
object.indices	  = {0,1,2,2,3,0}
object.tex_coords = {{ux -w/2    ,uy-h/2},
					 {ux + w/2 ,uy-h/2},
					 {ux + w/2 ,uy + h/2},
				     {ux-w/2 	 ,uy + h/2}}

return object

end

gun_sight_mark 					= create_textured_box(-100,-100,100,100) -- this is create_textured_box function call with parameters
gun_sight_mark.material       	= GunsightTexture
gun_sight_mark.name 			= create_guid_string()
gun_sight_mark.collimated	  	= true
gun_sight_mark.parent_element = "glass"
gun_sight_mark.use_mipfilter    = true
gun_sight_mark.additive_alpha   = true
Add(gun_sight_mark)
--]]

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)
TFOV  = 160  -- 105 cercle limitant interieur
verts = {}
for i = 1, num_points do
	verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

total_field_of_view.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.indices			= inds
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)
---------------------------------------------------------------------------
