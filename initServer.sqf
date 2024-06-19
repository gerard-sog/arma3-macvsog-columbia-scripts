profileNamespace setvariable ["SPSaveRoles", 1]; // Required to save loadouts using Persist.

ARTILLERY_SUPPORT_ENABLED = false; // Toggle ON/OFF artillery availability (see support module from Prairie Fire).
publicVariable "ARTILLERY_SUPPORT_ENABLED";

CAS_HELICOPTER_SUPPORT_ENABLED = false; // Toggle ON/OFF CAS (helicopter) availability (see support module from Prairie Fire).
publicVariable "CAS_HELICOPTER_SUPPORT_ENABLED";

CAS_JETS_SUPPORT_ENABLED = false; // Toggle ON/OFF CAS (jet) availability (see support module from Prairie Fire).
publicVariable "CAS_JETS_SUPPORT_ENABLED";

ARC_LIGHT_SUPPORT_ENABLED = false; // Toggle ON/OFF B-52 Arc Light strike availability (see support module from Prairie Fire).
publicVariable "ARC_LIGHT_SUPPORT_ENABLED";

DAISY_CUTTER_SUPPORT_ENABLED = false; // Toggle ON/OFF Daisy Cutter availability (see support module from Prairie Fire).
publicVariable "DAISY_CUTTER_SUPPORT_ENABLED";

TRACKERS_ENABLED = false; // Toggle ON/OFF Tracker in AO (will only affect tracker module from Prairie Fire with the following variable used as condition 'TRACKERS_ENABLED').
publicVariable "TRACKERS_ENABLED";

TRACKERS_DEFAULT = ["CARELESS", "BLUE", "LIMITED"]; // Default behaviour values for tracker groups
publicVariable "TRACKERS_DEFAULT";

_handle = [] execVM "functions\columbia_fnc_onTrackerSpawn.sqf";
_handle = [] execVM "functions\columbia_fnc_TrackerGroup.sqf";

waitUntil{ scriptDone _handle };

//Tell the monitoring function the Module to monitor, the Function to call when new units are spawned by the module
[ TrackermoduleNAME, columbia_fnc_customizeTrackerGroup] call columbia_fnc_onTrackerSpawn;