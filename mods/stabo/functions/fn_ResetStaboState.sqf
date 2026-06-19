params ["_heli"];

if (isNull _heli) exitWith {};

_heli setVariable ["APR_STABO_Rope", objNull, true];
_heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
_heli setVariable ["APR_STABO_Sandbag", objNull, true];
_heli setVariable ["APR_STABO_ActionPoint", objNull, true];
_heli setVariable ["APR_STABO_Deployed", false, true];
_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];

for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

	if (!isNull _unit) then {
		_unit setVariable ["APR_STABO_IsAttached", nil, true];
		_unit setVariable ["APR_STABO_DetachRequested", nil, true];
		_unit setVariable ["APR_STABO_Vehicle", nil, true];
		_unit setVariable ["APR_STABO_SlotIndex", nil, true];
		_unit setVariable ["APR_STABO_RappelDevice", nil, true];
		_unit setVariable ["APR_STABO_BottomRope", nil, true];
	};

	_heli setVariable ["APR_STABO_Player_" + str _i, nil, true];
};