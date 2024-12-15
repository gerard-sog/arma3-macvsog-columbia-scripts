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
    _dialogResult params ["_activateCycle", "_dawnNotUsed", "_dawnTimeAcceleration", "_dayTimeAcceleration", "_duskNotUsed", "_duskTimeAcceleration", "_nightTimeAcceleration"];

    if ((missionNamespace getVariable "colsog_dayAndNight_dawnTimeAcceleration") != _dawnTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_dawnTimeAcceleration", _duskTimeAcceleration, true];
        systemChat "Changed DawnTime Acceleration: " + str (_dawnTimeAcceleration);
    };

    if ((missionNamespace getVariable "colsog_dayAndNight_dayTimeAcceleration") != _dayTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_dayTimeAcceleration", _dayTimeAcceleration, true];
        systemChat "Changed DayTime Acceleration: " + str (_dayTimeAcceleration);
    };

    if ((missionNamespace getVariable "colsog_dayAndNight_duskTimeAcceleration") != _duskTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_duskTimeAcceleration", _duskTimeAcceleration, true];
        systemChat "Changed DuskTime Acceleration: " + str (_duskTimeAcceleration);
    };

    if ((missionNamespace getVariable "colsog_dayAndNight_nightTimeAcceleration") != _nightTimeAcceleration) then {
        missionNamespace setVariable ["colsog_dayAndNight_nightTimeAcceleration", _nightTimeAcceleration, true];
        systemChat "Changed NightTime Acceleration: " + str (_nightTimeAcceleration);
    };

    // switch Off
    if (!_activateCycle) exitWith {
        COLSOG_isDayNightCycleActive = false;
        publicVariable "COLSOG_isDayNightCycleActive";
    };

    // if already ON, no call needed to function
    if (COLSOG_isDayNightCycleActive && _activateCycle) exitWith {};

    systemChat "Day/Night cycle enabled";

    private _callerID = clientOwner;
    [_callerID] remoteExec ["COLSOG_fnc_startCycle", 2];
};

private _dialogTitle = format ["Day/Night Cycle: %1-%2-%3 / %4H%5", date select 0, date select 1, date select 2, date select 3, date select 4];

private _sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
private _sunriseTime = (_sunriseSunsetTime select 0);
private _sunsetTime = (_sunriseSunsetTime select 1);

private _dawnTime = _sunriseTime - (colsog_dayAndNight_dawnDuration / 60);
private _dawnTimeInHourMinuteFormat = format [">>>> Dawn: from %1h%2m to %3h%4m", floor _dawnTime, round ((_dawnTime - (floor _dawnTime)) * 60), floor _sunriseTime, round ((_sunriseTime - (floor _sunriseTime)) * 60)];

private _duskTime = _sunsetTime - (colsog_dayAndNight_duskDuration / 60);
private _duskTimeInHourMinuteFormat = format [">>>> Dusk: from %1h%2m to %3h%4m", floor _duskTime, round ((_duskTime - (floor _duskTime)) * 60), floor _sunsetTime, round ((_sunsetTime - (floor _sunsetTime)) * 60)];

[
	_dialogTitle, 
	[
		["TOOLBOX:YESNO", "Activate Day/Night Cycle", [COLSOG_isDayNightCycleActive], true],
		["LIST", [_dawnTimeInHourMinuteFormat], [[false], [""], 0, 0]],
		["SLIDER", "Dawn Time Acceleration", [0, 120, colsog_dayAndNight_dawnTimeAcceleration, 0], true],
		["SLIDER", "Day Time Acceleration", [0, 120, colsog_dayAndNight_dayTimeAcceleration, 0], true],
        ["LIST", [_duskTimeInHourMinuteFormat], [[false], [""], 0, 0]],
		["SLIDER", "Dusk Time Acceleration", [0, 120, colsog_dayAndNight_duskTimeAcceleration, 0], true],
		["SLIDER", "Night Time Acceleration", [0, 120, colsog_dayAndNight_nightTimeAcceleration, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;