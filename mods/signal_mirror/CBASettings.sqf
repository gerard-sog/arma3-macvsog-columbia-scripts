// CBASettings.sqf

#define CBA_SETTINGS_SIGNAL_MIRROR "Signal Mirror"

[
    "SM_SUN_THRESHOLD",
    "SLIDER",
    [
        "Minimum sunlight",
        "Minimum sunOrMoon value required for the signal mirror to work. 0 = night, 1 = full daylight."
    ],
    [CBA_SETTINGS_SIGNAL_MIRROR, "General"],
    [0, 1, 0.3, 2],
    1,
    {},
    true
] call CBA_fnc_addSetting;