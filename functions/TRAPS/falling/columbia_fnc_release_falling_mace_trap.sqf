params ["_wire_trap", "_mace", "_mace_sphere", "_selected_tree_height"];
private _trap_pos = getPos _wire_trap;
private _trap_dir = getDir _wire_trap;

private _unit = nearestObject [_trap_pos, 'Man'];
playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss" ,_wire_trap, false, _wire_trap, 4];
deleteVehicle _wire_trap;

// *******************************************************
// Detach mace from original position to start the fall
// *******************************************************
detach _mace;
_mace_sphere attachTo [_mace, [0, 0, 0]];

// *******************************************************
// Detect and deal with victims of mace
// *******************************************************
// Depending on height, we need to wait before checking distance to unit next to trap (to see if hit or not).
_additional_time_before_mace_hits_ground = 0.0;
if (_selected_tree_height >= 14 && _selected_tree_height < 21) then {
    _additional_time_before_mace_hits_ground = 0.5;
};
if (_selected_tree_height >= 21 && _selected_tree_height < 26) then {
    _additional_time_before_mace_hits_ground = 0.9;
};
uiSleep (1.5 + _additional_time_before_mace_hits_ground);

_sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];

[[_unit, _mace, _trap_dir, _trap_pos], "functions\TRAPS\columbia_fnc_mace_victims.sqf"] remoteExec ["execVM", 0, true];
uiSleep 4;

// *******************************************************
// Disable trap simulation to save performance
// *******************************************************
private _future = time + 10;
waitUntil {!alive _unit or _trap_pos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};

uiSleep 30;
_mace setMass 290;
uiSleep 10;
deleteVehicle _mace;