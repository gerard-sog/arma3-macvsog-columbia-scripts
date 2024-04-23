
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_cashelicopterstatus", "_casjetsstatus", "_artillerystatus"];

    CAS_HELICOPTER_SUPPORT_ENABLED = _cashelicopterstatus;
    publicVariable "CAS_HELICOPTER_SUPPORT_ENABLED";

    CAS_JETS_SUPPORT_ENABLED = _casjetsstatus;
    publicVariable "CAS_JETS_SUPPORT_ENABLED";

    ARTILLERY_SUPPORT_ENABLED = _artillerystatus;
    publicVariable "ARTILLERY_SUPPORT_ENABLED";

};

private _currentcashelicopterstatus = CAS_HELICOPTER_SUPPORT_ENABLED;
private _current_currentcasjetsstatus = CAS_JETS_SUPPORT_ENABLED;
private _currentartillerystatus = ARTILLERY_SUPPORT_ENABLED;

// Module dialog
[
	"Toggle CAS", [
		["TOOLBOX:YESNO", "CAS Heli Support", [_currentcashelicopterstatus], true],
		["TOOLBOX:YESNO", "CAS Jets Support", [_current_currentcasjetsstatus], true],
		["TOOLBOX:YESNO", "Artillery Support", [_currentartillerystatus], true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;