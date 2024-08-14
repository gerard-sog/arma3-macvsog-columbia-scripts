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
	_dialogResult params ["_vanilla_fog", "_vanilla_fog_duration", "_vanilla_fog_density", "_vanilla_fog_decay", "_vanilla_fog_altitude"];

	// exec initfog server-side it not NO CHANGE
	if (_vanilla_fog) then {
		//[[_vanilla_fog_duration, _vanilla_fog_density, _vanilla_fog_decay, _vanilla_fog_altitude], "rcc_zeus\fn_initFog.sqf"] remoteExec ["execVM", 2];
		[_vanilla_fog_duration, [_vanilla_fog_density, _vanilla_fog_decay, _vanilla_fog_altitude]] remoteExec ["setFog", 2];
	};
};


private _actualfog = fogparams;

// Module dialog
[
	"Vanilla Fog Transition",
	[
		["TOOLBOX:YESNO", ["Vanilla Fog Transition", "Vanilla fog will be transitioned by the module"], [false], true],
		["SLIDER", [">>> Duration", "Time for the vanilla fog to reach values"], [10, 240, 30, 0], true],
		["SLIDER:PERCENT", [">>> Fog Density", "Density of vanilla fog after transition (displayed is current)"], [0, 1, _actualfog select 0], true],
		["SLIDER:PERCENT", [">>> Fog Decay", "Decay of vanilla fog after transition (displayed is current)"], [-1, 1, _actualfog select 1], true],
		["SLIDER", [">>> Fog Altitude", "Altitude of vanilla fog after transition (displayed is current)"], [0, 600, _actualfog select 2, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;