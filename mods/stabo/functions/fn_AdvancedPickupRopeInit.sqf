/*
	STABO Pickup Rope

	- Dedicated server safe
	- Ground-only STABO extract action
	- Works for players and Zeus remote-controlled AI
	- 8 rope slots, 3.5m apart
	- Only the last occupied slot has the dangling bottom rope
*/

APR_STABO_SEGMENT_COUNT = 8;
APR_STABO_SEGMENT_LENGTH = 3.5;
APR_STABO_ROPE_LENGTH = APR_STABO_SEGMENT_COUNT * APR_STABO_SEGMENT_LENGTH;
APR_STABO_SANDBAG_CLASS = "vn_prop_sandbag_01";

APR_Drop_STABO_Sandbag = {
	params ["_unit", "_heli"];

	if (isNull _unit || {isNull _heli}) exitWith {};
	if (!alive _unit) exitWith {};
	if !(_heli isKindOf "Helicopter") exitWith {};
	if (vehicle _unit != _heli) exitWith {};

	if (!isServer) exitWith {
		[_unit, _heli] remoteExecCall ["APR_Drop_STABO_Sandbag", 2];
	};

	if (_heli getVariable ["APR_STABO_Sandbag_Deployed", false]) exitWith {};

	_heli setVariable ["APR_STABO_Sandbag_Deployed", true, true];
	_heli setVariable ["APR_STABO_Sandbag_Stuck", false, true];
	_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];

	private _pos = getPosATL _heli;
	_pos set [2, 0];

	private _droppedSandbag = APR_STABO_SANDBAG_CLASS createVehicle ATLToASL _pos;
	_droppedSandbag allowDamage false;

	private _staboRope = ropeCreate [
		_heli,
		[0, 0, 0],
		_droppedSandbag,
		[0, 0, 0],
		APR_STABO_ROPE_LENGTH,
		nil,
		nil,
		nil,
		63
	];

	_staboRope allowDamage false;

	_heli setVariable ["APR_STABO_Rope", _staboRope, true];
	_heli setVariable ["APR_STABO_DroppedSandbag", _droppedSandbag, true];

	[_droppedSandbag, _heli] spawn {
		params ["_droppedSandbag", "_heli"];

		private _hasAttachedPlayers = {
			params ["_heli"];

			private _hasPlayers = false;

			for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
				private _slotUnit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

				if (!isNull _slotUnit && {alive _slotUnit}) exitWith {
					_hasPlayers = true;
				};
			};

			_hasPlayers
		};

		private _stickSandbagToGround = {
			params ["_droppedSandbag", "_heli"];

			if (isNull _droppedSandbag || {isNull _heli}) exitWith {objNull};

			[_droppedSandbag, true] remoteExec ["hideObjectGlobal", 2];

			private _frozenSandbag = APR_STABO_SANDBAG_CLASS createVehicle (getPosATL _droppedSandbag);
			_frozenSandbag allowDamage false;
			_frozenSandbag enableSimulationGlobal false;

			_frozenSandbag setVariable ["APR_STABO_ParentHelicopter", _heli, true];

			_heli setVariable ["APR_STABO_Sandbag", _frozenSandbag, true];
			_heli setVariable ["APR_STABO_Sandbag_Stuck", true, true];

			[
				_frozenSandbag,
				"Attach STABO rig",
				"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",
				"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",
				"(_this distance _target < 6) && {((_target getVariable ['APR_STABO_ParentHelicopter', objNull]) getVariable ['APR_STABO_Sandbag_Deployed', false])} && {((_target getVariable ['APR_STABO_ParentHelicopter', objNull]) getVariable ['APR_STABO_Sandbag_Stuck', false])}",
				"true",
				{},
				{},
				{
					params ["_target", "_caller", "_actionId", "_arguments"];

					private _heli = _arguments select 0;

					[_caller, _heli] call APR_Pickup_Rope;

					private _rope = _heli getVariable ["APR_STABO_Rope", objNull];

					if (!isNull _rope) then {
						ropeDestroy _rope;
						_heli setVariable ["APR_STABO_Rope", objNull, true];
					};

					_heli setVariable ["APR_STABO_Using_Player_Chain", true, true];

					[_heli] spawn {
						params ["_heli"];
						sleep 0.5;
						[_heli] call APR_Refresh_Stabo_Bottom_Ropes;
					};
				},
				{},
				[_heli],
				3,
				0,
				false,
				false
			] remoteExec ["BIS_fnc_holdActionAdd", 0];

			_frozenSandbag
		};

		while {
			!isNull _droppedSandbag
			&& {!isNull _heli}
			&& {_heli getVariable ["APR_STABO_Sandbag_Deployed", false]}
		} do {
            waitUntil {
                sleep 0.25;
                isNull _droppedSandbag
                || {isNull _heli}
                || {
                    ((getPos _droppedSandbag) select 2) <= 0.25
                    && {(_droppedSandbag distance _heli) < (APR_STABO_ROPE_LENGTH + 5)}
                }
            };

			if (isNull _droppedSandbag || {isNull _heli}) exitWith {};

			private _crew = crew _heli;
			["Sandbag touching ground!", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _crew];

			private _frozenSandbag = [_droppedSandbag, _heli] call _stickSandbagToGround;

			[_heli] call APR_Refresh_Stabo_Bottom_Ropes;

			while {
				!isNull _droppedSandbag
				&& {!isNull _frozenSandbag}
				&& {!isNull _heli}
				&& {_heli getVariable ["APR_STABO_Sandbag_Deployed", false]}
				&& {_heli getVariable ["APR_STABO_Sandbag_Stuck", false]}
			} do {
				sleep 0.25;

				if ((_droppedSandbag distance _frozenSandbag) > 0.5) then {
					_droppedSandbag setPosATL getPosATL _frozenSandbag;
				};

				if ((_droppedSandbag distance _heli) >= (APR_STABO_ROPE_LENGTH + 5)) then {
					if (!([_heli] call _hasAttachedPlayers)) then {
						private _rope = _heli getVariable ["APR_STABO_Rope", objNull];

						if (!isNull _rope) then {
							ropeDestroy _rope;
						};

						deleteVehicle _droppedSandbag;
						deleteVehicle _frozenSandbag;

						_heli setVariable ["APR_STABO_Rope", objNull, true];
						_heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
						_heli setVariable ["APR_STABO_Sandbag", objNull, true];
						_heli setVariable ["APR_STABO_Sandbag_Deployed", false, true];
						_heli setVariable ["APR_STABO_Sandbag_Stuck", false, true];
						_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];
                        } else {
                            private _groundPos = getPosATL _frozenSandbag;

                            // Remove ground-stuck visible sandbag.
                            deleteVehicle _frozenSandbag;

                            // Reuse the original physical sandbag as the dangling sandbag.
                            [_droppedSandbag, false] remoteExec ["hideObjectGlobal", 2];

                            _droppedSandbag setPosATL _groundPos;
                            _droppedSandbag enableSimulationGlobal true;
                            _droppedSandbag allowDamage false;

                            // Important: this keeps the last player's bottom rope attached to a real sandbag.
                            _heli setVariable ["APR_STABO_Sandbag", _droppedSandbag, true];
                            _heli setVariable ["APR_STABO_Sandbag_Stuck", false, true];

                            // Rebuild bottom rope: last attached player -> dangling sandbag.
                            [_heli] call APR_Refresh_Stabo_Bottom_Ropes;

                            // Safety refresh in case the client-side rappel device was not ready this frame.
                            [_heli] spawn {
                                params ["_heli"];

                                sleep 0.5;
                                [_heli] call APR_Refresh_Stabo_Bottom_Ropes;
                            };
                        };

					break;
				};
			};
		};
	};
};

