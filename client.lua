local isTackling = false
local dict = 'anim@sports@ballgame@handball@'

local function doTackle()
	local tackle = false 
    CreateThread(function()
		while isTackling do
			if tackle then break end 
			if HasEntityCollidedWithAnything(cache.ped) then
				local coords = GetEntityCoords(cache.ped)
				local closestPlayer = lib.getClosestPlayer(coords, 1, false)
				if closestPlayer then 
					tackle = true
					targetId = GetPlayerServerId(closestPlayer)
					TriggerServerEvent('NomNomTackle:server:TacklePlayer', targetId, coords)
				end
			end
			Wait(0)
		end
    end)
    lib.requestAnimDict(dict, 2000)
    TaskPlayAnim(cache.ped, dict, 'ball_rstop_r_slide', 8.0, 8.0, -1, 2, 0, false, false, false)
    Wait(GetAnimDuration(dict, 'ball_rstop_r_slide') * 1000)
    TaskPlayAnim(cache.ped, dict, 'ball_get_up', 8.0, 8.0, -1, 01, 0, false, false, false)
    Wait(GetAnimDuration(dict, 'ball_get_up') * 500)
    StopAnimTask(cache.ped, dict, 'ball_get_up', 1.0)
    RemoveAnimDict(dict)
    isTackling = false
end

RegisterNetEvent('NomNomTackle:client:GetTackled')
AddEventHandler('NomNomTackle:client:GetTackled', function()
	if isPedRagdoll then return end
	SetPedToRagdoll(cache.ped, 10000, 10000)
end)


lib.addKeybind({
    name = 'SuperTackle',
    description = 'Yeeeeeeeeeeet',
    defaultKey = 'G',
    onPressed = function()
        if IsControlPressed(1, 21) and not isTackling then
            isTackling = true
            doTackle()
        end
    end,
})