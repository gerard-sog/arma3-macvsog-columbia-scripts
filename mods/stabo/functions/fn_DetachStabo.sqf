params ["_heli"];

if (isNull _heli) exitWith {};

if (!isServer) exitWith {
	[_heli] remoteExecCall ["Dash_fnc_DetachStabo", 2];
};

/*
	Request detach for all units currently attached to this STABO rope.
*/
for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

	if (!isNull _unit) then {
		_unit setVariable ["APR_STABO_DetachRequested", true, true];
	};
};

/*
	If players are still attached, their client cleanup loop will remove them first.
	Do not destroy the main STABO objects yet.
*/
if ([_heli] call Dash_fnc_HasAttachedPlayers) exitWith {};

private _rope = _heli getVariable ["APR_STABO_Rope", objNull];
private _droppedSandbag = _heli getVariable ["APR_STABO_DroppedSandbag", objNull];
private _sandbag = _heli getVariable ["APR_STABO_Sandbag", objNull];

if (!isNull _rope) then {
	ropeDestroy _rope;
};

if (!isNull _droppedSandbag) then {
	deleteVehicle _droppedSandbag;
};

if (!isNull _sandbag) then {
	_sandbag setVariable ["APR_STABO_ParentHelicopter", nil, true];
	deleteVehicle _sandbag;
};

[_heli] call Dash_fnc_ResetStaboState;