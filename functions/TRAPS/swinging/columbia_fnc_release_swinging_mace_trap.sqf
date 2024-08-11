// *******************************************************
// Spring the trap when the trap's trigger is fired.
// *******************************************************
params ["_wire_trap", "_mace", "_rope_top_obj", "_mace_sphere"];
private _trap_pos = getPos _wire_trap;
private _trap_dir = getDir _wire_trap;

private _unit = nearestObject [_trap_pos, 'Man'];
playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wire_trap, false, _wire_trap, 4];
deleteVehicle _wire_trap;
// *******************************************************
// Delete cosmetic rope and attach swing rope.  Then detach mace from original position to start the swing
// *******************************************************
private _rope_2 = ropeCreate [_mace, [0, 0, .1], _rope_top_obj, [0, 0, -.5], _mace distance _rope_top_obj];
detach _mace;
_mace_sphere attachTo [_mace, [0, 0, 0]];
private _dir_to = ([_mace_sphere, _rope_top_obj] call BIS_fnc_dirTo);
_mace setDir _dir_to;

// *******************************************************
// stabilizes mace swing and plays creaking noise
// *******************************************************
[[_mace, _rope_top_obj], "functions\TRAPS\swinging\columbia_fnc_control_mace_swing.sqf"] remoteExec ["execVM", 0, true];

// *******************************************************
// Units react to springing of trap
// *******************************************************
uiSleep 1.5;
private _group = group _unit;

// *******************************************************
// sound FX and accelerate swing when mace lower (waiting so it won't just pile drive into the ground)
// *******************************************************
_sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];
waitUntil {_mace distance2D _trap_pos < 3};
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];
// *******************************************************
// Deal with victims of mace
// *******************************************************
[[_unit, _mace, _trap_dir, _trap_pos], "functions\TRAPS\columbia_fnc_mace_victims.sqf"] remoteExec ["execVM", 0, true];
uiSleep 4;

// *******************************************************
// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity).
// *******************************************************
private _future = time + 10;
waitUntil {!alive _unit or _trap_pos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};
[[_mace], "functions\TRAPS\swinging\columbia_fnc_end_mace_swinging.sqf"] remoteExec ["execVM", 0, true];
