local QBCore = exports['qb-core']:GetCoreObject()



RegisterServerEvent('flow-rent:giveMoney')
AddEventHandler('flow-rent:giveMoney', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.RefundFee, 'flow-rent:giveMoney')

end)

RegisterServerEvent('flow-rent:removeMoney')
AddEventHandler('flow-rent:removeMoney', function (carPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerMoney = Player.PlayerData.money.cash
	
    if tonumber(PlayerMoney) < tonumber(carPrice) then
        TriggerClientEvent("flow-rent:removeCar",src)
        TriggerClientEvent("flow-rent:enoughMoney",src)
    else 
        Player.Functions.RemoveMoney('cash', carPrice, 'flow-rent:removeMoney')
    end


end)
