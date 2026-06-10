#define CBA_SETTINGS_TS "Turbulent Skies"

[
    "TS_maximum_altitude",
    "SLIDER",
    ["Maximum altitude", "Maximum altitude in meters AGL where turbulence affects helicopters"],
    [CBA_SETTINGS_TS, "General"],
    [10, 500, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_camera_shake_multiplier",
    "SLIDER",
    [
        "Camera shake strength",
        "Multiplier for camera shake intensity. 0 = no shake, 0.5 = subtle (default), 1 = original intensity, 2 = double strength."
    ],
    [CBA_SETTINGS_TS, "Effects"],
    [0, 3, 0.5, 2],
    0,
    {},
    false
] call CBA_fnc_addSetting;

[
    "TS_overcast_factor",
    "SLIDER",
    ["Overcast factor", "How much overcast contributes to turbulence severity"],
    [CBA_SETTINGS_TS, "Weather severity"],
    [0, 1, 0.2, 2],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_rain_factor",
    "SLIDER",
    ["Rain factor", "How much rain contributes to turbulence severity"],
    [CBA_SETTINGS_TS, "Weather severity"],
    [0, 1, 0.5, 2],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_wind_divisor",
    "SLIDER",
    ["Wind divisor", "Lower value means wind contributes more strongly to turbulence severity"],
    [CBA_SETTINGS_TS, "Weather severity"],
    [5, 30, 14, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_damage_enabled",
    "CHECKBOX",
    ["Enable turbulence damage", "Allows severe turbulence to cause small helicopter damage"],
    [CBA_SETTINGS_TS, "Damage"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_damage_threshold",
    "SLIDER",
    ["Damage severity threshold", "Turbulence damage can occur only when severity is above this value"],
    [CBA_SETTINGS_TS, "Damage"],
    [0.5, 4, 2.0, 2],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_debug_enabled",
    "CHECKBOX",
    ["Enable debug messages", "Show turbulence debug messages in systemChat"],
    [CBA_SETTINGS_TS, "Debug"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;