/*
 * Promote player to 'spectator' using a Zeus module
 * (Inspired from https://github.com/Reeveli/SPG-Template/blob/bdf258817e4aba4f9fa4d446d8c71a3f35381aa2/scripts/Reeveli_fnc/Rev_zeus/fn_spectator.sqf#L3)
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {
    ["Select a player!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

[true,false,true] remoteExec ["ace_spectator_fnc_setSpectator",_unit,false];
private _players = [] call CBA_fnc_players;
private _viewable = _players select {isNull (getAssignedCuratorLogic _x)};

[_viewable, [_unit]] remoteExec ["call ace_spectator_fnc_updateUnits",_unit,false];

private _string = name _unit + " promoted to spectator";
[objNull, _string] call BIS_fnc_showCuratorFeedbackMessage;