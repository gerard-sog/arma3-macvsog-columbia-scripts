params ["_heli"];

_heli setVariable ["APR_STABO_Rope", objNull, true];
_heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
_heli setVariable ["APR_STABO_Sandbag", objNull, true];
_heli setVariable ["APR_STABO_ActionPoint", objNull, true];
_heli setVariable ["APR_STABO_Deployed", false, true];
_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];

for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	_heli setVariable ["APR_STABO_Player_" + str _i, nil, true];
};
