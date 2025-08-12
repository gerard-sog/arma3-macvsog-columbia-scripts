[
    {
        _battery = missionNamespace getVariable "TEST";
        _battery = _battery - 5;
        missionNamespace setVariable ["TEST", _battery, true];
    },
    5,
    []
] call CBA_fnc_addPerFrameHandler;