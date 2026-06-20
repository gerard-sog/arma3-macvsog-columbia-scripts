/*
    Starts one local turbulence loop for this player while inside a helicopter.

    The turbulence function itself decides:
    - who applies physics: only local helicopter owner
    - who gets camera shake: everyone in crew
*/

params ["_unit", "_heli"];

if !(isNil {_unit getVariable "TS_seatMonitorHandle"}) exitWith {};

private _monitor = [_unit, _heli] spawn {

    params ["_unit", "_heli"];

    while {
        alive _unit &&
        {vehicle _unit == _heli}
    } do {

        if (isNil {_unit getVariable "TS_handle"}) then {

            if (TS_debug_enabled) then {
                systemChat "[TS] Turbulence camera loop started";
            };

            private _handle =
                [_heli] spawn TS_fnc_startTurbulence;

            _unit setVariable ["TS_handle", _handle];
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

        if (
            !(isNil {_unit getVariable "TS_physicsHandle"}) &&
            {!([_unit] call TS_fnc_isPilotOrCopilot)}
        ) then {

            private _physicsHandle =
                _unit getVariable ["TS_physicsHandle", scriptNull];

            if !(isNull _physicsHandle) then {
                terminate _physicsHandle;
            };

            _unit setVariable ["TS_physicsHandle", nil];
        };

        sleep 0.5;
    };

    private _handle =
        _unit getVariable ["TS_handle", scriptNull];

    if !(isNull _handle) then {
        terminate _handle;
    };

    private _physicsHandle =
        _unit getVariable ["TS_physicsHandle", scriptNull];

    if !(isNull _physicsHandle) then {
        terminate _physicsHandle;
    };

    _unit setVariable ["TS_handle", nil];
    _unit setVariable ["TS_physicsHandle", nil];
    _unit setVariable ["TS_seatMonitorHandle", nil];

    if (TS_debug_enabled) then {
        systemChat "[TS] Seat monitor stopped";
    };
};

_unit setVariable ["TS_seatMonitorHandle", _monitor];