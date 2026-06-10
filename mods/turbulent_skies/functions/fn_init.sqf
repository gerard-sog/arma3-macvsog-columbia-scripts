if (!hasInterface) exitWith {};
if (!isNil "TS_initialized") exitWith {};

TS_initialized = true;

if (isNil "TS_maximum_altitude") then {
    TS_maximum_altitude = 100;
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

if (isNil "TS_wind_divisor") then {
    TS_wind_divisor = 14;
};

if (isNil "TS_damage_enabled") then {
    TS_damage_enabled = false;
};

if (isNil "TS_damage_threshold") then {
    TS_damage_threshold = 2.0;
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