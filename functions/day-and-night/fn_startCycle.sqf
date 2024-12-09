/*
 * Start CBA PerFrameHandler for day/night cycle
 *
 * Arguments:
 * 0: Machine Network ID of Zeus starting cycle
 *
 * Locality:
 * Only execute server-side
 *
 * Example:
 * [_callerID] remoteExec ["COLSOG_fnc_startCycle", 2];
 *
 * Return values:
 * COLSOG_PFHdaynight global handle of PerFrameHandler
 *
 */
params ["_callerID"];

if (!isServer) exitWith {};

COLSOG_isDayNightCycleActive = true;
publicVariable "COLSOG_isDayNightCycleActive";

private _beforeCycleTimeMultiplier = timeMultiplier;

COLSOG_PFHdaynight = [
	{
    params ["_args","_handle"];
		_args params ["_beforeCycleTimeMultiplier", "_callerID"];

		if (!COLSOG_isDayNightCycleActive) exitWith {
			setTimeMultiplier _beforeCycleTimeMultiplier;
      ["Day/Night Cycle OFF", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		// Dusk time is 30 minutes before night.
		private _nightTime = (date call BIS_fnc_sunriseSunsetTime) select 1;
		private _duskTime = _nightTime - (colsog_dayAndNight_duskDuration / 60);
    private _dayTime = (date call BIS_fnc_sunriseSunsetTime) select 0;
    private _dawnTime = _dayTime - (colsog_dayAndNight_duskDuration / 60);
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

		// Between 5:30 and 6:00 time is 6x speed (to give 5 minutes to sunrise)
		private _isDawn = (_actualTime >= _dawnTime) && (_actualTime < _dayTime);
		if (_isDawn && (_actualTimeMultiplier != colsog_dayAndNight_duskTimeAcceleration)) then {
			setTimeMultiplier colsog_dayAndNight_duskTimeAcceleration;
			["Dawn Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
		};
    
		// Between 18:00 and 6:00 time is 120 speed (so night is 5 minutes long)
		if ((sunOrMoon == 0) && !_isDayTime && !_isDusk && !_isDawn && (_actualTimeMultiplier != colsog_dayAndNight_nightTimeAcceleration)) then {
			setTimeMultiplier colsog_dayAndNight_nightTimeAcceleration;
			["Night Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
		};

	}, 1, [_beforeCycleTimeMultiplier, _callerID]
] call CBA_fnc_addPerFrameHandler;