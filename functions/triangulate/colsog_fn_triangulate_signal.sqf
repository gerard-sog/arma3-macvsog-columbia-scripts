// Check if ACRE spike required and nearby.
private _isAcreSpikeConditionOk = [player] call COLSOG_fnc_isAcreSpikeRequiredAndNearby;

if (not (_isAcreSpikeConditionOk)) exitWith {
    hint format ["No ground spike nearby"];
};

// 5 minutes timeout between each call.
private _nextTriangulationTimeSeconds = COLSOG_lastTriangulationTimeSeconds + colsog_triangulation_coolDown;
private _currentTimeSeconds = serverTime;
if (_currentTimeSeconds < _nextTriangulationTimeSeconds) exitWith
{
    private _coolDown = abs (_currentTimeSeconds - _nextTriangulationTimeSeconds);
    hint format ["Cool down : %1 seconds", round _coolDown];
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