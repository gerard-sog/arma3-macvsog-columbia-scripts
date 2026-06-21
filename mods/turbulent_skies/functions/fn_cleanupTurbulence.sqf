/*
    Turbulent Skies
    Stops all local turbulence scripts attached to a unit.
*/

params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

private _monitorHandle = _unit getVariable ["TS_seatMonitorHandle", scriptNull];
private _cameraHandle = _unit getVariable ["TS_cameraHandle", scriptNull];
private _physicsHandle = _unit getVariable ["TS_physicsHandle", scriptNull];

if !(isNull _monitorHandle) then {
    terminate _monitorHandle;
};

if !(isNull _cameraHandle) then {
    terminate _cameraHandle;
};

if !(isNull _physicsHandle) then {
    terminate _physicsHandle;
};

_unit setVariable ["TS_seatMonitorHandle", nil];
_unit setVariable ["TS_cameraHandle", nil];
_unit setVariable ["TS_physicsHandle", nil];
_unit setVariable ["TS_currentHeli", nil];

["Turbulence scripts stopped"] call TS_fnc_debug;
