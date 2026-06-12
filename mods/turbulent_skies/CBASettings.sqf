#define CBA_SETTINGS_TS "Turbulent Skies"

[
    "TS_maximum_altitude",
    "SLIDER",
    ["Maximum altitude", "Maximum altitude in meters AGL where turbulence affects helicopters"],
    [CBA_SETTINGS_TS, "General"],
    [10, 500, 300, 0],
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
    "TS_wind_factor",
    "SLIDER",
    [
        "Wind factor",
        "How much wind strength contributes to turbulence severity."
    ],
    [CBA_SETTINGS_TS, "Weather severity"],
    [0, 2, 1.0, 2],
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
    [
        "Damage severity threshold",
        "Turbulence damage can occur only when severity is above this value. 0.5 = frequent damage, 0.8 = rough weather, 1.2 = severe storm only, 1.4 = near extreme storm (recommended), 1.7 = almost never."
    ],
    [CBA_SETTINGS_TS, "Damage"],
    [0.5, 1.7, 1.4, 2],
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

[
    "TS_weather_system_enabled",
    "CHECKBOX",
    ["Enable Dynamic Weather System", "Automatically cycles Turbulent Skies weather presets logically."],
    [CBA_SETTINGS_TS, "Weather System"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_weather_cycle_min_time",
    "SLIDER",
    ["Minimum Weather Duration", "Minimum time before the weather system transitions to the next preset."],
    [CBA_SETTINGS_TS, "Weather System"],
    [60, 7200, 900, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_weather_cycle_max_time",
    "SLIDER",
    ["Maximum Weather Duration", "Maximum time before the weather system transitions to the next preset."],
    [CBA_SETTINGS_TS, "Weather System"],
    [60, 7200, 1800, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;