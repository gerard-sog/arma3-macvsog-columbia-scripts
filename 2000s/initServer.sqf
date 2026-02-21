// For battery draining automatically when not turned off.
missionNamespace setVariable ["COLSOG_radios", [], true];
[] execVM "functions\battery\fn_radioBatteryTracker.sqf";

profileNamespace setvariable ["SPSaveRoles", 1]; // Required to save loadouts using Persist.

COLSOG_ArtillerySupportEnabled = colsog_support_artilleryEnable; // Toggle ON/OFF artillery availability (see support module from Prairie Fire).
publicVariable "COLSOG_ArtillerySupportEnabled";

COLSOG_CasHelicopterSupportEnabled = colsog_support_casHelicopterEnable; // Toggle ON/OFF CAS (helicopter) availability (see support module from Prairie Fire).
publicVariable "COLSOG_CasHelicopterSupportEnabled";

COLSOG_CasJetSupportEnabled = colsog_support_casJetEnable; // Toggle ON/OFF CAS (jet) availability (see support module from Prairie Fire).
publicVariable "COLSOG_CasJetSupportEnabled";

COLSOG_ArcLightSupportEnabled = colsog_support_arcLightEnable; // Toggle ON/OFF B-52 Arc Light strike availability (see support module from Prairie Fire).
publicVariable "COLSOG_ArcLightSupportEnabled";

COLSOG_DaisyCutterSupportEnabled = colsog_support_daisyCutterEnable; // Toggle ON/OFF Daisy Cutter availability (see support module from Prairie Fire).
publicVariable "COLSOG_DaisyCutterSupportEnabled";

COLSOG_SimplexBackpacks = colsog_support_simplexAccessBackpack;
publicVariable "COLSOG_SimplexBackpacks";

COLSOG_lastTriangulationTimeSeconds = -colsog_triangulation_coolDown;
publicVariable "COLSOG_lastTriangulationTimeSeconds";

COLSOG_amountOfRadioCalls = 0;
publicVariable "COLSOG_amountOfRadioCalls";

COLSOG_sensorIdCounter = 0;
publicVariable "COLSOG_sensorIdCounter";

COLSOG_intelPool = [
    "The message is encoded, return it to base for decryption",
    "The message is encoded, return it to base for decryption",
    "The message is encoded, return it to base for decryption",
    "The message is encoded, return it to base for decryption"
    ];
publicVariable "COLSOG_intelPool";

COLSOG_isDayNightCycleActive = false;
publicVariable "COLSOG_isDayNightCycleActive";