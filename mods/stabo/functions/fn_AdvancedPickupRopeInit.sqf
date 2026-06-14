/*
	STABO Pickup Rope

	- Dedicated server safe
	- Ground-only STABO extract action
	- Works for players and Zeus remote-controlled AI
	- 8 rope slots, 3.5m apart
*/

APR_STABO_SEGMENT_COUNT = 8;
APR_STABO_SEGMENT_LENGTH = 3.5;

APR_Pickup_Rope = {
	params ["_unit", "_heli"];

	if (isNull _unit || {isNull _heli}) exitWith {};
	if (!alive _unit) exitWith {};
	if (vehicle _unit != _unit) exitWith {};
	if !(_heli isKindOf "Helicopter") exitWith {};

	if (!isServer) exitWith {
		[_unit, _heli] remoteExecCall ["APR_Pickup_Rope", 2];
	};

	if (_unit getVariable ["AR_Is_Rappelling", false]) exitWith {};

	private _rappelPoints = [_heli] call AR_Get_Heli_Rappel_Points;

	if ((count _rappelPoints) == 0) exitWith {
		if (isPlayer _unit) then {
			[
				["No STABO pickup anchor available on this helicopter.", false],
				"AR_Hint",
				_unit
			] call AR_RemoteExec;
		};
	};

	private _rappelPoint = _rappelPoints select 0;
	private _slotIndex = -1;

	for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
		private _slotUnit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

		if (isNull _slotUnit || {!alive _slotUnit}) exitWith {
			_slotIndex = _i;
		};
	};

	if (_slotIndex < 0) exitWith {
		if (isPlayer _unit) then {
			[
				["All STABO rope segments are in use. Please try again.", false],
				"AR_Hint",
				_unit
			] call AR_RemoteExec;
		};
	};

	_heli setVariable ["APR_STABO_Player_" + str _slotIndex, _unit, true];
	_unit setVariable ["AR_Is_Rappelling", true, true];
	_unit setVariable ["APR_STABO_SlotIndex", _slotIndex, true];

	[
		_unit,
		_heli,
		_rappelPoint,
		_slotIndex
	] remoteExec ["APR_Client_Pickup_Rope", owner _unit];

	[_unit, _heli, _slotIndex] spawn {
		params ["_unit", "_heli", "_slotIndex"];

		waitUntil {
			sleep 2;
			!alive _unit || {!(_unit getVariable ["AR_Is_Rappelling", false])}
		};

		_heli setVariable ["APR_STABO_Player_" + str _slotIndex, nil, true];
	};
};

