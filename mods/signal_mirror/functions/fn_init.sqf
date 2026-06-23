if (!hasInterface) exitWith {};

// Shows or hides the reticle overlay.
SM_fnc_updateSignalMirrorOverlay = {
    private _shouldShow =
        currentWeapon player == "SM_SignalMirror"
        && {cameraView == "GUNNER"};

    private _overlayVisible = uiNamespace getVariable ["SM_SignalMirrorOverlay_Visible", false];

    if (_shouldShow && {!_overlayVisible}) then {
        "SM_SignalMirrorOverlay" cutRsc ["SM_SignalMirrorOverlay", "PLAIN", 0, false];
        uiNamespace setVariable ["SM_SignalMirrorOverlay_Visible", true];
    };

    if (!_shouldShow && {_overlayVisible}) then {
        "SM_SignalMirrorOverlay" cutText ["", "PLAIN"];
        uiNamespace setVariable ["SM_SignalMirrorOverlay_Visible", false];
    };
};

SM_SignalMirrorOverlay_PFH = -1;

["weapon", {
    params ["_unit", "_weapon"];

    if (_weapon == "SM_SignalMirror") then {
        [_unit] call SM_fnc_startAirScanner;

        if (SM_SignalMirrorOverlay_PFH < 0) then {
            SM_SignalMirrorOverlay_PFH = [
                {
                    [] call SM_fnc_updateSignalMirrorOverlay;
                },
                0.1
            ] call CBA_fnc_addPerFrameHandler;
        };
    } else {
        if (SM_SignalMirrorOverlay_PFH >= 0) then {
            [SM_SignalMirrorOverlay_PFH] call CBA_fnc_removePerFrameHandler;
            SM_SignalMirrorOverlay_PFH = -1;
        };

        "SM_SignalMirrorOverlay" cutText ["", "PLAIN"];
        uiNamespace setVariable ["SM_SignalMirrorOverlay_Visible", false];
    };
}, true] call CBA_fnc_addPlayerEventHandler;