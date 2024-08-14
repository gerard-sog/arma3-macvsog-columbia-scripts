// 5 minutes timeout between each call.
private _nextTriangulationTimeSeconds = COLSOG_lastTriangulationTimeSeconds + Columbia_CBA_triangulation_cool_down;
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
} forEach Columbia_CBA_triangulation_items_to_detect;

// Convert into signal intensity
if (_currentMinimalDistance >= 5000) exitWith
{
    hint "No signal detected";
};
if (_currentMinimalDistance >= Columbia_CBA_triangulation_signal_strength_2 && _currentMinimalDistance < Columbia_CBA_triangulation_signal_strength_1) exitWith
{
    hint "Signal strength: 1/5";
};
if (_currentMinimalDistance >= Columbia_CBA_triangulation_signal_strength_3 && _currentMinimalDistance < Columbia_CBA_triangulation_signal_strength_2) exitWith
{
    hint "Signal strength: 2/5";
};
if (_currentMinimalDistance >= Columbia_CBA_triangulation_signal_strength_4 && _currentMinimalDistance < Columbia_CBA_triangulation_signal_strength_3) exitWith
{
    hint "Signal strength: 3/5";
};
if (_currentMinimalDistance >= Columbia_CBA_triangulation_signal_strength_5 && _currentMinimalDistance < Columbia_CBA_triangulation_signal_strength_4) exitWith
{
    hint "Signal strength: 4/5";
};
if (_currentMinimalDistance >= 0 && _currentMinimalDistance < Columbia_CBA_triangulation_signal_strength_5) exitWith
{
    hint "Signal strength: 5/5";
};