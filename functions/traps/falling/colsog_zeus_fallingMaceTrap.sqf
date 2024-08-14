/*
 * Custom Zeus module: Create a Falling Mace Trap at location and with specific direction and height.
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
	_dialogResult params ["_trapDirection", "_trapHeight", "_treeType"];

	_input params ["_location", "_pos"];

    // Clicked position needs to be empty and not an object.
    if (isNull _location) exitWith {
        private _wireTrap = "vn_modulemine_punji_03" createVehicle _pos;
        _wireTrap setDir _trapDirection;
        [[_wireTrap, _trapHeight, _treeType], "functions\traps\falling\colsog_fn_createFallingMaceTrap.sqf"] remoteExec ["execVM", 0, true];
    };
};

// Module dialog
[
	"Place Falling Mace Trap",
	[
		["SLIDER", "(0=N, 90=E, 180=S, 270=W)" , [0, 360, 0, 0], true],
		["SLIDER", "Height", [0, 25, 0, 0], true],
		["TOOLBOX:WIDE", "Tree", [0, 4, 1, ["None", "Ficus Big Tree (height: 23)", "Inocarpus Tree (height: 13)", "palaquium Tree (height: 12)"]], true]
	],
	_onConfirm,
	{},
	[_location, _pos]
] call zen_dialog_fnc_create;