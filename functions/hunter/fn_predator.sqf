
params ["_player"];

[
    colsog_hunting_timeToFindFootprints,
    [_player],
    {
        params ["_args"];
        _args params ["_player"];

        if (colsog_hunting_debugMode) then {
            _debugMarkerSpawnTime = round serverTime;
            _debugMarkerUniqueId = "COLSOG_DEBUG_OPFOR_CIRLCE:" + name player + ", COLSOG_MARKER_TIME:"+  str(_debugMarkerSpawnTime);
            private _debugMarker = createMarker [_debugMarkerUniqueId, player];

            // Debug red search circle.
            _debugMarker setMarkerShape "ELLIPSE";
            _debugMarker setMarkerColor "ColorRed";
            _debugMarker setMarkerBrush "Border";
            _debugMarker setMarkerSize [colsog_hunting_FootprintsDetectionRangeFar, colsog_hunting_FootprintsDetectionRangeFar];

            private _debugMarkerTTL = serverTime + 30;
            [
                { (_this select 0) < serverTime },
                {
                    private _debugMarker = _this select 1;
                    deleteMarker _debugMarker;
                },
                [_debugMarkerTTL, _debugMarker]
            ] call CBA_fnc_waitUntilAndExecute;
        };

        private _prefix = "COLSOG_PREY_NAME:";
        private _key = "COLSOG_MARKER_TIME:";
        private _bestTimeNum = 0;
        private _bestDistance = colsog_hunting_FootprintsDetectionRangeFar;

        // [markerName, time, markerPos]
        private _freshestResult = [];

        // [markerName, time, markerPos]
        private _closestResult = [];

        // Find closest and freshest footprint.
        // ------------------------------------
        {
            private _markerName = _x;
            private _pos = getMarkerPos _markerName;

            // Check distance.
            private _distanceToPlayer = (getPos player) distance2D _pos;
            if (_distanceToPlayer <= colsog_hunting_FootprintsDetectionRangeFar) then {

                // Check prefix.
                if ((_markerName find _prefix) == 0) then {

                    if (_distanceToPlayer <= _bestDistance) then {

                        // Extract time.
                        private _i = _markerName find _key;
                        if (_i >= 0) then {
                            private _start   = _i + count _key;
                            private _timeStr = _markerName select [_start];
                            private _timeNum = parseNumber _timeStr;

                            _bestDistance = _distanceToPlayer;
                            _closestResult = [_markerName, _timeNum, _pos];
                        };
                    };

                    // Extract time.
                    private _i = _markerName find _key;
                    if (_i >= 0) then {
                        private _start   = _i + count _key;
                        private _timeStr = _markerName select [_start];
                        private _timeNum = parseNumber _timeStr;

                        if (_timeNum > _bestTimeNum) then {
                            _bestTimeNum = _timeNum;
                            _freshestResult = [_markerName, _timeNum, _pos];
                        };
                    };
                };
            };
        } forEach allMapMarkers;

        private _allMarkersInRange = [];
        private _maxDistance = (getPos player) distance2D _freshestResult#2;
        private _timeToBeat = _closestResult#1;

        // Keeps only markers in range, fresher than closest footprint.
        // ------------------------------------------------------------
        {
            private _markerName = _x;
            private _pos = getMarkerPos _markerName;

            // Check distance.
            private _distanceToPlayer = (getPos player) distance2D _pos;
            if (_distanceToPlayer <= colsog_hunting_FootprintsDetectionRangeFar) then {

                // Check prefix.
                if ((_markerName find _prefix) == 0) then {

                    // Extract time.
                    private _i = _markerName find _key;
                    if (_i >= 0) then {
                        private _start   = _i + count _key;
                        private _timeStr = _markerName select [_start];
                        private _timeNum = parseNumber _timeStr;

                        if (_timeNum >= _timeToBeat) then {
                            _allMarkersInRange append [_pos];
                        };
                    };
                };
            };
        } forEach allMapMarkers;


        if (count _closestResult != 0 && count _freshestResult != 0) then {
            private _closestMarkerPos = _closestResult#2;
            private _freshestMarkerPos = _freshestResult#2;
            private _playerPos = getPos player;

            // When within 50m of a track, receive information there is a track in the area.
            if (_bestDistance <= colsog_hunting_FootprintsDetectionRangeFar && _bestDistance > colsog_hunting_FootprintsDetectionRangeMedium) then {
                hint format ["There are footprints close by!"];
            };

            // When within 20m receive bearing to the nearest track (e.g. there is a track somewhere to the north west).
            if (_bestDistance <= colsog_hunting_FootprintsDetectionRangeMedium && _bestDistance > colsog_hunting_FootprintsDetectionRangeClose) then {
                // Direction from player to closest marker (0 = North, clockwise degrees)
                private _dir = _playerPos getDir _closestMarkerPos;

                // Show to player
                private _dist = round (_playerPos distance2D _closestMarkerPos);
                hint format ["Footprint in direction: %1°\nDistance: %2 m", round _dir, _dist];

                [_closestMarkerPos, 1] call COLSOG_fnc_showFootprint;
            };

            // When within 1m receive exact bearing to the next track (e.g. the tracks lead 157 degrees)
            if (_bestDistance <= colsog_hunting_FootprintsDetectionRangeClose) then {
                hint format ["Trail found"];
                [_allMarkersInRange] call COLSOG_fnc_showTrail;
            };
        } else {
            hint format ["No footprint detected..."];
        };
    },
    {},
    "Searching for footprints!"
] call ace_common_fnc_progressBar;
