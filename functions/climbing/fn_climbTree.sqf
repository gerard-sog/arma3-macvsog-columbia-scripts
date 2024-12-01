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

private _object = cursorObject;
private _modelInfo = getModelInfo _object;

private _hashMapOfAuthorizedTreesAndHeightCorrection = createHashMapFromArray [
    ["t_cyathea_f.p3d", 2],
    ["t_cocos_tall_f.p3d", 9],
    ["t_cocosnucifera3s_tall_f.p3d", 0],
    ["t_inocarpus_f.p3d", 8],
    ["t_palaquium_f.p3d", 3],
    ["t_ficus_big_f.p3d", 15]
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

if (!_isAuthorizedTree) exitWith {
    hintSilent format ["Not a tree."];
};

private _xyzTreeDimension = _object call BIS_fnc_boundingBoxDimensions;
private _treeHeightCorrection = _hashMapOfAuthorizedTreesAndHeightCorrection get _tree;
private _treeHeight = (_xyzTreeDimension select 1) + _treeHeightCorrection;

[_treeHeight] spawn {
    params ["_treeHeight"];
    waitUntil {inputAction "MoveForward" > 0};

    private _shelter = createVehicle ["Land_vn_o_wallfoliage_01", getPos player vectorAdd [0, 0, _treeHeight]];
    _shelter setPos [getPos player select 0, getPos player select 1, _treeHeight + 2];
    // Rotate 90 degree
    _shelter setVectorDirAndUp [[0,1,0], [1,0,0]];
    player setPosATL (getPos _shelter vectorAdd [0, 0, 1]);

    hint "Climbing";

};

[_treeHeight] spawn {
    params ["_treeHeight"];
    waitUntil {inputAction "MoveBack" > 0};
    hint "Going down";
    player setPosATL (getPos player vectorAdd [0, 0, -(_treeHeight + 2)]);
};
