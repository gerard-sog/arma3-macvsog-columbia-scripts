params ["_pos"];

private _ehID = addMissionEventHandler [
    "Draw3D",
    {
        _thisArgs params ["_pos"];

        private _dist = player distance _pos;
        private _k = 10 / (_dist max 1);

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
    sleep 0.3;
    removeMissionEventHandler ["Draw3D", _ehID];
};