#define BATTERY_LEVEL "battery_level_"

{
    if ([player, _x] call acre_api_fnc_hasKindOfRadio) then
    {
        private _radioId = [_x, player] call acre_api_fnc_getRadioByType;
        private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;
        // initial level of battery is equal to 'colsog_battery_capacity'.

        private _batteryLevelInSeconds = missionNamespace getVariable _batteryLevelRadioId;

        if (isNil "_batteryLevelInSeconds") then
        {
            missionNamespace setVariable [_batteryLevelRadioId, colsog_battery_capacity];
            _batteryLevelInSeconds = colsog_battery_capacity;
            hint format ["Battery initialized: %1 - %2 seconds", _x, round _batteryLevelInSeconds];
        } else {
            scopeName "outsideOfLoop";
            private _powerItemRemoved = "MISSING";
            {
                if ([player, _x] call BIS_fnc_hasItem) then
                {
                    _powerItemRemoved = _x;
                    player removeItem _powerItemRemoved;
                    breakTo "outsideOfLoop";
                };
            } forEach colsog_battery_powerItems;

            // This is where script execution will jump to after 'breakTo'.
            missionNamespace setVariable [_batteryLevelRadioId, colsog_battery_capacity];
            hint format ["New battery added: %1 - %2 seconds ( -1x %3)", _x, round colsog_battery_capacity, _powerItemRemoved];
        };
        uiSleep 2;
    };
} forEach colsog_battery_supportedRadios;