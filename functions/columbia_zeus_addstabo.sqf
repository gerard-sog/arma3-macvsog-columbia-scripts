params [["_pos", [0,0,0] , [[]], 3], ["_helicopterobj", objNull, [objNull]]];

// if param is empty or not Helicopter type, exit
if (isNull _helicopterobj || !(_helicopterobj isKindOf "Helicopter")) exitWith {
	["Need a helicopter", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localaction = _helicopterobj getVariable "COLSOG_stabo";

if!(isNil "_localaction") exitWith {
	["Helicopter already has a STABO", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

// Broadcast (3rd parameter) is not really needed except if multiple zeus, if only 1 could be false to save network traffic
_helicopterobj setVariable ["COLSOG_stabo", true, true];

Columbia_fnc_addstabo_to_helicopter = {
	params ["_helicopterobj"];
    _helicopterobj setVariable ["COLSOG_stabo_rope_deployed", false, false]; // Should not need Broadcast because setVariable is already done in a forEeach allPlayers
	_helicopterobj addAction
      [
          "<t color='#FF0000'>Drop the STABO rig</t>",
          "functions\Stabo\dropSTABO.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND !(_target getVariable 'COLSOG_stabo_rope_deployed')", // brackets not needed but better readability of condition shown
          50,
          false,
          "",
          ""
      ];
      _helicopterobj addAction
      [
          "<t color='#FF0000'>Detatch ropes</t>",
          "functions\Stabo\detatchRopes.sqf",
          nil,
          0,
          true,
          true,
          "",
          "(_this in _target) AND (_target getVariable 'COLSOG_stabo_rope_deployed')", // single quotes when string is inside double quotes
          50,
          false,
          "",
          ""
      ];
};

// Attach both addAction to allPlayers
{
	["zen_common_execute", [Columbia_fnc_addstabo_to_helicopter, [_helicopterobj]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;

["STABO added", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;