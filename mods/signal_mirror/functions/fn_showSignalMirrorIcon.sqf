params ["_pos"];

private _texture = selectRandom [
    "\signal_mirror\assets\signal_glint_01_ca.paa",
    "\signal_mirror\assets\signal_glint_02_ca.paa",
    "\signal_mirror\assets\signal_glint_03_ca.paa",
    "\signal_mirror\assets\signal_glint_04_ca.paa"
];

private _ehID = addMissionEventHandler [
    "Draw3D",
    {
        _thisArgs params ["_pos", "_texture"];

        private _dist = cameraOn distance _pos;
        private _size = (_dist / 400) max 1.5 min 5;

        drawIcon3D [
            _texture,
            [1,1,1,1],
            _pos,
            _size,
            _size,
            random 360,
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
    [_pos, _texture]
];

[_ehID] spawn {
    params ["_ehID"];
    sleep 0.6;
    removeMissionEventHandler ["Draw3D", _ehID];
};