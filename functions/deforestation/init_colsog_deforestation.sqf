/*
 * Adds an event handler on all "Air" vehicles that triggers when the vehicle fires. Triggered by player and AI.
 * Burns or destroys trees near bomb impact point.
 */

COLSOG_fnc_handleBombImpact = {
    params ["_pos", "_isNapalm", "_destructionRadius", "_obliterationRadius"];

    private _floorPos = [_pos select 0, _pos select 1, 0];

    if (_isNapalm) then {
        createVehicle ["vn_ground_burned_01", _floorPos, [], 0, "CAN_COLLIDE"];
        private _embersDecal = createVehicle ["vn_ground_embers_01", _floorPos, [], 0, "CAN_COLLIDE"];

        private _extinguishTime = serverTime + colsog_deforestation_napalmEmbersTimeToLive;
        [
            { (_this select 0) < serverTime },
            {
                private _embersDecal = _this select 1;
                deleteVehicle _embersDecal;
            },
            [_extinguishTime, _embersDecal]
        ] call CBA_fnc_waitUntilAndExecute;
    } else {
        if (_destructionRadius < 30) then {
            createVehicle ["Land_vn_crater_decal_01", _floorPos, [], 0, "CAN_COLLIDE"];
        } else {
            createVehicle ["Land_vn_crater_decal_02", _floorPos, [], 0, "CAN_COLLIDE"];
        };
    };

    private _searchTreeRadius = _destructionRadius + 10;
    private _listOfNearestTreeBushAndDamagedTreesToDest = [_pos, _searchTreeRadius] call COLSOG_fnc_getNearestTreesAndBushes;

    private _temporaryUnit = [_pos] call COLSOG_fnc_createInvisibleUnit;

    {
        private _modelInfo = getModelInfo _x;
        private _treeP3dName = _modelInfo select 0;

        private _boundingBoxCorrection = [_treeP3dName] call COLSOG_fnc_get3dModelBoundingBoxCorrection;
        private _isIndestructibleTree = _boundingBoxCorrection select 0;
        private _correctionOrientation = _boundingBoxCorrection select 1;
        private _correctionDistance = _boundingBoxCorrection select 2;

        private _orientation = direction _x;
        private _correctedPos = [_orientation, getPosATL _x, _correctionOrientation, _correctionDistance] call COLSOG_fnc_getCorrected3dModelPos;

        private _distanceFromExplosion = _pos distance2D _correctedPos;

        if (_distanceFromExplosion < _destructionRadius) then {
            if (_distanceFromExplosion < _obliterationRadius) then {
                if (_isIndestructibleTree) then {
                    [_x, true] remoteExec ["hideObjectGlobal", 2];
                } else {
                    _x setDamage [1, true, _temporaryUnit];
                };
            } else {
                if !(isObjectHidden _x) then {
                    if (_isNapalm) then {
                        if !(_treeP3dName == "vn_burned_t_ficus_big_01.p3d") then {
                            if (_isIndestructibleTree) then {
                                [_x, _correctedPos] call COLSOG_fnc_burnTree;
                            } else {
                                _x setDamage [1, true, _temporaryUnit];
                            };
                        };
                    } else {
                        if (_isIndestructibleTree) then {
                            [_x, _correctedPos] call COLSOG_fnc_destroyTree;
                        } else {
                            _x setDamage [1, true, _temporaryUnit];
                        };
                    };
                };
            };
        };
    } forEach _listOfNearestTreeBushAndDamagedTreesToDest;

    deleteVehicle _temporaryUnit;
};

