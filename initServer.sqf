profileNamespace setvariable ["SPSaveRoles", 1]; // Required to save loadouts using Persist.

ARTILLERY_SUPPORT_ENABLED = Columbia_CBA_support_module_artillery_enable; // Toggle ON/OFF artillery availability (see support module from Prairie Fire).
publicVariable "ARTILLERY_SUPPORT_ENABLED";

CAS_HELICOPTER_SUPPORT_ENABLED = Columbia_CBA_support_module_cas_helicopter_enable; // Toggle ON/OFF CAS (helicopter) availability (see support module from Prairie Fire).
publicVariable "CAS_HELICOPTER_SUPPORT_ENABLED";

CAS_JETS_SUPPORT_ENABLED = Columbia_CBA_support_module_cas_jets_enable; // Toggle ON/OFF CAS (jet) availability (see support module from Prairie Fire).
publicVariable "CAS_JETS_SUPPORT_ENABLED";

ARC_LIGHT_SUPPORT_ENABLED = Columbia_CBA_support_module_arc_light_enable; // Toggle ON/OFF B-52 Arc Light strike availability (see support module from Prairie Fire).
publicVariable "ARC_LIGHT_SUPPORT_ENABLED";

DAISY_CUTTER_SUPPORT_ENABLED = Columbia_CBA_support_module_daisy_cutter_enable; // Toggle ON/OFF Daisy Cutter availability (see support module from Prairie Fire).
publicVariable "DAISY_CUTTER_SUPPORT_ENABLED";

TRACKERS_ENABLED = Columbia_CBA_tracker_module_enable; // Toggle ON/OFF Tracker in AO (will only affect tracker module from Prairie Fire with the following variable used as condition 'TRACKERS_ENABLED').
publicVariable "TRACKERS_ENABLED";

// Default behaviour values for tracker groups
TRACKERS_DEFAULT = [
    Columbia_CBA_tracker_module_default_behaviour,
    Columbia_CBA_tracker_module_default_combat,
    Columbia_CBA_tracker_module_default_speed
    ];
publicVariable "TRACKERS_DEFAULT";

_handle = [] execVM "functions\TRACKER\columbia_fnc_onTrackerSpawn.sqf";
_handle = [] execVM "functions\TRACKER\columbia_fnc_TrackerGroup.sqf";

waitUntil{ scriptDone _handle };

// Tell the monitoring function the Module to monitor, the Function to call when new units are spawned by the module
private _trackerModuleToMonitor = missionNamespace getVariable Columbia_CBA_tracker_module_name;
[_trackerModuleToMonitor, columbia_fnc_customizeTrackerGroup] call columbia_fnc_onTrackerSpawn;