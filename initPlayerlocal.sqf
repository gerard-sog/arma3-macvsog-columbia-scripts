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

execVM "functions\init\init_colsog_PlayerLocalVar.sqf"; // player exists we can set variables on object player

// ACRE BABEL config
colsog_available_languages = [["en", "English"], ["vn", "Vietnamese"]];
{
	_x call acre_api_fnc_babelAddLanguageType;
} forEach colsog_available_languages;
// exec only for players https://github.com/IDI-Systems/acre2/blob/master/addons/api/fnc_babelAddLanguageType.sqf#L20

// Safety to be sure player has finished downloading the mission, is on map screen, alive (inventory loaded, acre initialized)
[
	{_this == _this}, // waitUntil {player == player}
	{
		[
			{alive _this}, // waitUntil {alive player}
			{
				// sets the default loadout for respawn to initial loadout when player joined the server.
				_this setVariable ["saved_loadout", getUnitLoadout _this];

				// force vietnamese face if needed
				call COLSOG_fnc_faces;

				// init Babel spoken language
				execVM "functions\init\init_colsog_PlayerBabel.sqf";
				// init Babel zeus switch language
				execVM "functions\init\init_colsog_ZeusBabelSwitch.sqf";
			}, 
			_this // argument (still player)
		] call CBA_fnc_waitUntilAndExecute;
	}, 
	player // argument passes to condition & statement
] call CBA_fnc_waitUntilAndExecute;