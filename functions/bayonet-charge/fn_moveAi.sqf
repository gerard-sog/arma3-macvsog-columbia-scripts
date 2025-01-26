/*
 * Manage attack logic for bayonet charge.
 *
 * Arguments:
 * 0: AI group attacking (Object)
 * 1: Targeted player (Object)
 *
 * Return values:
 * Current waypoint AI are moving to.
 */

params ["_attacker", "_target", "_currentWaypointPos"];

private _targetMovedAwayFromLastPos = _currentWaypointPos distanceSqr (getPos _target) > 3;
if (_targetMovedAwayFromLastPos) then {
    systemChat "moving";
    _currentWaypointPos = getPos _target;
    _attacker move _currentWaypointPos;
} else {
    systemChat "continue moving...";
};
_currentWaypointPos;