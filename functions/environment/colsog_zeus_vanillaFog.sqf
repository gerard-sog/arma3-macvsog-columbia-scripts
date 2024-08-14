/*
 * Author: 1er RCC - Kay
 * Vanilla Fog Transition
 *
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_vanillaFog", "_vanillaFogDuration", "_vanillaFogDensity", "_vanillaFogDecay", "_vanillaFogAltitude"];

	// exec initfog server-side it not NO CHANGE
	if (_vanillaFog) then {
		[_vanillaFogDuration, [_vanillaFogDensity, _vanillaFogDecay, _vanillaFogAltitude]] remoteExec ["setFog", 2];
	};
};


private _actualFog = fogparams;

// Module dialog
[
	"Vanilla Fog Transition",
	[
		["TOOLBOX:YESNO", ["Vanilla Fog Transition", "Vanilla fog will be transitioned by the module"], [false], true],
		["SLIDER", [">>> Duration", "Time for the vanilla fog to reach values"], [10, 240, 30, 0], true],
		["SLIDER:PERCENT", [">>> Fog Density", "Density of vanilla fog after transition (displayed is current)"], [0, 1, _actualFog select 0], true],
		["SLIDER:PERCENT", [">>> Fog Decay", "Decay of vanilla fog after transition (displayed is current)"], [-1, 1, _actualFog select 1], true],
		["SLIDER", [">>> Fog Altitude", "Altitude of vanilla fog after transition (displayed is current)"], [0, 600, _actualFog select 2, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;