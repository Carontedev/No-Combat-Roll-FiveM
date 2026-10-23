local INPUT_JUMP = 22
local INPUT_ATTACK = 24
local INPUT_AIM = 25
local COMBAT_ROLL_TASK = 3
local WEAPON_UNARMED = GetHashKey('WEAPON_UNARMED')

local function isControlHeld(control)
    return IsControlPressed(0, control) or IsDisabledControlPressed(0, control)
end

local function isCombatInputActive(player, ped)
    if GetSelectedPedWeapon(ped) == WEAPON_UNARMED then return false end

    return IsPlayerFreeAiming(player)
        or IsAimCamActive()
        or isControlHeld(INPUT_AIM)
        or isControlHeld(INPUT_ATTACK)
        or IsPedShooting(ped)
        or IsPedUsingActionMode(ped)
end

CreateThread(function()
    while true do
        local player = PlayerId()
        local ped = PlayerPedId()

        -- Combat roll and jump share INPUT_JUMP. Blocking it only while the
        -- player has active combat intent preserves ordinary jump and vault.
        if isCombatInputActive(player, ped) then
            DisableControlAction(0, INPUT_JUMP, true)
        end

        -- Secondary defense for rolls started through an unusual input path.
        if GetIsTaskActive(ped, COMBAT_ROLL_TASK) then
            ClearPedTasksImmediately(ped)
        end

        Wait(0)
    end
end)
