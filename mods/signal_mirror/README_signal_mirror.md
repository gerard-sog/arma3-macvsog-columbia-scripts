# Signal Mirror

Signal Mirror adds a **Signal Mirror** item to the **Binoculars** section of the Arsenal.

Ground personnel equipped with a signal mirror can attract the attention of nearby aircraft by aiming at them. When a player on foot uses the signal mirror and looks at a flying aircraft, the aircraft crew sees a flashing glint at the player's location.

```text
Player                             Helicopter

                /                    __|__
               /               -----/     \-----
  O           /                     \_____/
 /|\         <
 / \          \
               \
                \

              30° Detection Cone
```

## Features

- Adds a Signal Mirror item to the Arsenal's Binoculars section
- Aircraft signaling using signal mirror
- Randomized glint effects
- Supports multiple signalers
- Multiplayer and dedicated server compatible
- Only visible to the targeted aircraft crew

## CBA Settings

### Minimum Sunlight

Controls the minimum `sunOrMoon` value required for the signal mirror to function.

- Default: `0.3`
- Range: `0.0` to `1.0`
- `0.0` = works at any time of day
- `1.0` = requires full daylight

### Require Direct Line-of-Sight to Sun

When enabled, the signal mirror only works if the player has an unobstructed line-of-sight to the sun.

Examples of situations where signaling will not work:

- Inside buildings
- Under roofs
- Inside hangars
- Beneath dense overhead terrain obstruction

- Default: `Disabled`

## Acknowledgements

Special thanks to **TheDUDE** for creating and providing the signal mirror 3D model used in this mod.

## Requirements

- CBA_A3