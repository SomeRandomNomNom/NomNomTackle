RegisterNetEvent('NomNomTackle:server:TacklePlayer', function(targetId, coords)
	local nearestPlayers = lib.getNearbyPlayers(coords, 3)
	local sourceAtCoords = false
	local targetAtCoords = false
	for _, nearestPlayer in ipairs(nearestPlayers) do
		if nearestPlayer.id == source then
			sourceAtCoords = true
		elseif nearestPlayer.id == targetId then
			targetAtCoords = true 
		end 
	end
	if sourceAtCoords and targetAtCoords then
		TriggerClientEvent('NomNomTackle:client:GetTackled', targetId)
	end
end)