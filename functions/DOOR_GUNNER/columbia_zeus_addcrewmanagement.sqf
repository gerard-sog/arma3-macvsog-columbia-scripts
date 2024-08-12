params [["_pos", [0,0,0] , [[]], 3], ["_helicopterobj", objNull, [objNull]]];

// if param is empty or not Helicopter type, exit
if (isNull _helicopterobj || !(_helicopterobj isKindOf "Helicopter")) exitWith {
	["Need a helicopter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localaction = _helicopterobj getVariable "COLSOG_crew_management";

if!(isNil "_localaction") exitWith {
	["Helicopter already has crew management", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

// Broadcast (3rd parameter) is not really needed except if multiple zeus, if only 1 could be false to save network traffic
_helicopterobj setVariable ["COLSOG_crew_management", true, true];

Columbia_fnc_add_crew_management_to_helicopter = {
	params ["_helicopterobj"];
    _helicopterobj setVariable ["COLSOG_has_crew", false, true]; // Should not need Broadcast because setVariable is already done in a forEeach allPlayers
	_helicopterobj addAction
      [
          "<t color='#FFFF00'>Request crew</t>",
          "functions\DOOR_GUNNER\columbia_fnc_add_crew.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND !(_target getVariable 'COLSOG_has_crew')",
          50,
          false,
          "",
          ""
      ];
      _helicopterobj addAction
      [
          "<t color='#FFFF00'>Remove crew</t>",
          "functions\DOOR_GUNNER\columbia_fnc_delete_crew.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND (_target getVariable 'COLSOG_has_crew')",
          50,
          false,
          "",
          ""
      ];
};

// Attach both addAction to allPlayers
{
	["zen_common_execute", [Columbia_fnc_add_crew_management_to_helicopter, [_helicopterobj]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;

["STABO added", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;