/*
 * Action "chatter"
 *
 * Arguments:
 * 0: object triggering action
 * 1: player triggering action

 *
 * Example (in eden init field):
 * this setVariable ["COLSOG_chatter", true, true];
 * this addaction ["<t color='#82FA58'>Listen to chatter</t>", "functions\columbia_fnc_addchatter.sqf", nil, 1.5, false, true, "", "", 4, false];
 *
 */

params ["_chatterobj", "_caller"];

_chatterobj setVariable ["COLSOG_chatter", false, true];

// duration = "2*60+47";
private _sound = playSound3D ["\vn\sounds_f_vietnam\sfx\missiondesign\vn_phoneline_1.ogg", _chatterobj, false, getPosASL _chatterobj, 1, 0.9, 5, 0, false];
waitUntil {soundParams _sound isEqualTo []};
