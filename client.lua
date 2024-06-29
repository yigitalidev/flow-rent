local display = false
local npcVector1 = Config.NpcCoord[math.random(1,#Config.NpcCoord)]
local QBCore = exports['qb-core']:GetCoreObject()
local car_names = {}
local car_prices = {}
local vehicle
local newPrice

local cashamount = 5



function SetDisplay(bool)
	display = bool
	SetNuiFocus(bool, bool)

	SendNUIMessage({
		type = "ui",
		status = bool,
		car_names = car_names,
		car_prices = car_prices,
	})
end







RegisterNetEvent('flow-rent:enoughMoney')
AddEventHandler('flow-rent:enoughMoney', function()
	QBCore.Functions.Notify('you dont have enough money','error',5000)

end)


RegisterNetEvent('flow-rent:removeCar')
AddEventHandler('flow-rent:removeCar', function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if veh ~= 0 then
		Citizen.Wait(1)
		SetEntityAsMissionEntity(veh, true, true)
		DeleteVehicle(veh)
	end

end)

for i = 1, #Config.Cars do
	car_names[i] = Config.Cars[i].car_name
	car_prices[i] = Config.Cars[i].car_price
end
  
RegisterCommand("menuac",function()	

    SetDisplay(true)  

end)
  

  

RegisterNUICallback("close", function()
    SetDisplay(false)  

end)


Citizen.CreateThread(function()
    for _, info in pairs(Config.NpcCoord) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, 523)
    SetBlipColour(info.blip, 1)
    SetBlipDisplay(info.blip, 3)
    AddTextEntry('blipVehicle', 'Rent a Car')
    BeginTextCommandSetBlipName('blipVehicle')
    EndTextCommandSetBlipName(info.blip)
    end
end)


RegisterNUICallback("rentCar", function(carNames)
	
	SetDisplay(false)
	local counter = carNames.counter
	local car = carNames.spawnedCarName
	local price = carNames.spawnedCarPrice


	newPrice = price.sub(price,0,#price-1)

	counter = tonumber(counter.."0000")

	local newCounter = (counter)*6

	local vehiclename = car

	if counter ~= 0 then

	RequestModel(vehiclename)

	while not HasModelLoaded(vehiclename) do
		Wait(10)
	end
	
	local playerPed = PlayerPedId() 
	local pos = GetEntityCoords(playerPed)+2
	local heading = (GetEntityHeading(playerPed))
	vehicle = CreateVehicle(
		vehiclename,
		pos,
		heading,
		true
	)

	SetPedIntoVehicle(playerPed,vehicle,-1)

	SetModelAsNoLongerNeeded(vehiclename)

	TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
	TriggerServerEvent("flow-rent:removeMoney",newPrice)

	else
		QBCore.Functions.Notify('please choose renting time and car','error',5000)
	end


	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if veh ~= 0 then
		Citizen.Wait(newCounter)
		SetEntityAsMissionEntity(veh, true, true)
		DeleteVehicle(veh)
		QBCore.Functions.Notify('Your Car Rental Period Has Expired', 'error', 5000)
	end

end)

--------------------------------------------------------------------------------

RegisterNUICallback("returnVehicle", function()
    local ped = PlayerPedId()
	local veh = vehicle
		if vehicle then
			Citizen.Wait(1)
			SetEntityAsMissionEntity(veh, true, true)
			DeleteVehicle(veh)
			TriggerServerEvent("flow-rent:giveMoney")
			SetDisplay(false)  
			QBCore.Functions.Notify('You have successfully delivered the vehicle', 'success', 5000)
			vehicle=false	
		end	
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.NpcModel))
	
    while not HasModelLoaded(GetHashKey(Config.NpcModel)) do
        Wait(1)
    end
	
			local npc = CreatePed(4, 0xA1435105, npcVector1.x, npcVector1.y, npcVector1.z, npcVector1.heading, false, true)


			local npcCoord = vector3(npcVector1.x,npcVector1.y,npcVector1.z)

			Citizen.CreateThread(function()
				local alreadyEnteredZone = false
				while true do
					Sleep = 2000
					local PlayerPed = PlayerPedId()
					local PlayerCoord = GetEntityCoords(PlayerPed)
					local inZone = false
					local Distance = #(PlayerCoord - npcCoord)
					if Distance <= 2.0 then
						Sleep = 5
						inZone  = true
						if IsControlJustReleased(0, 38) then
							   SetDisplay(true)     
      
						end
					else
						Sleep = 2000
					end
					if inZone and not alreadyEnteredZone then
						alreadyEnteredZone = true
						exports['qb-core']:DrawText('Please Press [E]', 'left')
					end
			  
					if not inZone and alreadyEnteredZone then
						alreadyEnteredZone = false
						exports['qb-core']:HideText()
					end
					Citizen.Wait(wait)
				end
			end)


			SetEntityHeading(npc, npcVector1.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)

end)

