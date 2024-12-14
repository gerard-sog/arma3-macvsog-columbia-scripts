/*
 * Release falling mace trap
 *
 * Arguments:
 * 0: _wireTrap
 * 1: _mace
 * 2: _maceSphere
 * 3: _selectedTreeHeight
 * TO DO 4: _trigger
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [_wireTrap, _mace, _maceSphere, _selectedTreeHeight, _trigger] execVM "functions\traps\falling\colsog_fn_releaseFallingMaceTrap.sqf";
 *
 * Return values:
 * None
 *
 */

params ["_wireTrap", "_mace", "_maceSphere", "_selectedTreeHeight", "_trigger"];
if (!isServer) exitWith {}; // safety

private _trapPosition = getPos _wireTrap;
private _trapDirection = getDir _wireTrap;

playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wireTrap, false, getPosASL _wireTrap, 4]; // TO DO test distance
// deleteVehicle _wireTrap; if we delete _wireTrap it cannot be used as a deletion object
hideObjectGlobal _wireTrap; // hide 3d model instead, zeus can still see hitbox

// *******************************************************
// Detach mace from original position to start the fall
// *******************************************************
detach _mace;
_maceSphere attachTo [_mace, [0, 0, 0]];

// *******************************************************
// Detect and deal with victims of mace
// *******************************************************
// Depending on height, we need to wait before checking distance to unit next to trap (to see if hit or not).
private _additionalTimeBeforeMaceHitsGround = 0.0;
if (_selectedTreeHeight >= 14 && _selectedTreeHeight < 21) then {
    _additionalTimeBeforeMaceHitsGround = 0.5;
};
if (_selectedTreeHeight >= 21 && _selectedTreeHeight < 26) then {
    _additionalTimeBeforeMaceHitsGround = 0.9;
};
uiSleep (1.5 + _additionalTimeBeforeMaceHitsGround);

private _sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];  // TO DO test distance

[_mace, _trapDirection, _trapPosition] execVM "functions\traps\colsog_fn_maceVictims.sqf";
uiSleep 4;

// *******************************************************
// Disable trap simulation to save performance
// *******************************************************
private _future = time + 10;
waitUntil {time > _future};
// TO DO rewrite with CBA_waitUntilAndExecute

uiSleep 30;
_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
uiSleep 10;
deleteVehicle _mace;