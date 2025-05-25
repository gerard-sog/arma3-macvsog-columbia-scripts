/*
 * Return correction for the bounding box of a 3D model. Values are to be manually obtained in the eden editor.
 *
 * Arguments:
 * 0: tree name (string)
 *
 * Return values:
 * Arrays of type [boolean, float, float].
 */

params ["_treeP3dName"];

private _hashMapOfIndestructibleTreesAndBoundingBoxCorrection = [
    ["vn_t_ficus_big_f.p3d", 0, 0],
    ["t_ficus_big_f.p3d", 0, 0],
    ["vn_t_inocarpus_f.p3d", 0, 0],
    ["t_inocarpus_f.p3d", 0, 0],
    ["vn_dried_t_ficus_big_01.p3d", 0, 0],
    ["vn_t_palaquium_f.p3d", 0, 0],
    ["t_palaquium_f.p3d", 24, 9.2],
    ["vn_burned_t_ficus_big_01.p3d", 0, 0]
];

private _isIndestructibleTree = false;
private _correctionOrientation = 0;
private _correctionDistance = 0;
{
    private _key = _x select 0;
    if (_key == _treeP3dName) exitWith {
        _isIndestructibleTree = true;
        _correctionOrientation = _x select 1;
        _correctionDistance = _x select 2;
    };
} forEach _hashMapOfIndestructibleTreesAndBoundingBoxCorrection;

private _boundingBoxCorrection = [_isIndestructibleTree, _correctionOrientation, _correctionDistance];

_boundingBoxCorrection;