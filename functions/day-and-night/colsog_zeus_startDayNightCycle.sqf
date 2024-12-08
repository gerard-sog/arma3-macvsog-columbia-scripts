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

// Get if system is ON or OFF.
_isDayNightCycleActive = !COLSOG_isDayNightCycleActive;
COLSOG_isDayNightCycleActive = _isDayNightCycleActive;
publicVariable "COLSOG_isDayNightCycleActive";

// Will be turn OFF inside the spawn method. The condition for the loop is updated to false.
if (!_isDayNightCycleActive) exitWith {};

[
    [],
    {
        while {COLSOG_isDayNightCycleActive} do {
            uiSleep 1;

            // Dusk time is 30 minutes before night.
            private _sunriseAndSunsetArray = date call BIS_fnc_sunriseSunsetTime;
            private _nightTime = _sunriseAndSunsetArray select 1;
            private _duskTime = _nightTime - (colsog_dayAndNight_duskDuration / 60);
            private _actualTime = daytime;

            // Between 6:00 and 17:30 time is 12x speed (so roughly 1 hour real time)
            private _isDayTime = (sunOrMoon == 1) && (_actualTime < _duskTime);
            if (_isDayTime) then {
                setTimeMultiplier colsog_dayAndNight_dayTimeAcceleration;
            };

            // Between 17:30 and 18:00 time is 6x speed (to give 5 minutes to set up RON position when there is still light)
            private _isDusk = (_actualTime >= _duskTime) && (_actualTime < _nightTime);
            if (_isDusk) then {
                setTimeMultiplier colsog_dayAndNight_duskTimeAcceleration;
            };

            // Between 18:00 and 6:00 time is 120 speed (so night is 5 minutes long)
            if (!_isDayTime && !_isDusk) then {
                setTimeMultiplier colsog_dayAndNight_nightTimeAcceleration;
            };
        };
        setTimeMultiplier 1;
    }
] remoteExecCall ["spawn", 2, false];