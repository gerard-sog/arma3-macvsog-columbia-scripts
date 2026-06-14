/*
	Advanced Pickup Rope - dedicated server safe version
*/

APR_Pickup_Rope = {
	params ["_player", "_heli"];

	if (isNull _player || {isNull _heli}) exitWith {};
	if (!isPlayer _player) exitWith {};

	if (!isServer) exitWith {
		[_player, _heli] remoteExecCall ["APR_Pickup_Rope", 2];
	};

	if (_player getVariable ["AR_Is_Rappelling", false]) exitWith {};

	private _rappelPoints = [_heli] call AR_Get_Heli_Rappel_Points;
	private _rappelPointIndex = 0;

	{
		private _rappellingPlayer = _heli getVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, objNull];

		if (isNull _rappellingPlayer) exitWith {};

		_rappelPointIndex = _rappelPointIndex + 1;
	} forEach _rappelPoints;

	if ((count _rappelPoints) == _rappelPointIndex) exitWith {
		[
			["All rappel anchors in use. Please try again.", false],
			"AR_Hint",
			_player
		] call AR_RemoteExec;
	};

	_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, _player, true];
	_player setVariable ["AR_Is_Rappelling", true, true];

	[
		_player,
		_heli,
		_rappelPoints select _rappelPointIndex
	] remoteExec ["APR_Client_Pickup_Rope", owner _player];

	[_player, _heli, _rappelPointIndex] spawn {
		params ["_player", "_heli", "_rappelPointIndex"];

		waitUntil {
			sleep 2;
			!alive _player || {!(_player getVariable ["AR_Is_Rappelling", false])}
		};

		_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, nil, true];
	};
};

