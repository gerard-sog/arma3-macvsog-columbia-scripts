params ["_pos"];

private _ehID = addMissionEventHandler [
    "Draw3D",
    {
        _thisArgs params ["_pos"];

        private _dist = cameraOn distance _pos;
        private _size = (_dist / 200) max 2 min 10;

        drawIcon3D [
            "\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa",
            [1,1,1,1],
            _pos,
            _size,
            _size,
            0,
            "",
            0,
            0.1,
            "RobotoCondensed",
            "center",
            true,
            0,
            0
        ];
    },
    [_pos]
];

[_ehID] spawn {
    params ["_ehID"];
    sleep 0.6;
    removeMissionEventHandler ["Draw3D", _ehID];
};