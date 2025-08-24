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
    [_radioType, _player, colsog_battery_prc77Capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["Battery Initialized"];
} else {
    scopeName "outsideOfLoop";
    private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;
    private _powerItemRemoved = "MISSING";
    {
        if ([_player, _x] call BIS_fnc_hasItem) then
        {
            _powerItemRemoved = _x;
            _player removeItem _powerItemRemoved;
            // Needs to be run GLOBALLY... (would need to implement set method in ACRE otherwise).
            [_radioId, "setOnOffState", 1, true] remoteExec ["acre_sys_data_fnc_dataEvent", 0];
            breakTo "outsideOfLoop";
        };
    } forEach colsog_battery_powerItems;

    // This is where script execution will jump to after 'breakTo'.
    [_radioType, _player, colsog_battery_prc77Capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["New battery inserted"];
};