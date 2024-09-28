/*
 * Locality:
 * On the server.
 */

// *******************************************************
// Find units near unit that triggered mace as a list of potential victims.
// Then call function to make them a victim if they are hit by the mace.
// *******************************************************
params ["_unit", "_mace", "_trapDirection", "_trapPosition"];
private _victims = (_unit nearEntities ["Man", 20]) select {_x isKindOf "Man"}; // nearEntities 'Man' includes UGV, so we exclude those with isKindOf
{
    [[_x, _mace, _trapDirection, _trapPosition], "functions\traps\colsog_fn_maceVictim.sqf"] remoteExec ["execVM", owner _x, true];
} forEach _victims;

private _sound = "a3\sounds_f\characters\movements\bush_004.wss"; // play sound to mask the ugv motor sound
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];
uiSleep 1.5;