/*
 * Custom Zeus module: Add "Crew management" action on selected object.
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

private _localAction = _helicopterObject getVariable "COLSOG_CrewManagement";

if!(isNil "_localAction") exitWith {
	["Helicopter already has crew management", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

// Broadcast (3rd parameter) is not really needed except if multiple zeus, if only 1 could be false to save network traffic
_helicopterObject setVariable ["COLSOG_CrewManagement", true, true];

COLSOG_fnc_addCrewManagementToHelicopter = {
	params ["_helicopterObject"];
    _helicopterObject setVariable ["COLSOG_HasCrew", false, true]; // Should not need Broadcast because setVariable is already done in a forEeach allPlayers
	_helicopterObject addAction
      [
          "<t color='#FFFF00'>Request crew</t>",
          "functions\DOOR_GUNNER\colsog_fn_addCrew.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND !(_target getVariable 'COLSOG_HasCrew')",
          50,
          false,
          "",
          ""
      ];
      _helicopterObject addAction
      [
          "<t color='#FFFF00'>Remove crew</t>",
          "functions\DOOR_GUNNER\colsog_fn_deleteCrew.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND (_target getVariable 'COLSOG_HasCrew')",
          50,
          false,
          "",
          ""
      ];
};

// Attach both addAction to allPlayers
{
	["zen_common_execute", [COLSOG_fnc_addCrewManagementToHelicopter, [_helicopterObject]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;

["Crew management added", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;