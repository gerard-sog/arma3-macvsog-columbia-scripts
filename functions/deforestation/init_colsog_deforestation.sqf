/*
 * TODO
 */

if (!isServer) exitWith {};

["Air", "Fired", {

	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    private _projectileInfo = getModelInfo _projectile;
    private _projectileP3dName = _projectileInfo select 0;
    systemChat _projectileP3dName;

    _projectile addEventHandler ["HitPart", {
    	params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType", "_instigator"];

    	[
            {!alive (_this select 0)},
            {
                // -------------
                // | Cut trees |
                // -------------
                private _listOfNearestTerrainTreesAndBushes = nearestTerrainObjects [(_this select 1), ["Tree", "Bush"], 50, true, true];

                systemChat str count _listOfNearestTerrainTreesAndBushes;

                {
                    private _modelInfo = getModelInfo _x;
                    private _treeP3dName = _modelInfo select 0;

                    private _hashMapOfIndestructibleTreesAndBoundingBoxCorrection = [
                        ["vn_t_ficus_big_f.p3d", 0, 0],
                        ["t_ficus_big_f.p3d", 0, 0],
                        ["vn_t_inocarpus_f.p3d", 0, 0],
                        ["t_inocarpus_f.p3d", 0, 0],
                        ["vn_dried_t_ficus_big_01.p3d", 0, 0],
                        ["vn_t_palaquium_f.p3d", 0, 0],
                        ["t_palaquium_f.p3d", 24, 9.2]
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

                    private _orientation = direction _x;
                    private _orientationToRealTreeDegrees = ((((_orientation + _correctionOrientation) % 360) + 180) % 360);

                    private _pos = getPosATL _x;
                    private _currentX = _pos select 0;
                    private _currentY = _pos select 1;
                    private _currentZ = _pos select 2;

                    private _deltaNorth = (cos _orientationToRealTreeDegrees) * _correctionDistance;
                    private _deltaEast = (sin _orientationToRealTreeDegrees) * _correctionDistance;

                    private _correctedX = _currentX + _deltaEast;
                    private _correctedY = _currentY + _deltaNorth;
                    private _correctedPos = [_correctedX, _correctedY, 0];

                    if ((_this select 1) distance2D _correctedPos < 50) then {
                        if (_isIndestructibleTree) then {
                            [_x, true] remoteExec ["hideObjectGlobal", 2];
                            createVehicle ["land_vn_burned_t_ficus_big_04", _correctedPos, [], 0, "CAN_COLLIDE"];
                        } else {
                            _x setDamage 1;
                        };
                    };
                } forEach _listOfNearestTerrainTreesAndBushes;
            },
            [_projectile, _pos]
        ] call CBA_fnc_waitUntilAndExecute;
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;