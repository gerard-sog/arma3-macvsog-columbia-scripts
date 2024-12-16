/*
 * Find units near unit that triggered mace as a list of potential victims.
 *
 * Then call function local to the victim unit if they are hit by the mace.
 * 
 * Arguments:
 * 0: _mace
 * 1: _trapDirection
 * 2: _trapPosition
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [_mace, _trapDirection, _trapPosition] execVM "functions\traps\colsog_fn_maceVictims.sqf";
 *
 * Return values:
 * None
 *
 */

params ["_mace", "_trapDirection", "_trapPosition"];

if (!isServer) exitWith {};

private _victims = (_trapPosition nearEntities ["Man", colsog_traps_maceKillRadius]) select {_x isKindOf "Man"}; // nearEntities 'Man' includes UGV, so we exclude those with isKindOf
{
    [[_x, _mace, _trapDirection, _trapPosition], "functions\traps\colsog_fn_maceVictim.sqf"] remoteExec ["execVM", owner _x, false];
} forEach _victims;

private _sound = "a3\sounds_f\characters\movements\bush_004.wss"; // play sound to mask the ugv motor sound
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5, 1, 150];
uiSleep 1.5;