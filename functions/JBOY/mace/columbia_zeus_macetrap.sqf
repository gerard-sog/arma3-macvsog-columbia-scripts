/*
 * Custom Zeus module
 * Create a Mace Trap at location and with specific direction.
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_location", objNull, [objNull]]];

private _onConfirm = {
    params ["_dialogResult", "_input"];
	_dialogResult params ["_trap_direction"];
	_input params ["_location", "_posa"];

    // Clicked position needs to be empty and not an object.
    if (isNull _location) exitWith {
        _create_trap = "vn_modulemine_punji_03" createVehicle _posa;
        _create_trap setDir _trap_direction;
        [_create_trap, 'WEST'] spawn {params ["_trap","_triggerActivatedBy"];[_trap,_triggerActivatedBy] spawn JBOY_maceTrapCreate;};
    };
};

// Module dialog
[
	"Place Punji Trap",
	[
		["SLIDER", "(0=N, 90=E, 180=S, 270=W)" , [0, 360, 0, 0], false]
	],
	_onConfirm,
	{},
	[_location, _pos] // _location and _pos passed as argument.
] call zen_dialog_fnc_create;