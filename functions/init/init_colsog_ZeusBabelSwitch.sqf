/*
 * Set Babel switch language for remote controlling unit
 * Executed locally when player joins mission (includes both mission start and JIP)
 * DO NOT call again at respawn: It creates multiple events !
 *
 * Event is created for every player
 * When someone controls a unit, this event handler will be triggered
 *
 */

if (!hasInterface) exitWith {};

["unit", {
    params ["_player"];
    switch ((getNumber (configFile >> "CfgVehicles" >> (typeOf _player) >> "side"))) do {
        case 0: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };		// OPFOR
        case 1: { ["en"] call acre_api_fnc_babelSetSpokenLanguages; };		// BLUFOR
        case 2: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };		// INDEP
        case 3: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };		// CIVIL
    };
}, false] call CBA_fnc_addPlayerEventHandler; // _applyRetroactively false or it fires immediately 