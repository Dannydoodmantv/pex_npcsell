ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('np_selltonpc:dodeal')
AddEventHandler('np_selltonpc:dodeal', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local weedprice = math.random(150, 500)
		local weed = xPlayer.getInventoryItem(item).count

		local weedamount = math.random(1, 5)
		local finalamount = weedprice * weedamount
		xPlayer.removeInventoryItem(item, weedamount)
		xPlayer.addAccountMoney('black_money', finalamount)
	end
end)


RegisterServerEvent('np_selltonpc:saleInProgress')
AddEventHandler('np_selltonpc:saleInProgress', function(streetName, playerGender)
	if playerGender == 0 then
		playerGender = 'Female'
	else
		playerGender = 'Male'
	end

	TriggerClientEvent('np_selltonpc:policeNotify', -1, 'Drug deal in progress: A ' .. playerGender .. ' has been spotted selling drugs at ' .. streetName)
end)