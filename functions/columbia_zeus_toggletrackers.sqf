
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_trackerstatus", "_behaviour", "_combat", "_speed", "_update"];

    TRACKERS_ENABLED = _trackerstatus;
    publicVariable "TRACKERS_ENABLED";

    TRACKERS_DEFAULT = [_behaviour, _combat, _speed];
    publicVariable "TRACKERS_DEFAULT";

	if !(_update) exitWith {};

	private _grouptoupdate = [];

	{

		private _grouptoadd = _x getVariable "ColumbiaTrackedGroup";
		if !(isNil "_grouptoadd") then {
			_grouptoupdate pushBack _x;
		};

	} forEach allGroups;

	// spawn group update
	[ 
		[_grouptoupdate], { 
			params ["_grouptoupdate"];
			{
				_x setBehaviour (TRACKERS_DEFAULT select 0);
				_x setCombatMode (TRACKERS_DEFAULT select 1);
				_x setSpeedMode (TRACKERS_DEFAULT select 2);
			} forEach _grouptoupdate;
		}
	] remoteExecCall ["spawn", 2, false];

};

private _currenttrackerstatus = TRACKERS_ENABLED;

private _defaultBehaviour = 0;
private _defaultCombat = 0;
private _defaultSpeed = 0;

switch (TRACKERS_DEFAULT select 0) do
{
	case "CARELESS": {_defaultBehaviour = 0;};
	case "SAFE": {_defaultBehaviour = 1;};
	case "AWARE": {_defaultBehaviour = 2;};
	case "COMBAT": {_defaultBehaviour = 3;};
};

switch (TRACKERS_DEFAULT select 1) do
{
	case "BLUE": {_defaultCombat = 0;};
	case "GREEN": {_defaultCombat = 1;};
	case "WHITE": {_defaultCombat = 2;};
	case "YELLOW": {_defaultCombat = 3;};
  case "RED": {_defaultCombat = 4;};
};

switch (TRACKERS_DEFAULT select 2) do
{
	case "LIMITED": {_defaultSpeed = 0;};
	case "NORMAL": {_defaultSpeed = 1;};
	case "FULL": {_defaultSpeed = 2;};
};

// Module dialog
[
	"Toggle Trackers", [
		["TOOLBOX:YESNO", "Tracker in area", [_currenttrackerstatus], true],
		["COMBO", "Behaviour", [["CARELESS", "SAFE", "AWARE", "COMBAT"], [["Careless"], ["Safe"], ["Aware"], ["Combat"]], _defaultBehaviour]],
		["COMBO", "Combat", [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], [["Never fire"], ["Hold fire"], ["Hold fire, engage at will"], ["Fire at will"], "Fire at will, loose formation"], _defaultCombat]],
		["COMBO", "Speed", [["LIMITED", "NORMAL", "FULL"], [["Limited"], ["Normal"], ["Full"]], _defaultSpeed]],
		["TOOLBOX:YESNO", "Update already spawned groups", false, true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;