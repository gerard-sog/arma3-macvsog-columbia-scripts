params ["_unit"];

if (isNull _unit) exitWith {};

if (!isServer) exitWith {
	[_unit] remoteExecCall ["Dash_fnc_DetachUnitFromStabo", 2];
};

_unit setVariable ["APR_STABO_DetachRequested", true, true];