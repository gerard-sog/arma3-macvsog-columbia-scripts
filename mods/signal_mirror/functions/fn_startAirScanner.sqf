params ["_unit"];

if (!hasInterface) exitWith {};
if (!local _unit) exitWith {};

if (_unit getVariable ["SM_airScannerRunning", false]) exitWith {};

_unit setVariable ["SM_airScannerRunning", true];

[_unit] spawn {
    params ["_unit"];

    private _requiredWeapon = "SM_SignalMirror";
    private _range = 2500;
    private _maxAngle = 30;

    while {
        hasInterface
        && {alive _unit}
        && {local _unit}
        && {currentWeapon _unit == _requiredWeapon}
        && {vehicle _unit == _unit}
    } do {
        if (sunOrMoon < SM_SUN_THRESHOLD) then {
            sleep 0.2;
            continue;
        };

        if (SM_REQUIRE_SUN_LOS) then {
            private _sunDir = getLighting select 2;
            private _sunPosASL = eyePos _unit vectorAdd ((_sunDir vectorMultiply -1) vectorMultiply 10000);

            if (
                lineIntersectsSurfaces [
                    eyePos _unit,
                    _sunPosASL,
                    _unit,
                    objNull,
                    true,
                    1,
                    "GEOM",
                    "NONE"
                ] isNotEqualTo []
            ) then {
                sleep 0.2;
                continue;
            };
        };

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

        if (!isNull _best && {_bestAngle <= _maxAngle}) then {
            private _signalPos = getPosATLVisual _unit vectorAdd [0,0,1.6];

            {
                if (isPlayer _x) then {
                    [_signalPos] remoteExecCall [
                        "SM_fnc_showSignalMirrorIcon",
                        owner _x
                    ];
                };
            } forEach crew _best;
        };

        sleep 0.2;
    };

    hintSilent "";
    _unit setVariable ["SM_airScannerRunning", false];
};