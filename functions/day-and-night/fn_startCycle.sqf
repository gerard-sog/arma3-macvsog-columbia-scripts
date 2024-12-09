/*
 * Start CBA PerFrame Handler for day/night cycle
 *
 * Arguments:
 * 0: Machine Network ID of Zeus starting cycle
 *
 * Locality:
 * Only execute server-side
 *
 * Example:
 *
 *
 * Return values:
 * None
 *
 */
params ["_callerID"];

if (!isServer) exitWith {};

COLSOG_isDayNightCycleActive = true;
publicVariable "COLSOG_isDayNightCycleActive";

private _beforeCycleTimeMultiplier = timeMultiplier;

COLSOG_PFEHdaynight = [
	{
		params ["_beforeCycleTimeMultiplier"];

		if (!COLSOG_isDayNightCycleActive) exitWith {
			setTimeMultiplier _beforeCycleTimeMultiplier;
			[COLSOG_PFEHdaynight] call CBA_fnc_removePerFrameHandler;
		};

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

	}, 1, [_beforeCycleTimeMultiplier, _callerID]
] call CBA_fnc_addPerFrameHandler;