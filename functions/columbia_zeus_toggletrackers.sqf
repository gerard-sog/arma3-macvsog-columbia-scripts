
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
			_grouptoupdate = _grouptoupdate append _x;
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

// Module dialog
[
	"Toggle Trackers", [
		["TOOLBOX:YESNO", "Tracker in area", [_currenttrackerstatus], true],
		["COMBO", "Behaviour", [["CARELESS", "SAFE", "AWARE", "COMBAT"], [["Careless"], ["Safe"], ["Aware"], ["Combat"]], 0]],
		["COMBO", "Combat", [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], [["Never fire"], ["Hold fire"], ["Hold fire, engage at will"], ["Fire at will"], "Fire at will, loose formation"], 0]],
		["COMBO", "Speed", [["LIMITED", "NORMAL", "FULL"], [["Limited"], ["Normal"], ["Full"]], 0]],
		["TOOLBOX:YESNO", "Update already spawned groups", false, true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;