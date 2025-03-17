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

COLSOG_TrackersEnabled = colsog_tracker_enable; // Toggle ON/OFF Tracker in AO (will only affect tracker module from Prairie Fire with the following variable used as condition 'COLSOG_TrackersEnabled').
publicVariable "COLSOG_TrackersEnabled";

COLSOG_SimplexBackpacks = colsog_support_simplexAccessBackpack;
publicVariable "COLSOG_SimplexBackpacks";

// Default behaviour values for tracker groups
COLSOG_TrackersDefault = [
    colsog_tracker_defaultBehaviour,
    colsog_tracker_defaultCombat,
    colsog_tracker_defaultSpeed
    ];
publicVariable "COLSOG_TrackersDefault";

COLSOG_lastTriangulationTimeSeconds = -colsog_triangulation_coolDown;
publicVariable "COLSOG_lastTriangulationTimeSeconds";

COLSOG_amountOfRadioCalls = 0;
publicVariable "COLSOG_amountOfRadioCalls";

COLSOG_sensorIdCounter = 0;
publicVariable "COLSOG_sensorIdCounter";

COLSOG_intelPool = [
    "intel 1",
    "intel 2",
    "intel 3",
    "intel 4",
    "intel 5"
    ];
publicVariable "COLSOG_intelPool";

COLSOG_isDayNightCycleActive = false;
publicVariable "COLSOG_isDayNightCycleActive";

_handle = [] execVM "functions\tracker\colsog_fn_onTrackerSpawn.sqf";
_handle = [] execVM "functions\tracker\colsog_fn_trackerGroup.sqf";

waitUntil{ scriptDone _handle };

// Tell the monitoring function the Module to monitor, the Function to call when new units are spawned by the module
private _trackerModuleToMonitor = missionNamespace getVariable colsog_tracker_moduleName;
[_trackerModuleToMonitor, colsog_fn_customizeTrackerGroup] call colsog_fn_onTrackerSpawn;