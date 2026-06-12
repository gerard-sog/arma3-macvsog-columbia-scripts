# Turbulent Skies

Adds immersive low-altitude helicopter turbulence during bad weather in **Arma 3**, designed for **MACV-SOG style insertions/extractions**, immersive flying, and **multiplayer / dedicated servers**.

---

## Features

### Dynamic Helicopter Turbulence

- Low-altitude helicopter turbulence during poor weather
- Turbulence only affects helicopters flying:
    - **above 3m AGL**
    - **below configurable maximum altitude**
- Weather severity driven by:
    - **Overcast**
    - **Rain**
    - **Wind Strength (`windStr`)**
- Fog has **no impact**

### Realistic Weather Severity

Turbulence strength scales exponentially:

```sqf
_weatherRamp = _severity ^ 1.6;
```

Severity is calculated using:

```sqf
(overcast * TS_overcast_factor)
+ (rain * TS_rain_factor)
+ (windStr * TS_wind_factor)
```

Default weighting:

```sqf
TS_overcast_factor = 0.2;
TS_rain_factor = 0.5;
TS_wind_factor = 1;
```

### Multiplayer & Dedicated Server Safe

- Helicopter physics are only applied where the helicopter is **local**
- Prevents duplicated turbulence in multiplayer
- Compatible with **dedicated servers**
- No `CfgRemoteExec` required
- Uses **CBA server events** for synchronization

### Configurable Camera Shake

Each player can configure turbulence camera shake:

| Setting | Result |
|----------|--------|
| `0` | Disabled |
| `0.5` | Subtle (default) |
| `1` | Original intensity |
| `2` | Double intensity |

Camera shake is applied **locally to all helicopter occupants**.

### Optional Turbulence Damage

Optional airframe stress during severe turbulence:

- Configurable enable/disable
- Configurable severity threshold
- Damage only occurs in extreme weather
- Damage capped to prevent catastrophic instant failure

Recommended threshold:

```sqf
TS_damage_threshold = 1.4;
```

### Dynamic Weather System

Optional weather cycling system that transitions logically between weather states:

```text
CALM
↓
CALM to OVERCAST
↓
OVERCAST to RAINY
↓
RAINY
↓
RAINY to STORMY
↓
STORMY
```

Weather transitions are logical:

- **CALM** can only become **CALM to OVERCAST**
- **STORMY** can only improve to **RAINY to STORMY**
- Intermediate weather has configurable probabilities to:
    - improve
    - worsen

Weather duration and worsening probability are configurable via **CBA Settings**.

### ZEN Zeus Weather Presets

If **ZEN** is installed, Zeus gains:

```text
Turbulent Skies > Weather Preset
```

Available presets:

- CALM
- CALM to OVERCAST
- OVERCAST to RAINY
- RAINY
- RAINY to STORMY
- STORMY

Weather changes synchronize automatically across clients and dedicated servers.

### ACE Weather Forecast

If **ACE3** is installed:

Pilots and copilots gain a self action:

```text
Request Weather Forecast
```

The forecast reports:

- **Forecasted weather**
- **Expected low-altitude turbulence**
- **Estimated time until weather transition**

Example:

```text
AIR CONTROL

Forecasted weather: STORMY
Turbulence: Severe low-level turbulence expected
Expected in: 4m 32s
```

---

## CBA Settings

All settings are configurable through:

```text
Options > Addon Options > Turbulent Skies
```

Includes:

### General
- Maximum turbulence altitude

### Effects
- Camera shake multiplier

### Weather Severity
- Overcast factor
- Rain factor
- Wind factor

### Damage
- Enable turbulence damage
- Damage threshold

### Weather System
- Enable dynamic weather
- Minimum weather duration
- Maximum weather duration

### Debug
- Enable debug messages

---

## Test Weather (Eden / Debug Console)

### CALM

```sqf
skipTime 0.01;
86400 setOvercast 0;
forceWeatherChange;
0 setRain 0;
0 setWindStr 0.1;
0 setWindDir 45;
setWind [0.3, 0.3, true];
simulWeatherSync;
```

### CALM to OVERCAST

```sqf
skipTime 0.01;
86400 setOvercast 0.5;
forceWeatherChange;
0 setRain 0;
0 setWindStr 0.2;
0 setWindDir 45;
setWind [0.5, 0.5, true];
simulWeatherSync;
```

### OVERCAST to RAINY

```sqf
skipTime 0.01;
86400 setOvercast 0.7;
forceWeatherChange;
0 setRain 0.2;
0 setWindStr 0.3;
0 setWindDir 45;
setWind [0.8, 0.8, true];
simulWeatherSync;
```

### RAINY

```sqf
skipTime 0.01;
86400 setOvercast 0.85;
forceWeatherChange;
0 setRain 0.5;
0 setWindStr 0.5;
0 setWindDir 45;
setWind [1.5, 1.5, true];
simulWeatherSync;
```

### RAINY to STORMY

```sqf
skipTime 0.01;
86400 setOvercast 0.95;
forceWeatherChange;
0 setRain 0.75;
0 setWindStr 0.75;
0 setWindDir 45;
setWind [2.5, 2.5, true];
simulWeatherSync;
```

### STORMY

```sqf
skipTime 0.01;
86400 setOvercast 1;
forceWeatherChange;
0 setRain 1;
0 setWindStr 1;
0 setWindDir 45;
setWind [3.5, 3.5, true];
simulWeatherSync;
```