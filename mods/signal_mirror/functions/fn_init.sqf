if (!hasInterface) exitWith {};

["weapon", {
    params ["_unit", "_weapon"];

    if (_weapon == "SM_SignalMirror") then {
        [_unit] call SM_fnc_startAirScanner;
    };
}, true] call CBA_fnc_addPlayerEventHandler;

// Reticle overlay while aiming with signal mirror
[] spawn {
    private _overlayVisible = false;

    while {true} do {
        private _shouldShow =
            currentWeapon player == "SM_SignalMirror"
            && {cameraView == "GUNNER"};

        if (_shouldShow && {!_overlayVisible}) then {
            "SM_SignalMirrorOverlay" cutRsc ["SM_SignalMirrorOverlay", "PLAIN", 0, false];
            _overlayVisible = true;
        };

        if (!_shouldShow && {_overlayVisible}) then {
            "SM_SignalMirrorOverlay" cutText ["", "PLAIN"];
            _overlayVisible = false;
        };

        sleep 0.1;
    };
};