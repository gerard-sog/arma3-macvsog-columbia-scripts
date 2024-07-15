/*
 *
 * CBA Settings Columbia
 * Called as Extended_PreInit_EventHandlers
 *
 * see https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

#define CBA_SETTINGS_COLUMBIA "Columbia Settings"

// Medical kit conversion - Medikit
["Columbia_CBA_medikit_convert_ace_field_dressing", "SLIDER", ["Medikit - field dressing"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 50, 20, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_medikit_convert_ace_saline_iv_500", "SLIDER", ["Medikit - saline IV 500"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_medikit_convert_ace_epinephrine", "SLIDER", ["Medikit - epinephrine"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_medikit_convert_ace_morphine", "SLIDER", ["Medikit - morphine"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_medikit_convert_ace_tourniquet", "SLIDER", ["Medikit - tourniquet"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 4, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_medikit_convert_ace_splint", "SLIDER", ["Medikit - splint"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;

// Medical kit conversion - First Aid
["Columbia_CBA_first_aid_convert_ace_field_dressing", "SLIDER", ["First Aid - field dressing"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 5, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_first_aid_convert_ace_morphine", "SLIDER", ["First Aid - morphine"], [CBA_SETTINGS_COLUMBIA, "Medical kit conversion"], [0, 10, 1, 0], 1, {}, false] call CBA_fnc_addSetting;

// AI skills
["Columbia_CBA_ai_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLUMBIA, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_ai_general_skill", "SLIDER", ["general"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_aiming_accuracy", "SLIDER", ["aiming accuracy"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_aiming_speed", "SLIDER", ["aiming speed"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_aiming_shake", "SLIDER", ["aiming shake"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_commanding", "SLIDER", ["commanding"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_courage", "SLIDER", ["courage"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_spot_distance", "SLIDER", ["spot distance"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_spot_time", "SLIDER", ["spot time"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_reload_speed", "SLIDER", ["reload speed"], [CBA_SETTINGS_COLUMBIA, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_ai_seek_cover", "CHECKBOX", ["seek cover"], [CBA_SETTINGS_COLUMBIA, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_ai_auto_combat", "CHECKBOX", ["auto combat"], [CBA_SETTINGS_COLUMBIA, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_ai_suppression", "CHECKBOX", ["suppression"], [CBA_SETTINGS_COLUMBIA, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;

// ==============================|
// /!\ CURRENTLY NOT WORKING /!\ |
// Tracker module                |
// ==============================|
//["Columbia_CBA_tracker_module_name", "EDITBOX", ["Tracker module name"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], "TrackermoduleNAME", 1, {}, false] call CBA_fnc_addSetting;
//["Columbia_CBA_tracker_module_default_behaviour", "LIST", [Default behaviour"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["CARELESS", "SAFE", "AWARE", "COMBAT"], ["Careless", "Safe", "Aware", "Combat"], 0], 1, {}, false] call CBA_fnc_addSetting;
//["Columbia_CBA_tracker_module_default_combat", "LIST", [Default combat"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], ["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"], 0], 1, {}, false] call CBA_fnc_addSetting;
//["Columbia_CBA_tracker_module_default_speed", "LIST", [Default speed"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["LIMITED", "NORMAL", "FULL"], ["Limited", "Normal", "Full"], 0], 1, {}, false] call CBA_fnc_addSetting;
