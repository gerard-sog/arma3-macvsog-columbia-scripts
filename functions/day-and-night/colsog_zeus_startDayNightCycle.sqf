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
  _dialogResult params ["_activateCycle", "_dayTimeAcceleration", "_dummy1", "_duskTimeAcceleration", "_nightTimeAcceleration", "_dummy2"];

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

private _dialogTitle = format ["Day/Night Cycle: %1-%2-%3 / %4H%5", date select 0, date select 1, date select 2, date select 3, date select 4];

private _duskTime = ((date call BIS_fnc_sunriseSunsetTime) select 1) - (colsog_dayAndNight_duskDuration / 60);
private _duskTimeDisplay = format [">>>> Dusk: %1H-%2Min", floor _duskTime, round ((_duskTime - (floor _duskTime)) * 60)];

private _dawnTime = ((date call BIS_fnc_sunriseSunsetTime) select 0) - (colsog_dayAndNight_duskDuration / 60);
private _dawnTimeDisplay = format [">>>> Dawn: %1H-%2Min", floor _dawnTime, round ((_dawnTime - (floor _dawnTime)) * 60)];

[
	_dialogTitle, 
	[
		["TOOLBOX:YESNO", "Activate Day/Night Cycle", [COLSOG_isDayNightCycleActive], true],
		["SLIDER", "Day Time Acceleration", [0, 120, colsog_dayAndNight_dayTimeAcceleration, 0], true],
    ["LIST", [_duskTimeDisplay], [[false], [""], 0, 0]], // Display Dusk Time
		["SLIDER", "Dusk Time Acceleration", [0, 120, colsog_dayAndNight_duskTimeAcceleration, 0], true],
		["SLIDER", "Night Time Acceleration", [0, 120, colsog_dayAndNight_nightTimeAcceleration, 0], true],
    ["LIST", [_dawnTimeDisplay], [[false], [""], 0, 0]] // Display Dawn Time
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;