-- Config: milliseconds to block combat roll after combat actions
local BLOCK_AFTER_SHOT_MS = 500
local BLOCK_RELOAD_MS    = 1200

local UNARMED_HASH = GetHashKey("WEAPON_UNARMED")
local blockUntil = 0

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local sleep = 250

        -- Skip if unarmed
        local hasWeapon = GetSelectedPedWeapon(ped) ~= UNARMED_HASH

        if hasWeapon then
            sleep = 0
            local now = GetGameTimer()

            -- Track actions that should block the roll
            if IsPedShooting(ped) or IsControlJustPressed(0, 24) then -- INPUT_ATTACK
                blockUntil = now + BLOCK_AFTER_SHOT_MS
            end

            -- Block while reloading and when pressing R
            if IsPedReloading(ped) or IsControlJustPressed(0, 45) then -- INPUT_RELOAD
                blockUntil = now + BLOCK_RELOAD_MS
            end

            -- Keep blocked while in combat (auto-extends slightly)
            if IsPedInCombat(ped, 0) then
                blockUntil = now + BLOCK_AFTER_SHOT_MS
            end

            local shouldBlock = IsControlPressed(0, 25) -- aiming (INPUT_AIM)
                or IsPedReloading(ped)
                or now < blockUntil

            if shouldBlock then
                -- Block jump/roll across control groups
                DisableControlAction(0, 22, true)
                DisableControlAction(1, 22, true)
                DisableControlAction(2, 22, true)
            end
        end

        Citizen.Wait(sleep)
    end
end)
