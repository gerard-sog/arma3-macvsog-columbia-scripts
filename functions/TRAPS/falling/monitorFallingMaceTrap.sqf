// ********************************************************
// Spring the trap when the trap's trigger is fired.
// ********************************************************
params ["_trapProxy","_mace","_maceSphere","_selected_tree_height"];
private _trapPos = getPos _trapProxy;
private _trapDir = getDir _trapProxy;

private _unit = nearestObject [_trapPos,'Man'];
playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss",_trapProxy, false, _trapProxy, 4];
deleteVehicle _trapProxy;

// *******************************************************
// Detach mace from original position to start the swing
// *******************************************************
detach _mace;
_maceSphere attachTo [_mace,[0,0,0]];

_additional_time_before_mace_hits_ground = 0.0;
if (_selected_tree_height >= 14 && _selected_tree_height < 21) then {
    _additional_time_before_mace_hits_ground = 0.5;
};
if (_selected_tree_height >= 21 && _selected_tree_height < 26) then {
    _additional_time_before_mace_hits_ground = 0.9;
};
uiSleep (1.5 + _additional_time_before_mace_hits_ground);

// *******************************************************
// sound FX and accelerate swing when mace lower (waiting so it won't just pile drive into the ground)
// *******************************************************
_sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];

// *******************************************************
// Deal with victims of mace
// *******************************************************
[[_unit,_mace, _trapDir, _trapPos], "functions\TRAPS\maceVictims.sqf"] remoteExec ["execVM", 0, true];
uiSleep 4;

private _future = time + 10;
waitUntil {!alive _unit or _trapPos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};

uiSleep 30;
_mace setMass 290;
uiSleep 10;
_mace enableSimulation false;