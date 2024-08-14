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
	_maincolor = _dialogResult select 0;

	_helipos= ASLToATL (_pos);
	_helipad = createVehicle ["Land_HelipadEmpty_F", _pos vectorAdd [0, 0, 1], [], 0, "CAN_COLLIDE"];
	_helipad setposATL _helipos;
	_helipad setVariable ["AL_lowfog_ON", true, true]; // still setting a variable on object created, could be used to delete all at once

	[[_helipad, _maincolor], "functions\AL_localfog\low_fog.sqf"] remoteExec ["execVM", 0, true];
	["zen_common_addObjects", [[_helipad]]] call CBA_fnc_serverEvent;

};

// Module dialog
[
	"Spawn low fog at position", [["COLOR", "Fog Color", [1,1,1], true]], _onConfirm, {}, _pos // _pos passed as argument
] call zen_dialog_fnc_create;