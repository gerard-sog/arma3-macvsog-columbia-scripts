/*
 * Initialized battery level for all supported radios in the player's inventory.
 */

{
    if ([player, _x] call acre_api_fnc_hasKindOfRadio) then
    {
        private _batteryLevelInSeconds = [_x, player] call COLSOG_fnc_getBatteryLevelFromRadioType;

        if (isNil "_batteryLevelInSeconds") then
        {
            [_x, player, colsog_battery_capacity] call COLSOG_fnc_setBatteryLevelFromRadioType;
            hint format ["Battery Initialized: %1 - %2 seconds", _x, round colsog_battery_capacity];
        };
    };
} forEach COLSOG_batterySupportedRadios;