CreateThread(function()	
    for k,v in pairs(Config.item) do
        ESX.RegisterUsableItem(v.itemname, function(source)
            TriggerClientEvent('KD_PropItem:creandatta', source, v.Model, v.Bone, v.xPos, v.yPos, v.zPos, v.xRot, v.yRot, v.zRot, v.itemname)  
        end)
    end
end)

CreateThread(function()	
    for k,v in pairs(Config.ItemAnim) do
        ESX.RegisterUsableItem(v.itemname, function(source)
            TriggerClientEvent('KD_PropItem:creandattaanim', source, v.model, v.animName, v.animDict, v.bone, v.canMove, v.emoteLoop, v.x, v.y, v.z, v.xR, v.yR, v.zR, v.itemname)
        end)
    end
end)

RegisterNetEvent('KD_PropItem:sv_sendwebhook')
AddEventHandler('KD_PropItem:sv_sendwebhook', function(k)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.Webhook then
		SendToDiscord(string.format("**Name**: %s\n**Identifier**: %s (%s)\n**Used A Prop Item Name: %s**\n**Timestamp**: %s", xPlayer.getName(), GetPlayerName(source), xPlayer.identifier, k, os.date('%Y-%m-%d %H:%M:%S')))
	end
end)

function SendToDiscord(message)
	local embed = {
		{
			["title"] = "Prop As Item",
			["description"] = message,
		    ["footer"] = {
		        ["text"] = "• Kokkachi_Damu#5646 •",
		    },
		}
	}
	PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Kokkachi_Damu#5646", embeds = embed}), { ['Content-Type'] = 'application/json' })
end