APR_Client_Pickup_Rope = {
	params ["_player", "_heli", "_rappelPoint"];

	if (!hasInterface) exitWith {};
	if (!local _player) exitWith {};
	if (!isPlayer _player) exitWith {};

	[_player] orderGetIn false;
	moveOut _player;

	waitUntil {
		vehicle _player == _player
	};

	private _rappelPointPosition = AGLToASL (_heli modelToWorldVisual _rappelPoint);

	private _anchor = "Land_Can_V2_F" createVehicle _rappelPointPosition;
	_anchor allowDamage false;
	hideObject _anchor;

	[[_anchor], "AR_Hide_Object_Global"] call AR_RemoteExecServer;

	_anchor attachTo [_heli, _rappelPoint];

	private _rappelDevice = "B_static_AA_F" createVehicle position _player;
	_rappelDevice allowDamage false;
	hideObject _rappelDevice;

	[[_rappelDevice], "AR_Hide_Object_Global"] call AR_RemoteExecServer;

	[[_player, _rappelDevice, _anchor], "AR_Play_Rappelling_Sounds_Global"] call AR_RemoteExecServer;

	private _bottomRopeLength = 3;
	private _bottomRope = ropeCreate [_rappelDevice, [-0.15, 0, 0], _bottomRopeLength];
	_bottomRope allowDamage false;

	private _topRopeLength = (getPos _heli select 2) + 3;
	private _topRope = ropeCreate [_rappelDevice, [0, 0.15, 0], _anchor, [0, 0, 0], _topRopeLength];
	_topRope allowDamage false;

	[_player] spawn AR_Enable_Rappelling_Animation_Client;

	private _gravityAccelerationVec = [0, 0, -9.8];
	private _velocityVec = [0, 0, 0];
	private _lastTime = diag_tickTime;
	private _lastPosition = AGLToASL (_rappelDevice modelToWorldVisual [0, 0, 0]);
	private _lookDirFreedom = 50;
	private _dir = (random 360) + (_lookDirFreedom / 2);
	private _dirSpinFactor = (((random 10) - 5) / 5) max 0.1;

	private _ropeKeyDownHandler = -1;
	private _ropeKeyUpHandler = -1;

	_player setVariable ["AR_DECEND_PRESSED", false];
	_player setVariable ["AR_FAST_DECEND_PRESSED", false];
	_player setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0];
	_player setVariable ["AR_ASCEND_PRESSED", false];

	_ropeKeyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		if ((_this select 1) in (actionKeys "MoveBack")) then {
			player setVariable ["AR_DECEND_PRESSED", true];
		};

		if ((_this select 1) in (actionKeys "Turbo")) then {
			player setVariable ["AR_FAST_DECEND_PRESSED", true];
		};

		if ((_this select 1) in (actionKeys "MoveForward")) then {
			player setVariable ["AR_ASCEND_PRESSED", true];
		};
	}];

	_ropeKeyUpHandler = (findDisplay 46) displayAddEventHandler ["KeyUp", {
		if ((_this select 1) in (actionKeys "MoveBack")) then {
			player setVariable ["AR_DECEND_PRESSED", false];
		};

		if ((_this select 1) in (actionKeys "Turbo")) then {
			player setVariable ["AR_FAST_DECEND_PRESSED", false];
		};

		if ((_this select 1) in (actionKeys "MoveForward")) then {
			player setVariable ["AR_ASCEND_PRESSED", false];
		};
	}];

	[_player, _heli] spawn {
		params ["_player", "_heli"];

		while {_player getVariable ["AR_Is_Rappelling", false]} do {
			if (speed _heli > 150) then {
				["Moving too fast! You've lost grip of the rope.", false] call AR_Hint;
				[_player] call AR_Rappel_Detach_Action;
			};

			sleep 2;
		};
	};

	while {true} do {
		private _currentTime = diag_tickTime;
		private _timeSinceLastUpdate = _currentTime - _lastTime;
		_lastTime = _currentTime;

		if (_timeSinceLastUpdate > 1) then {
			_timeSinceLastUpdate = 0;
		};

		private _environmentWindVelocity = wind;
		private _playerWindVelocity = _velocityVec vectorMultiply -1;
		private _helicopterWindVelocity = (vectorUp _heli) vectorMultiply -30;
		private _totalWindVelocity = _environmentWindVelocity vectorAdd _playerWindVelocity vectorAdd _helicopterWindVelocity;
		private _totalWindForce = _totalWindVelocity vectorMultiply (9.8 / 53);

		private _accelerationVec = _gravityAccelerationVec vectorAdd _totalWindForce;
		_velocityVec = _velocityVec vectorAdd (_accelerationVec vectorMultiply _timeSinceLastUpdate);

		private _newPosition = _lastPosition vectorAdd (_velocityVec vectorMultiply _timeSinceLastUpdate);
		private _heliPos = AGLToASL (_heli modelToWorldVisual _rappelPoint);

		if (_newPosition distance _heliPos > _topRopeLength) then {
			_newPosition = _heliPos vectorAdd ((vectorNormalized (_heliPos vectorFromTo _newPosition)) vectorMultiply _topRopeLength);

			private _surfaceVector = vectorNormalized (_newPosition vectorFromTo _heliPos);
			_velocityVec = _velocityVec vectorAdd ((_surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1);
		};

		_rappelDevice setPosWorld (_lastPosition vectorAdd ((_newPosition vectorDiff _lastPosition) vectorMultiply 6));
		_rappelDevice setVectorDir (vectorDir _player);

		_player setPosWorld [
			_newPosition select 0,
			_newPosition select 1,
			(_newPosition select 2) - 0.6
		];

		_player setVelocity [0, 0, 0];

		if (_player getVariable ["AR_DECEND_PRESSED", false]) then {
			private _decendSpeedMetersPerSecond = 3.5;

			if (_player getVariable ["AR_FAST_DECEND_PRESSED", false]) then {
				_decendSpeedMetersPerSecond = 5;
			};

			_decendSpeedMetersPerSecond = _decendSpeedMetersPerSecond + (_player getVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0]);

			_bottomRopeLength = _bottomRopeLength - (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
			_topRopeLength = _topRopeLength + (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);

			ropeUnwind [_topRope, _decendSpeedMetersPerSecond, _topRopeLength];
			ropeUnwind [_bottomRope, _decendSpeedMetersPerSecond, _bottomRopeLength];
		} else {
			if (_player getVariable ["AR_ASCEND_PRESSED", false]) then {
				private _decendSpeedMetersPerSecond = 3.5;
				_decendSpeedMetersPerSecond = _decendSpeedMetersPerSecond + (_player getVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0]);

				_bottomRopeLength = _bottomRopeLength + (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
				_topRopeLength = _topRopeLength - (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);

				ropeUnwind [_topRope, _decendSpeedMetersPerSecond, _topRopeLength];
				ropeUnwind [_bottomRope, _decendSpeedMetersPerSecond, _bottomRopeLength];
			};
		};

		_dir = _dir + ((360 / 1000) * _dirSpinFactor);

		private _currentDir = getDir _player;
		private _minDir = (_dir - (_lookDirFreedom / 2)) mod 360;
		private _maxDir = (_dir + (_lookDirFreedom / 2)) mod 360;

		private _minDegreesToMax = 0;
		private _minDegreesToMin = 0;

		if (_currentDir > _maxDir) then {
			_minDegreesToMax = (_currentDir - _maxDir) min (360 - _currentDir + _maxDir);
		};

		if (_currentDir < _maxDir) then {
			_minDegreesToMax = (_maxDir - _currentDir) min (360 - _maxDir + _currentDir);
		};

		if (_currentDir > _minDir) then {
			_minDegreesToMin = (_currentDir - _minDir) min (360 - _currentDir + _minDir);
		};

		if (_currentDir < _minDir) then {
			_minDegreesToMin = (_minDir - _currentDir) min (360 - _minDir + _currentDir);
		};

		if (_minDegreesToMin > _lookDirFreedom || {_minDegreesToMax > _lookDirFreedom}) then {
			if (_minDegreesToMin < _minDegreesToMax) then {
				_player setDir _minDir;
			} else {
				_player setDir _maxDir;
			};
		} else {
			_player setDir (_currentDir + ((360 / 1000) * _dirSpinFactor));
		};

		_lastPosition = _newPosition;

		if (_player distance _heli < 3) then {
			_player moveInCargo _heli;
		};

		if (
			!alive _player ||
			{vehicle _player != _player} ||
			{_bottomRopeLength <= 1} ||
			{_player getVariable ["AR_Detach_Rope", false]}
		) exitWith {};

		sleep 0.01;
	};

	if (_bottomRopeLength > 1 && {alive _player} && {vehicle _player == _player}) then {
		private _playerStartASLIntersect = getPosASL _player;
		private _playerEndASLIntersect = [
			_playerStartASLIntersect select 0,
			_playerStartASLIntersect select 1,
			(_playerStartASLIntersect select 2) - 5
		];

		private _surfaces = lineIntersectsSurfaces [
			_playerStartASLIntersect,
			_playerEndASLIntersect,
			_player,
			objNull,
			true,
			10
		];

		private _intersectionASL = [];

		{
			scopeName "surfaceLoop";

			private _intersectionObject = _x select 2;
			private _objectFileName = str _intersectionObject;

			if ((_objectFileName find " t_") == -1 && {(_objectFileName find " b_") == -1}) then {
				_intersectionASL = _x select 0;
				breakOut "surfaceLoop";
			};
		} forEach _surfaces;

		if ((count _intersectionASL) != 0) then {
			_player allowDamage false;
			_player setPosASL _intersectionASL;
		};

		if (_player getVariable ["AR_Detach_Rope", false]) then {
			if ((count _intersectionASL) == 0) then {
				_player allowDamage true;
			};
		};

		if (!isEngineOn _heli) then {
			_player allowDamage true;
		};
	};

	ropeDestroy _topRope;
	ropeDestroy _bottomRope;

	deleteVehicle _anchor;
	deleteVehicle _rappelDevice;

	_player setVariable ["AR_Is_Rappelling", nil, true];
	_player setVariable ["AR_Rappelling_Vehicle", nil, true];
	_player setVariable ["AR_Detach_Rope", nil];

	if (_ropeKeyDownHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyDownHandler];
	};

	if (_ropeKeyUpHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyUp", _ropeKeyUpHandler];
	};

	sleep 2;

	_player allowDamage true;
};

APR_Request_Pickup_Rope_Action = {
	params ["_player", "_vehicle"];

	if (isNull _player || {isNull _vehicle}) exitWith {};
	if (!isPlayer _player) exitWith {};

	if ([_player, _vehicle] call AR_Rappel_From_Heli_Action_Check) then {
		[_player, _vehicle] call APR_Pickup_Rope;
	};
};

APR_Pickup_Rope_Add_Player_Actions = {
	params ["_player"];

	if (isNull _player) exitWith {};
	if (!isPlayer _player) exitWith {};

	_player addAction [
		"Request Pickup Rope",
		{
			[player, cursorTarget] call APR_Request_Pickup_Rope_Action;
		},
		nil,
		0,
		false,
		true,
		"",
		"[player, cursorTarget] call AR_Rappel_From_Heli_Action_Check"
	];

	_player addEventHandler ["Respawn", {
		player setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false];
	}];
};

if (hasInterface) then {
	[] spawn {
		waitUntil {
			!isNull player
		};

		while {true} do {
			if !(player getVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false]) then {
				[player] call APR_Pickup_Rope_Add_Player_Actions;
				player setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", true];
			};

			sleep 5;
		};
	};
};