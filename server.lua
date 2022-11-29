local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_scoreboard")
vRPCscr = Tunnel.getInterface("vrp_scoreboard","vrp_scoreboard")
vRPscr = {}
Tunnel.bindInterface("vrp_scoreboard",vRPscr)
Proxy.addInterface("vrp_scoreboard",vRPscr)

local playerlist = {}
local ems = 0
local police = 0
local mafia = 0

function vRPscr.getScoreboardInformations()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local hours = vRP.getUserHoursPlayed({user_id})
    local jucatori = vRP.getUsers({user_id})
	local playername = GetPlayerName(player)
    vRPCscr.openscoreboard(player,{playerlist, playername})
end

function insertInScoreboard(jucator, user_id)
	factiune = "Civil"
	admin = 0
	numeNab = "Nume"

	local jucator = vRP.getUserSource({user_id})
	local getplayerping = GetPlayerPing(jucator)
	local getplayeradmintitle = vRP.getUserAdminTitle({user_id})

	for k,v in pairs(Config.Factions) do
		if vRP.isUserInFaction({user_id,k}) then
			factiune = v
		end
	end

    local scolor = Config.StaffColor;
	local color = Config.DefaultPingColor;
	if getplayerping > 70 and getplayerping < 90 then
		color = Config.Ping7090Color;
	elseif getplayerping >= 90 then
		color = Config.Ping90Color;
	end
	
	numeNab = vRP.getPlayerName({jucator})
	
	if(numeNab)then
		if(string.len(numeNab)>14)then
			newnumeNab = ""
			for i = 1, string.len(numeNab) do
				if(i <= 14)then
					newnumeNab = newnumeNab..string.sub(numeNab, i, i)
				end
			end
			numeNab = newnumeNab.."..."
		end
	end

	ore = vRP.getUserHoursPlayed({user_id})
	oameni = vRP.getUsers({user_id})	
	playerlist[user_id] = {tostring(numeNab),tostring("<font color='"..color.."'>"..getplayerping.."</font>"), tostring("<font color='"..scolor.."'>"..getplayeradmintitle.."</font>"),tostring(factiune),tonumber(ore),tonumber(oameni), 1}
end


AddEventHandler("vRP:playerSpawn",function(user_id, hours, jucatori, source, first_spawn)
	Citizen.SetTimeout(8 * 1000, function()
		fixeazaUsaKrestine()
	end)
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if playerlist[user_id] ~= nil then
		print("1")
	end
end)

function fixeazaUsaKrestine()
	playerlist = {}
	ems = 0
	police = 0
	mafia = 0

	users = vRP.getUsers({})
	for i, v in pairs(users) do
		jucator = v
		user_id = tonumber(i)

		if vRP.getPlayerName({jucator}) ~= "unknown" and vRP.getPlayerName({jucator}) ~= "Username" and vRP.getPlayerName({jucator}) then
			insertInScoreboard(jucator, user_id)
		end
	end

	SetTimeout(60000, fixeazaUsaKrestine)
end

RegisterCommand("fixscore", function(source, args, rawCommand)
	fixeazaUsaKrestine()
end)

RegisterNetEvent("scoreboard")
AddEventHandler("scoreboard",function()
    local num = GetNumPlayerIndices()
    TriggerClientEvent('getGlobalOnlinePly',-1,num)
end)