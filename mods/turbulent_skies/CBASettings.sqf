#define CBA_SETTINGS_TS "Turbulent Skies"

[
    "TS_maximum_altitude",
    "SLIDER",
    ["Maximum altitude", "Maximum altitude in meters AGL where turbulence can affect helicopters"],
    [CBA_SETTINGS_TS, "General"],
    [10, 300, 100, 0],
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    "TS_camera_shake_enabled",
    "CHECKBOX",
    ["Enable camera shake", "Adds camera shake when turbulence is active"],
    [CBA_SETTINGS_TS, "Effects"],
    true,
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