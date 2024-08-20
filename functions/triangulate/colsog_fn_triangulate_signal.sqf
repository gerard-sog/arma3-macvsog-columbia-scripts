// 5 minutes timeout between each call.
private _nextTriangulationTimeSeconds = COLSOG_lastTriangulationTimeSeconds + colsog_triangulation_coolDown;
private _currentTimeSeconds = serverTime;
private _nearest_acre_spike = player distance nearestObject [player, "vhf30108spike"]; //Gets the distances to the nearest radio spike

if (_currentTimeSeconds < _nextTriangulationTimeSeconds) exitWith
{
    private _coolDown = abs (_currentTimeSeconds - _nextTriangulationTimeSeconds);
    hint format ["Cool down : %1 seconds", round _coolDown];
};

if (_nearest_acre_spike > 5 && colsog_triangulation_requireSpike == true) exitWith //If there isn't a radio spike within 5m, returns a hint to tell the user there is no spike nearby. Does not trigger the cooldown period.
{
    hint format ["No ground spike nearby"];
};

COLSOG_lastTriangulationTimeSeconds = _currentTimeSeconds;
publicVariable "COLSOG_lastTriangulationTimeSeconds";

// For each, get distance to player and return shortest distance.
private _currentMinimalDistance = 9999;

{
    private _all_radios = entities _x;
    {
        private _distancePlayerRadio = _x distance player;
        if (_distancePlayerRadio <= _currentMinimalDistance) then
        {
            _currentMinimalDistance = _distancePlayerRadio;
        };
    } forEach _all_radios;
} forEach colsog_triangulation_itemsToDetect;

// Convert into signal intensity
if (_currentMinimalDistance >= 5000) exitWith
{
    hint "No signal detected";
};
if (_currentMinimalDistance >= colsog_triangulation_signalStrength2 && _currentMinimalDistance < colsog_triangulation_signalStrength1) exitWith
{
    hint "Signal strength: 1/5";
};
if (_currentMinimalDistance >= colsog_triangulation_signalStrength3 && _currentMinimalDistance < colsog_triangulation_signalStrength2) exitWith
{
    hint "Signal strength: 2/5";
};
if (_currentMinimalDistance >= colsog_triangulation_signalStrength4 && _currentMinimalDistance < colsog_triangulation_signalStrength3) exitWith
{
    hint "Signal strength: 3/5";
};
if (_currentMinimalDistance >= colsog_triangulation_signalStrength5 && _currentMinimalDistance < colsog_triangulation_signalStrength4) exitWith
{
    hint "Signal strength: 4/5";
};
if (_currentMinimalDistance >= 0 && _currentMinimalDistance < colsog_triangulation_signalStrength5) exitWith
{
    hint "Signal strength: 5/5";
};