/*
 * Creates a 'Gunshot' sensor.
 *
 * Arguments:
 * 0: (Optional) Sensor Object, needed when sensor created in Eden Editor (Object)
 * 1: (Optional) Sensor ID, needed when sensor created in Eden Editor (Integer)
 *
 * Return values:
 * None
 */

params ["_player", "_object"];

private _modelInfo = getModelInfo _object;

private _hashMapOfAuthorizedTreesAndHeightCorrection = createHashMapFromArray [
    ["t_cyathea_f.p3d", 2],
    ["t_cocos_tall_f.p3d", 9],
    ["t_cocosnucifera3s_tall_f.p3d", 0],
    ["t_inocarpus_f.p3d", 8],
    ["t_palaquium_f.p3d", 3],
    ["t_ficus_big_f.p3d", 15],
    ["t_cocosnucifera2s_small_f.p3d", 8]
];

private _isAuthorizedTree = false;
private _tree = "None";
private _objectP3dName = _modelInfo select 0;

{
    if ([_x, _objectP3dName] call BIS_fnc_inString) exitWith {
        _isAuthorizedTree = true;
        _tree = _x;
    };
} forEach (keys _hashMapOfAuthorizedTreesAndHeightCorrection);

// Conditions for action to be performed.
if (!_isAuthorizedTree) exitWith {
    hintSilent format ["I cannot climb this."];
};

if (_player distance2D _object > 5) exitWith {
    hintSilent format ["I need to get closer."];
};

private _xyzTreeDimension = _object call BIS_fnc_boundingBoxDimensions;
private _treeHeightCorrection = _hashMapOfAuthorizedTreesAndHeightCorrection get _tree;
private _treeHeight = (_xyzTreeDimension select 1) + _treeHeightCorrection;

[_treeHeight, _player] spawn {
    params ["_treeHeight", "_player"];
    waitUntil {inputAction "MoveForward" > 0};

    private _invisibleBarrier = createVehicle ["Land_InvisibleBarrier_F", getPos _player vectorAdd [0, 0, _treeHeight]];
    _invisibleBarrier setPos [getPos _player select 0, getPos _player select 1, _treeHeight + 2];
    _player setPos (getPos _invisibleBarrier vectorAdd [0,0,1]);
    _player switchMove "HubSpectator_stand";
    _player hideObjectGlobal true;

    _player setVariable ["COLSOG_invisibleBarrier", _invisibleBarrier, true];

    hintSilent format ["Climbing."];

    [_treeHeight, _player] spawn {
        params ["_treeHeight", "_player"];
        waitUntil {inputAction "MoveBack" > 0};

        private _invisibleBarrier = _player getVariable "COLSOG_invisibleBarrier";
        deleteVehicle _invisibleBarrier;

        _player setPos (getPos _player vectorAdd [0, 0, -(_treeHeight + 2)]);
        _player hideObjectGlobal false;
        _player switchMove "";

        hintSilent format ["Going down."];
    };
};