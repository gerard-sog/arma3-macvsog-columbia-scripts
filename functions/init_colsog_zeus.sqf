if (!hasInterface) exitWith {};

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitWith { systemChat "ZEN not detected";};

// Custom Zeus Modules in Right Panel

// Related to AI
["A - COLSOG AI", "Un-Garrison (enable PATH)", {_this execVM "functions\colsog_zeus_ungarrison.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_UnGarrison_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG AI", "Set AI Skills", {_this execVM "functions\colsog_zeus_setAiSubSkills.sqf";}, "\a3\Modules_F_Curator\Data\iconDiary_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG AI", "Toggle Trackers", {_this execVM "functions\TRACKER\colsog_zeus_toggleTrackers.sqf";}, "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"] call zen_custom_modules_fnc_register;

// Related to action on vehicle/object
["A - COLSOG Vehicle", "Add STABO", {_this execVM "functions\STABO\colsog_zeus_addStabo.sqf";}, "\z\ace\addons\fastroping\UI\Icon_Waypoint.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Vehicle", "Add Crew management", {_this execVM "functions\DOOR_GUNNER\colsog_zeus_addCrewManagement.sqf";}, "\a3\Modules_F_Curator\Data\portraitObjectiveGetIn_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Vehicle", "Conceal AA", {_this execVM "functions\colsog_zeus_concealStaticWeapon.sqf";}, "x\zen\addons\context_actions\ui\stealth_ca.paa"] call zen_custom_modules_fnc_register;

// Radio Tools
["A - COLSOG Radio", "Init PF77s", {_this execVM "functions\colsog_zeus_initPf77Rack.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Radio", "NVA radio chatter", {_this execVM "functions\CHATTER\colsog_zeus_addChatter.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Radio", "Toggle CAS", {_this execVM "functions\ARTILLERY\colsog_zeus_toggleCas.sqf";}, "\a3\Modules_F_Curator\Data\portraitCASGun_ca.paa"] call zen_custom_modules_fnc_register;

// Environment Tools
["A - COLSOG Env", "Transition Time", {execVM "functions\colsog_zeus_transitionTime.sqf";}, "\a3\Modules_F_Curator\Data\iconSkiptime_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Env", "Fog Low", {_this execVM "functions\ENV\colsog_zeus_lowFog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Env", "Fog Ring", {_this execVM "functions\ENV\colsog_zeus_ringFog.sqf";}, "\a3\Modules_F_Curator\Data\iconSmoke_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Env", "Vanilla Fog", {_this execVM "functions\ENV\colsog_zeus_vanillaFog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;

// Punji Traps
["A - COLSOG Punji Traps", "Swing Trap", {_this execVM "functions\TRAPS\swinging\colsog_zeus_swingingMaceTrap.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\kill_ca.paa"] call zen_custom_modules_fnc_register;
["A - COLSOG Punji Traps", "Fall Trap", {_this execVM "functions\TRAPS\falling\colsog_zeus_fallingMaceTrap.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\kill_ca.paa"] call zen_custom_modules_fnc_register;
