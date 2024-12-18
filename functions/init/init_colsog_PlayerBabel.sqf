/*
 * Set Babel spoken language for player
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 * Called again when player respawn
 *
 */


if (!hasInterface) exitWith {};

//_languagesPlayerSpeaks = player getVariable ["f_languages", []]; // get old var from eden
_languagesPlayerSpeaks = player getVariable ["canSpeak", []]; // get old var from eden

switch (playerside) do {
case west: {
		if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["en"];};
		// Have the MACVSOG team able to talk and understand each other (using English)
	};
case east: {
		if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
	};
case independent: {
		if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
	};
case civilian: {
		if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
	};
};
_languagesPlayerSpeaks call acre_api_fnc_babelSetSpokenLanguages;

// The below lines are only executed by ZEUS. (event is created for every player)
// When someone controls a unit (zeus), this event handler will be triggered.
["unit", {
    params ["_player"];
    switch ((getNumber (configFile >> "CfgVehicles" >> (typeOf _player) >> "side"))) do {
        case 0: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };          // OPFOR
        case 1: { ["en"] call acre_api_fnc_babelSetSpokenLanguages; };          // BLUFOR
        case 2: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };          // INDEP
        case 3: { ["vn"] call acre_api_fnc_babelSetSpokenLanguages; };          // CIVIL
    };
}, true] call CBA_fnc_addPlayerEventHandler;