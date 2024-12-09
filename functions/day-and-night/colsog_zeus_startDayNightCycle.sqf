/*
 * Custom Zeus module: Start a customized day/night cycle.
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object (not used)
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0, 0, 0] , [[]], 3], ["_location", objNull, [objNull]]];

private _onConfim = {
	params ["_dialogResult"];
    _dialogResult params ["_activateCycle" ,"_dayTimeAcceleration", "_duskTimeAcceleration", "_nightTimeAcceleration"]

    if (missionNamespace getVariable "colsog_dayAndNight_dayTimeAcceleration" != _dayTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_dayTimeAcceleration", _dayTimeAcceleration, true];
        systemChat "Changed DayTime Acceleration";
    };

    if (missionNamespace getVariable "colsog_dayAndNight_duskTimeAcceleration" != _duskTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_duskTimeAcceleration", _duskTimeAcceleration, true];
        systemChat "Changed DuskTime Acceleration";
    };

    if (missionNamespace getVariable "colsog_dayAndNight_nightTimeAcceleration" != _nightTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_nightTimeAcceleration", _nightTimeAcceleration, true];
        systemChat "Changed NightTime Acceleration";
    };

    if (!_activateCycle) exitWith { // switch Off
        COLSOG_isDayNightCycleActive = false;
        publicVariable "COLSOG_isDayNightCycleActive";
        systemChat "Day/Night Cycle OFF";
    };

    if (COLSOG_isDayNightCycleActive && _activateCycle) exitWith {
        systemChat "Day/Night Already ON";
    }; // if already ON, no call needed to function

    private _callerID = clientOwner;

    [
        [_callerID],
        {
            params ["_callerID"];

            COLSOG_isDayNightCycleActive = true;
            publicVariable "COLSOG_isDayNightCycleActive";

            private _beforeCycleTimeMultiplier = timeMultiplier;

            while {COLSOG_isDayNightCycleActive} do {
                uiSleep 1;

                // Dusk time is 30 minutes before night.
                private _sunriseAndSunsetArray = date call BIS_fnc_sunriseSunsetTime;
                private _nightTime = _sunriseAndSunsetArray select 1;
                private _duskTime = _nightTime - (colsog_dayAndNight_duskDuration / 60);
                private _actualTime = daytime;

                private _actualTimeMultiplier = timeMultiplier;

                // Between 6:00 and 17:30 time is 12x speed (so roughly 1 hour real time)
                private _isDayTime = (sunOrMoon == 1) && (_actualTime < _duskTime);
                if (_isDayTime && (_actualTimeMultiplier != colsog_dayAndNight_dayTimeAcceleration)) then {
                    setTimeMultiplier colsog_dayAndNight_dayTimeAcceleration;
                    ["Day Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
                };

                // Between 17:30 and 18:00 time is 6x speed (to give 5 minutes to set up RON position when there is still light)
                private _isDusk = (_actualTime >= _duskTime) && (_actualTime < _nightTime);
                if (_isDusk && (_actualTimeMultiplier != colsog_dayAndNight_duskTimeAcceleration)) then {
                    setTimeMultiplier colsog_dayAndNight_duskTimeAcceleration;
                    ["Dusk Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
                };

                // Between 18:00 and 6:00 time is 120 speed (so night is 5 minutes long)
                if (!_isDayTime && !_isDusk && (_actualTimeMultiplier != colsog_dayAndNight_nightTimeAcceleration)) then {
                    setTimeMultiplier colsog_dayAndNight_nightTimeAcceleration;
                    ["Night Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
                };
            };
            setTimeMultiplier _beforeCycleTimeMultiplier;
        }
    ] remoteExecCall ["spawn", 2, false];

};

private _sunriseAndSunsetArray = date call BIS_fnc_sunriseSunsetTime;
private _dialogTitle = format ["Day/Night Cycle: %1, %2", date, _sunriseAndSunsetArray];

[
	_dialogTitle, 
	[
		["TOOLBOX:YESNO", "Activate Day/Night Cycle", [COLSOG_isDayNightCycleActive], true],
		["SLIDER", "Day Time Acceleration", [0, 120, colsog_dayAndNight_dayTimeAcceleration, 0], true],
		["SLIDER", "Dusk Time Acceleration", [0, 120, colsog_dayAndNight_duskTimeAcceleration, 0], true],
		["SLIDER", "Night Time Acceleration", [0, 120, colsog_dayAndNight_nightTimeAcceleration, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;