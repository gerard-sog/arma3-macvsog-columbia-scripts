params ["_wireTrap", "_mace", "_maceSphere", "_selectedTreeHeight"];
private _trapPosition = getPos _wireTrap;
private _trapDirection = getDir _wireTrap;

private _unit = nearestObject [_trapPosition, 'Man'];
playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wireTrap, false, _wireTrap, 4];
deleteVehicle _wireTrap;

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
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5];

[[_unit, _mace, _trapDirection, _trapPosition], "functions\traps\colsog_fn_maceVictims.sqf"] remoteExec ["execVM", 0, true];
uiSleep 4;

// *******************************************************
// Disable trap simulation to save performance
// *******************************************************
private _future = time + 10;
waitUntil {!alive _unit or _trapPosition distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};

uiSleep 30;
_mace setMass 290;
uiSleep 10;
deleteVehicle _mace;