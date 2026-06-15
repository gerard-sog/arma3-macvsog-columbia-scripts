# STABO Pickup Rope

STABO helicopter extraction system for **Arma 3**, inspired by **Advanced Pickup Rope by Dash** and built for **multiplayer** and **dedicated servers**.

## Features

- Helicopter-deployed **STABO rope with sandbag**
- Ground players attach using:

```text
Attach STABO rig
```

- Multiple players can attach simultaneously
- Dynamic rope lengths:

```text
1st player → 3.5m  
2nd player → 7m  
3rd player → 10.5m
```

- Rope breaks if helicopter flies too far
- Attached players remain connected
- Crew can redeploy a new STABO rope
- Zeus remote-controlled AI supported
- Dedicated server compatible

## Requirements

Required mod:

- **Advanced Rappelling**

## Main Class

The mod initializes through:

```cpp
class AdvancedPickupRopeInit
{
	postInit = 1;
};
```

Main gameplay functions:

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