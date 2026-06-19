params ["_heli"];

if (isNull _heli) exitWith {};

if !(missionNamespace getVariable ["APR_STABO_CLIMB_SUPPRESSION_ENABLED", false]) exitWith {
	_heli setVariable ["APR_STABO_ForceActive", false, true];
	_heli setVariable ["APR_STABO_AttachedCount", 0, true];
};

if (!isServer) exitWith {
	[_heli] remoteExecCall [
		"Dash_fnc_UpdateStaboDownwardForce",
		2
	];
};

private _attachedCount = 0;

for "_i" from 0 to ((call APR_STABO_GetSlotCount) - 1) do {
	private _unit = _heli getVariable [
		"APR_STABO_Player_" + str _i,
		objNull
	];

	if (!isNull _unit && {alive _unit}) then {
		_attachedCount = _attachedCount + 1;
	};
};

if (APR_STABO_DEBUG_ENABLED) then {
	[
		format [
			"STABO DEBUG: attached players = %1",
			_attachedCount
		]
	] remoteExec ["systemChat", crew _heli];
};

// Store latest count
_heli setVariable [
	"APR_STABO_AttachedCount",
	_attachedCount,
	true
];

// No players = fully stop
if (_attachedCount <= 0) exitWith {
	_heli setVariable [
		"APR_STABO_ForceActive",
		false,
		true
	];
};

// Start loop ONLY if not already running
if !(_heli getVariable [
	"APR_STABO_ForceLoopRunning",
	false
]) then {

	_heli setVariable [
		"APR_STABO_ForceActive",
		true,
		true
	];

	[_heli] remoteExecCall [
		"Dash_fnc_ApplyStaboDownwardForce",
		owner _heli
	];
};