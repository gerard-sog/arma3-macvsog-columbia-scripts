params ["_unit", "_heli"];

if (!local _unit) exitWith {};

private _oldBottomRope = _unit getVariable ["APR_STABO_BottomRope", objNull];

if (!isNull _oldBottomRope) then {
	ropeDestroy _oldBottomRope;
	_unit setVariable ["APR_STABO_BottomRope", objNull, true];
};

private _slotIndex = _unit getVariable ["APR_STABO_SlotIndex", -1];
private _rappelDevice = _unit getVariable ["APR_STABO_RappelDevice", objNull];

if (_slotIndex < 0 || {isNull _rappelDevice}) exitWith {};

private _lastOccupiedSlot = -1;

for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	private _slotUnit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

	if (!isNull _slotUnit && {alive _slotUnit}) then {
		_lastOccupiedSlot = _i;
	};
};

if (_slotIndex != _lastOccupiedSlot) exitWith {};

private _usedRopeLength = (_slotIndex + 1) * APR_STABO_SEGMENT_LENGTH;
private _danglingRopeLength = APR_STABO_ROPE_LENGTH - _usedRopeLength;

if (_danglingRopeLength > 0) then {
	private _bottomRope = ropeCreate [
		_rappelDevice,
		[-0.15, 0, 0],
		_danglingRopeLength
	];

	_bottomRope allowDamage false;
	_unit setVariable ["APR_STABO_BottomRope", _bottomRope, true];
};
