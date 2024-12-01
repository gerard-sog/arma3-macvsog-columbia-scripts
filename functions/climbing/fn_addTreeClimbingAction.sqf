/*
 * Adds an ace action to climb to the top of a tree.
 *
 * Return values:
 * None
 */

if !(hasInterface) exitWith {};

_climbTree = [
	"COLSOG_climbTree",
	"Climb tree",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		[player, cursorObject] call COLSOG_fnc_climbTree;
	},
	{
        private _hasItem = [player, "ACE_rope18"] call BIS_fnc_hasItem;

        private _isRoleAllowedToClimb = false;
        private _role = roleDescription player;
        {
            if ([_x, _role] call BIS_fnc_inString) then {
                _isRoleAllowedToClimb = true;
            };
        } forEach colsog_climbing_unitsAllowedToClimbTrees;
        _result = (_hasItem AND _isRoleAllowedToClimb);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _climbTree, true] call ace_interact_menu_fnc_addActionToClass;