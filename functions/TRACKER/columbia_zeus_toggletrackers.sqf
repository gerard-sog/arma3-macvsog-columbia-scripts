
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_trackerStatus", "_behaviour", "_combat", "_speed", "_update"];

    COLSOG_TrackersEnabled = _trackerStatus;
    publicVariable "COLSOG_TrackersEnabled";

    COLSOG_TrackersDefault = [_behaviour, _combat, _speed];
    publicVariable "COLSOG_TrackersDefault";

	if !(_update) exitWith {};

	private _groupToUpdate = [];

	{
		private _groupToAdd = _x getVariable "COLSOG_trackedGroup";
		if !(isNil "_groupToAdd") then {
			_groupToUpdate pushBack _x;
		};

	} forEach allGroups;

	// spawn group update
	[ 
		[_groupToUpdate], {
			params ["_groupToUpdate"];
			{
				_x setBehaviour (COLSOG_TrackersDefault select 0);
				_x setCombatMode (COLSOG_TrackersDefault select 1);
				_x setSpeedMode (COLSOG_TrackersDefault select 2);
			} forEach _groupToUpdate;
		}
	] remoteExecCall ["spawn", 2, false];

};

private _currentTrackerStatus = COLSOG_TrackersEnabled;

private _defaultBehaviour = 0;
private _defaultCombat = 0;
private _defaultSpeed = 0;

switch (COLSOG_TrackersDefault select 0) do
{
	case "CARELESS": {_defaultBehaviour = 0;};
	case "SAFE": {_defaultBehaviour = 1;};
	case "AWARE": {_defaultBehaviour = 2;};
	case "COMBAT": {_defaultBehaviour = 3;};
};

switch (COLSOG_TrackersDefault select 1) do
{
	case "BLUE": {_defaultCombat = 0;};
	case "GREEN": {_defaultCombat = 1;};
	case "WHITE": {_defaultCombat = 2;};
	case "YELLOW": {_defaultCombat = 3;};
  case "RED": {_defaultCombat = 4;};
};

switch (COLSOG_TrackersDefault select 2) do
{
	case "LIMITED": {_defaultSpeed = 0;};
	case "NORMAL": {_defaultSpeed = 1;};
	case "FULL": {_defaultSpeed = 2;};
};

// Module dialog
[
	"Toggle Trackers", [
		["TOOLBOX:YESNO", "Tracker in area", [_currentTrackerStatus], true],
		["COMBO", "Behaviour", [["CARELESS", "SAFE", "AWARE", "COMBAT"], [["Careless"], ["Safe"], ["Aware"], ["Combat"]], _defaultBehaviour]],
		["COMBO", "Combat", [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], [["Never fire"], ["Hold fire"], ["Hold fire, engage at will"], ["Fire at will"], "Fire at will, loose formation"], _defaultCombat]],
		["COMBO", "Speed", [["LIMITED", "NORMAL", "FULL"], [["Limited"], ["Normal"], ["Full"]], _defaultSpeed]],
		["TOOLBOX:YESNO", "Update already spawned groups", false, true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;