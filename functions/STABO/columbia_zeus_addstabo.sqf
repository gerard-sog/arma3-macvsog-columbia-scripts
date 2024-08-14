/*
 * Custom Zeus module: Add "STABO" action on selected object.
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_helicopterObject", objNull, [objNull]]];

// if param is empty or not Helicopter type, exit
if (isNull _helicopterObject || !(_helicopterObject isKindOf "Helicopter")) exitWith {
	["Need a helicopter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localAction = _helicopterObject getVariable "COLSOG_stabo";

if!(isNil "_localAction") exitWith {
	["Helicopter already has a STABO", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

// Broadcast (3rd parameter) is not really needed except if multiple zeus, if only 1 could be false to save network traffic
_helicopterObject setVariable ["COLSOG_stabo", true, true];

COLSOG_fnc_addStaboToHelicopter = {
	params ["_helicopterObject"];
    _helicopterObject setVariable ["COLSOG_staboRopeDeployed", false, false]; // Should not need Broadcast because setVariable is already done in a forEeach allPlayers
	_helicopterObject addAction
      [
          "<t color='#FF0000'>Drop the STABO rig</t>",
          "functions\STABO\dropSTABO.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND !(_target getVariable 'COLSOG_staboRopeDeployed')", // brackets not needed but better readability of condition shown
          50,
          false,
          "",
          ""
      ];
      _helicopterObject addAction
      [
          "<t color='#FF0000'>Detach ropes</t>",
          "functions\STABO\detatchRopes.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (_target getVariable 'COLSOG_staboRopeDeployed')", // single quotes when string is inside double quotes
          50,
          false,
          "",
          ""
      ];
};

// Attach both addAction to allPlayers
{
	["zen_common_execute", [COLSOG_fnc_addStaboToHelicopter, [_helicopterObject]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;

["STABO added", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;