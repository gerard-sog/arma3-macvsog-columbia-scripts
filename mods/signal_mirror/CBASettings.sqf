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

[
    "SM_REQUIRE_SUN_LOS",
    "CHECKBOX",
    [
        "Require direct line-of-sight to sun",
        "If enabled, the signal mirror only works when the player has direct line-of-sight to the sun."
    ],
    [CBA_SETTINGS_SIGNAL_MIRROR, "General"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;