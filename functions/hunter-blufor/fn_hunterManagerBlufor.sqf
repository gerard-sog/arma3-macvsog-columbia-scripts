if !(hasInterface) exitWith {};

_searchForTrails = [
	"COLSOG_hunterBlufor",
	"HUNT - search for trails",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa",
	{
		[player] call COLSOG_fnc_predatorBlufor;
	},
	{
        (side player == west)
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _searchForTrails, true] call ace_interact_menu_fnc_addActionToClass;