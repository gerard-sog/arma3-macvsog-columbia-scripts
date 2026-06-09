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
                systemChat "[TS] Turbulence loop started";
            };

            private _handle =
                [_heli] spawn TS_fnc_startTurbulence;

            _unit setVariable ["TS_handle", _handle];
        };

        sleep 0.5;
    };

    private _handle =
        _unit getVariable ["TS_handle", scriptNull];

    if !(isNull _handle) then {
        terminate _handle;
    };

    _unit setVariable ["TS_handle", nil];
    _unit setVariable ["TS_seatMonitorHandle", nil];

    if (TS_debug_enabled) then {
        systemChat "[TS] Seat monitor stopped";
    };
};

_unit setVariable ["TS_seatMonitorHandle", _monitor];