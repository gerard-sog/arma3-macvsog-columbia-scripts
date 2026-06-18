params ["_unit"];

if (_unit getVariable ["SignalMirror_airScannerRunning", false]) exitWith {};

_unit setVariable ["SignalMirror_airScannerRunning", true];

[_unit] spawn {
    params ["_unit"];

    private _requiredWeapon = "vn_ak_01";
    private _range = 2000;
    private _maxAngle = 30;

    while {
        alive _unit
        && {currentWeapon _unit == _requiredWeapon}
    } do {
        private _camPos = positionCameraToWorld [0,0,0];
        private _forward = _camPos vectorFromTo (positionCameraToWorld [0,0,1]);

        private _best = objNull;
        private _bestAngle = 180;

        {
            if (
                alive _x
                && {_x isKindOf "Air"}
                && {_x distance _unit < _range}
                && {(getPosATL _x select 2) > 10}
            ) then {
                private _dir = _camPos vectorFromTo (aimPos _x);
                private _angle = acos ((_forward vectorDotProduct _dir) max -1 min 1);

                if (_angle < _bestAngle) then {
                    _bestAngle = _angle;
                    _best = _x;
                };
            };
        } forEach vehicles;

        if (isNull _best || {_bestAngle > _maxAngle}) then {
            hintSilent "No aircraft in sight";
        } else {
            hintSilent format [
                "Aircraft in sight\n\nType: %1\nAngle: %2°",
                typeOf _best,
                [_bestAngle, 1] call BIS_fnc_cutDecimals
            ];
        };

        sleep 0.2;
    };

    hintSilent "";
    _unit setVariable ["SignalMirror_airScannerRunning", false];
};