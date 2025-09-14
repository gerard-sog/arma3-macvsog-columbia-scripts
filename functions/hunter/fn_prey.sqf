[
    {
        _markerSpawnTime = round serverTime;
        _markerUniqueId = "COLSOG_PREY_NAME:" + name player + ", COLSOG_MARKER_TIME:"+  str(_markerSpawnTime);
        private _marker = createMarker [_markerUniqueId, player];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBlue";

        if (colsog_hunting_debugMode) then {
            _marker setMarkerText str(_markerSpawnTime);
            _marker setMarkerAlpha 1;
        } else {
            _marker setMarkerAlpha 0;
        };

        // Marker lives in seconds.
        private _markerTTL = serverTime + colsog_hunting_markerTTL;
        [
            { (_this select 0) < serverTime },
            {
                private _marker = _this select 1;
                deleteMarker _marker;
            },
            [_markerTTL, _marker]
        ] call CBA_fnc_waitUntilAndExecute;
    },
    colsog_hunting_markerSpawnTime,
    []
] call CBA_fnc_addPerFrameHandler;