/*
 * Adds an ace action to climb to the top of a tree and climb down.
 *
 * Return values:
 * None
 */

if !(hasInterface) exitWith {};

_climbTree = [
	"COLSOG_climbUpTree",
	"Climb up",
	"\a3\modules_f\data\hideterrainobjects\icon_ca.paa",
	{
		call COLSOG_fnc_climbTree;
	},
	{
        private _hasItem = [player, colsog_climbing_requiredItem] call BIS_fnc_hasItem;

        private _isPlayerInTree = player getVariable ["COLSOG_isUpInTree", false];

		private _canClimb = player getVariable ["canClimb", false];

        _result = (_hasItem AND canClimb AND !_isPlayerInTree);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _climbTree, true] call ace_interact_menu_fnc_addActionToClass;

_climbTree = [
	"COLSOG_climbDownTree",
	"Climb down",
	"\a3\modules_f\data\hideterrainobjects\icon_ca.paa",
	{
		call COLSOG_fnc_climbDownTree;
	},
	{
        player getVariable ["COLSOG_isUpInTree", false];
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _climbTree, true] call ace_interact_menu_fnc_addActionToClass;