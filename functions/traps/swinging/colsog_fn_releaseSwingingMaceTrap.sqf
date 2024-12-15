/*
 * Release swinging mace trap
 *
 * Arguments:
 * 0: _wireTrap
 * 1: _mace
 * 2: _ropeTopObject
 * 3: _maceSphere
 * 4: _trigger
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [_wireTrap, _mace, _ropeTopObject, _maceSphere, _trigger] execVM "functions\traps\falling\colsog_fn_releaseSwingingMaceTrap.sqf";
 *
 * Return values:
 * None
 *
 */

params ["_wireTrap", "_mace", "_ropeTopObject", "_maceSphere", "_trigger"];

if (!isServer) exitWith {};

// *******************************************************
// Spring the trap when the trap's trigger is fired.
// *******************************************************
private _trapPosition = getPos _wireTrap;
private _trapDirection = getDir _wireTrap;

playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wireTrap, false, getPosASL _wireTrap, 4]; // TO DO test distance
deleteVehicle _wireTrap;

["zen_common_updateEditableObjects", [[_maceSphere], false]] call CBA_fnc_serverEvent; // hide macesphere once trap triggered

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
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5]; // TO DO test distance
waitUntil {_mace distance2D _trapPosition < 3};
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5]; // TO DO test distance

// *******************************************************
// Deal with victims of mace
// *******************************************************
[_mace, _trapDirection, _trapPosition] execVM "functions\traps\colsog_fn_maceVictims.sqf";
uiSleep 4;

deleteVehicle _trigger;

// *******************************************************
// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity).
// *******************************************************
[
    {
        (_this select 0) setMass 290; // Make mace settle down to ground so no more physics eating CPU
        [
            {
                deleteVehicle (_this select 0); // delete _mace UGV
				deleteVehicle (_this select 1); // delete _ropeTopObject UGV
            }, 
            _this, // argument (still _mace)
            10
        ] call CBA_fnc_waitAndExecute;
    }, 
    [_mace, _ropeTopObject], // argument
    70
] call CBA_fnc_waitAndExecute;