
params ["_player"];

[
    colsog_hunting_blufor_timeToFindFootprints,
    [_player],
    {
        params ["_args"];
        _args params ["_player"];

        if (colsog_hunting_blufor_debugMode) then {
            _debugMarkerSpawnTime = round serverTime;
            _debugMarkerUniqueId = "COLSOG_DEBUG_OPFOR_CIRLCE:" + name player + ", COLSOG_MARKER_TIME:"+  str(_debugMarkerSpawnTime);
            private _debugMarker = createMarker [_debugMarkerUniqueId, player];

            // Debug red search circle.
            _debugMarker setMarkerShape "ELLIPSE";
            _debugMarker setMarkerColor "ColorRed";
            _debugMarker setMarkerBrush "Border";
            _debugMarker setMarkerSize [colsog_hunting_blufor_FootprintsDetectionRange, colsog_hunting_blufor_FootprintsDetectionRange];

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

        private _prefix = "COLSOG_TRAIL_NAME";

        // Find all markers in range.
        // ------------------------------------
        private _allMarkersInRange = [];

        // Keeps only markers in range, fresher than closest footprint.
        // ------------------------------------------------------------
        {
            private _markerName = _x;
            private _pos = getMarkerPos _markerName;

            // Check distance.
            private _distanceToPlayer = (getPos player) distance2D _pos;
            if (_distanceToPlayer <= colsog_hunting_blufor_FootprintsDetectionRange) then {
                // Check prefix.
                if ((_markerName find _prefix) == 0) then {
                    _allMarkersInRange append [_pos];
                };
            };
        } forEach allMapMarkers;

        if (count _allMarkersInRange != 0) then {
            hint format ["You spot a trail!"];
            [_allMarkersInRange] call COLSOG_fnc_showTrail;
        } else {
            hint format ["No footprint detected..."];
        };
    },
    {},
    "Searching for footprints!"
] call ace_common_fnc_progressBar;
