params ["_heli"];

if (isNull _heli) exitWith {};

if (!isServer) exitWith {
	[_heli] remoteExecCall ["Dash_fnc_RefreshBottomRopes", 2];
};

for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
	private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

	if (!isNull _unit && {alive _unit}) then {
		private _targetOwner = owner _unit;

		if (!isPlayer _unit) then {
			private _controller = remoteControlled _unit;

			if (!isNull _controller) then {
				_targetOwner = owner _controller;
			};
		};

		[_unit, _heli] remoteExecCall ["Dash_fnc_ClientRefreshBottomRope", _targetOwner];
	};
};
