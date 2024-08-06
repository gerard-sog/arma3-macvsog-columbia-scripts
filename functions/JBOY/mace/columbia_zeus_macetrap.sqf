/*
 * Custom Zeus module
 * Create a Mace Trap at location
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_location", objNull, [objNull]]];

[str _pos, -1, 1, 4, 0] spawn BIS_fnc_dynamicText;

// Clicked position needs to be empty and not an object.
if (isNull _location) exitWith {
    _create_trap = "vn_modulemine_punji_03" createVehicle _pos;
    [_create_trap, 'WEST'] spawn {params ["_trap","_triggerActivatedBy"];[_trap,_triggerActivatedBy] spawn JBOY_maceTrapCreate;};
};