params ["_heli", "_sandbag"];

if (isNull _heli) exitWith {};

if (!isServer) exitWith {
	[_heli, _sandbag] remoteExecCall ["Dash_fnc_BreakDeployRope", 2];
};

if (!(_heli getVariable ["APR_STABO_Deployed", false])) exitWith {};

["Rope broke!", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", crew _heli];

private _rope = _heli getVariable ["APR_STABO_Rope", objNull];
private _droppedSandbag = _heli getVariable ["APR_STABO_DroppedSandbag", objNull];
private _frozenSandbag = _heli getVariable ["APR_STABO_Sandbag", _sandbag];

if (!isNull _rope) then { ropeDestroy _rope; };
if (!isNull _droppedSandbag) then { deleteVehicle _droppedSandbag; };

if (!isNull _frozenSandbag) then {
	_frozenSandbag setVariable ["APR_STABO_ParentHelicopter", nil, true];
	deleteVehicle _frozenSandbag;
};

_heli setVariable ["APR_STABO_Rope", objNull, true];
_heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
_heli setVariable ["APR_STABO_Sandbag", objNull, true];
_heli setVariable ["APR_STABO_ActionPoint", objNull, true];
_heli setVariable ["APR_STABO_Deployed", false, true];
_heli setVariable ["APR_STABO_Using_Player_Chain", ([_heli] call Dash_fnc_HasAttachedPlayers), true];
