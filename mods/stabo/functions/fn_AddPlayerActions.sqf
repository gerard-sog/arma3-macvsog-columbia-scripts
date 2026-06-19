params ["_unit"];

if (isNull _unit) exitWith {};
if (_unit getVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false]) exitWith {};

_unit setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", true];

_unit addAction [
	"Drop STABO rope",
	{
		params ["_target", "_caller"];
		[_caller, vehicle _caller] call Dash_fnc_DropStaboRope;
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
		[vehicle _caller] call Dash_fnc_DetachStabo;
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
		&& {!([vehicle _this] call Dash_fnc_HasAttachedPlayers)}
	"
];

_unit addAction [
	"Detach STABO rig",
	{
		params ["_target", "_caller"];

		[_caller] call Dash_fnc_DetachUnitFromStabo;
	},
	nil,
	1.5,
	false,
	true,
	"",
	"_this getVariable ['APR_STABO_IsAttached', false] && {alive _this}",
	-1,
	false,
	"",
	""
];

_unit addEventHandler ["Respawn", {
	params ["_unit"];

	_unit setVariable ["APR_Pickup_Rope_Player_Actions_Loaded", false];

	[_unit] spawn {
		params ["_unit"];
		sleep 1;

		if (!isNull _unit && {alive _unit}) then {
			[_unit] call Dash_fnc_AddPlayerActions;
		};
	};
}];
