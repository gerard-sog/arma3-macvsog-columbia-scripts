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

private _onConfirm = {
    params ["_dialogResult"];
    _dialogResult params ["_activateCycle" ,"_dayTimeAcceleration", "_duskTimeAcceleration", "_nightTimeAcceleration"];

    if ((missionNamespace getVariable "colsog_dayAndNight_dayTimeAcceleration") != _dayTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_dayTimeAcceleration", _dayTimeAcceleration, true];
        systemChat "Changed DayTime Acceleration";
    };

    if ((missionNamespace getVariable "colsog_dayAndNight_duskTimeAcceleration") != _duskTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_duskTimeAcceleration", _duskTimeAcceleration, true];
        systemChat "Changed DuskTime Acceleration";
    };

    if ((missionNamespace getVariable "colsog_dayAndNight_nightTimeAcceleration") != _nightTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_nightTimeAcceleration", _nightTimeAcceleration, true];
        systemChat "Changed NightTime Acceleration";
    };

    if (!_activateCycle) exitWith { // switch Off
        COLSOG_isDayNightCycleActive = false;
        publicVariable "COLSOG_isDayNightCycleActive";
    };

    if (COLSOG_isDayNightCycleActive && _activateCycle) exitWith {}; // if already ON, no call needed to function

    systemChat "Day/Night Cycle Starting";
    
    private _callerID = clientOwner;
    [_callerID] remoteExec ["COLSOG_fnc_startCycle", 2];

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