params ["_heli", "_invisibleSandbag", "_frozenSandbag"];

if (!isServer) exitWith {
	[_heli, _invisibleSandbag, _frozenSandbag] remoteExecCall ["Dash_fnc_ServerKeepSandbagPinned", 2];
};

[_heli, _invisibleSandbag, _frozenSandbag] spawn {
	params ["_heli", "_invisibleSandbag", "_frozenSandbag"];

	while {
		alive _heli
		&& {!isNull _invisibleSandbag}
		&& {!isNull _frozenSandbag}
		&& {_heli getVariable ["APR_STABO_Deployed", false]}
	} do {
		sleep 1;

		if ((_invisibleSandbag distance _frozenSandbag) > 0.5) then {
			_invisibleSandbag setPosATL getPosATL _frozenSandbag;
		};
	};
};
