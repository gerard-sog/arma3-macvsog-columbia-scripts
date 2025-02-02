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
	"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",
	{

		private _sandbags = nearestObjects [player, ["vn_prop_sandbag_01"], 6];

		private _parentHelicopter = [];
		private _sandbagtowatch = [];
		{
			private _parentVar = _x getVariable "COLSOG_staboParentHelicopter";
			if (!isNil "_parentVar") then {
				_parentHelicopter = _parentVar;
				_sandbagtowatch = _x;
			};
		} forEach _sandbags;

		[
			colsog_stabo_climbDuration,
			[_sandbagtowatch, _target],
			{
				params ["_args"];
				_args params ["_sandbagtowatch", "_target"];

				private _parentHelicopter = _sandbagtowatch getVariable "COLSOG_staboParentHelicopter";

				[player, _target, _parentHelicopter] call ace_common_fnc_loadPerson;

			},
			{},
			"Loading casualty into bird",
			{
				params ["_args"];
				_args params ["_sandbagtowatch", "_target"];
				private _parentVar = _sandbagtowatch getVariable "COLSOG_staboParentHelicopter";
				if (isNil "_parentVar") then {false;} else {true;};
			}
		] call ace_common_fnc_progressBar;

	},
	{
		private _sandbags = nearestObjects [player, ["vn_prop_sandbag_01"], 6];
		if (
				_target getVariable ["ACE_isUnconscious", false] && !(_sandbags isEqualTo [])
		) then {
			private _HasParentHelicopter = false;
			{
				private _parentVar = _x getVariable "COLSOG_staboParentHelicopter";
				if (!isNil "_parentVar") then {
					_HasParentHelicopter = true;
				};
			} forEach _sandbags;

			_HasParentHelicopter; // exit true if we have found an active STABO sandbag with a parent helicopter
		}
	}
] call ace_interact_menu_fnc_createAction;

["Man", 0, ["ACE_MainActions"], _staboLoadUncon, true] call ace_interact_menu_fnc_addActionToClass;
