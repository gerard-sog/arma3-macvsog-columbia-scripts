/*
 * Displays the battery level for a radio in the player's inventory (or initialize them if not configured).
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * None
 */

params ["_radioType", "_player"];

private _batteryLevelInSeconds = [_radioType, player] call COLSOG_fnc_getBatteryLevelFromRadioType;

if (isNil "_batteryLevelInSeconds") then {
    [_radioType, player, colsog_battery_capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["Battery Initialized: %1 - %2 seconds", _radioType, round colsog_battery_capacity];
} else {
    hint format ["Battery level: %1 - %2 seconds", _radioType, round _batteryLevelInSeconds];
};
