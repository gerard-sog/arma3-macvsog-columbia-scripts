/*
 * Add "chatter" action on selected object.
 *
 * Arguments:
 * 0: object triggering action
 * 1: player triggering action
 */

params ["_chatterObject", "_caller"];

_chatterObject setVariable ["COLSOG_Chatter", false, true];

// duration = "2*60+47";
private _sound = playSound3D ["\vn\sounds_f_vietnam\sfx\missiondesign\vn_phoneline_1.ogg", _chatterObject, false, getPosASL _chatterObject, 1, 0.9, 10, 0, false];
waitUntil {soundParams _sound isEqualTo []};
