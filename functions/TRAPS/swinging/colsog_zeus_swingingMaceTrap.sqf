/*
 * Custom Zeus module: Create a Swinging Mace Trap at location and with specific direction.
 *
 * Arguments:
 * 0: logic position
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0, 0, 0] , [[]], 3], ["_location", objNull, [objNull]]];

private _onConfirm = {
    params ["_dialogResult", "_input"];
	_dialogResult params ["_trapDirection"];
	_input params ["_location", "_pos"];

    // Clicked position needs to be empty and not an object.
    if (isNull _location) exitWith {
        private _wireTrap = "vn_modulemine_punji_03" createVehicle _pos;
        _wireTrap setDir _trapDirection;
        [[_wireTrap], "functions\TRAPS\swinging\colsog_fn_createSwingingMaceTrap.sqf"] remoteExec ["execVM", 0, true];
    };
};

// Module dialog
[
	"Place Swinging Mace Trap",
	[
		["SLIDER", "(0=N, 90=E, 180=S, 270=W)" , [0, 360, 0, 0], true]
	],
	_onConfirm,
	{},
	[_location, _pos]
] call zen_dialog_fnc_create;