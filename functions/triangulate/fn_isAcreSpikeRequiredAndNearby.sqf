/*
 * Returns True if "vhf30108spike" is required and nearby (closer than 10 meters away).
 *
 * Arguments:
 * 0: player triggering action (Object).
 *
 * Return values:
 * Boolean
 */

params ["_player"];

private _result = true;

if (colsog_triangulation_requireAcreSpike) then {
    private _nearestAcreSpike = nearestObject [_player, "vhf30108spike"];

    if (isNull _nearestAcreSpike) then {
        _result = false;
    } else {
        private _distanceToNearestAcreSpike = _player distance _nearestAcreSpike;
        if (_distanceToNearestAcreSpike <= 10) then {
            _result = true;
        } else {
            _result = false;
        };
    };
};
_result;
