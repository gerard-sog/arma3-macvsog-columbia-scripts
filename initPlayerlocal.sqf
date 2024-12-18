/*
 * initPlayerlocal.sqf
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 * https://community.bistudio.com/wiki/Initialisation_Order
 *
 * PArameters:
 * 0: _player
 * 1: _didJIP
 *
 */

params ["_player", "_didJIP"];

execVM "functions\init\init_colsog_PlayerLocalVar.sqf";

// good safety to wait player has finished downloading the mission, is on map screen, & alive (might need a [] spawn for waitUntil or CBA_fnc_waitUntilAndExecute)
//
//if (player != player) then {waitUntil {player == player};};
//if (!alive player) then {waitUntil {alive player};};

player setVariable ["saved_loadout", getUnitLoadout _player];	// sets the default loadout for respawn to initial loadout when player joined the server.

// set all variable on player
//
// f_languages for acre_api_fnc_babelSetSpokenLanguages
// hasUSface for COLSOG_fnc_faces
//
// todo: climbing, arma unitTraits

call COLSOG_fnc_faces;