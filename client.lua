vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_scoreboard")
vRPscr = Tunnel.getInterface("vrp_scoreboard","vrp_scoreboard")
vRPscrC = {}
Tunnel.bindInterface("vrp_scoreboard",vRPscrC)
vRPserver = Tunnel.getInterface("vrp_scoreboard","vrp_scoreboard")

local scoreboardon = false
local playersOn = 0
RegisterNetEvent('getGlobalOnlinePly')
AddEventHandler('getGlobalOnlinePly', function(connectedPlayers)
	playersOn = connectedPlayers
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("scoreboard")
        Wait(30000)
    end
end)

RegisterCommand("+openscoreboard", function()
    openscoreboard()
end)

RegisterKeyMapping("+openscoreboard", "Sa vezi scoreboardul", "keyboard", Config.OpenKey)

function openscoreboard()
    scoreboard = vRPserver.getScoreboardInformations()
end

function GetOnlinePlayers()
	local players = 0

	for i = 0, 512 do
		if NetworkIsPlayerActive(i) then
			players = players + 1
		end
	end

	return tonumber(players)
end

function vRPscrC.openscoreboard(info, playername)
    playerlist = {}
    for k,v in pairs (info) do
        theID = tonumber(k)
        table.insert(playerlist ,{id=theID,html='<tr> <td>'..v[1]..'</td> <th>'..v[3]..'</th> <th>'..v[2]..'</th> <th>'..v[4]..'</th> <th> ID: '..k..'</th><th> ORE: '..v[5]..'</th></tr>'})
    end
    local playersText = {}
    function compare(a,b)
        return a["id"] < b["id"]
    end
    table.sort(playerlist, compare)
    for item, value in pairs(playerlist) do
        table.insert(playersText, value["html"])
    end
    playersOn = playersOn
    SendNUIMessage({
        action = "deschideUsaCrestine",
        idsiuseritext = playersOn,
        username = playername,
        maxplayers = Config.MaxPlayers,
        info = table.concat(playersText)
    })
    if Config.HideMapOnOpen then
        DisplayRadar(false)
    end
    if Config.HideHudOnOpen then
        TriggerEvent(Config.HideHudTrigger)
    end
    SetNuiFocus(true, true)
end

RegisterNUICallback('inchideusacrestine', function(data,cb)
    SetNuiFocus(false, false)
    if Config.HideMapOnOpen then
        DisplayRadar(true)
    end
    if Config.HideHudOnOpen then
        TriggerEvent(Config.ShowHudTrigger)
    end
end)
