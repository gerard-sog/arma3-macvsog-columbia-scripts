Turbulent Skies

Adds realistic helicopter turbulence during bad weather in Arma 3, designed for multiplayer and dedicated servers. 
Turbulence affects helicopters flying low (default: below 100m AGL), with optional camera shake for all occupants. 
Settings are configurable through CBA Addon Options.

Test weather in Eden / debug console:

```
0 setOvercast 1;
0 setRain 1;

// Strong wind
setWind [14, 14, true];

forceWeatherChange;
```

Requires CBA_A3.

