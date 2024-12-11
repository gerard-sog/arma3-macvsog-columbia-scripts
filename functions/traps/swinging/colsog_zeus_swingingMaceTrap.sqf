/*
 * Custom Zeus module: Create a Swinging Mace Trap at location and with specific direction.
 *
 * Arguments:
 * 0: logic position
 * 1: attached object (not used)
 *
 * Locality:
 * On Zeus local computer.
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0, 0, 0] , [[]], 3], ["_object", objNull, [objNull]]];

// Clicked position needs to be empty and not an object. (test before menu creation)
if (!isNull _object) exitWith {
	["Need a position and not an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _onConfirm = {
    params ["_dialogResult", "_pos"];
	_dialogResult params ["_trapDirection"];

	private _wireTrap = "vn_modulemine_punji_03" createVehicle _pos;
	_wireTrap setDir _trapDirection;
	[[_wireTrap], "functions\traps\swinging\colsog_fn_createSwingingMaceTrap.sqf"] remoteExec ["execVM", 2, false];

};

// Module dialog
[
	"Place Swinging Mace Trap",
	[
		["SLIDER", "(0=N, 90=E, 180=S, 270=W)" , [0, 360, 0, 0], true]
	],
	_onConfirm,
	{},
	_pos // only need position as _arguments for _onConfirm
] call zen_dialog_fnc_create;