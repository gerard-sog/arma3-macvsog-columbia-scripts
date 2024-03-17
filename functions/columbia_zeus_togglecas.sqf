
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_casstatus", "_artillerystatus"];

    CAS_SUPPORT_ENABLED = _casstatus;
    publicVariable "CAS_SUPPORT_ENABLED";

    ARTILLERY_SUPPORT_ENABLED = _artillerystatus;
    publicVariable "ARTILLERY_SUPPORT_ENABLED";

};

private _currentcasstatus = CAS_SUPPORT_ENABLED;
private _currentartillerystatus = ARTILLERY_SUPPORT_ENABLED;

// Module dialog
[
	"Toggle CAS", [
		["TOOLBOX:YESNO", "CAS Support", [_currentcasstatus], true],
		["TOOLBOX:YESNO", "Artillery Support", [_currentartillerystatus], true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;