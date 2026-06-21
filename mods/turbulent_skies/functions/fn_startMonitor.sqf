/*
    Turbulent Skies
    Starts local turbulence loops for this player while inside a helicopter.

    Camera shake:
    - applied locally to every player inside the helicopter

    Physics force:
    - started separately
    - only applies force where helicopter is local
*/

params [
    ["_unit", objNull, [objNull]],
    ["_heli", objNull, [objNull]]
];

if (isNull _unit || {isNull _heli}) exitWith {};
if !(_heli isKindOf "Helicopter") exitWith {};

// Always clean previous handles first so switching helicopters never leaves stale state.
[_unit] call TS_fnc_cleanupTurbulence;

_unit setVariable ["TS_currentHeli", _heli];

private _monitorHandle = [_unit, _heli] spawn {
    params ["_unit", "_heli"];

    [format ["Seat monitor started for %1", typeOf _heli]] call TS_fnc_debug;

    while {
        alive _unit &&
        {alive _heli} &&
        {vehicle _unit isEqualTo _heli}
    } do {

        if (isNil {_unit getVariable "TS_cameraHandle"}) then {
            private _cameraHandle = [_heli] spawn TS_fnc_startTurbulence;

            _unit setVariable ["TS_cameraHandle", _cameraHandle];

            ["Camera turbulence loop started"] call TS_fnc_debug;
        };

        if (
            isNil {_unit getVariable "TS_physicsHandle"} &&
            {[_unit] call TS_fnc_isPilotOrCopilot}
        ) then {
            private _physicsHandle = [_heli] spawn TS_fnc_startTurbulencePhysics;

            _unit setVariable ["TS_physicsHandle", _physicsHandle];

            ["Physics turbulence loop started"] call TS_fnc_debug;
        };

        sleep 0.5;
    };

    private _cameraHandle = _unit getVariable ["TS_cameraHandle", scriptNull];
    private _physicsHandle = _unit getVariable ["TS_physicsHandle", scriptNull];

    if !(isNull _cameraHandle) then {
        terminate _cameraHandle;
    };

    if !(isNull _physicsHandle) then {
        terminate _physicsHandle;
    };

    _unit setVariable ["TS_cameraHandle", nil];
    _unit setVariable ["TS_physicsHandle", nil];
    _unit setVariable ["TS_currentHeli", nil];
    _unit setVariable ["TS_seatMonitorHandle", nil];

    ["Seat monitor stopped"] call TS_fnc_debug;
};

_unit setVariable ["TS_seatMonitorHandle", _monitorHandle];
