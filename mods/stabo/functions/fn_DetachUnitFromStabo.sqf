params ["_unit"];

if (isNull _unit) exitWith {};

if (!isServer) exitWith {
	[_unit] remoteExecCall ["Dash_fnc_DetachUnitFromStabo", 2];
};

_unit setVariable ["AR_Detach_Rope", true, true];
