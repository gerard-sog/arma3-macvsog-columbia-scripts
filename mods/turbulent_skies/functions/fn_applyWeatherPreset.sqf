/*
    Turbulent Skies
    Applies a weather preset on the server and syncs it to clients.
*/

if (!isServer) exitWith {};

params [
    ["_overcast", 0, [0]],
    ["_rain", 0, [0]],
    ["_windStr", 0.1, [0]],
    ["_windDir", 45, [0]],
    ["_wind", [0.3, 0.3, true], [[]]],
    ["_name", "CALM", [""]],
    ["_zeus", objNull, [objNull]],
    ["_preset", -1, [0]]
];

if (!isNull _zeus || {missionNamespace getVariable ["TS_weather_system_enabled", false]}) then {
    [] call TS_fnc_lockVanillaWeather;
};

if (_preset >= 0) then {
    TS_weatherSystem_currentPreset = _preset;
    TS_weatherSystem_nextPreset = [_preset] call TS_fnc_getNextWeatherPreset;

    publicVariable "TS_weatherSystem_currentPreset";
    publicVariable "TS_weatherSystem_nextPreset";
};

// Overcast must be forced first or rain won't apply reliably
86400 setOvercast _overcast;
forceWeatherChange;

// Rain after overcast is established
0 setRain _rain;

// Wind settings
0 setWindStr _windStr;
0 setWindDir _windDir;

// Actual physical wind vector
setWind [
    (_wind # 0),
    (_wind # 1),
    true
];

// Sync to all clients
simulWeatherSync;

// Confirmation only to Zeus
if (!isNull _zeus) then {
    [
        format [
            "[TS] %1 | Over:%2 Rain:%3 Wind:%4 | Next:%5",
            _name,
            _overcast,
            _rain,
            _windStr,
            TS_weatherSystem_nextPreset
        ]
    ] remoteExecCall [
        "systemChat",
        owner _zeus
    ];
};