APR_Refresh_Stabo_Bottom_Ropes = {
	params ["_heli"];

	if (isNull _heli) exitWith {};

	if (!isServer) exitWith {
		[_heli] remoteExecCall ["APR_Refresh_Stabo_Bottom_Ropes", 2];
	};

	for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
		private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

		if (!isNull _unit && {alive _unit}) then {
			[_unit, _heli] remoteExecCall ["APR_Client_Refresh_Bottom_Rope", owner _unit];
		};
	};
};

APR_Client_Refresh_Bottom_Rope = {
	params ["_unit", "_heli"];

	if (!local _unit) exitWith {};

	private _oldBottomRope = _unit getVariable ["APR_STABO_BottomRope", objNull];

	if (!isNull _oldBottomRope) then {
		ropeDestroy _oldBottomRope;
		_unit setVariable ["APR_STABO_BottomRope", objNull];
	};

	private _slotIndex = _unit getVariable ["APR_STABO_SlotIndex", -1];
	private _rappelDevice = _unit getVariable ["APR_STABO_RappelDevice", objNull];

	if (_slotIndex < 0 || {isNull _rappelDevice}) exitWith {};

	private _lastOccupiedSlot = -1;

	for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
		private _slotUnit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

		if (!isNull _slotUnit && {alive _slotUnit}) then {
			_lastOccupiedSlot = _i;
		};
	};

	if (_slotIndex != _lastOccupiedSlot) exitWith {};

	private _sandbag = _heli getVariable ["APR_STABO_Sandbag", objNull];

	if (!isNull _sandbag) then {
		private _bottomRopeLength = _rappelDevice distance _sandbag;

		private _bottomRope = ropeCreate [
			_rappelDevice,
			[-0.15, 0, 0],
			_sandbag,
			[0, 0, 0],
			_bottomRopeLength
		];

		_bottomRope allowDamage false;
		_unit setVariable ["APR_STABO_BottomRope", _bottomRope];
	} else {
		private _usedRopeLength = (_slotIndex + 1) * APR_STABO_SEGMENT_LENGTH;
		private _danglingRopeLength = APR_STABO_ROPE_LENGTH - _usedRopeLength;

		if (_danglingRopeLength > 0) then {
			private _bottomRope = ropeCreate [
				_rappelDevice,
				[-0.15, 0, 0],
				_danglingRopeLength
			];

			_bottomRope allowDamage false;
			_unit setVariable ["APR_STABO_BottomRope", _bottomRope];
		};
	};
};

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

	sleep 0.25;
	[_heli] call APR_Refresh_Stabo_Bottom_Ropes;

	[_unit, _heli, _slotIndex] spawn {
		params ["_unit", "_heli", "_slotIndex"];

		waitUntil {
			sleep 2;
			!alive _unit || {!(_unit getVariable ["AR_Is_Rappelling", false])}
		};

		_heli setVariable ["APR_STABO_Player_" + str _slotIndex, nil, true];

		[_heli] call APR_Refresh_Stabo_Bottom_Ropes;
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

	_unit setVariable ["APR_STABO_RappelDevice", _rappelDevice];
	_unit setVariable ["APR_STABO_BottomRope", objNull];

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
		_unit setDir _dir;

		_lastPosition = _newPosition;

		if (
			!alive _unit ||
			{vehicle _unit != _unit} ||
			{_unit getVariable ["AR_Detach_Rope", false]}
		) exitWith {};

		sleep 0.01;
	};

	private _storedBottomRope = _unit getVariable ["APR_STABO_BottomRope", objNull];

	if (!isNull _storedBottomRope) then {
		ropeDestroy _storedBottomRope;
	};

	ropeDestroy _topRope;

	deleteVehicle _anchor;
	deleteVehicle _rappelDevice;

	_unit setVariable ["AR_Is_Rappelling", nil, true];
	_unit setVariable ["AR_Rappelling_Vehicle", nil, true];
	_unit setVariable ["AR_Detach_Rope", nil];
	_unit setVariable ["APR_STABO_SlotIndex", nil, true];
	_unit setVariable ["APR_STABO_RappelDevice", nil];
	_unit setVariable ["APR_STABO_BottomRope", nil];

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
        "Deploy STABO",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_caller, vehicle _caller] call APR_Drop_STABO_Sandbag;
        },
        nil,
        1.5,
        false,
        true,
        "",
        "
            alive _this
            && {vehicle _this != _this}
            && {(vehicle _this) isKindOf 'Helicopter'}
            && {!((vehicle _this) getVariable ['APR_STABO_Sandbag_Deployed', false])}
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