/*
 * Author: 1er RCC - Kay
 * Ring Fog module (from Aliascartoon scripts)
 * Add a ring fog centered on an helipad at position
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
	private _heliPosition = ASLToATL (_pos);
	private _helipad = createVehicle ["Land_HelipadEmpty_F", _pos vectorAdd [0, 0, 1], [], 0, "CAN_COLLIDE"];

	_helipad setPosATL _heliPosition;
	_helipad setVariable ["AL_high_ON", true, true]; // still setting a variable on object created, could be used to delete all at once

	[[_helipad, _mainColor], "functions\environment\colsog_fn_highFog.sqf"] remoteExec ["execVM", 0, true];
	["zen_common_addObjects", [[_helipad]]] call CBA_fnc_serverEvent;

};

// Module dialog
[
	"Spawn ring fog at position", [["COLOR", "Fog Color", [1,1,1], true]], _onConfirm, {}, _pos
] call zen_dialog_fnc_create;