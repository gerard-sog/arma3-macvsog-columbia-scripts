/*
    Turbulent Skies
    Main initialization.
*/

if (!isNil "TS_initialized") exitWith {};
TS_initialized = true;

// Defaults used by both clients and server-side functions
private _defaults = [
    ["TS_maximum_altitude", 300],
    ["TS_camera_shake_multiplier", 0.5],
    ["TS_debug_enabled", false],
    ["TS_overcast_factor", 0.2],
    ["TS_rain_factor", 0.5],
    ["TS_wind_factor", 1],
    ["TS_damage_enabled", false],
    ["TS_damage_threshold", 1.4],
    ["TS_weather_system_enabled", false],
    ["TS_weather_cycle_min_time", 900],
    ["TS_weather_cycle_max_time", 1800],
    ["TS_weatherSystem_currentPreset", 0],
    ["TS_weatherSystem_nextPreset", 1]
];

{
    _x params ["_name", "_defaultValue"];

    if (isNil _name) then {
        missionNamespace setVariable [_name, _defaultValue];
    };
} forEach _defaults;

[
    "TS_applyWeatherPreset",
    {
        _this call TS_fnc_applyWeatherPreset;
    }
] call CBA_fnc_addEventHandler;

if (isServer) then {
    [] spawn {
        waitUntil { !isNil "TS_weather_system_enabled" };

        if (TS_weather_system_enabled) then {
            [] call TS_fnc_lockVanillaWeather;
            [] call TS_fnc_startWeatherSystem;
        };
    };
};

// Player-only logic
if (hasInterface) then {

    [] spawn {
        waitUntil { !isNull player };

        if (!isNil "ace_interact_menu_fnc_createAction") then {
            [] call TS_fnc_addAceActions;
        };

        player addEventHandler ["GetInMan", {
            params ["_unit", "_role", "_vehicle"];

            if !(_vehicle isKindOf "Helicopter") exitWith {};

            [_unit, _vehicle] call TS_fnc_startMonitor;
        }];

        player addEventHandler ["GetOutMan", {
            params ["_unit"];

            [_unit] call TS_fnc_cleanupTurbulence;
        }];

        [] call TS_fnc_registerZeusModules;
    };
};
