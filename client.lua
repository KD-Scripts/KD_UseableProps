local toggleKit = false 
local medkit = nil

RegisterNetEvent('KD_PropItem:creandatta')
AddEventHandler('KD_PropItem:creandatta', function(Model, Bone, xPos, yPos, zPos, xRot, yRot, zRot, k)
    toggleKit = not toggleKit
    if toggleKit then
        if medkit == nil then
			medkit = CreateObject(GetHashKey(Model), 0, 0, 0, true, true, true)
        end			
        AttachEntityToEntity(medkit, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), Bone), xPos, yPos, zPos, xRot, yRot, zRot, true, true, false, true, 1, true) 
        TriggerServerEvent('KD_PropItem:sv_sendwebhook', k) 
        notify1()
    else
        if medkit ~= nil then
            DeleteEntity(medkit)
            medkit = nil
            notify2()
        end			
    end
end)

RegisterNetEvent('KD_PropItem:creandattaanim')
AddEventHandler('KD_PropItem:creandattaanim', function(model, animName, animDict, bone, canMove, emoteLoop, x, y, z, xR, yR, zR, k)
    toggleKit = not toggleKit
    if toggleKit then
        if medkit == nil then
            LoadAnimationDic(animName)
            TaskPlayAnim(GetPlayerPed(-1), animName , animDict, 5.0, -1, -1, 50, 0, false, false, false)
            local model = GetHashKey(model)
            RequestModel(model)
            while not HasModelLoaded(model) do Citizen.Wait(0) end
            medkit = CreateObject(model, 0, 0, 0, true, true, true)
        end
        AttachEntityToEntity(medkit, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), bone), x, y, z, xR, yR, zR, true, true, false, true, 1, true)
        TriggerServerEvent('KD_PropItem:sv_sendwebhook', k)
        notify1()
    else
        if medkit ~= nil then
            DeleteEntity(medkit)
            ClearPedTasks(PlayerPedId())
            ClearPedSecondaryTask(PlayerPedId())
            medkit = nil
            notify2()
        end
    end

    local ped = PlayerPedId()
    while medkit ~= nil do 
        Citizen.Wait(550)
        if IsEntityPlayingAnim(ped, animName, animDict, 3) == false then 
            if medkit ~= nil then
                TaskPlayAnim(ped, animName , animDict, 5.0, -1, -1, 50, 0, false, false, false)
            end
        end
    end
end)

function LoadAnimationDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) and timeout < 100 do
            timeout = timeout + 1
            Citizen.Wait(0)
        end
    end
end