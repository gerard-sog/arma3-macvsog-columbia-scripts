params ["_sandbag"];

if (!hasInterface) exitWith {};
if (isNull _sandbag) exitWith {};
if (_sandbag getVariable ["APR_STABO_HoldAction_Added_Local", false]) exitWith {};

_sandbag setVariable ["APR_STABO_HoldAction_Added_Local", true];

[
	_sandbag,
	"Attach STABO rig",
	APR_STABO_HOLD_ACTION_ICON,
	APR_STABO_HOLD_ACTION_ICON,
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
			[_caller, _heli] call Dash_fnc_PickupRope;
		};
	},
	{},
	[],
	APR_STABO_HOLD_DURATION,
	6,
	false,
	false
] call BIS_fnc_holdActionAdd;
