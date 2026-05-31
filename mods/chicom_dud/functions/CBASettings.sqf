/*
 * CBA Settings - Chicom Dud Grenade
 */

#define CBA_SETTINGS_CHICOM_DUD "Chicom Dud Grenade"

[
    "chicom_dud_chance",
    "SLIDER",
    ["Dud chance (%)", "Chance that a Chicom/T67 grenade becomes a dud instead of exploding"],
    [CBA_SETTINGS_CHICOM_DUD, "General"],
    [0, 100, 50, 0],
    1,
    {
        chicom_dud_chance = chicom_dud_chance / 100;
    },
    true
] call CBA_fnc_addSetting;

[
    "chicom_dud_audio_enabled",
    "CHECKBOX",
    ["Play dud fuse audio", "Play a short fuse sound when a Chicom/T67 grenade becomes a dud"],
    [CBA_SETTINGS_CHICOM_DUD, "Audio"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;