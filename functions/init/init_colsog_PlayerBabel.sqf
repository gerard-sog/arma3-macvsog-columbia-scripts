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

switch (playerSide) do {
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

systemChat str _languagesPlayerSpeaks;