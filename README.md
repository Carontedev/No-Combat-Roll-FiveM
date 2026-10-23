# CS No Combat Roll

Standalone FiveM resource that prevents combat rolls during active combat input while keeping normal jumping, sprint-jumping, vaulting, and climbing available outside combat.

[Features](#features) · [How it works](#how-it-works) · [Installation](#installation) · [Troubleshooting](#troubleshooting) · [Performance](#performance) · [Requirements](#requirements) · [License](#license)

---

## Features

- 🛑 Blocks the shared jump/roll input while an armed player is aiming or attacking
- 🏃 Preserves normal jump, sprint-jump, vault, and climb controls outside active combat input
- ⚡ Checks combat input every frame to catch quick aim-and-jump combinations
- 🛡️ Detects the combat-roll task as a secondary safeguard
- 🧩 Standalone client resource with no framework dependency
- 🪶 No server loop, network events, or framework calls

---

## How it works

GTA V uses the same input (`INPUT_JUMP`, control 22) for jumping and combat rolls. Permanently disabling it would also prevent ordinary jumps and vaults.

This resource checks the player's weapon and combat input every frame. While an armed player is aiming, attacking, shooting, or using combat action mode, it disables `INPUT_JUMP`. It also checks for the combat-roll task and clears it if the task starts through another input path.

When those combat conditions are not active, the resource leaves the jump input alone. Equipping a weapon by itself does not disable jumping.

---

## Installation

1. Place the `cs_no_combat_roll` folder in your server's `resources` directory.
2. Add this line to `server.cfg` (or ensure it through one of your resource groups):

   ```cfg
   ensure cs_no_combat_roll
   ```

3. Start or restart the resource:

   ```text
   restart cs_no_combat_roll
   ```

---

## Troubleshooting

**Combat rolls still happen**

- Confirm that `cs_no_combat_roll` is started in the server console.
- Check that the resource folder name matches the `ensure` and `restart` commands.
- Try the behavior with the weapon and input combination where the issue occurs; custom weapons may handle combat input differently.

**Jumping or vaulting is blocked**

- This resource disables jump only while an armed player has active combat input. Test again after releasing aim and attack.
- Check for another resource that also disables control 22 or modifies player tasks.

---

## Performance

The resource is currently showing around **3.0 ms** in my resmon readings. I am working on lowering its resource usage, and I will continue releasing updates as performance improvements are made. Resmon values can vary depending on the server and test conditions.

---

## Requirements

- FiveM artifact with support for `GetIsTaskActive` combat-roll task detection (task 3)
- No ESX, QBCore, or other framework dependency

## License

MIT. See [LICENSE](LICENSE) for details.
