/*
 * Locality:
 * On the server.
 */

// *******************************************************
// Spring the trap when the trap's trigger is fired.
// *******************************************************
params ["_wireTrap", "_mace", "_ropeTopObject", "_maceSphere"];
private _trapPosition = getPos _wireTrap;
private _trapDirection = getDir _wireTrap;

playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wireTrap, false, _wireTrap, 4];
deleteVehicle _wireTrap;
// *******************************************************
// Delete cosmetic rope and attach swing rope.  Then detach mace from original position to start the swing
// *******************************************************
private _secondRope = ropeCreate [_mace, [0, 0, .1], _ropeTopObject, [0, 0, -.5], _mace distance _ropeTopObject];
detach _mace;
_maceSphere attachTo [_mace, [0, 0, 0]];
private _directionTo = ([_maceSphere, _ropeTopObject] call BIS_fnc_dirTo);
_mace setDir _directionTo;

// *******************************************************
// stabilizes mace swing and plays creaking noise
// *******************************************************
[_mace, _ropeTopObject] execVM "functions\traps\swinging\colsog_fn_controlMaceSwing.sqf";

// *******************************************************
// Units react to springing of trap
// *******************************************************
uiSleep 1.5;

// *******************************************************
// sound FX and accelerate swing when mace lower (waiting so it won't just pile drive into the ground)
// *******************************************************
_sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];
waitUntil {_mace distance2D _trapPosition < 3};
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];

// *******************************************************
// Deal with victims of mace
// *******************************************************
[_mace, _trapDirection, _trapPosition] execVM "functions\traps\colsog_fn_maceVictims.sqf";
uiSleep 4;

// *******************************************************
// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity).
// *******************************************************
private _future = time + 10;
waitUntil {time > _future};

uiSleep 60;
_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
uiSleep 10;
deleteVehicle _mace;