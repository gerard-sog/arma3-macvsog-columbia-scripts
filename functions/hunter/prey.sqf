[
    {
        _markerUniqueId = "COLSOG_FOOTPRINT:" + name player + str(round serverTime);
        private _marker = createMarker [_markerUniqueId, player];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBlue";
        _marker setMarkerAlpha 1;

        // Marker lives for 30 sec.
        private _markerTTL = serverTime + 30;
        [
            { (_this select 0) < serverTime },
            {
                private _marker = _this select 1;
                deleteMarker _marker;
            },
            [_markerTTL, _marker]
        ] call CBA_fnc_waitUntilAndExecute;
    },
    5,
    []
] call CBA_fnc_addPerFrameHandler;