-- SELL DRUGS TO NPC --

ESX = exports["es_extended"]:getSharedObject()
selling       = false
Citizen.CreateThread(function()
  	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(250)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	Citizen.Wait(5000)
end)



exports.qtarget:Ped({
	options = {
		{
			event = "pex_sell:sellitem",
			icon = "fa-solid fa-cannabis",
			label = "Prodat LemonHaze",
			num = 1,
			action = function(sellItem) 
				local sellItem = 'weed_lemonhaze'
				TriggerEvent('pex_sell:sellitem', sellItem)
		
			end	
		},
		{
			event = "pex_sell:sellitem",
			icon = "fa-solid fa-cannabis",
			label = "Prodat Black Widow",
			num = 2,
			action = function(sellItem) 
				local sellItem = 'weed_blackwidow'
				TriggerEvent('pex_sell:sellitem', sellItem)
		
			end	
		},
		{
			icon = "fa-solid fa-cannabis",
			label = "Prodat White Widow",
			num = 3,
			action = function(sellItem) 
				local sellItem = 'weed_whitewidow'
				TriggerEvent('pex_sell:sellitem', sellItem)
		
			end	
		},
	},
	distance = 2
})








RegisterNetEvent('pex_sell:sellitem')
AddEventHandler('pex_sell:sellitem', function(sellItem)
	item = sellItem
	lib.progressBar({
		duration = 3500,
		label = 'Zkoušíš prodat drogy',
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
		},
	}) 

	local percent = math.random(1, 11)

	if percent <= 4 then
		exports['mythic_notify']:SendAlert('error', 'Kupce tě odmítl!', 4000)
	elseif percent <= 9 then
		

		TriggerServerEvent('np_selltonpc:dodeal', item)
	else
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)

		exports['mythic_notify']:SendAlert('error', 'Kupce zavolal policii', 4000)
		TriggerServerEvent('np_selltonpc:saleInProgress', streetName)
	end
	
	selling = false
	
	

	
	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'offpolice' or ESX.PlayerData.job.name == 'offsheriff' then
		exports['mythic_notify']:SendAlert('error', 'Kupce tě už viděl ty si polda!', 4000)
	
		selling = false
		return
	end
	
end)


AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)



RegisterNetEvent('np_selltonpc:policeNotify')
AddEventHandler('np_selltonpc:policeNotify', function(alert)
	local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'police', 'sheriff'}, 
		coords = data.coords,
		title = '10-14 - Prodej Drog',
		message = data.sex..' je podezřelý z prodeje drog na '..data.street, 
		flash = 0,
		unique_id = data.unique_id,
		sound = 1,
		blip = {
			sprite = 431, 
			scale = 1.2, 
			colour = 3,
			flashes = false, 
			text = '10-14 - Prodej Drog',
			time = 5,
			radius = 0,
		}
	})
end)
