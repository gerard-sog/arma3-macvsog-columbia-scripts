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
    hint format ["Battery Initialized"];
} else {
    private _batteryLevelInPercent = round (100 * (_batteryLevelInSeconds/colsog_battery_capacity));
    if ((_batteryLevelInPercent > 80) AND (_batteryLevelInPercent <= 100)) exitWith
    {
        hint format ["Full: [#####]"];
    };
    if ((_batteryLevelInPercent > 60) AND (_batteryLevelInPercent <= 80)) exitWith
    {
        hint format ["High: [####-]"];
    };
    if ((_batteryLevelInPercent > 40) AND (_batteryLevelInPercent <= 60)) exitWith
    {
        hint format ["Medium: [###--]"];
    };
    if ((_batteryLevelInPercent > 20) AND (_batteryLevelInPercent <= 40)) exitWith
    {
        hint format ["Low: [##---]"];
    };
    if ((_batteryLevelInPercent > 0) AND (_batteryLevelInPercent <= 20)) exitWith
    {
        hint format ["Critical: [#----]"];
    };
    if (_batteryLevelInPercent <= 0) exitWith
    {
        hint format ["Empty: [-----]"];
    };
};
