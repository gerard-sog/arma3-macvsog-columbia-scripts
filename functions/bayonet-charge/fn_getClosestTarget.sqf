/*
 * Return closest player not unconscious or dead in a range of 500m.
 *
 * Arguments:
 * 0: AI unit (Object)
 *
 * Return values: None
 */

params ["_unit"];

private _availableTargets = [];
{
    if ((_x distance _unit < 500) && (alive _x && lifeState _x != "INCAPACITATED")) then {
	    _availableTargets pushBack _x;
    };
} forEach allPlayers;

if (count _availableTargets == 0) exitWith {
    objNull;
};

private _unitPos = getPos _unit;
private _availableTargetList = _availableTargets apply {[_unitPos distanceSqr _x, _x]};
_availableTargetList sort true;
private _closestPlayer = (_availableTargetList select 0) param [1, objNull];
_closestPlayer;