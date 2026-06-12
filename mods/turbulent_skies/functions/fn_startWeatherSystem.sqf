if (!isServer) exitWith {};

if (!isNil "TS_weatherSystem_handle") then {
    terminate TS_weatherSystem_handle;
};

TS_fnc_getNextWeatherPreset = {
    params [
        ["_currentPreset", 0, [0]]
    ];

    private _nextPreset = _currentPreset;

    if (_currentPreset <= 0) then {
        _nextPreset = 1;
    } else {
        if (_currentPreset >= 5) then {
            _nextPreset = 4;
        } else {
            if ((random 1) < 0.5) then {
                _nextPreset = _currentPreset + 1;
            } else {
                _nextPreset = _currentPreset - 1;
            };
        };
    };

    _nextPreset
};

TS_fnc_getWeatherPresetData = {
    params [
        ["_preset", 0, [0]]
    ];

    private _weatherData = switch (_preset) do {
        case 0: {
            [0, 0, 0.1, 45, [0.3, 0.3, true], "CALM"]
        };

        case 1: {
            [0.5, 0, 0.2, 45, [0.5, 0.5, true], "CALM to OVERCAST"]
        };

        case 2: {
            [0.7, 0.2, 0.3, 45, [0.8, 0.8, true], "OVERCAST to RAINY"]
        };

        case 3: {
            [0.85, 0.5, 0.5, 45, [1.5, 1.5, true], "RAINY"]
        };

        case 4: {
            [0.95, 0.75, 0.75, 45, [2.5, 2.5, true], "RAINY to STORMY"]
        };

        case 5: {
            [1, 1, 1, 45, [3.5, 3.5, true], "STORMY"]
        };

        default {
            [0, 0, 0.1, 45, [0.3, 0.3, true], "CALM"]
        };
    };

    _weatherData
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

    while {TS_weather_system_enabled} do {
        private _currentPreset = TS_weatherSystem_currentPreset;
        private _nextPreset = TS_weatherSystem_nextPreset;

        TS_weatherSystem_currentPreset = _nextPreset;
        TS_weatherSystem_nextPreset = [_nextPreset] call TS_fnc_getNextWeatherPreset;

        publicVariable "TS_weatherSystem_currentPreset";
        publicVariable "TS_weatherSystem_nextPreset";

        private _weatherData = [TS_weatherSystem_currentPreset] call TS_fnc_getWeatherPresetData;

        (_weatherData + [objNull, TS_weatherSystem_currentPreset]) call TS_fnc_applyWeatherPreset;

        private _duration = TS_weather_cycle_min_time + random (TS_weather_cycle_max_time - TS_weather_cycle_min_time);

        TS_weatherSystem_nextTransitionTime = CBA_missionTime + _duration;
        publicVariable "TS_weatherSystem_nextTransitionTime";

        if (TS_debug_enabled) then {
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