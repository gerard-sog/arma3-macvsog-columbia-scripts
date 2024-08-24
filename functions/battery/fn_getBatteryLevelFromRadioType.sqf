/*
 * Get battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * Battery level in seconds (Number)
 */

#define BATTERY_LEVEL "battery_level_"

params ["_radioType", "_player"];

private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;
private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;
private _batteryLevelInSeconds = missionNamespace getVariable _batteryLevelRadioId;
_batteryLevelInSeconds;