/*
 * TODO
 */

["Air", "Fired", {

	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    private _projectileInfo = getModelInfo _projectile;
    private _projectileP3dName = _projectileInfo select 0;
    systemChat _projectileP3dName;

    private _hashMapOfBombsAndIsNapalmAndRadius = [
        ["vn_bomb_blu1b_fb.p3d", true, 45],
        ["vn_bomb_blu1b_500_fb.p3d", true, 30],
        ["vn_bomb_mk82_se_proxy.p3d", false, 10],
        ["vn_bomb_mk82_he.p3d", false, 10],
        ["vn_bomb_mk82_dc.p3d", false, 10],
        ["vn_bomb_mk83_he.p3d", false, 20],
        ["vn_bomb_mk82_dc.p3d", false, 10],
        ["vn_bomb_mk84_he.p3d", false, 40],
        ["vn_bomb_m117_01_he.p3d", false, 15],
        ["frl_blu1b_fly.p3d", true, 45]
    ];

    private _isAllowedBomb = false;
    private _isNapalm = false;
    private _destructionRadius = 0;
    {
        private _key = _x select 0;
        if (_key == _projectileP3dName) exitWith {
            _isAllowedBomb = true;
            _isNapalm = _x select 1;
            _destructionRadius = _x select 2;
        };
    } forEach _hashMapOfBombsAndIsNapalmAndRadius;

    _projectile setVariable ["COLSOG_isNapalm", _isNapalm];
    _projectile setVariable ["COLSOG_destructionRadius", _destructionRadius];

    if (_isAllowedBomb) then {
        _projectile addEventHandler [
            "HitPart",
            {
                params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType", "_instigator"];

                private _isNapalm = _projectile getVariable "COLSOG_isNapalm";
                private _destructionRadius = _projectile getVariable "COLSOG_destructionRadius";

                if (_isNapalm) then {
                    private _floorPos = [_pos select 0, _pos select 1, 0];
                    createVehicle ["vn_ground_embers_01", _floorPos, [], 0, "CAN_COLLIDE"];
                };

                // -------------
                // | Cut trees |
                // -------------
                private _searchTreeRadius = _destructionRadius + 10;
                private _listOfNearestTerrainTreesAndBushes = nearestTerrainObjects [_pos, ["Tree", "Bush"], _searchTreeRadius, true, true];

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

                    private _posTree = getPosATL _x;
                    private _currentX = _posTree select 0;
                    private _currentY = _posTree select 1;
                    private _currentZ = _posTree select 2;

                    private _deltaNorth = (cos _orientationToRealTreeDegrees) * _correctionDistance;
                    private _deltaEast = (sin _orientationToRealTreeDegrees) * _correctionDistance;

                    private _correctedX = _currentX + _deltaEast;
                    private _correctedY = _currentY + _deltaNorth;
                    private _correctedPos = [_correctedX, _correctedY, 0];

                    if (_pos distance2D _correctedPos < _destructionRadius) then {
                        if (_isNapalm) then {
                            if (_isIndestructibleTree) then {
                                [_x, true] remoteExec ["hideObjectGlobal", 2];
                                private _destroyedTree = createVehicle ["land_vn_burned_t_ficus_big_01", _correctedPos, [], 0, "CAN_COLLIDE"];
                                private _orientationTree = getDir _x;
                                _destroyedTree setDir _orientationTree;
                            } else {
                                _x setDamage 1;
                            };
                        } else {
                            if (_isIndestructibleTree) then {
                                [_x, true] remoteExec ["hideObjectGlobal", 2];
                                private _destroyedTree = createVehicle ["land_vn_burned_t_ficus_big_04", _correctedPos, [], 0, "CAN_COLLIDE"];
                                private _orientationTree = getDir _x;
                                _destroyedTree setDir _orientationTree;
                            } else {
                                _x setDamage 1;
                            };
                        };
                    };
                } forEach _listOfNearestTerrainTreesAndBushes;
            }
        ];
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;