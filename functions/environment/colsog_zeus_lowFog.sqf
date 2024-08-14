/*
 * Author: 1er RCC - Kay
 * Low Fog module (from Aliascartoon scripts)
 * Add a low fog centered on an helipad at position
 *
 * Arguments:
 * 0: fog position
 * 1: attached object (not used)
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult", "_pos"];

	private _mainColor = _dialogResult select 0;
	private _heliPosition= ASLToATL (_pos);
	private _helipad = createVehicle ["Land_HelipadEmpty_F", _pos vectorAdd [0, 0, 1], [], 0, "CAN_COLLIDE"];

	_helipad setPosATL _heliPosition;

	[[_helipad, _mainColor], "functions\environment\colsog_fn_lowFog.sqf"] remoteExec ["execVM", 0, true];
	["zen_common_addObjects", [[_helipad]]] call CBA_fnc_serverEvent;

};

// Module dialog
[
	"Spawn low fog at position", [["COLOR", "Fog Color", [1,1,1], true]], _onConfirm, {}, _pos
] call zen_dialog_fnc_create;