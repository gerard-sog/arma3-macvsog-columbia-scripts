/*
	STABO Pickup Rope

	- Dedicated server safe
	- Helicopter-deployed 28m STABO rope
	- No sandbag object
	- Ground players attach via hold action on helicopter
	- Hold action is only visible while STABO is deployed
	- Works for players and locally controlled / Zeus remote-controlled AI
	- 8 rope slots, 3.5m apart
	- Only the last occupied slot has the dangling bottom rope
*/

APR_STABO_SEGMENT_COUNT = 8;
APR_STABO_SEGMENT_LENGTH = 3.5;
APR_STABO_ROPE_LENGTH = APR_STABO_SEGMENT_COUNT * APR_STABO_SEGMENT_LENGTH;

APR_Has_Attached_Players = {
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

APR_Get_Last_Attached_Player = {
	params ["_heli"];

	private _lastUnit = objNull;

	for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
		private _unit = _heli getVariable ["APR_STABO_Player_" + str _i, objNull];

		if (!isNull _unit && {alive _unit}) then {
			_lastUnit = _unit;
		};
	};

	_lastUnit
};

APR_Reset_STABO_State = {
	params ["_heli"];

	_heli setVariable ["APR_STABO_Rope", objNull, true];
	_heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
	_heli setVariable ["APR_STABO_Sandbag", objNull, true];
	_heli setVariable ["APR_STABO_ActionPoint", objNull, true]; // legacy safe clear
	_heli setVariable ["APR_STABO_Deployed", false, true];
	_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];

	for "_i" from 0 to (APR_STABO_SEGMENT_COUNT - 1) do {
		_heli setVariable ["APR_STABO_Player_" + str _i, nil, true];
	};
};

APR_Restore_STABO_Dangling_Rope = {
	params ["_heli"];

	if (isNull _heli) exitWith {};

	if (!isServer) exitWith {
		[_heli] remoteExecCall ["APR_Restore_STABO_Dangling_Rope", 2];
	};

	if (!(_heli getVariable ["APR_STABO_Deployed", false])) exitWith {};
	if ([_heli] call APR_Has_Attached_Players) exitWith {};

	private _oldRope = _heli getVariable ["APR_STABO_Rope", objNull];

	if (!isNull _oldRope) then {
		ropeDestroy _oldRope;
	};

	private _newRope = ropeCreate [
		_heli,
		[0, 0, 0],
		APR_STABO_ROPE_LENGTH
	];

	_newRope allowDamage false;

	_heli setVariable ["APR_STABO_Rope", _newRope, true];
	_heli setVariable ["APR_STABO_Using_Player_Chain", false, true];
};

APR_Add_STABO_Sandbag_Hold_Action = {
	params ["_sandbag"];

	if (!hasInterface) exitWith {};
	if (isNull _sandbag) exitWith {};

	if (_sandbag getVariable ["APR_STABO_HoldAction_Added_Local", false]) exitWith {};
	_sandbag setVariable ["APR_STABO_HoldAction_Added_Local", true];

	[
		_sandbag,
		"Attach STABO rig",
		"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",
		"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",
		"
			(_this distance _target <= 6)
			&& {vehicle _this == _this}
			&& {alive _this}
			&& {!isNull (_target getVariable ['APR_STABO_ParentHelicopter', objNull])}
			&& {alive (_target getVariable ['APR_STABO_ParentHelicopter', objNull])}
			&& {(_target getVariable ['APR_STABO_ParentHelicopter', objNull]) getVariable ['APR_STABO_Deployed', false]}
		",
		"true",
		{},
		{},
		{
			params ["_target", "_caller"];

			private _heli = _target getVariable ["APR_STABO_ParentHelicopter", objNull];

			if (!isNull _heli) then {
				[_caller, _heli] call APR_Pickup_Rope;
			};
		},
		{},
		[],
		1,
		6,
		false,
		false
	] call BIS_fnc_holdActionAdd;
};

