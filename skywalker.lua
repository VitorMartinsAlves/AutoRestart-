if Config.EsxOrVrpex == "VRP" then
	local Tunnel = module("vrp", "lib/Tunnel")
	local Proxy = module("vrp", "lib/Proxy")
	vRP = Proxy.getInterface("vRP")
	vRPclient = Tunnel.getInterface("vRP")
else
	--[[ESX = nil
	TriggerEvent(
		"esx:getSharedObject",
		function(obj)
			ESX = obj
		end
	)]]
end

Citizen.CreateThread(
	function()
		Wait(1 * Config.time)
		if Config.EsxOrVrpex == "VRP" then
			kickVRPEX()
		else
			kickESX()
		end
		os.execute(
			"start PowerShell.exe ../../../build/FXServer.exe +exec config/config.cfg  +set onesync on +set onesync_population false +set sv_enforceGameBuild 2372"
		)
		Wait(1)
		os.exit()
	end
)

function kickVRPEX()
	print("vrp")
	TriggerClientEvent("Notify", -1, "negado", "15 minutes to restart!", 60000)
	Wait(900000)
	TriggerClientEvent("Notify", -1, "negado", "10 minutes to restart ", 60000)
	Wait(600000)
	TriggerClientEvent("Notify", -1, "negado", "5 minutes to restart ", 60000)
	Wait(300000)

	local users = vRP.getUsers()
	for k, v in pairs(users) do
		local id = vRP.getUserSource(parseInt(k))
		if id then
			vRP.kick(id, Config.kick_message)
		end
	end
end

-- i really don't what i did in this part, pls fix if u understand something about esx

--[[function kickESX()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	print("esx")
	local _source = source
	xPlayer.showNotification(_U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
	Wait(900000)
	xPlayer.showNotification(_U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
	Wait(600000)
	xPlayer.showNotification(_U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
	Wait(300000)

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		xPlayer.kick(Config.kick_message)
	end
end]]