["Air", "Fired", {

    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    private _gunnerNetId = netId _gunner;
    private _playerNetId = netId player;
    private _isAi = !(isPlayer _gunner);

    if ((_gunnerNetId == _playerNetId) || _isAi) then {
        private _projectileInfo = getModelInfo _projectile;
        private _projectileP3dName = _projectileInfo select 0;

        private _hashMapOfBombsAndIsNapalmAndRadius = [
            // Napalm
            ["frl_blu1b_fly.p3d", true, 40, 0],
            ["frl_mk77_fly.p3d", true, 30, 0],
            ["uns_blu1_fly.p3d", true, 40, 0],
            ["vn_bomb_blu1b_fb.p3d", true, 40, 0],
            ["vn_bomb_blu1b_500_fb.p3d", true, 30, 0],

            // Bombs
            ["frl_mk82.p3d", false, 10, 0],
            ["frl_mk84.p3d", false, 35, 10],
            ["uns_mk82.p3d", false, 10, 0],
            ["uns_mk83.p3d", false, 20, 0],
            ["vn_bomb_mk82_dc.p3d", false, 10, 0],
            ["vn_bomb_mk82_he.p3d", false, 10, 0],
            ["vn_bomb_mk82_se_proxy.p3d", false, 10, 0],
            ["vn_bomb_mk83_he.p3d", false, 20, 0],
            ["vn_bomb_mk84_he.p3d", false, 35, 10],
            ["vn_bomb_m117_01_he.p3d", false, 15, 0]
        ];

        private _isAllowedBomb = false;
        private _isNapalm = false;
        private _destructionRadius = 0;
        private _obliterationRadius = 0;

        {
            private _key = _x select 0;

            if (_key == _projectileP3dName) exitWith {
                _isAllowedBomb = true;
                _isNapalm = _x select 1;
                _destructionRadius = _x select 2;
                _obliterationRadius = _x select 3;
            };
        } forEach _hashMapOfBombsAndIsNapalmAndRadius;

        if (_isAllowedBomb) then {
            _projectile setVariable ["COLSOG_isNapalm", _isNapalm];
            _projectile setVariable ["COLSOG_destructionRadius", _destructionRadius];
            _projectile setVariable ["COLSOG_obliterationRadius", _obliterationRadius];
            _projectile setVariable ["COLSOG_hitPartTriggered", false];

            /*
             * Fallback for napalm projectiles that are deleted/exploded without firing HitPart.
             * Bombs continue to use HitPart normally.
             */
            [_projectile, _projectileP3dName, _isNapalm, _destructionRadius, _obliterationRadius] spawn {
                params ["_projectile", "_projectileP3dName", "_isNapalm", "_destructionRadius", "_obliterationRadius"];

                private _lastPos = getPosATL _projectile;
                private _hitPartTriggered = false;

                while {!isNull _projectile} do {
                    _lastPos = getPosATL _projectile;
                    _hitPartTriggered = _projectile getVariable ["COLSOG_hitPartTriggered", false];
                    sleep 0.05;
                };

                if (!_hitPartTriggered && {_isNapalm}) then {
                    if (colsog_deforestation_debug) then {
                        systemChat format [
                            "[DEFOREST][FALLBACK_USED] model=%1 lastPos=%2",
                            _projectileP3dName,
                            _lastPos
                        ];
                    };

                    [_lastPos, _isNapalm, _destructionRadius, _obliterationRadius] call COLSOG_fnc_handleBombImpact;
                };
            };

            _projectile addEventHandler [
                "HitPart",
                {
                    params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius", "_surfaceType", "_instigator"];

                    _projectile setVariable ["COLSOG_hitPartTriggered", true];

                    private _isNapalm = _projectile getVariable ["COLSOG_isNapalm", false];
                    private _destructionRadius = _projectile getVariable ["COLSOG_destructionRadius", 0];
                    private _obliterationRadius = _projectile getVariable ["COLSOG_obliterationRadius", 0];

                    if (colsog_deforestation_debug) then {
                        systemChat format [
                            "[DEFOREST][HITPART] pos=%1 isNapalm=%2 radius=%3 hitEntity=%4 surface=%5",
                            _pos,
                            _isNapalm,
                            _destructionRadius,
                            _hitEntity,
                            _surfaceType
                        ];
                    };

                    [_pos, _isNapalm, _destructionRadius, _obliterationRadius] call COLSOG_fnc_handleBombImpact;
                }
            ];
        } else {
            if (colsog_deforestation_debug) then {
                systemChat format [
                    "[DEFOREST][SKIP] model not allowed: %1 ammo=%2 mag=%3",
                    _projectileP3dName,
                    _ammo,
                    _magazine
                ];
            };
        };
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;