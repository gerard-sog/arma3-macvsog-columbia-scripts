if !(hasInterface) exitWith {};

_decryptIntel = [
	"COLSOG_intel",
	"Decrypt intel",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa",
	{
		[player] execVM "functions\intel\fn_decryptIntel.sqf";
	},
	{
	    [player, colsog_intel_inventoryItem] call BIS_fnc_hasItem;
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _decryptIntel, true] call ace_interact_menu_fnc_addActionToClass;