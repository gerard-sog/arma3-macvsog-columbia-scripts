# STABO Pickup Rope

**Based on the original mod:**  
[Advanced Pickup Rope by Dash](https://steamcommunity.com/sharedfiles/filedetails/?id=1667745333)

Adds immersive **STABO helicopter pickup rope extraction** to **Arma 3**, updated for **multiplayer** and **dedicated servers**.

Designed for:

- MACV-SOG style missions

---

## Features

### Helicopter Pickup Rope

Compatible helicopters gain an action:

```text
Request Pickup Rope
```

Players can attach to a rope suspended from a helicopter and be extracted while airborne.

### Rope Controls

| Key | Action |
|------|--------|
| `W` | Ascend |
| `S` | Descend |
| `Shift` | Fast Descend |

### Multiplayer & Dedicated Server Safe

- Dedicated server compatible
- Proper locality handling
- No AI freezing
- Multiplayer safe rope simulation
- Server-authoritative pickup validation

### Dynamic Rope Physics

Simulated:

- Gravity
- Helicopter movement
- Wind
- Rope sway

Players automatically re-enter the helicopter when close enough.

---

## Requirements

Required mod:

- [Advanced Rappelling](https://steamcommunity.com/sharedfiles/filedetails/?id=713709341)

---

## Usage

1. Enter a compatible helicopter
2. Open action menu
3. Select:

```text
Request Pickup Rope
```

4. Ascend or descend while attached

---

## Testing

Check mod loaded:

```sqf
hint str !isNil "APR_Pickup_Rope";
```

Force rope pickup:

```sqf
[player, vehicle player] call APR_Pickup_Rope;
```

Check helicopter compatibility:

```sqf
hint str ([player, vehicle player] call AR_Rappel_From_Heli_Action_Check);
```

---

## Credits

Original concept based on:

[Advanced Pickup Rope by Dash](https://steamcommunity.com/sharedfiles/filedetails/?id=1667745333)