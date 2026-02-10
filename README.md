# FiveM No Combat Roll


There is no fully reliable script that removes the combat roll without breaking or affecting other mechanics such as normal jumping.
With this resource, I aimed to find a clean and effective alternative that completely disables the combat roll while keeping all other controls intact.
This script is fully functional, optimized, and free, designed to work without impacting performance or gameplay balance.
I hope this resource is very useful to you, and don’t forget to leave a ⭐ on this repository if it helped you.


Client-side resource that blocks combat roll by disabling the Jump control (INPUT_JUMP / Space) under these conditions:

* While aiming (INPUT_AIM)
* While reloading / after pressing R (INPUT_RELOAD)
* For a short time after shooting
* While the ped is flagged as being in combat

Note: because combat roll uses the Jump control, this also prevents jumping/vaulting while the block is active.

## Installation

1. Download and extract the contents into your `resources` folder.
2. Rename the folder to `no_combat_roll` (if needed).
3. Add the following line to your `server.cfg`:
   ```
    ensure no_combat_roll
  
   ```
4. Restart your server or start the resource from the server console.

## Configuration

You can tweak how strict the block is by editing these values in `client.lua`:

```lua
-- Milliseconds to block roll after shooting / combat
local BLOCK_AFTER_SHOT_MS = 500

-- Milliseconds to block roll when reloading / after pressing R
local BLOCK_RELOAD_MS = 1200
```

## Requirements

* FiveM (FXServer).
* Up-to-date server artifacts for native control functions compatibility.
* Standalone resource (no ESX, no QBCore required).

## License

This project is distributed under the MIT license. See [LICENSE](LICENSE) for details.
