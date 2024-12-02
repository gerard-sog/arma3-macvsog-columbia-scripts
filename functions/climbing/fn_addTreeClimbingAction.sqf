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
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		call COLSOG_fnc_climbTree;
	},
	{
        private _hasItem = [player, colsog_climbing_requiredItem] call BIS_fnc_hasItem;

        private _isPlayerInTree = player getVariable ["COLSOG_isUpInTree", false];

        private _isRoleAllowedToClimb = false;
        private _role = roleDescription player;
        {
            if ([_x, _role] call BIS_fnc_inString) then {
                _isRoleAllowedToClimb = true;
            };
        } forEach colsog_climbing_unitsAllowedToClimbTrees;
        _result = (_hasItem AND _isRoleAllowedToClimb AND !_isPlayerInTree);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _climbTree, true] call ace_interact_menu_fnc_addActionToClass;

_climbTree = [
	"COLSOG_climbDownTree",
	"Climb down",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		call COLSOG_fnc_climbDownTree;
	},
	{
        player getVariable ["COLSOG_isUpInTree", false];
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _climbTree, true] call ace_interact_menu_fnc_addActionToClass;