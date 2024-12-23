/*
 * Custom Zeus module: Create a Falling Mace Trap at location and with specific direction and height.
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

// Clicked position needs to be empty and not an object
if (!isNull _object) exitWith {
	["Need a position and not an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _onConfirm = {
    params ["_dialogResult", "_pos"];
	_dialogResult params ["_trapDirection", "_trapHeight", "_treeType"];

	private _wireTrap = "vn_modulemine_punji_03" createVehicle _pos;
	_wireTrap setDir _trapDirection;
	
	// Needs to be sent to server.
	[[_wireTrap, _trapHeight, _treeType], "functions\traps\falling\colsog_fn_createFallingMaceTrap.sqf"] remoteExec ["execVM", 2, false];

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
	_pos // only need position as _arguments for _onConfirm
] call zen_dialog_fnc_create;