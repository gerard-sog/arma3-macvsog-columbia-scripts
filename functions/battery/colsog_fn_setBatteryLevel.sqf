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
        };

        hint format ["Battery initialized: %1 - %2 seconds", _x, round _batteryLevelInSeconds];
    };
} forEach colsog_battery_supportedRadios;