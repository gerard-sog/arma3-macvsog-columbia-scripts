/*
 *
 * CBA Settings COLSOG
 * Called as Extended_PreInit_EventHandlers
 *
 * see https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

#define CBA_SETTINGS_COLSOG "COLSOG Settings"

// Medical kit conversion - Medikit
["colsog_medikit_convertAceFieldDressing", "SLIDER", ["Medikit - field dressing"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 50, 20, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceSalineIv500", "SLIDER", ["Medikit - saline IV 500"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceEpinephrine", "SLIDER", ["Medikit - epinephrine"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceMorphine", "SLIDER", ["Medikit - morphine"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceTourniquet", "SLIDER", ["Medikit - tourniquet"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 4, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceSplint", "SLIDER", ["Medikit - splint"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;

// Medical kit conversion - First Aid
["colsog_firstAid_convertAceFieldDressing", "SLIDER", ["First Aid - field dressing"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 5, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_firstAid_convertAceMorphine", "SLIDER", ["First Aid - morphine"], [CBA_SETTINGS_COLSOG, "Medical kit conversion"], [0, 10, 1, 0], 1, {}, false] call CBA_fnc_addSetting;

// AI skills
["colsog_ai_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLSOG, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_generalSkill", "SLIDER", ["general"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingAccuracy", "SLIDER", ["aiming accuracy"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingSpeed", "SLIDER", ["aiming speed"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingShake", "SLIDER", ["aiming shake"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_commanding", "SLIDER", ["commanding"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_courage", "SLIDER", ["courage"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_spotDistance", "SLIDER", ["spot distance"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_spotTime", "SLIDER", ["spot time"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_reloadSpeed", "SLIDER", ["reload speed"], [CBA_SETTINGS_COLSOG, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_seekCover", "CHECKBOX", ["seek cover"], [CBA_SETTINGS_COLSOG, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_autoCombat", "CHECKBOX", ["auto combat"], [CBA_SETTINGS_COLSOG, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_suppression", "CHECKBOX", ["suppression"], [CBA_SETTINGS_COLSOG, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;

// Tracker module
["colsog_tracker_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLSOG, "Tracker module"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_tracker_moduleName", "EDITBOX", ["Tracker module name"], [CBA_SETTINGS_COLSOG, "Tracker module"], "TrackermoduleNAME", 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultBehaviour", "LIST", ["Default behaviour"], [CBA_SETTINGS_COLSOG, "Tracker module"], [["CARELESS", "SAFE", "AWARE", "COMBAT"], ["Careless", "Safe", "Aware", "Combat"], 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultCombat", "LIST", ["Default combat"], [CBA_SETTINGS_COLSOG, "Tracker module"], [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], ["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"], 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultSpeed", "LIST", ["Default speed"], [CBA_SETTINGS_COLSOG, "Tracker module"], [["LIMITED", "NORMAL", "FULL"], ["Limited", "Normal", "Full"], 0], 1, {}, false] call CBA_fnc_addSetting;

// Support module
["colsog_support_artilleryEnable", "CHECKBOX", ["enable artillery"], [CBA_SETTINGS_COLSOG, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_casHelicopterEnable", "CHECKBOX", ["enable helicopter"], [CBA_SETTINGS_COLSOG, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_casJetEnable", "CHECKBOX", ["enable jets"], [CBA_SETTINGS_COLSOG, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_arcLightEnable", "CHECKBOX", ["enable arc light (B52)"], [CBA_SETTINGS_COLSOG, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_daisyCutterEnable", "CHECKBOX", ["enable daisy cutter"], [CBA_SETTINGS_COLSOG, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;

// STABO
["colsog_stabo_climbDuration", "SLIDER", ["Action duration in seconds"], [CBA_SETTINGS_COLSOG, "STABO"], [1, 30, 10, 0], 1, {}, false] call CBA_fnc_addSetting;

// Throwable
["colsog_throwable_remove", "EDITBOX", ["Throwable to Remove from AI"], [CBA_SETTINGS_COLSOG, "Throwable"], "vn_rdg2_mag,vn_molotov_grenade_mag", 1, {colsog_throwable_remove = colsog_throwable_remove splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;

// Triangulation
["colsog_triangulation_requiredItem", "EDITBOX", ["Required Item"], [CBA_SETTINGS_COLSOG, "Triangulation"], "ACRE_PRC77", 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_itemsToDetect", "EDITBOX", ["Items to detect"], [CBA_SETTINGS_COLSOG, "Triangulation"], "vn_o_prop_t884_01,vn_o_prop_t102e_01", 1, {colsog_triangulation_itemsToDetect = colsog_triangulation_itemsToDetect splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
["colsog_triangulation_coolDown", "SLIDER", ["Cool down in seconds"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 600, 300, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength1", "SLIDER", ["Threshold distance for signal strength 1/5"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 5000, 5000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength2", "SLIDER", ["Threshold distance for signal strength 2/5"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 5000, 4000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength3", "SLIDER", ["Threshold distance for signal strength 3/5"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 5000, 3000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength4", "SLIDER", ["Threshold distance for signal strength 4/5"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 5000, 2000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength5", "SLIDER", ["Threshold distance for signal strength 5/5"], [CBA_SETTINGS_COLSOG, "Triangulation"], [0, 5000, 1000, 0], 1, {}, false] call CBA_fnc_addSetting;

// Traps
["colsog_traps_maceKillRadius", "SLIDER", ["Mace kill radius (m)"], [CBA_SETTINGS_COLSOG, "Traps"], [1, 10, 3, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_traps_screamingEnable", "CHECKBOX", ["Enable screams"], [CBA_SETTINGS_COLSOG, "Traps"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_traps_activatedBySide", "LIST", ["Trigger for Side"], [CBA_SETTINGS_COLSOG, "Traps"], [["WEST", "EAST", "GUER", "CIV", "ANYPLAYER", "ANY"], ["BLUFOR", "OPFOR", "Independent", "Civilian", "Any player", "Any AI or player"], 0], 1, {}, false] call CBA_fnc_addSetting;

// Battery
["colsog_battery_capacity", "SLIDER", ["Battery capacity in seconds"], [CBA_SETTINGS_COLSOG, "Battery"], [0, 300, 120, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_battery_enemySpawnThreshold", "SLIDER", ["Amount of radio calls before enemy detection"], [CBA_SETTINGS_COLSOG, "Battery"], [0, 100, 50, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease", "EDITBOX", ["Groups impacted by enemy radio call detection"], [CBA_SETTINGS_COLSOG, "Battery"], "Columbia,Reserves", 1, {colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease = colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
["colsog_battery_powerItems", "EDITBOX", ["Item used as spare battery"], [CBA_SETTINGS_COLSOG, "Battery"], "ACE_UAVBattery", 1, {colsog_battery_powerItems = colsog_battery_powerItems splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
