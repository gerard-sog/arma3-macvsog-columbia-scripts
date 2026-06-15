params ["_unit", "_heli"];

if (isNull _unit || {isNull _heli}) exitWith {};
if (!alive _unit) exitWith {};
if !(_heli isKindOf "Helicopter") exitWith {};
if (vehicle _unit != _heli) exitWith {};

if (!isServer) exitWith {
	[_unit, _heli] remoteExecCall ["Dash_fnc_DropStaboRope", 2];
};

if (_heli getVariable ["APR_STABO_Deployed", false]) exitWith {};

_heli setVariable ["APR_STABO_Deployed", true, true];
_heli setVariable ["APR_STABO_Using_Player_Chain", ([_heli] call Dash_fnc_HasAttachedPlayers), true];

private _pos = getPosATL _heli;
_pos set [2, 0];

private _droppedSandbag = APR_STABO_SANDBAG_CLASS createVehicle ATLToASL _pos;
_droppedSandbag allowDamage false;

private _rope = ropeCreate [
	_heli,
	[0, 0, 0],
	_droppedSandbag,
	[0, 0, 0],
	APR_STABO_ROPE_LENGTH,
	nil,
	nil,
	nil,
	63
];
_rope allowDamage false;

_heli setVariable ["APR_STABO_Rope", _rope, true];
_heli setVariable ["APR_STABO_DroppedSandbag", _droppedSandbag, true];

[
	{(getPosATL (_this select 0) select 2) <= 0.25},
	{
		params ["_droppedSandbag", "_heli"];

		if (!(_heli getVariable ["APR_STABO_Deployed", false])) exitWith {};

		["Sandbag touching ground!", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", crew _heli];
		[_droppedSandbag, true] remoteExec ["hideObjectGlobal", 2];

		private _frozenSandbag = APR_STABO_SANDBAG_CLASS createVehicle getPosATL _droppedSandbag;
		_frozenSandbag allowDamage false;
		_frozenSandbag enableSimulationGlobal false;
		_frozenSandbag setVariable ["APR_STABO_ParentHelicopter", _heli, true];

		_heli setVariable ["APR_STABO_Sandbag", _frozenSandbag, true];
		_heli setVariable ["APR_STABO_ActionPoint", _frozenSandbag, true];

		[_frozenSandbag] remoteExecCall ["Dash_fnc_AddSandbagHoldAction", 0, _frozenSandbag];

		[_heli, _droppedSandbag, _frozenSandbag] remoteExecCall [
			"Dash_fnc_ServerKeepSandbagPinned",
			2
		];

		[
			{params ["_frozenSandbag", "_heli"]; (_frozenSandbag distance _heli) >= (APR_STABO_ROPE_LENGTH + 5)},
			{params ["_frozenSandbag", "_heli"]; [_heli, _frozenSandbag] call Dash_fnc_BreakDeployRope;},
			[_frozenSandbag, _heli]
		] call CBA_fnc_waitUntilAndExecute;
	},
	[_droppedSandbag, _heli]
] call CBA_fnc_waitUntilAndExecute;
