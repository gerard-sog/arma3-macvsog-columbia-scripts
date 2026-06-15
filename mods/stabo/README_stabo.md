# STABO Pickup Rope

STABO helicopter extraction system for **Arma 3**, inspired by **Advanced Pickup Rope by Dash** and built for **multiplayer** and **dedicated servers**.

## Features

- Helicopter-deployed **STABO rope with sandbag**
- Ground players attach using:

```text
Attach STABO rig
```

- Multiple players can attach simultaneously
- **Configurable rope length** (default: `28m`)
- **3.5m spacing per player slot**
- Dynamic rope lengths:

```text
1st player → 3.5m
2nd player → 7m
3rd player → 10.5m
...
```

- **Configurable hold action duration** (`1–30s`)
- Rope breaks if helicopter flies too far
- Attached players remain connected
- Crew can redeploy a new STABO rope
- Zeus remote-controlled AI supported
- Dedicated server compatible
- Multiplayer-safe and server authoritative

## Requirements

Required mods:

- **CBA_A3**
- **Advanced Rappelling**

## Configuration

Configurable in **CBA Addon Settings**:

### STABO Rope Length

- Default: `28m`
- Maximum: `56m`

Slot count is automatically calculated using **3.5m per segment**.

Example:

```text
28m rope = 8 slots
56m rope = 16 slots
```

### STABO Attach Duration

- Range: `1–30 seconds`
- Default: `1 second`

## Main Class

The mod initializes through:

```cpp
class AdvancedPickupRopeInit
{
	postInit = 1;
};
```

### Main Gameplay Functions

```sqf
Dash_fnc_DropStaboRope
Dash_fnc_PickupRope
Dash_fnc_ClientPickupRope
```

## Usage

### Helicopter Crew

Use the action menu:

```text
Drop STABO rope
```

### Ground Players

Use the sandbag hold action:

```text
Attach STABO rig
```

Detach using:

```text
Detach Rappel Device
```

(from **Advanced Rappelling**)

## Credits

Inspired by **Advanced Pickup Rope by Dash**: https://steamcommunity.com/sharedfiles/filedetails/?id=1667745333