
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_trackerstatus"];

    TRACKERS_ENABLED = _trackerstatus;
    publicVariable "TRACKERS_ENABLED";
};

private _currenttrackerstatus = TRACKERS_ENABLED;

// Module dialog
[
	"Toggle Trackers", [
		["TOOLBOX:YESNO", "Tracker in area", [_currenttrackerstatus], true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;