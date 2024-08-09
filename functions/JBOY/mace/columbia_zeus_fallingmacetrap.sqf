/*
 * Custom Zeus module
 * Create a Falling Mace Trap at location and with specific direction and height.
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_location", objNull, [objNull]]];

private _onConfirm = {
    params ["_dialogResult", "_input"];
	_dialogResult params ["_trap_direction", "_trap_height"];
	_input params ["_location", "_pos"];

    // Clicked position needs to be empty and not an object.
    if (isNull _location) exitWith {
        _create_trap = "vn_modulemine_punji_03" createVehicle _pos;
        _create_trap setDir _trap_direction;
        [_create_trap, 'WEST', _trap_height] spawn {params ["_trap","_triggerActivatedBy", "_mace_height"];[_trap,_triggerActivatedBy,_mace_height] spawn JBOY_createFallingMaceTrap;};
    };
};

// Module dialog
[
	"Place Falling Mace Trap",
	[
		["SLIDER", "(0=N, 90=E, 180=S, 270=W)" , [0, 360, 0, 0], false],
		["SLIDER", "Height" , [0, 100, 0, 0], false]
	],
	_onConfirm,
	{},
	[_location, _pos] // _location and _pos passed as argument.
] call zen_dialog_fnc_create;