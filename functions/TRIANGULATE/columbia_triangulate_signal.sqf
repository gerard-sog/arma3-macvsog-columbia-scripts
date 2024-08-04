// 5 minutes timeout between each call.
private _next_triangulation_time_seconds = LAST_TRIANGULATION_TIME_SECONDS + 300;
private _current_time_seconds = serverTime;
if (_current_time_seconds < _next_triangulation_time_seconds) exitWith
{
    private _cool_down = abs (_current_time_seconds - _next_triangulation_time_seconds);
    hint format ["Cool down : %1", _cool_down];
};

LAST_TRIANGULATION_TIME_SECONDS = _current_time_seconds;
publicVariable "LAST_TRIANGULATION_TIME_SECONDS";

// Finds all T884_01 and T102E radio in game.
_all_t884_radios = entities "vn_o_prop_t884_01";
_all_t102e_radios = entities "vn_o_prop_t102e_01";
_all_radios = _all_t884_radios + _all_t102e_radios;

// For each, get distance to player and return shortest distance.
private _current_minimal_distance = 9999;
{
    _distance_player_radio = _x distance player;
    if (_distance_player_radio <= _current_minimal_distance) then
    {
        _current_minimal_distance = _distance_player_radio;
    };
} forEach _all_radios;

// Convert into signal intensity
if (_current_minimal_distance >= 5000) exitWith
{
    hint "No signal detected";
};
if (_current_minimal_distance >= 4000 && _current_minimal_distance < 5000) exitWith
{
    hint "Signal strength: 1/5";
};
if (_current_minimal_distance >= 3000 && _current_minimal_distance < 4000) exitWith
{
    hint "Signal strength: 2/5";
};
if (_current_minimal_distance >= 2000 && _current_minimal_distance < 3000) exitWith
{
    hint "Signal strength: 3/5";
};
if (_current_minimal_distance >= 1000 && _current_minimal_distance < 2000) exitWith
{
    hint "Signal strength: 4/5";
};
if (_current_minimal_distance >= 0 && _current_minimal_distance < 1000) exitWith
{
    hint "Signal strength: 5/5";
};