/*
 * Remove 1 battery from player's inventory to reset the battery level to maximum capacity (or initialize them if not configured).
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * None
 */

params ["_radioType", "_player"];

private _batteryLevelInSeconds = [_radioType, _player] call COLSOG_fnc_getBatteryLevelFromRadioType;

if (isNil "_batteryLevelInSeconds") then
{
    [_radioType, _player, colsog_battery_capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["Battery Initialized: %1 - %2 seconds", _radioType, round colsog_battery_capacity];
} else {
    scopeName "outsideOfLoop";
    private _powerItemRemoved = "MISSING";
    {
        if ([_player, _x] call BIS_fnc_hasItem) then
        {
            _powerItemRemoved = _x;
            _player removeItem _powerItemRemoved;
            breakTo "outsideOfLoop";
        };
    } forEach colsog_battery_powerItems;

    // This is where script execution will jump to after 'breakTo'.
    [_radioType, _player, colsog_battery_capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["New battery added: %1 - %2 seconds ( -1x %3)", _radioType, round colsog_battery_capacity, _powerItemRemoved];
};