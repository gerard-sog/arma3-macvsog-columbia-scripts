# Turbulent Skies

Adds realistic helicopter turbulence during bad weather in **Arma 3**, designed for immersive low-altitude flying and **multiplayer / dedicated servers**.

## Features

- Dynamic helicopter turbulence during bad weather
- Configurable camera shake for all helicopter occupants
- Optional airframe damage during severe turbulence
- Advanced Flight Model (AFM) balancing
- Multiplayer & dedicated-server safe
- ZEN Zeus weather presets (**CALM / RAINY / STORMY**)

All settings are configurable through **CBA Addon Options**.

## Test Weather (Eden / Debug Console)

```
0 setOvercast 1;
0 setRain 1;

// Strong wind
setWind [14, 14, true];

forceWeatherChange;
```