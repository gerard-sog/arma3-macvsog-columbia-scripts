
params ["_player"];

private _prefix = "COLSOG_PREY_NAME:";
private _key = "COLSOG_MARKER_TIME:";
private _range = 200;
private _bestTimeNum = 0;

// [markerName, time, markerPos]
private _result = [];

{
    private _markerName = _x;
    private _pos = getMarkerPos _markerName;

    // Check distance.
    if ((getPos player) distance2D _pos <= _range) then {

        // Check prefix.
        if ((_markerName find _prefix) == 0) then {

            // Extract time.
            private _i = _markerName find _key;
            if (_i >= 0) then {
                private _start   = _i + count _key;
                private _timeStr = _markerName select [_start];
                private _timeNum = parseNumber _timeStr;

                if (_timeNum > _bestTimeNum) then {
                    _bestTimeNum = _timeNum;
                    _result = [_markerName, _timeNum, _pos];
                };
            };
        };
    };

} forEach allMapMarkers;

if (count _result != 0) then {
    private _markerPos = _result#2;
    private _playerPos = getPos player;

    // Direction from player to marker (0 = North, clockwise degrees)
    private _dir = _playerPos getDir _markerPos;

    // Show to player
    private _dist = round (_playerPos distance2D _markerPos);
    hint format ["Direction: %1°\nDistance: %2 m", round _dir, _dist];
};


