params ["_unit", "_heli"];

if (isNull _unit || {isNull _heli}) exitWith {};
if (!alive _unit) exitWith {};
if (vehicle _unit != _unit) exitWith {};
if (!isPlayer _unit && {isNull remoteControlled _unit}) exitWith {};
if !(_heli isKindOf "Helicopter") exitWith {};
if !(_heli getVariable ["APR_STABO_Deployed", false]) exitWith {};

if (!isServer) exitWith {
	[_unit, _heli] remoteExecCall ["Dash_fnc_PickupRope", 2];
};

if (_unit getVariable ["APR_STABO_IsAttached", false]) exitWith {};

private _rappelPoint = [0, 0, -1.5];

private _slotIndex = [_heli] call Dash_fnc_FindFreeSlot;

if (_slotIndex < 0) exitWith {
	private _message = format ["All STABO rope segments are occupied (%1/%1).", call APR_STABO_GetSlotCount];

	if (isPlayer _unit) then {
		[_message, -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", owner _unit];
	} else {
		private _controller = remoteControlled _unit;

		if (!isNull _controller) then {
			[_message, -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", owner _controller];
		};
	};
};

private _targetOwner = owner _unit;

if (!isPlayer _unit) then {
	private _controller = remoteControlled _unit;

	if (!isNull _controller) then {
		_targetOwner = owner _controller;
	};
};

_heli setVariable ["APR_STABO_Using_Player_Chain", true, true];
_heli setVariable ["APR_STABO_Player_" + str _slotIndex, _unit, true];

_unit setVariable ["APR_STABO_IsAttached", true, true];
_unit setVariable ["APR_STABO_DetachRequested", false, true];
_unit setVariable ["APR_STABO_Vehicle", _heli, true];
_unit setVariable ["APR_STABO_SlotIndex", _slotIndex, true];

private _oldKilledEH = _unit getVariable ["APR_STABO_KilledEH", -1];

if (_oldKilledEH >= 0) then {
	_unit removeEventHandler ["Killed", _oldKilledEH];
};

private _killedEH = _unit addEventHandler ["Killed", {
	params ["_unit"];

	_unit setVariable ["APR_STABO_DetachRequested", true, true];
}];

_unit setVariable ["APR_STABO_KilledEH", _killedEH, true];

[_unit, _heli, _rappelPoint, _slotIndex] remoteExec ["Dash_fnc_ClientPickupRope", _targetOwner];

[_unit, _heli, _slotIndex] spawn {
	params ["_unit", "_heli", "_slotIndex"];

	waitUntil {
		sleep 2;
		!alive _unit || {!(_unit getVariable ["APR_STABO_IsAttached", false])}
	};

	private _killedEH = _unit getVariable ["APR_STABO_KilledEH", -1];

	if (_killedEH >= 0) then {
		_unit removeEventHandler ["Killed", _killedEH];
	};

	_unit setVariable ["APR_STABO_KilledEH", nil, true];

	_heli setVariable ["APR_STABO_Player_" + str _slotIndex, nil, true];

	[_heli] call Dash_fnc_UpdateStaboDownwardForce;

	[_heli] call Dash_fnc_RefreshBottomRopes;

	if (!([_heli] call Dash_fnc_HasAttachedPlayers)) then {
		_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];
	};
};