params ["_heli"];

private _hasPlayers = false;

for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

	if (!isNull _unit && {alive _unit}) exitWith {
		_hasPlayers = true;
	};
};

_hasPlayers
