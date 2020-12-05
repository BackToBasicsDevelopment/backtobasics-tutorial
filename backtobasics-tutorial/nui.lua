local display = true
local first = true

RegisterCommand("tutorial", function(source, args, rawCommand)
    SetDisplay(not display)
end)

AddEventHandler('playerSpawned', function()
    SetDisplay(true)
end)

-- Exit callback
RegisterNUICallback("exit", function(data)
    if first == true then
        TriggerEvent('chatMessage', "SYSTEM", {0,0,0}, "Welcome to the server " .. GetPlayerName(PlayerId()))
    end
    first = false
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- Look Left/Right
        DisableControlAction(0, 2, display) -- Look Up/Down
        DisableControlAction(0, 142, display) -- Melee Attack
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- Mouse Click
        DisableControlAction(0, 199, display) -- Pause Menu (P)
    end
end)
