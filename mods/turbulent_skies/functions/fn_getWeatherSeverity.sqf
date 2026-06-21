/*
    Turbulent Skies
    Returns current turbulence severity from overcast, rain and wind.
*/

private _overcastFactor = missionNamespace getVariable ["TS_overcast_factor", 0.2];
private _rainFactor = missionNamespace getVariable ["TS_rain_factor", 0.5];
private _windFactor = missionNamespace getVariable ["TS_wind_factor", 1];

(overcast * _overcastFactor) +
(rain * _rainFactor) +
(windStr * _windFactor)
