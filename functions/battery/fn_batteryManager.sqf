#define LAST_TRANSMISSION_RADIO_ID "COLSOG_lastTransmissionRadioId"
#define ACRE_PRC77 "ACRE_PRC77"

if !(hasInterface) exitWith {};

_displayBatteryLevelPrc77 = [
	"COLSOG_battery",
	"PRC77 - Show battery level",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		[ACRE_PRC77, player] call COLSOG_fnc_displayBatteryLevel;
	},
	{
        [player, ACRE_PRC77] call acre_api_fnc_hasKindOfRadio
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _displayBatteryLevelPrc77, true] call ace_interact_menu_fnc_addActionToClass;

_increaseBatteryLevelPrc77 = [
	"COLSOG_battery",
	"PRC77 - Add new battery",
	"x\zen\addons\context_actions\ui\add_ca.paa",
	{
		[ACRE_PRC77, player] call COLSOG_fnc_increaseBatteryLevel;
	},
	{
	    private _result = false;

	    private _hasPowerItem = false;
        {
            if ([player, _x] call BIS_fnc_hasItem) then
            {
                _hasPowerItem = true;
            };
        } forEach colsog_battery_powerItems;

        private _hasRadioItem = ([player, ACRE_PRC77] call acre_api_fnc_hasKindOfRadio);

        _result = (_hasPowerItem AND _hasRadioItem);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _increaseBatteryLevelPrc77, true] call ace_interact_menu_fnc_addActionToClass;

// Set eventHandler to lower radio battery when used
// AND to spawn enemy if used too many times.

["acre_startedSpeaking",
    {
        params ["_unit", "_onRadio", "_radioId"];
        if ([_onRadio, _radioId, ACRE_PRC77, player] call COLSOG_fnc_isBatteryManagementRequired) then
        {
            private _currentBatteryLevelInSeconds = [_radioId] call COLSOG_fnc_getBatteryLevelFromRadioId;

            // If not initialized, we will initialize the radio.
            if (isNil "_currentBatteryLevelInSeconds") then
            {
                _currentBatteryLevelInSeconds = colsog_battery_prc77Capacity;
                [_radioId, _currentBatteryLevelInSeconds] call COLSOG_fnc_setBatteryLevelFromRadioId;
                hint format ["Battery Initialized"];
            };
        };

        // Required in order to have access to the 'radioId' in 'acre_stoppedSpeaking'.
        player setVariable [LAST_TRANSMISSION_RADIO_ID, _radioId, true];
    }
] call CBA_fnc_addEventHandler;


["acre_stoppedSpeaking",
    {
        params ["_unit", "_onRadio"];
        private _radioId = player getVariable [LAST_TRANSMISSION_RADIO_ID, ""];
        if ([_onRadio, _radioId, ACRE_PRC77, player] call COLSOG_fnc_isBatteryManagementRequired) then
        {
            // If radio call threshold reached, spawn enemy towards current player position and reset.
            [player] call COLSOG_fnc_incrementRadioCallsCounter;

            // If battery critically low, then 3 bip audio cue to warn about low battery.
            private _currentBatteryLevelInSeconds = [_radioId] call COLSOG_fnc_getBatteryLevelFromRadioId;
            private _batteryLevelInPercent = round (100 * (_currentBatteryLevelInSeconds/colsog_battery_prc77Capacity));
            if ((_batteryLevelInPercent > 0) AND (_batteryLevelInPercent <= 20)) then
            {
                playSound "gdtmod_satchel_starttimer"; // (bip bip bip)
                hintSilent format ["Critical: [#----]"];
            };
        };
    }
] call CBA_fnc_addEventHandler;

