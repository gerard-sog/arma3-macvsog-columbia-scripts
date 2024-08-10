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

// Tracker module
["Columbia_CBA_tracker_module_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], true, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_tracker_module_name", "EDITBOX", ["Tracker module name"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], "TrackermoduleNAME", 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_tracker_module_default_behaviour", "LIST", ["Default behaviour"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["CARELESS", "SAFE", "AWARE", "COMBAT"], ["Careless", "Safe", "Aware", "Combat"], 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_tracker_module_default_combat", "LIST", ["Default combat"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], ["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"], 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_tracker_module_default_speed", "LIST", ["Default speed"], [CBA_SETTINGS_COLUMBIA, "Tracker module"], [["LIMITED", "NORMAL", "FULL"], ["Limited", "Normal", "Full"], 0], 1, {}, false] call CBA_fnc_addSetting;

// Support module
["Columbia_CBA_support_module_artillery_enable", "CHECKBOX", ["enable artillery"], [CBA_SETTINGS_COLUMBIA, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_support_module_cas_helicopter_enable", "CHECKBOX", ["enable helicopter"], [CBA_SETTINGS_COLUMBIA, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_support_module_cas_jets_enable", "CHECKBOX", ["enable jets"], [CBA_SETTINGS_COLUMBIA, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_support_module_arc_light_enable", "CHECKBOX", ["enable arc light (B52)"], [CBA_SETTINGS_COLUMBIA, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["Columbia_CBA_support_module_daisy_cutter_enable", "CHECKBOX", ["enable daisy cutter"], [CBA_SETTINGS_COLUMBIA, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;

// STABO
["Columbia_CBA_stabo_climb_duration", "SLIDER", ["Action duration in seconds"], [CBA_SETTINGS_COLUMBIA, "STABO"], [1, 30, 10, 0], 1, {}, false] call CBA_fnc_addSetting;

// Throwable
["Columbia_CBA_remove_throwable", "EDITBOX", ["Throwable to Remove from AI"], [CBA_SETTINGS_COLUMBIA, "Throwable"], "vn_rdg2_mag,vn_molotov_grenade_mag", 1, {Columbia_CBA_remove_throwable = Columbia_CBA_remove_throwable splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;

// Triangulation
["Columbia_CBA_triangulation_required_item", "EDITBOX", ["Required Item"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], "ACRE_PRC77", 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_items_to_detect", "EDITBOX", ["Items to detect"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], "vn_o_prop_t884_01,vn_o_prop_t102e_01", 1, {Columbia_CBA_triangulation_items_to_detect = Columbia_CBA_triangulation_items_to_detect splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_cool_down", "SLIDER", ["Cool down in seconds"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 600, 300, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_signal_strength_1", "SLIDER", ["Threshold distance for signal strength 1/5"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 5000, 5000, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_signal_strength_2", "SLIDER", ["Threshold distance for signal strength 2/5"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 5000, 4000, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_signal_strength_3", "SLIDER", ["Threshold distance for signal strength 3/5"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 5000, 3000, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_signal_strength_4", "SLIDER", ["Threshold distance for signal strength 4/5"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 5000, 2000, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_triangulation_signal_strength_5", "SLIDER", ["Threshold distance for signal strength 5/5"], [CBA_SETTINGS_COLUMBIA, "Triangulation"], [0, 5000, 1000, 0], 1, {}, false] call CBA_fnc_addSetting;

// Traps
["Columbia_CBA_traps_mace_kill_radius", "SLIDER", ["Mace kill radius (m)], [CBA_SETTINGS_COLUMBIA, "Traps"], [1, 10, 3, 0], 1, {}, false] call CBA_fnc_addSetting;
["Columbia_CBA_traps_screaming_enable", "CHECKBOX", ["enable screams"], [CBA_SETTINGS_COLUMBIA, "Traps"], true, 1, {}, false] call CBA_fnc_addSetting;
