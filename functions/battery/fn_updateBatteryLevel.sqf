#define LAST_TRANSMISSION_RADIO_ID "COLSOG_lastTransmissionRadioId"

if !(hasInterface) exitWith {};

_displayBatteryLevelPrc77 = [
	"COLSOG_battery",
	"PRC77 - Show battery level",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		["ACRE_PRC77", player] call COLSOG_fnc_displayBatteryLevel;
	},
	{
        [player, "ACRE_PRC77"] call acre_api_fnc_hasKindOfRadio
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _displayBatteryLevelPrc77, true] call ace_interact_menu_fnc_addActionToClass;

_displayBatteryLevelPrc343 = [
	"COLSOG_battery",
	"PRC343 - Show battery level",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		["ACRE_PRC343", player] call COLSOG_fnc_displayBatteryLevel;
	},
	{
        [player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _displayBatteryLevelPrc343, true] call ace_interact_menu_fnc_addActionToClass;


_increaseBatteryLevelPrc77 = [
	"COLSOG_battery",
	"PRC77 - Add new battery",
	"x\zen\addons\context_actions\ui\add_ca.paa",
	{
		["ACRE_PRC77", player] call COLSOG_fnc_increaseBatteryLevel;
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

        private _hasRadioItem = ([player, "ACRE_PRC77"] call acre_api_fnc_hasKindOfRadio);

        _result = (_hasPowerItem AND _hasRadioItem);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _increaseBatteryLevelPrc77, true] call ace_interact_menu_fnc_addActionToClass;


_increaseBatteryLevelPrc343 = [
	"COLSOG_battery",
	"PRC343 - Add new battery",
	"x\zen\addons\context_actions\ui\add_ca.paa",
	{
		["ACRE_PRC343", player] call COLSOG_fnc_increaseBatteryLevel;
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

        private _hasRadioItem = ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio);

        _result = (_hasPowerItem AND _hasRadioItem);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _increaseBatteryLevelPrc343, true] call ace_interact_menu_fnc_addActionToClass;


// Wait for first broadcast in order to initialize battery on all radio of current player.
[
    {[player] call acre_api_fnc_isBroadcasting;},
    {execVM "functions\battery\fn_initializeBatteryLevel.sqf";},
    [player]
]
call CBA_fnc_waitUntilAndExecute;

// Set eventHandler to lower radio battery when used
// AND to spawn enemy if used too many times.

["acre_startedSpeaking",
    {
    params ["_unit", "_onRadio", "_radioId"];
        if (_onRadio AND (isTouchingGround player)) then {

            // Checks that radio has not be forced ON by player if battery is empty.
            // If needed, turn OFF radio again.
            private _currentBatteryLevelInSeconds = [_radioId] call COLSOG_fnc_getBatteryLevelFromRadioId;

            if (_currentBatteryLevelInSeconds <= 0) exitWith {
                [_radioId, "setOnOffState", 0, true] call acre_sys_data_fnc_dataEvent;
                hint format ["Battery is empty: %1", _radioId];
            };

            [serverTime, _radioId] call COLSOG_fnc_setLastStartOfTransmission;

            // Required in order to have access to the 'radioId' in 'acre_stoppedSpeaking'.
            player setVariable [LAST_TRANSMISSION_RADIO_ID, _radioId, true];
        };
    }
] call CBA_fnc_addEventHandler;


["acre_stoppedSpeaking",
    {
        params ["_unit", "_onRadio"];
        if (_onRadio AND (isTouchingGround player)) then {
            private _radioId = player getVariable LAST_TRANSMISSION_RADIO_ID;

            private _transmissionStartTime = [_radioId] call COLSOG_fnc_getLastStartOfTransmission;
            private _transmissionEndTime = serverTime;

            if (isNil "_transmissionStartTime") then
            {
                _transmissionStartTime = _transmissionEndTime;
            };

            private _powerToRemove = _transmissionEndTime - _transmissionStartTime;

            private _currentBatteryLevelInSeconds = [_radioId] call COLSOG_fnc_getBatteryLevelFromRadioId;
            private _newBatteryLevelInSeconds = _currentBatteryLevelInSeconds - _powerToRemove;
            [_radioId, _newBatteryLevelInSeconds] call COLSOG_fnc_setBatteryLevelFromRadioId;

            if (_newBatteryLevelInSeconds <= 0) exitWith {
                [_radioId, "setOnOffState", 0, true] call acre_sys_data_fnc_dataEvent;
                hint format ["Battery is empty: %1", _radioId];
            };

            hint format ["Battery level: %1 - %2 seconds", _radioId, round _newBatteryLevelInSeconds];

            // If radio call threshold reached, spawn enemy towards current player position and reset.
            COLSOG_amountOfRadioCalls = COLSOG_amountOfRadioCalls + 1;
            if (COLSOG_amountOfRadioCalls > colsog_battery_enemySpawnThreshold) then {
                COLSOG_amountOfRadioCalls = 0;
                private _group = [(player modelToWorld [0,250,0]), 1, east, "VN"] call VN_ms_fnc_tracker_spawnGroup;
                _group move (getPos player);
            };
            publicVariable "COLSOG_amountOfRadioCalls";
        };
    }
] call CBA_fnc_addEventHandler;

