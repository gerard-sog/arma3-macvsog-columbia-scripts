params ["_unit", "_heli"];

if (isNull _unit || {isNull _heli}) exitWith {};
if (!alive _unit) exitWith {};
if (vehicle _unit != _unit) exitWith {};
if !(_heli isKindOf "Helicopter") exitWith {};
if !(_heli getVariable ["APR_STABO_Deployed", false]) exitWith {};

if (!isServer) exitWith {
	[_unit, _heli] remoteExecCall ["Dash_fnc_PickupRope", 2];
};

if (_unit getVariable ["AR_Is_Rappelling", false]) exitWith {};

private _rappelPoints = [_heli] call AR_Get_Heli_Rappel_Points;

if ((count _rappelPoints) == 0) exitWith {
	if (isPlayer _unit) then {
		[["No STABO pickup anchor available on this helicopter.", false], "AR_Hint", _unit] call AR_RemoteExec;
	};
};

private _slotIndex = [_heli] call Dash_fnc_FindFreeSlot;

if (_slotIndex < 0) exitWith {
	private _message = format ["All STABO rope segments are occupied (%1/%1).", APR_STABO_SEGMENT_COUNT];

	if (isPlayer _unit) then {
		[_message, -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", owner _unit];
	} else {
		private _controller = remoteControlled _unit;

		if (!isNull _controller) then {
			[_message, -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", owner _controller];
		};
	};
};

private _rappelPoint = _rappelPoints select 0;
private _targetOwner = owner _unit;

if (!isPlayer _unit) then {
	private _controller = remoteControlled _unit;

	if (!isNull _controller) then {
		_targetOwner = owner _controller;
	};
};

_heli setVariable ["APR_STABO_Using_Player_Chain", true, true];
_heli setVariable ["APR_STABO_Player_" + str _slotIndex, _unit, true];

_unit setVariable ["AR_Is_Rappelling", true, true];
_unit setVariable ["APR_STABO_SlotIndex", _slotIndex, true];

[_unit, _heli, _rappelPoint, _slotIndex] remoteExec ["Dash_fnc_ClientPickupRope", _targetOwner];

sleep 0.25;
[_heli] call Dash_fnc_RefreshBottomRopes;

[_unit, _heli, _slotIndex] spawn {
	params ["_unit", "_heli", "_slotIndex"];

	waitUntil {
		sleep 2;
		!alive _unit || {!(_unit getVariable ["AR_Is_Rappelling", false])}
	};

	_heli setVariable ["APR_STABO_Player_" + str _slotIndex, nil, true];
	[_heli] call Dash_fnc_RefreshBottomRopes;

	if (!([_heli] call Dash_fnc_HasAttachedPlayers)) then {
		_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];
	};
};
