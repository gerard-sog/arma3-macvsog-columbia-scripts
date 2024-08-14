/*
 * Custom Zeus module: Add "chatter" action on selected object.
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_chatterObject", objNull, [objNull]]];

// if param is empty or Man unit, exit
if (isNull _chatterObject || (_chatterObject isKindOf "CAManBase")) exitWith {
	["Need an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localAction = _chatterObject getVariable "COLSOG_Chatter";

if !(isNil "_localAction") exitWith {
	["Object already has chatter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

_chatterObject setVariable ["COLSOG_Chatter", true, true];

COLSOG_fnc_addChatterToObject = {
	params ["_chatterObject"];
	_chatterObject addAction ["<t color='#82FA58'>Record chatter</t>", "functions\CHATTER\colsog_fn_addChatter.sqf", nil, 1.5, false, true, "", "_target getVariable 'COLSOG_Chatter'", 4, false];
};

{
	["zen_common_execute", [COLSOG_fnc_addChatterToObject, [_chatterObject]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;
