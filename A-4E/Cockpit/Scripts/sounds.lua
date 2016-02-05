--[[
sounds ids 0 ... n
]]

local count = -1
local function counter()
	count = count + 1
	return count
end

SOUND_SW1		= counter()
SOUND_SW2_ON	= counter()
SOUND_SW2_OFF	= counter()
SOUND_SW3_OPEN	= counter()
SOUND_SW3_CLOSE	= counter()
SOUND_SW4_UP	= counter()
SOUND_SW4_DOWN	= counter()
SOUND_SW5_ON	= counter()
SOUND_SW5_OFF	= counter()
SOUND_SW6		= counter()
SOUND_SW7_UP	= counter()
SOUND_SW7_DOWN	= counter()
SOUND_SW8		= counter()
SOUND_SW9		= counter()
SOUND_SW10_ON	= counter()
SOUND_SW10_OFF	= counter()
