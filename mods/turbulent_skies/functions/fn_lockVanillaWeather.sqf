if (!isServer) exitWith {};

// Disable vanilla dynamic weather evolution
setForecastFog 0;
setForecastOvercast 0;
setForecastRain 0;
setForecastWaves 0;
setForecastWind 0;
setForecastLightnings 0;

// Re-apply current weather immediately so Arma stops drifting
forceWeatherChange;
simulWeatherSync;

if (TS_debug_enabled) then {
    systemChat "[TS] Vanilla weather evolution locked";
};