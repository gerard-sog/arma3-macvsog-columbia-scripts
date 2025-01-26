/*
 * Adds an ace action to load unconscious player into Stabo sandbag
 *
 * Return values:
 * None
 */

if !(hasInterface) exitWith {};

_staboLoadUncon = [
	"COLSOG_staboLoadUncon",
	"Load body",
	"\a3\modules_f\data\hideterrainobjects\icon_ca.paa",
	{
		private _frozenDroppedSandbag = nearestObjects [player, ["vn_prop_sandbag_01"], 6];

		private _parentHelicopter = [];
		{
			private _parent = _x getVariable "COLSOG_staboParentHelicopter";
			if (!isNil "_parent") then {
				_parentHelicopter = _parent;
			};
		} forEach _frozenDroppedSandbag;

		[player, _target, _parentHelicopter] call ace_common_fnc_loadPerson;
	},
	{
		true
	}
] call ace_interact_menu_fnc_createAction;

["Man", 0, ["ACE_MainActions"], _staboLoadUncon, true] call ace_interact_menu_fnc_addActionToClass;
