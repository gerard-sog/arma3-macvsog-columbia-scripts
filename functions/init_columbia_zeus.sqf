if (!hasInterface) exitWith {};

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitWith { systemChat "ZEN not detected";};

// Custom Zeus Modules in Right Panel

// Related to AI
["A - Columbia AI", "Un-Garrison (enable PATH)", {_this execVM "functions\columbia_zeus_ungarrison.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_UnGarrison_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia AI", "Set AI Skills", {_this execVM "functions\columbia_zeus_setaisubskills.sqf";}, "\a3\Modules_F_Curator\Data\iconDiary_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia AI", "Toggle Trackers", {_this execVM "functions\TRACKER\columbia_zeus_toggletrackers.sqf";}, "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"] call zen_custom_modules_fnc_register;

// Related to action on vehicle/object
["A - Columbia Vehicle", "Add STABO", {_this execVM "functions\STABO\columbia_zeus_addstabo.sqf";}, "\z\ace\addons\fastroping\UI\Icon_Waypoint.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Vehicle", "Conceal AA", {_this execVM "functions\columbia_zeus_concealaa.sqf";}, "x\zen\addons\context_actions\ui\stealth_ca.paa"] call zen_custom_modules_fnc_register;

// Radio Tools
["A - Columbia Radio", "Init PF77s", {_this execVM "functions\columbia_zeus_initpf77rack.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Radio", "NVA radio chatter", {_this execVM "functions\CHATTER\columbia_zeus_addchatter.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Radio", "Toggle CAS", {_this execVM "functions\ARTILLERY\columbia_zeus_togglecas.sqf";}, "\a3\Modules_F_Curator\Data\portraitCASGun_ca.paa"] call zen_custom_modules_fnc_register;

// Environment Tools
["A - Columbia Env", "Transition Time", {execVM "functions\columbia_zeus_transitiontime.sqf";}, "\a3\Modules_F_Curator\Data\iconSkiptime_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Env", "Fog Low", {_this execVM "functions\ENV\columbia_zeus_AL_lowfog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Env", "Fog Ring", {_this execVM "functions\ENV\columbia_zeus_AL_ringfog.sqf";}, "\a3\Modules_F_Curator\Data\iconSmoke_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Env", "Vanilla Fog", {_this execVM "functions\ENV\columbia_zeus_vanillaFog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;

// Punji Traps
["A - Columbia Punji Traps", "Place Mace Trap", {_this execVM "functions\JBOY\mace\columbia_zeus_macetrap.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\kill_ca.paa"] call zen_custom_modules_fnc_register;
