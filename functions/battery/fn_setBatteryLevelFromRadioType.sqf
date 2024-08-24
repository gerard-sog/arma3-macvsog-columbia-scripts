/*
 * Set battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 * 2: new battery level (Number)
 *
 * Return values:
 * None
 */

#define BATTERY_LEVEL "battery_level_"

params ["_radioType", "_player", "_newBatteryLevel"];

private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;
private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;

missionNamespace setVariable [_batteryLevelRadioId, _newBatteryLevel];