/*
    Turbulent Skies
    Server-side dynamic weather loop.
*/

if (!isServer) exitWith {};

if (!isNil "TS_weatherSystem_handle") then {
    terminate TS_weatherSystem_handle;
};

TS_weatherSystem_handle = [] spawn {
    if (isNil "TS_weatherSystem_currentPreset") then {
        TS_weatherSystem_currentPreset = 0;
    };

    if (isNil "TS_weatherSystem_nextPreset") then {
        TS_weatherSystem_nextPreset = [TS_weatherSystem_currentPreset] call TS_fnc_getNextWeatherPreset;
    };

    publicVariable "TS_weatherSystem_currentPreset";
    publicVariable "TS_weatherSystem_nextPreset";

    while {missionNamespace getVariable ["TS_weather_system_enabled", false]} do {
        private _nextPreset = TS_weatherSystem_nextPreset;

        TS_weatherSystem_currentPreset = _nextPreset;
        TS_weatherSystem_nextPreset = [_nextPreset] call TS_fnc_getNextWeatherPreset;

        publicVariable "TS_weatherSystem_currentPreset";
        publicVariable "TS_weatherSystem_nextPreset";

        private _weatherData = [TS_weatherSystem_currentPreset] call TS_fnc_getWeatherPresetData;

        (_weatherData + [objNull, TS_weatherSystem_currentPreset]) call TS_fnc_applyWeatherPreset;

        private _minTime = missionNamespace getVariable ["TS_weather_cycle_min_time", 900];
        private _maxTime = missionNamespace getVariable ["TS_weather_cycle_max_time", 1800];
        private _duration = _minTime + random ((_maxTime - _minTime) max 1);

        TS_weatherSystem_nextTransitionTime = CBA_missionTime + _duration;
        publicVariable "TS_weatherSystem_nextTransitionTime";

        if (missionNamespace getVariable ["TS_debug_enabled", false]) then {
            systemChat format [
                "[TS] Current weather: %1 | Next forecast: %2 | Next transition in %3 seconds.",
                TS_weatherSystem_currentPreset,
                TS_weatherSystem_nextPreset,
                round _duration
            ];
        };

        sleep _duration;
    };
};
