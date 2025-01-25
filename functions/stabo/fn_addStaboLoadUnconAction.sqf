/*
 * Adds an ace action to load unconscious player into Stabo sandbag
 *
 * Return values:
 * None
 */

if !(hasInterface) exitWith {};

_staboLoadUncon = [
	"COLSOG_staboLoadUncon",
	"Load body",
	"\a3\modules_f\data\hideterrainobjects\icon_ca.paa",
	{
		//call COLSOG_fnc_climbTree;
	},
	{
		private _dropppedsanbbag = nearestObjects [player, ["vn_prop_sandbag_01"], 6];
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_MainActions"], _staboLoadUncon, true] call ace_interact_menu_fnc_addActionToClass;
