/*
 * Set battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio id (String)
 * 1: new battery level (Number)
 *
 * Return values:
 * None
 */

params ["_radioId", "_newBatteryLevel"];

private _radios = missionNamespace getVariable "COLSOG_radios";
_radios pushBack [_radioId, _newBatteryLevel];
missionNamespace setVariable ["COLSOG_radios", _radios, true];