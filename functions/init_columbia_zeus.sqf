 if (!hasInterface) exitWith {};

 private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
 if !(_hasZen) exitWith { systemChat "ZEN not detected";};
 
 // Custom Zeus Modules in Right Panel
 ["COLUMBIA Tools", "Toggle Consciousness", {_this execVM "functions\columbia_zeus_toggleconsciousness.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_Unconscious_ca.paa"] call zen_custom_modules_fnc_register;

 // Checks if unit object, is not null and is alive. Required to filter away if right-clicked on group as the other if-checks dont work with group
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
