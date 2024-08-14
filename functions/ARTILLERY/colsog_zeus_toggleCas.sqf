params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_casHelicopterStatus", "_casJetStatus", "_artilleryStatus", "_arcLightStatus", "_daisyCutterStatus"];

    COLSOG_CasHelicopterSupportEnabled = _casHelicopterStatus;
    publicVariable "COLSOG_CasHelicopterSupportEnabled";

    COLSOG_CasJetSupportEnabled = _casJetStatus;
    publicVariable "COLSOG_CasJetSupportEnabled";

    COLSOG_ArtillerySupportEnabled = _artilleryStatus;
    publicVariable "COLSOG_ArtillerySupportEnabled";

    COLSOG_ArcLightSupportEnabled = _arcLightStatus;
    publicVariable "COLSOG_ArcLightSupportEnabled";

    COLSOG_DaisyCutterSupportEnabled = _daisyCutterStatus;
    publicVariable "COLSOG_DaisyCutterSupportEnabled";
};

private _currentCasHelicopterStatus = COLSOG_CasHelicopterSupportEnabled;
private _currentCasJetStatus = COLSOG_CasJetSupportEnabled;
private _currentArtilleryStatus = COLSOG_ArtillerySupportEnabled;
private _currentArcLightStatus = COLSOG_ArcLightSupportEnabled;
private _currentDaisyCutterStatus = COLSOG_DaisyCutterSupportEnabled;

// Module dialog
[
	"Toggle CAS", [
		["TOOLBOX:YESNO", "CAS Heli Support", [_currentCasHelicopterStatus], true],
		["TOOLBOX:YESNO", "CAS Jets Support", [_currentCasJetStatus], true],
		["TOOLBOX:YESNO", "Artillery Support", [_currentArtilleryStatus], true],
		["TOOLBOX:YESNO", "Arc Light Support", [_currentArcLightStatus], true],
		["TOOLBOX:YESNO", "Daisy Cutter Support", [_currentDaisyCutterStatus], true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;