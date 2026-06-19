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
[_anchor, true] remoteExecCall ["hideObjectGlobal", 2];
_anchor attachTo [_heli, _rappelPoint];

private _rappelDevice = "B_static_AA_F" createVehicle position _unit;
_rappelDevice allowDamage false;
hideObject _rappelDevice;
[_rappelDevice, true] remoteExecCall ["hideObjectGlobal", 2];

_unit setVariable ["APR_STABO_RappelDevice", _rappelDevice, true];
_unit setVariable ["APR_STABO_BottomRope", objNull, true];

private _topRopeLength = (_slotIndex + 1) * APR_STABO_SEGMENT_LENGTH;
private _topRope = ropeCreate [_rappelDevice, [0, 0.15, 0], _anchor, [0, 0, 0], _topRopeLength];
_topRope allowDamage false;
_unit switchMove "Acts_StaticDeath_11";

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
	private _currentHeliPos = AGLToASL (_heli modelToWorldVisual _rappelPoint);

	if (_newPosition distance _currentHeliPos > _topRopeLength) then {
		_newPosition = _currentHeliPos vectorAdd (
			(vectorNormalized (_currentHeliPos vectorFromTo _newPosition)) vectorMultiply _topRopeLength
		);

		private _surfaceVector = vectorNormalized (_newPosition vectorFromTo _currentHeliPos);
		_velocityVec = _velocityVec vectorAdd (
			(_surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1
		);
	};

	_rappelDevice setPosWorld (
		_lastPosition vectorAdd ((_newPosition vectorDiff _lastPosition) vectorMultiply 6)
	);

	_rappelDevice setVectorDir vectorDir _unit;

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
		!alive _unit
		|| {lifeState _unit == "DEAD"}
		|| {vehicle _unit != _unit}
		|| {_unit getVariable ["APR_STABO_DetachRequested", false]}
	) exitWith {};

    if (animationState _unit != "Acts_StaticDeath_11") then {
    	_unit switchMove "Acts_StaticDeath_11";
    };

	sleep 0.01;
};

private _bottomRope = _unit getVariable ["APR_STABO_BottomRope", objNull];

if (!isNull _bottomRope) then {
	ropeDestroy _bottomRope;
};

ropeDestroy _topRope;
deleteVehicle _anchor;
deleteVehicle _rappelDevice;

_unit setVariable ["APR_STABO_IsAttached", nil, true];
_unit setVariable ["APR_STABO_DetachRequested", nil, true];
_unit setVariable ["APR_STABO_Vehicle", nil, true];
_unit setVariable ["APR_STABO_SlotIndex", nil, true];
_unit setVariable ["APR_STABO_RappelDevice", nil, true];
_unit setVariable ["APR_STABO_BottomRope", nil, true];

_unit switchMove "";
_unit playMoveNow "";

sleep 2;
_unit allowDamage true;