/*
 * Hide tree and replace with burned version of the tree.
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
private _destroyedTree = createVehicle ["land_vn_burned_t_ficus_big_01", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_destroyedTree setPosATL _pos;
private _orientationTree = getDir _tree;
_destroyedTree setDir _orientationTree;