params ["_pos"];

private _ehID = addMissionEventHandler [
    "Draw3D",
    {
        _thisArgs params ["_pos"];
        private _k = 10 / (player distance _pos);

        drawIcon3D [
            "\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa",
            [1, 1, 1, 1],
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
    },
    [_pos]
];

[_ehID] spawn {
    params ["_ehID"];
    sleep colsog_hunting_timeToFindFootprints;
    removeMissionEventHandler ["Draw3D", _ehID];
};
