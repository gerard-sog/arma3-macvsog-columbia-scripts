/*
 * Set all variables on player
 * (most are local use only, no broadcast)
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 * Called again when player respawn
 *
 */

if (!hasInterface) exitWith {};

private _playerRole = roleDescription player;
if (["Chief SOG", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["hasUsface", true];
    player setUnitTrait ["vn_artillery", true, true];
    player setVariable ["canReadIntel", true];
}
if (["Pilot", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["hasUsface", true];
    player setVariable ["canMonitorSensor", true];
}
if (["0-1 Team Leader", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["canSpeak", ["en", "vn"]];
    player setVariable ["canClimb", true];
    player setVariable ["canReadIntel", true];
}
if (["0-2 Machine Gunner", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["canSpeak", ["en", "vn"]];
    player setVariable ["canReadIntel", true];
}
if (["0-3 Grenadier", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["canSpeak", ["en", "vn"]];
    player setVariable ["canReadIntel", true];
}
if (["0-4 Point man", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["canSpeak", ["en", "vn"]];
    player setVariable ["canClimb", true];
    player setVariable ["canReadIntel", true];
}
if (["1-0 Squad Leader", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["hasUsface", true];
}
if (["1-1 RTO", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["hasUsface", true];
}
if (["1-2 Medic", _playerRole] call BIS_fnc_inString) exitWith {
    player setVariable ["hasUsface", true];
}
// Default
player setVariable ["canSpeak", ["en", "vn"]];