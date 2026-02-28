/*
 *    Player Footprint Visibility System
 *    - Evaluates stance + speed every X seconds
 *    - Accumulates a stealth score
 *    - Spawns a marker if threshold exceeded
 */

// ===========
// FUNCTIONS |
// ===========

/*
 *   Returns a numeric factor based on unit speed.
 */
fnc_getSpeedFactor = {
    params ["_unit"];
    private _speed = speed _unit;

    switch (true) do {
        case (_speed < 1):  { 0 };      // idle
        case (_speed < 6):  { 0.5 };    // walking
        case (_speed < 15): { 4 };      // jogging
        default           { 5 };        // sprinting
    };
};

/*
 *   Returns a numeric factor based on stance.
 *   3 = standing (most visible)
 *   2 = crouching
 *   1 = prone (stealthiest)
 */
fnc_getStanceFactor = {
    params ["_unit"];

    switch (stance _unit) do {
        case "STAND":  { colsog_hunting_stanceFactorStand };
        case "CROUCH": { colsog_hunting_stanceFactorCrouch };
        case "PRONE":  { colsog_hunting_stanceFactorProne };
        default        { colsog_hunting_stanceFactorDefault };
    };
};

/*
 *   Spawns an invisible marker on map and deletes it after TTL.
 */
fnc_spawnFootprintMarker = {
    params ["_unit"];

    private _markerSpawnTime = round serverTime;
    private _markerUniqueId = format [
        "COLSOG_PREY_NAME:%1, COLSOG_MARKER_TIME:%2",
        name _unit,
        _markerSpawnTime
    ];

    private _marker = createMarker [_markerUniqueId, _unit];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorBlue";

    if (colsog_hunting_debugMode) then {
        _marker setMarkerText str(_markerSpawnTime);
        _marker setMarkerAlpha 1;
    } else {
        _marker setMarkerAlpha 0;
    };

    // Delete marker after TTL
    private _markerTTL = serverTime + colsog_hunting_markerTTL;
    [
        { (_this select 0) < serverTime },
        { deleteMarker (_this select 1) },
        [_markerTTL, _marker]
    ] call CBA_fnc_waitUntilAndExecute;
};

// ===========
// MAIN LOOP |
// ===========

if (player getVariable ["visibleFootprint", false]) then {
    [
        {
            if (vehicle player == player) then {
                private _currentFootprintScore = player getVariable ["currentFootprintScore", 0];

                private _speedFactor  = [player] call fnc_getSpeedFactor;
                private _stanceFactor = [player] call fnc_getStanceFactor;

                private _value = _stanceFactor * _speedFactor;
                _currentFootprintScore = _currentFootprintScore + _value;

                if (_currentFootprintScore >= colsog_hunting_scoreThreshold) then {
                    player setVariable ["currentFootprintScore", 0, false];
                    [player] call fnc_spawnFootprintMarker;
                } else {
                    player setVariable ["currentFootprintScore", _currentFootprintScore, false];
                };
            };
        },
        1, // checked every seconds.
        []
    ] call CBA_fnc_addPerFrameHandler;
};
