if !(hasInterface) exitWith {};

_searchForFootprints = [
	"COLSOG_hunter",
	"HUNT - search for footprints",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa",
	{
		[player] call COLSOG_fnc_predator;
	},
	{
        (side player == east)
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _searchForFootprints, true] call ace_interact_menu_fnc_addActionToClass;