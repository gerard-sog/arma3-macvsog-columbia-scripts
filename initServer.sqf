profileNamespace setvariable ["SPSaveRoles", 1]; // Required to save loadouts using Persist.

COLSOG_ArtillerySupportEnabled = Columbia_CBA_support_module_artillery_enable; // Toggle ON/OFF artillery availability (see support module from Prairie Fire).
publicVariable "COLSOG_ArtillerySupportEnabled";

COLSOG_CasHelicopterSupportEnabled = Columbia_CBA_support_module_cas_helicopter_enable; // Toggle ON/OFF CAS (helicopter) availability (see support module from Prairie Fire).
publicVariable "COLSOG_CasHelicopterSupportEnabled";

COLSOG_CasJetSupportEnabled = Columbia_CBA_support_module_cas_jets_enable; // Toggle ON/OFF CAS (jet) availability (see support module from Prairie Fire).
publicVariable "COLSOG_CasJetSupportEnabled";

COLSOG_ArcLightSupportEnabled = Columbia_CBA_support_module_arc_light_enable; // Toggle ON/OFF B-52 Arc Light strike availability (see support module from Prairie Fire).
publicVariable "COLSOG_ArcLightSupportEnabled";

COLSOG_DaisyCutterSupportEnabled = Columbia_CBA_support_module_daisy_cutter_enable; // Toggle ON/OFF Daisy Cutter availability (see support module from Prairie Fire).
publicVariable "COLSOG_DaisyCutterSupportEnabled";

TRACKERS_ENABLED = Columbia_CBA_tracker_module_enable; // Toggle ON/OFF Tracker in AO (will only affect tracker module from Prairie Fire with the following variable used as condition 'TRACKERS_ENABLED').
publicVariable "TRACKERS_ENABLED";

// Default behaviour values for tracker groups
TRACKERS_DEFAULT = [
    Columbia_CBA_tracker_module_default_behaviour,
    Columbia_CBA_tracker_module_default_combat,
    Columbia_CBA_tracker_module_default_speed
    ];
publicVariable "TRACKERS_DEFAULT";

LAST_TRIANGULATION_TIME_SECONDS = -Columbia_CBA_triangulation_cool_down;
publicVariable "LAST_TRIANGULATION_TIME_SECONDS";

_handle = [] execVM "functions\TRACKER\columbia_fnc_onTrackerSpawn.sqf";
_handle = [] execVM "functions\TRACKER\columbia_fnc_TrackerGroup.sqf";

waitUntil{ scriptDone _handle };

// Tell the monitoring function the Module to monitor, the Function to call when new units are spawned by the module
private _trackerModuleToMonitor = missionNamespace getVariable Columbia_CBA_tracker_module_name;
[_trackerModuleToMonitor, columbia_fnc_customizeTrackerGroup] call columbia_fnc_onTrackerSpawn;