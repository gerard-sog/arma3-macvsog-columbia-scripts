/*
 *
 * CBA Settings COLSOG
 * Called as Extended_PreInit_EventHandlers
 *
 * see https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

#define CBA_SETTINGS_COLSOG_AI_ENV_RELATED "COLSOG AI and ENV related"
#define CBA_SETTINGS_COLSOG_BAYONET_CHARGE "COLSOG Bayonet Charge"
#define CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY "COLSOG Medical and Supply"
#define CBA_SETTINGS_COLSOG_MISCELLANEOUS "COLSOG Miscellaneous"
#define CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE "COLSOG Prairie Fire Module"
#define CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY "COLSOG Radio and Battery"
#define CBA_SETTINGS_COLSOG_SENSORS "COLSOG Sensors"

// ====================================
// |CBA_SETTINGS_COLSOG_BAYONET_CHARGE|
// ====================================
// Bayonet Charge
["colsog_bayonet_screamingEnable", "CHECKBOX", ["Enable screams"], [CBA_SETTINGS_COLSOG_BAYONET_CHARGE, "Bayonet Charge"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_bayonet_searchRadius", "SLIDER", ["Search radius (m)"], [CBA_SETTINGS_COLSOG_BAYONET_CHARGE, "Bayonet Charge"], [1, 2500, 500, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_bayonet_damage", "SLIDER", ["Damage given to player"], [CBA_SETTINGS_COLSOG_BAYONET_CHARGE, "Bayonet Charge"], [1, 200, 100, 0], 1, {}, false] call CBA_fnc_addSetting;

// ========================================
// |CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY|
// ========================================
// Medical kit conversion - Medikit
["colsog_medikit_convertAceFieldDressing", "SLIDER", ["Medikit - field dressing"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 50, 20, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceSalineIv500", "SLIDER", ["Medikit - saline IV 500"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceEpinephrine", "SLIDER", ["Medikit - epinephrine"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceMorphine", "SLIDER", ["Medikit - morphine"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceTourniquet", "SLIDER", ["Medikit - tourniquet"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 4, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_medikit_convertAceSplint", "SLIDER", ["Medikit - splint"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 2, 0], 1, {}, false] call CBA_fnc_addSetting;

// Medical kit conversion - First Aid
["colsog_firstAid_convertAceFieldDressing", "SLIDER", ["First Aid - field dressing"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 5, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_firstAid_convertAceMorphine", "SLIDER", ["First Aid - morphine"], [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Medical kit conversion"], [0, 10, 1, 0], 1, {}, false] call CBA_fnc_addSetting;

// Supply box
[
    "colsog_supply_content",
    "EDITBOX",
    ["Content of supply box"],
    [CBA_SETTINGS_COLSOG_MEDICAL_AND_SUPPLY, "Supply box"],
    "[
      'vn_m16_20_t_mag', 12,
      'ACE_fieldDressing', 50,
      'ACE_packingBandage', 50,
      'ACE_elasticBandage', 50,
      'ACE_quikclot', 50,
      'ACE_CableTie', 5,
      'ACE_DefusalKit', 1,
      'ACE_EntrenchingTool', 1,
      'ACE_epinephrine', 10,
      'ACE_Flashlight_MX991', 1,
      'uns_m67gren', 20,
      'vn_m18_purple_mag', 3,
      'vn_m18_red_mag', 6,
      'vn_m18_white_mag', 20,
      'vn_m18_yellow_mag', 6,
      'vn_40mm_m381_he_mag', 25,
      'vn_40mm_m397_ab_mag', 5,
      'vn_40mm_m433_hedp_mag', 5,
      'ACE_Clacker', 1,
      'vn_40mm_m583_flare_w_mag', 8,
      'ACE_MapTools', 1,
      'vn_mine_m18_mag', 10,
      'ACE_salineIV', 10,
      'ACE_salineIV_250', 20,
      'ACE_salineIV_500', 15,
      'ACE_splint', 10,
      'ACE_surgicalKit', 1,
      'ACE_tourniquet', 20,
      'vn_xm16e1', 4,
      'pk_556_45_clip_bandolier', 14,
      'pk_762_39_100Rnd_belt', 5,
      'pk_762_51_100Rnd_belt', 5,
      'pk_762_51_60Rnd_clip_bandolier', 8,
      'pk_9_19_50Rnd_box', 5,
      'pk_carbine_10Rnd_clip', 5,
      'pk_45ACP_10Rnd_clip', 5,
      'pk_792_57_50Rnd_belt', 5
    ]",
    1,
    {
        colsog_supply_content = parseSimpleArray colsog_supply_content
    },
    false
] call CBA_fnc_addSetting;

// ====================================
// |CBA_SETTINGS_COLSOG_AI_ENV_RELATED|
// ====================================
// AI skills
["colsog_ai_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_generalSkill", "SLIDER", ["general"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingAccuracy", "SLIDER", ["aiming accuracy"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingSpeed", "SLIDER", ["aiming speed"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_aimingShake", "SLIDER", ["aiming shake"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_commanding", "SLIDER", ["commanding"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_courage", "SLIDER", ["courage"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_spotDistance", "SLIDER", ["spot distance"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_spotTime", "SLIDER", ["spot time"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.10, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_reloadSpeed", "SLIDER", ["reload speed"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], [0, 1, 0.33, 2], 1, {}, false] call CBA_fnc_addSetting;
["colsog_ai_seekCover", "CHECKBOX", ["seek cover"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_autoCombat", "CHECKBOX", ["auto combat"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_ai_suppression", "CHECKBOX", ["suppression"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "AI skills"], true, 1, {}, true] call CBA_fnc_addSetting;

// Throwable
["colsog_throwable_remove", "EDITBOX", ["Throwable to Remove from AI"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Throwable"], "vn_rdg2_mag,vn_molotov_grenade_mag", 1, {colsog_throwable_remove = colsog_throwable_remove splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;

// Day & Night
["colsog_dayAndNight_dawnDuration", "SLIDER", ["Time before day considered as dawn (minutes)"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 30, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_dayAndNight_dawnTimeAcceleration", "SLIDER", ["Dawn time acceleration"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 8, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_dayAndNight_dayTimeAcceleration", "SLIDER", ["Day time acceleration"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 12, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_dayAndNight_duskDuration", "SLIDER", ["Time before night considered as dusk (minutes)"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 30, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_dayAndNight_duskTimeAcceleration", "SLIDER", ["Dusk time acceleration"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 6, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_dayAndNight_nightTimeAcceleration", "SLIDER", ["Night time acceleration"], [CBA_SETTINGS_COLSOG_AI_ENV_RELATED, "Day & Night"], [0, 120, 120, 0], 1, {}, false] call CBA_fnc_addSetting;

// =========================================
// |CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE|
// =========================================
// Tracker module
["colsog_tracker_enable", "CHECKBOX", ["enable"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Tracker module"], true, 1, {}, true] call CBA_fnc_addSetting;
["colsog_tracker_moduleName", "EDITBOX", ["Tracker module name"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Tracker module"], "TrackermoduleNAME", 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultBehaviour", "LIST", ["Default behaviour"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Tracker module"], [["CARELESS", "SAFE", "AWARE", "COMBAT"], ["Careless", "Safe", "Aware", "Combat"], 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultCombat", "LIST", ["Default combat"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Tracker module"], [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], ["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"], 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_tracker_defaultSpeed", "LIST", ["Default speed"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Tracker module"], [["LIMITED", "NORMAL", "FULL"], ["Limited", "Normal", "Full"], 0], 1, {}, false] call CBA_fnc_addSetting;

// Support module
["colsog_support_artilleryEnable", "CHECKBOX", ["enable artillery"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_casHelicopterEnable", "CHECKBOX", ["enable helicopter"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_casJetEnable", "CHECKBOX", ["enable jets"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_arcLightEnable", "CHECKBOX", ["enable arc light (B52)"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;
["colsog_support_daisyCutterEnable", "CHECKBOX", ["enable daisy cutter"], [CBA_SETTINGS_COLSOG_PRAIRIE_FIRE_MODULE, "Support module"], false, 1, {}, true] call CBA_fnc_addSetting;

// =======================================
// |CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY|
// =======================================
// Triangulation
["colsog_triangulation_requiredAcreRadio", "EDITBOX", ["Required ACRE radio"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], "ACRE_PRC77", 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_itemsToDetect", "EDITBOX", ["Items to detect"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], "vn_o_prop_t884_01,vn_o_prop_t102e_01", 1, {colsog_triangulation_itemsToDetect = colsog_triangulation_itemsToDetect splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
["colsog_triangulation_coolDown", "SLIDER", ["Cool down in seconds"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 600, 300, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_requireAcreSpike", "CHECKBOX", ["Requires ACRE spike nearby (10m away max)"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength1", "SLIDER", ["Threshold distance for signal strength 1/5"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 5000, 5000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength2", "SLIDER", ["Threshold distance for signal strength 2/5"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 5000, 4000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength3", "SLIDER", ["Threshold distance for signal strength 3/5"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 5000, 3000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength4", "SLIDER", ["Threshold distance for signal strength 4/5"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 5000, 2000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_triangulation_signalStrength5", "SLIDER", ["Threshold distance for signal strength 5/5"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Triangulation"], [0, 5000, 1000, 0], 1, {}, false] call CBA_fnc_addSetting;

// Battery
["colsog_battery_prc77Capacity", "SLIDER", ["PRC77 Battery capacity in seconds"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Battery"], [0, 600, 300, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_battery_enemySpawnThreshold", "SLIDER", ["Amount of radio calls before enemy detection"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Battery"], [0, 100, 50, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease", "EDITBOX", ["Groups impacted by enemy radio call detection"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Battery"], "Columbia,Reserves", 1, {colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease = colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;
["colsog_battery_powerItems", "EDITBOX", ["Item used as spare battery"], [CBA_SETTINGS_COLSOG_RADIO_AND_BATTERY, "Battery"], "ACE_UAVBattery", 1, {colsog_battery_powerItems = colsog_battery_powerItems splitString " " joinString "" splitString ","}, false] call CBA_fnc_addSetting;

// =============================
// |CBA_SETTINGS_COLSOG_SENSORS|
// =============================
// Sensors - Gunshot
["colsog_sensor_gunshotInventoryItem", "EDITBOX", ["Inventory item to use"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gunshot"], "colsog_inv_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gunshotThingItem", "EDITBOX", ["Thing item used as sensor"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gunshot"], "colsog_thing_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gunshotTransmitDataOverRadio", "CHECKBOX", ["Transmit data over radio"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gunshot"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gunshotRadioTransmissionRange", "SLIDER", ["Radio transmission range (m)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gunshot"], [0, 2500, 500, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gunshotLogFrequency", "SLIDER", ["Sensor logging frequency (sec)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gunshot"], [0, 60, 5, 0], 1, {}, false] call CBA_fnc_addSetting;

// Sensors - Engine
["colsog_sensor_engineInventoryItem", "EDITBOX", ["Inventory item to use"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Engine"], "colsog_inv_handsid_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_engineThingItem", "EDITBOX", ["Thing item used as sensor"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Engine"], "colsog_thing_handsid_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_engineTransmitDataOverRadio", "CHECKBOX", ["Transmit data over radio"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Engine"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_engineRadioTransmissionRange", "SLIDER", ["Radio transmission range (m)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Engine"], [0, 2500, 1500, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_engineLogFrequency", "SLIDER", ["Sensor logging frequency (sec)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Engine"], [0, 60, 5, 0], 1, {}, false] call CBA_fnc_addSetting;

// Sensors - Gravity
["colsog_sensor_gravityInventoryItem", "EDITBOX", ["Inventory item to use"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gravity"], "colsog_inv_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gravityThingItem", "EDITBOX", ["Thing item used as sensor"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gravity"], "colsog_thing_sensor", 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gravityTransmitDataOverRadio", "CHECKBOX", ["Transmit data over radio"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gravity"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gravityRadioTransmissionRange", "SLIDER", ["Radio transmission range (m)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gravity"], [0, 2500, 1000, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_sensor_gravityLogFrequency", "SLIDER", ["Sensor logging frequency (sec)"], [CBA_SETTINGS_COLSOG_SENSORS, "Sensors - Gravity"], [0, 60, 5, 0], 1, {}, false] call CBA_fnc_addSetting;

// =======================================
// |CBA_SETTINGS_COLSOG_MISCELLANEOUS|
// =======================================
// STABO
["colsog_stabo_climbDuration", "SLIDER", ["Action duration in seconds"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "STABO"], [1, 30, 10, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_stabo_ropeLength", "SLIDER", ["Rope length (m)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "STABO"], [25, 100, 60, 0], 1, {}, false] call CBA_fnc_addSetting;

// Traps
["colsog_traps_maceKillRadius", "SLIDER", ["Mace kill radius (m)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Traps"], [1, 10, 3, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_traps_screamingEnable", "CHECKBOX", ["Enable screams"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Traps"], true, 1, {}, false] call CBA_fnc_addSetting;
["colsog_traps_activatedBySide", "LIST", ["Trigger for Side"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Traps"], [["WEST", "EAST", "GUER", "CIV", "ANYPLAYER", "ANY"], ["BLUFOR", "OPFOR", "Independent", "Civilian", "Any player", "Any AI or player"], 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_traps_chanceOfBeingImpaled", "SLIDER", ["Chance of being impaled (%)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Traps"], [0, 100, 20, 0], 1, {}, false] call CBA_fnc_addSetting;

// Intel
["colsog_intel_inventoryItem", "EDITBOX", ["Intel object (inventory item)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Intel"], "uns_leaflet16", 1, {}, false] call CBA_fnc_addSetting;
["colsog_intel_chanceOfUnitCarryingIntel", "SLIDER", ["Chance of unit carrying intel (%)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Intel"], [0, 100, 20, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_intel_chanceOfIntelFallingOnGround", "SLIDER", ["Chance of intel falling on ground (%)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Intel"], [0, 100, 20, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_intel_intelExpertRequired", "CHECKBOX", ["Requires trait to decrypt intel"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Intel"], true, 1, {}, false] call CBA_fnc_addSetting;

// Climbing
["colsog_climbing_requiredItem", "EDITBOX", ["Required item to climb"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Climbing"], "ACE_rope18", 1, {}, false] call CBA_fnc_addSetting;
["colsog_climbing_timeToClimbUp", "SLIDER", ["Time to climb up (sec)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Climbing"], [0, 60, 15, 0], 1, {}, false] call CBA_fnc_addSetting;
["colsog_climbing_timeToClimbDown", "SLIDER", ["Time to climb down (sec)"], [CBA_SETTINGS_COLSOG_MISCELLANEOUS, "Climbing"], [0, 60, 5, 0], 1, {}, false] call CBA_fnc_addSetting;