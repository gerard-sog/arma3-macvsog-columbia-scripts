if (!hasInterface) exitWith {};

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitWith { systemChat "ZEN not detected";};

// Custom Zeus Modules in Right Panel
["A - Columbia Tools", "Toggle Consciousness", {_this execVM "functions\columbia_zeus_toggleconsciousness.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_Unconscious_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Tools", "Toggle CAS", {_this execVM "functions\columbia_zeus_togglecas.sqf";}, "\a3\Modules_F_Curator\Data\portraitCASGun_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Tools", "Toggle Trackers", {_this execVM "functions\columbia_zeus_toggletrackers.sqf";}, "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Tools", "Transition Time", {execVM "functions\columbia_zeus_transitiontime.sqf";}, "\a3\Modules_F_Curator\Data\iconSkiptime_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Tools", "Init PF77s", {_this execVM "functions\columbia_zeus_initpf77rack.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;
["A - Columbia Tools", "NVA radio chatter", {_this execVM "functions\columbia_zeus_addchatter.sqf";}, "\a3\Modules_F_Curator\Data\portraitRadio_ca.paa"] call zen_custom_modules_fnc_register;

// Checks if unit object, is not null and is alive. Required to filter away if right-clicked on group as the other if-checks don't work with group
COLUMBIA_fnc_isAlivePlayerUnit = {
	params ["_unit"];
	private _result = false;

	if (typeName _unit != "OBJECT") exitWith { _result = false; _result;}; // check if not group, before 

	if (!isNull _unit && alive _unit && _unit isKindOf "CAManBase" && isPlayer _unit) then {
		_result = true;
	};
	_result;
};

// Toggle consciousness (in Heal subfolder)
private _playertoggleconsciousness = [
	"player_toggle_consciousness", 
	"Toggle Consciousness", 
	["\z\ace\addons\zeus\UI\Icon_Module_Zeus_Unconscious_ca.paa", [1, 0.5, 0, 0.9]], 
	{[_position, _hoveredEntity] execVM "functions\columbia_zeus_toggleconsciousness.sqf";}, 
	{[_hoveredEntity] call COLUMBIA_fnc_isAlivePlayerUnit}
] call zen_context_menu_fnc_createAction;

[_playertoggleconsciousness, ["HealUnits"], 0] call zen_context_menu_fnc_addAction;
