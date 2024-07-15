params [["_pos", [0,0,0] , [[]], 3], ["_helicopterobj", objNull, [objNull]]];

// if param is empty or Man unit, exit
if (isNull _helicopterobj || !(_helicopterobj isKindOf "Helicopter")) exitWith {
	["Need a helicopter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localaction = _helicopterobj getVariable "COLSOG_stabo";

if!(isNil "_localaction") exitWith {
	["Helicopter already has a STABO", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

_helicopterobj setVariable ["COLSOG_stabo", true, true];

Columbia_fnc_addstabo_to_helicopter = {
	params ["_helicopterobj"];
	_helicopterobj addAction
      [
          "Drop the STABO rig",
          "functions\Stabo\dropSTABO.sqf",
          nil,
          1.5,
          true,
          true,
          "",
          "_this distance _target < 3 AND !STABO_ROPE_DEPLOYED",
          50,
          false,
          "",
          ""
      ];
      _helicopterobj addAction
      [
          "Detatch ropes",
          "functions\Stabo\detatchRopes.sqf",
          nil,
          1.5,
          true,
          true,
          "",
          "_this distance _target < 3 AND STABO_ROPE_DEPLOYED",
          50,
          false,
          "",
          ""
      ];
};

{
	["zen_common_execute", [Columbia_fnc_addstabo_to_helicopter, [_helicopterobj]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;

["STABO added", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;