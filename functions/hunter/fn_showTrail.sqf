params ["_allMarkersInRange"];

private _ehID = addMissionEventHandler [
    "Draw3D",

    {
        // Unpack arguments provided to Draw3D
        _thisArgs params ["_allMarkersInRange"];

        {
            private _pos = _x;

            private _dist = player distance _pos;

            if (_dist < 0.01) exitWith {};

            private _k = 10 / _dist;

            // Alpha goes from 1 (close) to 0 (max range)
            private _alpha = 1 - (_dist / colsog_hunting_FootprintsDetectionRangeFar);
            _alpha = _alpha max 0 min 1;

            drawIcon3D [
                "\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa",
                [1, 1, 1, _alpha],
                _pos,
                1 * _k,
                1 * _k,
                0,
                "",
                0,
                0.04 * _k,
                "RobotoCondensed",
                "center",
                false,
                0,
                0
            ];
        } forEach _allMarkersInRange;
    },

    [_allMarkersInRange]
];

[_ehID] spawn {
    params ["_ehID"];
    sleep 10;
    removeMissionEventHandler ["Draw3D", _ehID];
};