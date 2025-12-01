/*
 * Returns the time stamp present in the marker name..
 *
 * Arguments:
 * 0: marker name (string)
 *
 * Return values:
 * integer.
 */

params ["_markerName"];

private _key = "COLSOG_MARKER_TIME:";

private _timeNum = -1;

// Extract time.
private _i = _markerName find _key;
if (_i >= 0) then {
    private _start   = _i + count _key;
    private _timeStr = _markerName select [_start];
    _timeNum = parseNumber _timeStr;
};

_timeNum;
