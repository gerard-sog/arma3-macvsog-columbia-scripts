params ["_heli"];

if (isNull _heli) exitWith {};

if (!isServer) exitWith {
	[_heli] remoteExecCall ["Dash_fnc_DetachStabo", 2];
};

if ([_heli] call Dash_fnc_HasAttachedPlayers) exitWith {};

private _rope = _heli getVariable ["APR_STABO_Rope", objNull];
private _droppedSandbag = _heli getVariable ["APR_STABO_DroppedSandbag", objNull];
private _sandbag = _heli getVariable ["APR_STABO_Sandbag", objNull];

if (!isNull _rope) then { ropeDestroy _rope; };
if (!isNull _droppedSandbag) then { deleteVehicle _droppedSandbag; };

if (!isNull _sandbag) then {
	_sandbag setVariable ["APR_STABO_ParentHelicopter", nil, true];
	deleteVehicle _sandbag;
};

[_heli] call Dash_fnc_ResetStaboState;
