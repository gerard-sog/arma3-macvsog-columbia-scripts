/*
 * Custom Zeus module
 * Add addaction "chatter" to object
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_chatterobj", objNull, [objNull]]];

// if param is empty or Man unit, exit
if (isNull _chatterobj || (_chatterobj isKindOf "CAManBase")) exitWith {
	["Need an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localaction = _chatterobj getVariable "COLSOG_chatter";

if !(isNil "_localaction") exitWith {
	["Object already has chatter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

_chatterobj setVariable ["COLSOG_chatter", true, true];

Columbia_fnc_addchatter_to_object = {
	params ["_chatterobj"];
	_chatterobj addaction ["<t color='#82FA58'>Record chatter</t>", "functions\CHATTER\columbia_fnc_addchatter.sqf", nil, 1.5, false, true, "", "_target getVariable 'COLSOG_chatter'", 4, false];
};

{
	["zen_common_execute", [Columbia_fnc_addchatter_to_object, [_chatterobj]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;
