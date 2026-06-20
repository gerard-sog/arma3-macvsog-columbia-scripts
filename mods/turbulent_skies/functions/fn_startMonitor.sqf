/*
    Starts local turbulence loops for this player while inside a helicopter.

    Camera shake:
    - applied locally to every player inside the helicopter

    Physics force:
    - started separately
    - only applies force where helicopter is local
*/

params ["_unit", "_heli"];

if !(isNil {_unit getVariable "TS_seatMonitorHandle"}) exitWith {};

private _monitor = [_unit, _heli] spawn {

    params ["_unit", "_heli"];

    while {
        alive _unit &&
        {vehicle _unit == _heli}
    } do {

        if (isNil {_unit getVariable "TS_cameraHandle"}) then {

            if (TS_debug_enabled) then {
                systemChat "[TS] Turbulence camera loop started";
            };

            private _cameraHandle =
                [_heli] spawn TS_fnc_startTurbulence;

            _unit setVariable ["TS_cameraHandle", _cameraHandle];
        };

        if (
            isNil {_unit getVariable "TS_physicsHandle"} &&
            {[_unit] call TS_fnc_isPilotOrCopilot}
        ) then {

            if (TS_debug_enabled) then {
                systemChat "[TS] Turbulence physics loop started";
            };

            private _physicsHandle =
                [_heli] spawn TS_fnc_startTurbulencePhysics;

            _unit setVariable ["TS_physicsHandle", _physicsHandle];
        };

        sleep 0.5;
    };

    private _cameraHandle =
        _unit getVariable ["TS_cameraHandle", scriptNull];

    private _physicsHandle =
        _unit getVariable ["TS_physicsHandle", scriptNull];

    if !(isNull _cameraHandle) then {
        terminate _cameraHandle;
    };

    if !(isNull _physicsHandle) then {
        terminate _physicsHandle;
    };

    _unit setVariable ["TS_cameraHandle", nil];
    _unit setVariable ["TS_physicsHandle", nil];
    _unit setVariable ["TS_seatMonitorHandle", nil];

    if (TS_debug_enabled) then {
        systemChat "[TS] Seat monitor stopped";
    };
};

_unit setVariable ["TS_seatMonitorHandle", _monitor];