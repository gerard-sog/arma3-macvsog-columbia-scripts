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
    [_radioType, player, colsog_battery_prc77Capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
    hint format ["Battery Initialized"];
} else {
    // Battery ON/OFF state.
    _isRadioOnText = "OFF";
    private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;
    _isRadioOn = (([_radioId] call acre_api_fnc_getRadioOnOffState) == 1);

    if (_isRadioOn) then {
        _isRadioOnText = "ON";
    };

    // Battery level state.
    private _batteryLevelInPercent = round (100 * (_batteryLevelInSeconds/colsog_battery_prc77Capacity));
    if ((_batteryLevelInPercent > 80) AND (_batteryLevelInPercent <= 100)) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [#####] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
    if ((_batteryLevelInPercent > 60) AND (_batteryLevelInPercent <= 80)) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [####-] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
    if ((_batteryLevelInPercent > 40) AND (_batteryLevelInPercent <= 60)) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [###--] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
    if ((_batteryLevelInPercent > 20) AND (_batteryLevelInPercent <= 40)) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [##---] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
    if ((_batteryLevelInPercent > 0) AND (_batteryLevelInPercent <= 20)) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [#----] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
    if (_batteryLevelInPercent <= 0) exitWith
    {
        hint composeText ["Radio state: " + _isRadioOnText, lineBreak, "Battery level: [-----] (" + str(colsog_battery_prc77Capacity) + ")"];
    };
};
