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

#define BATTERY_LEVEL "battery_level_"

params ["_radioId", "_newBatteryLevel"];

private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;

missionNamespace setVariable [_batteryLevelRadioId, _newBatteryLevel];