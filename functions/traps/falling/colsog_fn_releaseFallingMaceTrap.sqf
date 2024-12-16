/*
 * Release falling mace trap
 *
 * Arguments:
 * 0: _wireTrap
 * 1: _mace
 * 2: _maceSphere
 * 3: _selectedTreeHeight
 * 4: _trigger
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

if (!isServer) exitWith {};

private _trapPosition = getPos _wireTrap;
private _trapDirection = getDir _wireTrap;

playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss", _wireTrap, false, getPosASL _wireTrap, 4, 1, 150];
deleteVehicle _wireTrap;

["zen_common_updateEditableObjects", [[_maceSphere], false]] call CBA_fnc_serverEvent; // hide macesphere once trap triggered

// Detach mace from original position to start the fall
detach _mace;
_maceSphere attachTo [_mace, [0, 0, 0]];

// Detect and deal with victims of mace
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
playSound3D [_sound, _mace, false, getPosASL _mace, 3.5, 1, 150];

[_mace, _trapDirection, _trapPosition] execVM "functions\traps\colsog_fn_maceVictims.sqf";
uiSleep 4;

deleteVehicle _trigger;

// Disable trap simulation to save performance
[
    {
        _this setMass 290; // Make mace settle down to ground so no more physics eating CPU
        [
            {
                deleteVehicle _this;
            }, 
            _this, // argument (still _mace)
            10
        ] call CBA_fnc_waitAndExecute;
    }, 
    _mace, // argument
    40
] call CBA_fnc_waitAndExecute;