APR_Drop_STABO_Rope = {
	params ["_unit", "_heli"];

	if (isNull _unit || {isNull _heli}) exitWith {};
	if (!alive _unit) exitWith {};
	if !(_heli isKindOf "Helicopter") exitWith {};
	if (vehicle _unit != _heli) exitWith {};

	if (!isServer) exitWith {
		[_unit, _heli] remoteExecCall ["APR_Drop_STABO_Rope", 2];
	};

	if (_heli getVariable ["APR_STABO_Deployed", false]) exitWith {};

	_heli setVariable ["APR_STABO_Deployed", true, true];
	_heli setVariable [
    	"APR_STABO_Using_Player_Chain",
    	([_heli] call APR_Has_Attached_Players),
    	true
    ];

	private _pos = getPosATL _heli;
	_pos set [2, 0];

	private _droppedSandbag = "vn_prop_sandbag_01" createVehicle ATLToASL _pos;
	_droppedSandbag allowDamage false;

	private _rope = ropeCreate [
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

	_rope allowDamage false;

	_heli setVariable ["APR_STABO_Rope", _rope, true];
	_heli setVariable ["APR_STABO_DroppedSandbag", _droppedSandbag, true];

	[
		{
			(getPosATL (_this select 0) select 2) <= 0.25
		},
		{
			params ["_droppedSandbag", "_heli"];

			if (!(_heli getVariable ["APR_STABO_Deployed", false])) exitWith {};

			private _crew = crew _heli;
			["Sandbag touching ground!", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _crew];

			[_droppedSandbag, true] remoteExec ["hideObjectGlobal", 2];

			private _frozenSandbag = "vn_prop_sandbag_01" createVehicle (getPosATL _droppedSandbag);
			_frozenSandbag allowDamage false;
			_frozenSandbag enableSimulationGlobal false;

			_frozenSandbag setVariable ["APR_STABO_ParentHelicopter", _heli, true];

			_heli setVariable ["APR_STABO_Sandbag", _frozenSandbag, true];
			_heli setVariable ["APR_STABO_ActionPoint", _frozenSandbag, true]; // keeps old references harmless

			[_frozenSandbag] remoteExecCall ["APR_Add_STABO_Sandbag_Hold_Action", 0, true];

			[
				[_heli, _droppedSandbag, _frozenSandbag],
				{
					params ["_heli", "_invisibleSandbag", "_frozenSandbag"];

					while {
						alive _heli
						&& {!isNull _invisibleSandbag}
						&& {!isNull _frozenSandbag}
						&& {_heli getVariable ["APR_STABO_Deployed", false]}
					} do {
						sleep 1;

						if ((_invisibleSandbag distance _frozenSandbag) > 0.5) then {
							_invisibleSandbag setPosATL (getPosATL _frozenSandbag);
						};
					};
				}
			] remoteExecCall ["spawn", 2];

			[
				{
					params ["_frozenSandbag", "_heli"];

					(_frozenSandbag distance _heli) >= (APR_STABO_ROPE_LENGTH + 5)
				},
				{
					params ["_frozenSandbag", "_heli"];

					if (!(_heli getVariable ["APR_STABO_Deployed", false])) exitWith {};

                    private _crew = crew _heli;
                    ["Rope broke!", -1, 1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _crew];

                    private _rope = _heli getVariable ["APR_STABO_Rope", objNull];
                    private _droppedSandbag = _heli getVariable ["APR_STABO_DroppedSandbag", objNull];
                    private _sandbag = _heli getVariable ["APR_STABO_Sandbag", objNull];

                    if (!isNull _rope) then { ropeDestroy _rope; };
                    if (!isNull _droppedSandbag) then { deleteVehicle _droppedSandbag; };

                    if (!isNull _sandbag) then {
                        _sandbag setVariable ["APR_STABO_ParentHelicopter", nil, true];
                        deleteVehicle _sandbag;
                    };

                    _heli setVariable ["APR_STABO_Rope", objNull, true];
                    _heli setVariable ["APR_STABO_DroppedSandbag", objNull, true];
                    _heli setVariable ["APR_STABO_Sandbag", objNull, true];
                    _heli setVariable ["APR_STABO_ActionPoint", objNull, true];

                    // Allows pilot/crew to drop another sandbag STABO.
                    _heli setVariable ["APR_STABO_Deployed", false, true];

                    // Keep this true if anyone is still hanging.
                    _heli setVariable [
                        "APR_STABO_Using_Player_Chain",
                        ([_heli] call APR_Has_Attached_Players),
                        true
                    ];
				},
				[_frozenSandbag, _heli]
			] call CBA_fnc_waitUntilAndExecute;
		},
		[_droppedSandbag, _heli]
	] call CBA_fnc_waitUntilAndExecute;
};

APR_Detach_STABO = {
	params ["_heli"];

	if (isNull _heli) exitWith {};

	if (!isServer) exitWith {
		[_heli] remoteExecCall ["APR_Detach_STABO", 2];
	};

	if ([_heli] call APR_Has_Attached_Players) exitWith {};

	private _rope = _heli getVariable ["APR_STABO_Rope", objNull];
	private _droppedSandbag = _heli getVariable ["APR_STABO_DroppedSandbag", objNull];
	private _sandbag = _heli getVariable ["APR_STABO_Sandbag", objNull];

	if (!isNull _rope) then { ropeDestroy _rope; };
	if (!isNull _droppedSandbag) then { deleteVehicle _droppedSandbag; };
	if (!isNull _sandbag) then {
		_sandbag setVariable ["APR_STABO_ParentHelicopter", nil, true];
		deleteVehicle _sandbag;
	};

	[_heli] call APR_Reset_STABO_State;
};

APR_Detach_Unit_From_STABO = {
	params ["_unit"];

	if (isNull _unit) exitWith {};

	if (!isServer) exitWith {
		[_unit] remoteExecCall ["APR_Detach_Unit_From_STABO", 2];
	};

	_unit setVariable ["AR_Detach_Rope", true, true];
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
			private _targetOwner = owner _unit;

			if (!isPlayer _unit) then {
				private _controller = remoteControlled _unit;

				if (!isNull _controller) then {
					_targetOwner = owner _controller;
				};
			};

			[_unit, _heli] remoteExecCall ["APR_Client_Refresh_Bottom_Rope", _targetOwner];
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

APR_Pickup_Rope = {
	params ["_unit", "_heli"];

	if (isNull _unit || {isNull _heli}) exitWith {};
	if (!alive _unit) exitWith {};
	if (vehicle _unit != _unit) exitWith {};
	if !(_heli isKindOf "Helicopter") exitWith {};
	if !(_heli getVariable ["APR_STABO_Deployed", false]) exitWith {};

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

	private _deployRope = _heli getVariable ["APR_STABO_Rope", objNull];

	if (!isNull _deployRope) then {
		ropeDestroy _deployRope;
		_heli setVariable ["APR_STABO_Rope", objNull, true];
	};

	_heli setVariable ["APR_STABO_Using_Player_Chain", true, true];
	_heli setVariable ["APR_STABO_Player_" + str _slotIndex, _unit, true];

	_unit setVariable ["AR_Is_Rappelling", true, true];
	_unit setVariable ["APR_STABO_SlotIndex", _slotIndex, true];

	private _targetOwner = owner _unit;

	if (!isPlayer _unit) then {
		private _remoteController = remoteControlled _unit;

		if (!isNull _remoteController) then {
			_targetOwner = owner _remoteController;
		};
	};

	[
		_unit,
		_heli,
		_rappelPoint,
		_slotIndex
	] remoteExec ["APR_Client_Pickup_Rope", _targetOwner];

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

        if (!([_heli] call APR_Has_Attached_Players)) then {
            _heli setVariable ["APR_STABO_Using_Player_Chain", false, true];
        };
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

	_unit setVariable ["APR_STABO_RappelDevice", _rappelDevice, true];
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
	_unit setVariable ["APR_STABO_RappelDevice", nil, true];
	_unit setVariable ["APR_STABO_BottomRope", nil, true];

	sleep 2;

	_unit allowDamage true;
};

APR_Request_Pickup_Rope_Action = {
	params ["_unit", "_vehicle"];

	if (isNull _unit || {isNull _vehicle}) exitWith {};
	if (!alive _unit) exitWith {};

	if (vehicle _unit != _unit) exitWith {};
	if !(_vehicle isKindOf "Helicopter") exitWith {};
	if !(_vehicle getVariable ["APR_STABO_Deployed", false]) exitWith {};

	[_unit, _vehicle] call APR_Pickup_Rope;
};

APR_Pickup_Rope_Add_Player_Actions = {
	params ["_unit"];

	if (isNull _unit) exitWith {};
	if (_unit getVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false]) exitWith {};

	_unit setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", true];

	_unit addAction [
		"Drop STABO rope",
		{
			params ["_target", "_caller"];

			[_caller, vehicle _caller] call APR_Drop_STABO_Rope;
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
			&& {!((vehicle _this) getVariable ['APR_STABO_Deployed', false])}
		"
	];

	_unit addAction [
		"Detach STABO",
		{
			params ["_target", "_caller"];

			[vehicle _caller] call APR_Detach_STABO;
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
			&& {(vehicle _this) getVariable ['APR_STABO_Deployed', false]}
			&& {!([vehicle _this] call APR_Has_Attached_Players)}
		"
	];

	_unit addAction [
		"Detach from STABO",
		{
			params ["_target"];

			[_target] call APR_Detach_Unit_From_STABO;
		},
		nil,
		1.5,
		false,
		true,
		"",
		"
			alive _target
			&& {_target getVariable ['AR_Is_Rappelling', false]}
		"
	];

	_unit addEventHandler ["Respawn", {
		params ["_unit"];

		_unit setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false];

		[_unit] spawn {
			params ["_unit"];

			sleep 1;

			if (!isNull _unit && {alive _unit}) then {
				[_unit] call APR_Pickup_Rope_Add_Player_Actions;
			};
		};
	}];
};

if (hasInterface) then {
	[] spawn {
		waitUntil {
			sleep 1;
			!isNull player
		};

		{
			if (local _x && {alive _x}) then {
				[_x] call APR_Pickup_Rope_Add_Player_Actions;
			};
		} forEach allUnits;
	};

	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];

		if !(_entity isKindOf "Man") exitWith {};

		[_entity] spawn {
			params ["_unit"];

			sleep 1;

			if (local _unit && {alive _unit}) then {
				[_unit] call APR_Pickup_Rope_Add_Player_Actions;
			};
		};
	}];
};