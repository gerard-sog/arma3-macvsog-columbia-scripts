/*
 * Return an array of "Tree", "Bush" and "Land_vn_vegetation_base" in a specific radius around a position.
 *
 * Arguments:
 * 0: Center position of the search (Position)
 * 1: Radius in meter (float)
 *
 * Return values:
 * Array of objects.
 */

params ["_pos", "_radius"];

private _listOfNearestTerrainTreesAndBushes = nearestTerrainObjects [_pos, ["Tree", "Bush"], _radius, true, true];
private _listOfNearestDamagedTrees = nearestObjects [_pos, ["Land_vn_vegetation_base"], _radius, true, true];
private _listOfNearestTreeBushAndDamagedTreesToDest = _listOfNearestTerrainTreesAndBushes + _listOfNearestDamagedTrees;

_listOfNearestTreeBushAndDamagedTreesToDest;