APR_Client_Pickup_Rope = {
	params ["_unit", "_heli", "_rappelPoint", ["_slotIndex", 0]];

	if (!hasInterface) exitWith {};
	if (!local _unit) exitWith {};
	if (!alive _unit) exitWith {};
	if (vehicle _unit != _unit) exitWith {};

	[_unit] orderGetIn false;

	private _rappelPointPosition = AGLToASL (_heli modelToWorldVisual _rappelPoint);

	private _anchor = "Land_Can_V2_F" createVehicle _rappelPointPosition;
	_anchor allowDamage false;
	hideObject _anchor;

	[[_anchor], "AR_Hide_Object_Global"] call AR_RemoteExecServer;

	_anchor attachTo [_heli, _rappelPoint];

	private _rappelDevice = "B_static_AA_F" createVehicle position _unit;
	_rappelDevice allowDamage false;
	hideObject _rappelDevice;

	[[_rappelDevice], "AR_Hide_Object_Global"] call AR_RemoteExecServer;

	[[_unit, _rappelDevice, _anchor], "AR_Play_Rappelling_Sounds_Global"] call AR_RemoteExecServer;

	private _bottomRopeLength = 3;
	private _bottomRope = ropeCreate [_rappelDevice, [-0.15, 0, 0], _bottomRopeLength];
	_bottomRope allowDamage false;

	/*
		STABO slot distance:
		Slot 0 = 3.5m from helicopter
		Slot 1 = 7.0m from helicopter
		Slot 2 = 10.5m from helicopter
		...
		Slot 7 = 28.0m from helicopter
	*/
	private _topRopeLength = (_slotIndex + 1) * APR_STABO_SEGMENT_LENGTH;

	private _topRope = ropeCreate [
		_rappelDevice,
		[0, 0.15, 0],
		_anchor,
		[0, 0, 0],
		_topRopeLength
	];

	_topRope allowDamage false;

	[_unit] spawn AR_Enable_Rappelling_Animation_Client;

	private _gravityAccelerationVec = [0, 0, -9.8];
	private _velocityVec = [0, 0, 0];
	private _lastTime = diag_tickTime;

	private _heliPos = AGLToASL (_heli modelToWorldVisual _rappelPoint);

	private _lastPosition = [
		_heliPos select 0,
		_heliPos select 1,
		(_heliPos select 2) - _topRopeLength
	];

	private _lookDirFreedom = 50;
	private _dir = (random 360) + (_lookDirFreedom / 2);
	private _dirSpinFactor = (((random 10) - 5) / 5) max 0.1;

	private _ropeKeyDownHandler = -1;
	private _ropeKeyUpHandler = -1;

	_unit setVariable ["AR_DECEND_PRESSED", false];
	_unit setVariable ["AR_FAST_DECEND_PRESSED", false];
	_unit setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0];
	_unit setVariable ["AR_ASCEND_PRESSED", false];

	while {true} do {
		private _currentTime = diag_tickTime;
		private _timeSinceLastUpdate = _currentTime - _lastTime;
		_lastTime = _currentTime;

		if (_timeSinceLastUpdate > 1) then {
			_timeSinceLastUpdate = 0;
		};

		private _environmentWindVelocity = wind;
		private _unitWindVelocity = _velocityVec vectorMultiply -1;
		private _helicopterWindVelocity = (vectorUp _heli) vectorMultiply -30;
		private _totalWindVelocity = _environmentWindVelocity vectorAdd _unitWindVelocity vectorAdd _helicopterWindVelocity;
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
		_rappelDevice setVectorDir (vectorDir _unit);

		_unit setPosWorld [
			_newPosition select 0,
			_newPosition select 1,
			(_newPosition select 2) - 0.6
		];

		_unit setVelocity [0, 0, 0];

		_dir = _dir + ((360 / 1000) * _dirSpinFactor);

		private _currentDir = getDir _unit;
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
				_unit setDir _minDir;
			} else {
				_unit setDir _maxDir;
			};
		} else {
			_unit setDir (_currentDir + ((360 / 1000) * _dirSpinFactor));
		};

		_lastPosition = _newPosition;

		if (
			!alive _unit ||
			{vehicle _unit != _unit} ||
			{_unit getVariable ["AR_Detach_Rope", false]}
		) exitWith {};

		sleep 0.01;
	};

	if (alive _unit && {vehicle _unit == _unit}) then {
		private _unitStartASLIntersect = getPosASL _unit;
		private _unitEndASLIntersect = [
			_unitStartASLIntersect select 0,
			_unitStartASLIntersect select 1,
			(_unitStartASLIntersect select 2) - 5
		];

		private _surfaces = lineIntersectsSurfaces [
			_unitStartASLIntersect,
			_unitEndASLIntersect,
			_unit,
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
			_unit allowDamage false;
			_unit setPosASL _intersectionASL;
		};

		if (_unit getVariable ["AR_Detach_Rope", false]) then {
			if ((count _intersectionASL) == 0) then {
				_unit allowDamage true;
			};
		};

		if (!isEngineOn _heli) then {
			_unit allowDamage true;
		};
	};

	ropeDestroy _topRope;
	ropeDestroy _bottomRope;

	deleteVehicle _anchor;
	deleteVehicle _rappelDevice;

	_unit setVariable ["AR_Is_Rappelling", nil, true];
	_unit setVariable ["AR_Rappelling_Vehicle", nil, true];
	_unit setVariable ["AR_Detach_Rope", nil];
	_unit setVariable ["APR_STABO_SlotIndex", nil, true];

	if (_ropeKeyDownHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyDownHandler];
	};

	if (_ropeKeyUpHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyUp", _ropeKeyUpHandler];
	};

	sleep 2;

	_unit allowDamage true;
};

APR_Request_Pickup_Rope_Action = {
	params ["_unit", "_vehicle"];

	if (isNull _unit || {isNull _vehicle}) exitWith {};
	if (!alive _unit) exitWith {};

	if (vehicle _unit != _unit) exitWith {};
	if !(_vehicle isKindOf "Helicopter") exitWith {};

	[_unit, _vehicle] call APR_Pickup_Rope;
};

APR_Pickup_Rope_Add_Player_Actions = {
	params ["_unit"];

	if (isNull _unit) exitWith {};

	_unit addAction [
		"Request STABO Extract",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			[_target, cursorTarget] call APR_Request_Pickup_Rope_Action;
		},
		nil,
		1.5,
		false,
		true,
		"",
		"
			alive _target
			&& {vehicle _target == _target}
			&& {!isNull cursorTarget}
			&& {cursorTarget isKindOf 'Helicopter'}
			&& {!(_target getVariable ['AR_Is_Rappelling', false])}
		"
	];

	_unit addEventHandler ["Respawn", {
		params ["_unit"];

		_unit setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false];
	}];
};

if (hasInterface) then {
	[] spawn {
		while {true} do {
			{
				if (local _x && {alive _x}) then {
					if !(_x getVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false]) then {
						[_x] call APR_Pickup_Rope_Add_Player_Actions;
						_x setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", true];
					};
				};
			} forEach allUnits;

			sleep 5;
		};
	};
};