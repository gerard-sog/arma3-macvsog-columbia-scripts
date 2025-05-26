/*
 * Hide tree and replace with destroyed version of the tree.
 *
 * Arguments:
 * 0: tree to replace (Object)
 * 1: position of the tree to replace (Position)
 *
 * Return values:
 * None
 */

params ["_tree", "_pos"];

[_tree, true] remoteExec ["hideObjectGlobal", 2];
private _destroyedTree = createVehicle ["land_vn_burned_t_ficus_big_04", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_destroyedTree setPosATL _pos;
private _orientationTree = getDir _tree;
_destroyedTree setDir _orientationTree;

private _oddOfFallenTree = [1, 100] call BIS_fnc_randomNum;
if (_oddOfFallenTree <= 30) then {
    private _fallenTree = createVehicle ["land_vn_burned_t_ficus_big_03", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    private _fallenTreePos = [(_pos select 0) + 5, (_pos select 1) + 5, 0];
    _fallenTree setPosATL _fallenTreePos;
    _fallenTree setDir _orientationTree;
};