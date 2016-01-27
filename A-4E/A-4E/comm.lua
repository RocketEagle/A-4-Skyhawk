local parameters = {
	fighter = true, --true
	radar = true,
	ECM = false,
	refueling = true --false
}
return utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)