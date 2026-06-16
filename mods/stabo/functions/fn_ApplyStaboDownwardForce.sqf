params ["_heli"];

if (isNull _heli) exitWith {};

if (!local _heli) exitWith {
	[_heli] remoteExecCall [
		"Dash_fnc_ApplyStaboDownwardForce",
		owner _heli
	];
};

if (_heli getVariable ["APR_STABO_ForceLoopRunning", false]) exitWith {};

_heli setVariable ["APR_STABO_ForceLoopRunning", true];

[_heli] spawn {
	params ["_heli"];

	private _tickRate = 0.1;
	private _downAcceleration = 1.5;

	private _slingLoadMaxCargoMass = getNumber (
		configFile
		>> "CfgVehicles"
		>> typeOf _heli
		>> "slingLoadMaxCargoMass"
	);

	if (_slingLoadMaxCargoMass <= 0) then {
		_slingLoadMaxCargoMass = 800;
	};

	while {
		alive _heli
		&& {_heli getVariable ["APR_STABO_ForceActive", false]}
	} do {
		private _attachedCount =
			_heli getVariable ["APR_STABO_AttachedCount", 0];

		if (_attachedCount <= 0) exitWith {};

		private _staboMass =
			_attachedCount * APR_STABO_PLAYER_WEIGHT;

		private _loadRatio =
			(_staboMass / _slingLoadMaxCargoMass) min 1;

		private _vel = velocity _heli;
		private _verticalVelocity = _vel select 2;

		if (APR_STABO_CLIMB_SUPPRESSION_ENABLED) then {
			if (_verticalVelocity > 0) then {
				_verticalVelocity =
					_verticalVelocity * (1 - _loadRatio);
			};
		};

		private _downPull =
			_loadRatio * _downAcceleration * _tickRate;

		_verticalVelocity =
			_verticalVelocity - _downPull;

		_heli setVelocity [
			_vel select 0,
			_vel select 1,
			_verticalVelocity
		];

		if (APR_STABO_DEBUG_ENABLED) then {
			[
				format [
					"STABO DEBUG: attached=%1 | mass=%2kg | slingLoadMaxCargoMass=%3kg | loadRatio=%4 | climbSuppression=%5 | downPull=%6",
					_attachedCount,
					_staboMass,
					_slingLoadMaxCargoMass,
					_loadRatio,
					APR_STABO_CLIMB_SUPPRESSION_ENABLED,
					_downPull
				]
			] remoteExec ["systemChat", 0];
		};

		sleep _tickRate;
	};

	_heli setVariable ["APR_STABO_ForceLoopRunning", false];
	_heli setVariable ["APR_STABO_ForceActive", false];
};