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
        params ["_args", "_handle"];
		_args params ["_beforeCycleTimeMultiplier", "_callerID"];

		if (!COLSOG_isDayNightCycleActive) exitWith {
			setTimeMultiplier _beforeCycleTimeMultiplier;
            ["Day/Night cycle OFF", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		private _actualTime = daytime;
        private _actualTimeMultiplier = timeMultiplier;

        private _sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
		private _sunriseTime = (_sunriseSunsetTime select 0);
		private _sunsetTime = (_sunriseSunsetTime select 1);

        private _dayTime = _sunriseTime + (colsog_dayAndNight_dawnDuration / 60);
        private _dawnTime = _sunriseTime - (colsog_dayAndNight_dawnDuration / 60);

        private _nightTime = _sunsetTime + (colsog_dayAndNight_duskDuration / 60);
        private _duskTime = _sunsetTime - (colsog_dayAndNight_duskDuration / 60);

		// Dawn.
        private _isDawn = (_actualTime >= _dawnTime) && (_actualTime < _dayTime);
        if (_isDawn && (_actualTimeMultiplier != colsog_dayAndNight_dawnTimeAcceleration)) then {
            setTimeMultiplier colsog_dayAndNight_dawnTimeAcceleration;
            ["Dawn Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
        };

		// Day.
		private _isDayTime = (_actualTime > _dayTime) && (_actualTime < _duskTime);
		if (_isDayTime && (_actualTimeMultiplier != colsog_dayAndNight_dayTimeAcceleration)) then {
			setTimeMultiplier colsog_dayAndNight_dayTimeAcceleration;
			["Day Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
		};

		// Dusk.
		private _isDusk = (_actualTime >= _duskTime) && (_actualTime < _nightTime);
		if (_isDusk && (_actualTimeMultiplier != colsog_dayAndNight_duskTimeAcceleration)) then {
			setTimeMultiplier colsog_dayAndNight_duskTimeAcceleration;
			["Dusk Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
		};

		// Night.
		private _isNightTime = !_isDayTime && !_isDusk && !_isDawn;
		if (_isNightTime && (_actualTimeMultiplier != colsog_dayAndNight_nightTimeAcceleration)) then {
			setTimeMultiplier colsog_dayAndNight_nightTimeAcceleration;
			["Night Time", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _callerID];
		};
	},
	1,
	[_beforeCycleTimeMultiplier, _callerID]
] call CBA_fnc_addPerFrameHandler;