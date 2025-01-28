/*
 * Manage moving logic for bayonet charge.
 *
 * Arguments:
 * 0: AI group attacking (Object)
 * 1: Targeted player (Object)
 *
 * Return values:
 * Current waypoint AI are moving to.
 */

params ["_attacker", "_target"];

private _targetMovedAwayFromLastPos = _currentWaypointPos distanceSqr (getPos _target) > 3;
if (_targetMovedAwayFromLastPos) then {
    "moving" remoteExec ["systemChat", 0];
    _currentWaypointPos = getPos _target;
    _attacker move _currentWaypointPos;
} else {
    "continue moving..." remoteExec ["systemChat", 0];
};
_currentWaypointPos;