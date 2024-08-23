#define START_TRANSMIT "start_transmit_"
#define BATTERY_LEVEL "battery_level_"

if !(hasInterface) exitWith {};

_getBatteryLevel = [
	"COLSOG_battery",
	"Get battery level",
	"\a3\Modules_F_Curator\Data\iconLightning_ca.paa",
	{
		execVM "functions\battery\colsog_fn_getBatteryLevel.sqf";
	},
	{
        private _result = false;
        {
            if ([player, _x] call acre_api_fnc_hasKindOfRadio) then
            {
                _result = true;
            };
        } forEach colsog_battery_supportedRadios;
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _getBatteryLevel, true] call ace_interact_menu_fnc_addActionToClass;

_increaseBatteryLevel = [
	"COLSOG_battery",
	"Add new battery",
	"x\zen\addons\context_actions\ui\add_ca.paa",
	{
		execVM "functions\battery\colsog_fn_increaseBatteryLevel.sqf";
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

        private _hasRadioItem = false;
        {
            if ([player, _x] call acre_api_fnc_hasKindOfRadio) then
            {
                _hasRadioItem = true;
            };
        } forEach colsog_battery_supportedRadios;

        _result = (_hasPowerItem AND _hasRadioItem);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _increaseBatteryLevel, true] call ace_interact_menu_fnc_addActionToClass;


// Wait for first broadcast in order to initialize battery on all radio of current player.
[
    {[player] call acre_api_fnc_isBroadcasting;},
    {execVM "functions\battery\colsog_fn_setBatteryLevel.sqf";},
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
            private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;
            private _batteryLevelInSeconds = missionNamespace getVariable _batteryLevelRadioId;
            if (_newBatteryLevelInSeconds <= 0) exitWith {
                [_radioId, "setOnOffState", 0, true] call acre_sys_data_fnc_dataEvent;
                hint format ["Battery is empty: %1", _radioId];
            };

            // startTime for talking on the radio.
            private _startTime = serverTime;
            private _startTransmitRadioId = START_TRANSMIT + _radioId;
            missionNamespace setVariable [_startTransmitRadioId, _startTime];
            player setVariable ["COLSOG_radioId", _radioId, true];
        };
    }
] call CBA_fnc_addEventHandler;


["acre_stoppedSpeaking",
    {
        params ["_unit", "_onRadio"];
        if (_onRadio AND (isTouchingGround player)) then {
            private _radioId = player getVariable "COLSOG_radioId";
            // endTime for talking on the radio.
            private _endTime = serverTime;
            private _startTransmitRadioId = START_TRANSMIT + _radioId;
            private _startTime = missionNamespace getVariable _startTransmitRadioId;

            if (isNil "_startTime") then
            {
                _startTime = _endTime;
            };

            private _powerToRemove = _endTime - _startTime;

            private _batteryLevelRadioId = BATTERY_LEVEL + _radioId;
            private _batteryLevelInSeconds = missionNamespace getVariable _batteryLevelRadioId;

            private _newBatteryLevelInSeconds = _batteryLevelInSeconds - _powerToRemove;
            missionNamespace setVariable [_batteryLevelRadioId, _newBatteryLevelInSeconds];

            if (_newBatteryLevelInSeconds <= 0) exitWith {
                [_radioId, "setOnOffState", 0, true] call acre_sys_data_fnc_dataEvent;
                hint format ["Battery is empty: %1", _radioId];
            };

            hint format ["Battery level : %1 - %2 seconds", _radioId, round _newBatteryLevelInSeconds];

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

