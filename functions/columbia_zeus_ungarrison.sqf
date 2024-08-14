/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * if SquadLeader loop trough each units in group & enable path/move
 * if Not SquadLeader, separate into new group & find nearest building exit with MOVE waypoint
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached unit
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

//if unit is empty/null/player, exit
if (isNull _unit || !(_unit isKindOf "CAManBase") || isPlayer _unit) exitWith {
	["Select an AI unit", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};


COLSOG_fnc_unGarrison = {
	params ["_unit"];

	if (isFormationLeader _unit) then {
		{
			_x enableAI "PATH";
			_x enableAI "MOVE";
		} foreach units (group _unit);

	} else {
		[_unit] join grpNull;
		private _newGroup = group _unit;
		private _exit = nearestBuilding _unit buildingExit 0;
		private _waypoint = _newGroup addWaypoint [_exit, 5];

		_unit enableAI "PATH";
		_unit enableAI "MOVE";
		_waypoint setWaypointType "MOVE";
	};
};

["zen_common_execute", [COLSOG_fnc_unGarrison, [_unit]], _unit] call CBA_fnc_targetEvent;