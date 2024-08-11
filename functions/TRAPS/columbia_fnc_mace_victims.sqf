// *******************************************************
// Find units near unit that triggered mace as a list of potential victims.
// Then call function to make them a victim if they are hit by the mace.
// *******************************************************
params ["_unit", "_mace", "_trap_dir", "_trap_pos"];
_victims = (_unit nearEntities ["Man", 20]) select {_x isKindOf "Man"}; // nearEntities 'Man' includes UGV, so we exclude those with isKindOf
{
    [[_x, _mace, _trap_dir, _trap_pos], "functions\TRAPS\columbia_fnc_mace_victim.sqf"] remoteExec ["execVM", 0, true];
} forEach _victims;