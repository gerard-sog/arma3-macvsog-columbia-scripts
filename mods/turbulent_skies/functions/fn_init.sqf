if (!isNil "TS_initialized") exitWith {};
TS_initialized = true;

// Defaults used by both clients and server-side functions
if (isNil "TS_maximum_altitude") then {
    TS_maximum_altitude = 300;
};

if (isNil "TS_camera_shake_multiplier") then {
    TS_camera_shake_multiplier = 0.5;
};

if (isNil "TS_debug_enabled") then {
    TS_debug_enabled = false;
};

if (isNil "TS_overcast_factor") then {
    TS_overcast_factor = 0.2;
};

if (isNil "TS_rain_factor") then {
    TS_rain_factor = 0.5;
};

if (isNil "TS_wind_factor") then {
    TS_wind_factor = 1;
};

if (isNil "TS_damage_enabled") then {
    TS_damage_enabled = false;
};

if (isNil "TS_damage_threshold") then {
    TS_damage_threshold = 1.4;
};

if (isNil "TS_weather_system_enabled") then {
    TS_weather_system_enabled = false;
};

if (isNil "TS_weather_cycle_min_time") then {
    TS_weather_cycle_min_time = 900;
};

if (isNil "TS_weather_cycle_max_time") then {
    TS_weather_cycle_max_time = 1800;
};

if (isNil "TS_weatherSystem_currentPreset") then {
    TS_weatherSystem_currentPreset = 0;
};

if (isNil "TS_weatherSystem_nextPreset") then {
    TS_weatherSystem_nextPreset = 1;
};

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
            [] call TS_fnc_startWeatherSystem;
        };
    };

    if (isNil "TS_airControl") then {
        TS_airControl = createAgent [
            "VirtualCurator_F",
            [0, 0, 0],
            [],
            0,
            "NONE"
        ];

        TS_airControl setName "Air Control";
        publicVariable "TS_airControl";
    };
};

// Player-only logic
if (hasInterface) then {

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

        private _handle = _unit getVariable ["TS_handle", scriptNull];
        if !(isNull _handle) then {
            terminate _handle;
        };

        private _monitor = _unit getVariable ["TS_seatMonitorHandle", scriptNull];
        if !(isNull _monitor) then {
            terminate _monitor;
        };

        _unit setVariable ["TS_handle", nil];
        _unit setVariable ["TS_seatMonitorHandle", nil];

        if (TS_debug_enabled) then {
            systemChat "[TS] Turbulence disabled";
        };
    }];

    [] call TS_fnc_registerZeusModules;
};