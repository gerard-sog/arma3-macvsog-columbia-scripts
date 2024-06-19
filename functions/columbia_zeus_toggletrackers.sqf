
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_trackerstatus", "_behaviour", "_combat", "_speed"];

    TRACKERS_ENABLED = _trackerstatus;
    publicVariable "TRACKERS_ENABLED";

    TRACKERS_DEFAULT = [_behaviour, _combat, _speed];
    publicVariable "TRACKERS_DEFAULT";
};

private _currenttrackerstatus = TRACKERS_ENABLED;

// Module dialog
[
	"Toggle Trackers", [
		["TOOLBOX:YESNO", "Tracker in area", [_currenttrackerstatus], true],
		["COMBO", "Behaviour", [["CARELESS", "SAFE", "AWARE", "COMBAT"], [["Careless"], ["Safe"], ["Aware"], ["Combat"]], 0]],
		["COMBO", "Combat", [["BLUE", "GREEN", "WHITE", "YELLOW", "RED"], [["Never fire"], ["Hold fire"], ["Hold fire, engage at will"], ["Fire at will"], "Fire at will, loose formation"], 0]],
		["COMBO", "Speed", [["LIMITED", "NORMAL", "FULL"], [["Limited"], ["Normal"], ["Full"]], 0]]
	], _onConfirm, {}
] call zen_dialog_fnc_create;