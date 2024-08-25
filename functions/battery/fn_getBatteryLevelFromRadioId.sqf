/*
 * Get battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio id (String)
 *
 * Return values:
 * Battery level in seconds (Number)
 */

#define BATTERY_LEVEL "battery_level_"

params ["_radioId"];

private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;
private _batteryLevelInSeconds = missionNamespace getVariable _batteryLevelRadioId;
_batteryLevelInSeconds;