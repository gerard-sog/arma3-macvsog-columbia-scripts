/*
 * CBA Settings - Chicom Dud Grenade
 */

#define CBA_SETTINGS_CHICOM_DUD "Chicom Dud Grenade"

[
    "chicom_dud_chance",
    "SLIDER",
    ["Dud chance (%)", "Chance that a Chicom grenade becomes a dud instead of exploding"],
    [CBA_SETTINGS_CHICOM_DUD, "General"],
    [0, 100, 50, 0],
    1,
    {
        chicom_dud_chance = chicom_dud_chance / 100;
    },
    true
] call CBA_fnc_addSetting;