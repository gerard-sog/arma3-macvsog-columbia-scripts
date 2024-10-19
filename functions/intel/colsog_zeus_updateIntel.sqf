/*
 * Module for zeus to update (remove/add) intel during a mission.
 *
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0, 0, 0] , [[]], 3], ["_location", objNull, [objNull]]];

private _onConfirm = {
    params ["_dialogResult"];
	_dialogResult params ["_intelString"];

    private _intelArrayOfString = parseSimpleArray _intelString;
    COLSOG_intelPool = _intelArrayOfString;
    publicVariable "COLSOG_intelPool";
};

// Module dialog
[
	"Manage intel",
	[
		["EDIT:MULTI", "Manage intel (ARRAY of Text)", [COLSOG_intelPool, nil, 4], false]
	],
	_onConfirm,
	{},
	[]
] call zen_dialog_fnc_create;
