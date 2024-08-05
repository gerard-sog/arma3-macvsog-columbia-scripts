// 5 minutes timeout between each call.
private _next_triangulation_time_seconds = LAST_TRIANGULATION_TIME_SECONDS + Columbia_CBA_triangulation_cool_down;
private _current_time_seconds = serverTime;
if (_current_time_seconds < _next_triangulation_time_seconds) exitWith
{
    private _cool_down = abs (_current_time_seconds - _next_triangulation_time_seconds);
    hint format ["Cool down : %1 seconds", round _cool_down];
};

LAST_TRIANGULATION_TIME_SECONDS = _current_time_seconds;
publicVariable "LAST_TRIANGULATION_TIME_SECONDS";

// For each, get distance to player and return shortest distance.
private _current_minimal_distance = 9999;

{
    private _all_radios = entities _x;
    {
        _distance_player_radio = _x distance player;
        if (_distance_player_radio <= _current_minimal_distance) then
        {
            _current_minimal_distance = _distance_player_radio;
        };
    } forEach _all_radios;
} forEach Columbia_CBA_triangulation_items_to_detect;

// Convert into signal intensity
if (_current_minimal_distance >= 5000) exitWith
{
    hint "No signal detected";
};
if (_current_minimal_distance >= Columbia_CBA_triangulation_signal_strength_2 && _current_minimal_distance < Columbia_CBA_triangulation_signal_strength_1) exitWith
{
    hint "Signal strength: 1/5";
};
if (_current_minimal_distance >= Columbia_CBA_triangulation_signal_strength_3 && _current_minimal_distance < Columbia_CBA_triangulation_signal_strength_2) exitWith
{
    hint "Signal strength: 2/5";
};
if (_current_minimal_distance >= Columbia_CBA_triangulation_signal_strength_4 && _current_minimal_distance < Columbia_CBA_triangulation_signal_strength_3) exitWith
{
    hint "Signal strength: 3/5";
};
if (_current_minimal_distance >= Columbia_CBA_triangulation_signal_strength_5 && _current_minimal_distance < Columbia_CBA_triangulation_signal_strength_4) exitWith
{
    hint "Signal strength: 4/5";
};
if (_current_minimal_distance >= 0 && _current_minimal_distance < Columbia_CBA_triangulation_signal_strength_5) exitWith
{
    hint "Signal strength: 5/5";
};