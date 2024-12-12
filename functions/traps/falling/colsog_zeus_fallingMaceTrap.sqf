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

// Clicked position needs to be empty and not an object. (test before menu creation)
if (!isNull _object) exitWith {
	["Need a position and not an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _onConfirm = {
    params ["_dialogResult", "_pos"]; // if a single _arguments is passed, can be named directly
	_dialogResult params ["_trapDirection", "_trapHeight", "_treeType"];

	private _wireTrap = "vn_modulemine_punji_03" createVehicle _pos;
	_wireTrap setDir _trapDirection;

	// add wiretrap to zeus (planned to be used to delete whole composition)
	["zen_common_updateEditableObjects", [[_supplyBox], true]] call CBA_fnc_serverEvent;
	
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