/*
 * Adds an event handler on 'ace_explosives_place' ACE event. It will only trigger for the explosive
 * 'c4_charge_small.p3d' and will make AI, player go unconscious and destroy the trees in a radius around the explosion.
 *
 * Return values:
 * None
 */

["ace_explosives_place", {
    params ["_explosive", "_dir", "_pitch", "_unit"];

    _unitNetId = netId _unit;
    systemChat ("Unit unique ID: " + str(_unitNetId));
    _playerNetId = netId player;
    systemChat ("Player unique ID: " + str(_playerNetId));

    if (_unitNetId == _playerNetId) then {
        private _modelInfo = getModelInfo _explosive;
        private _explosiveP3dName = _modelInfo select 0;

        if (_explosiveP3dName == "c4_charge_small.p3d") then {
            [
                {!alive _this},
                {
                    // -------------------
                    // | Set unconscious |
                    // -------------------
                    private _unitsToUnconscious = nearestObjects [_this, ["CAManBase"], colsog_deforestation_explosionSearchRadiusUnconscious];

                    {
                        if (isPlayer _x) then {
                            private _playerDistanceToExplosion = _x distance2D _this;
                            private _unconsciousTime = abs (colsog_deforestation_maximumTimeUnconscious - _playerDistanceToExplosion);
                            [_x, true, _unconsciousTime, true] call ace_medical_fnc_setUnconscious;
                        } else {
                            _x setUnconscious true;
                            _x setVariable ["COLSOG_hasConcussion", true, true];

                            private _triggerTime = serverTime + 5;
                            [
                                { (_this select 0) < serverTime },
                                {
                                    private _unit = _this select 1;
                                    if (alive _unit) then {
                                        _unit switchMove "UnconsciousFaceDown";
                                    };
                                },
                                [_triggerTime, _x]
                            ] call CBA_fnc_waitUntilAndExecute;
                        };
                    } forEach _unitsToUnconscious;

                    _vehiclesToUnconsciousDriver = nearestObjects [_this, ["LandVehicle"], colsog_deforestation_explosionSearchRadiusUnconscious];
                    {
                        _driver = driver _x;
                        if (isPlayer _driver) then {
                            private _driverDistanceToExplosion = _driver distance2D _this;
                            private _driverUnconsciousTime = abs (colsog_deforestation_maximumTimeUnconscious - _driverDistanceToExplosion);
                            [_driver, true, _driverUnconsciousTime, true] call ace_medical_fnc_setUnconscious;
                        } else {
                            _driver setUnconscious true;
                            _driver setVariable ["COLSOG_hasConcussion", true, true];
                            _driver switchMove "KIA_driver_scooter_01";

                            _driver addEventHandler ["GetOutMan", {
                                params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

                                private _triggerTime = serverTime + 5;
                                [
                                    { (_this select 0) < serverTime },
                                    {
                                        private _unit = _this select 1;
                                        if (alive _unit) then {
                                            _unit switchMove "UnconsciousFaceDown";
                                        };
                                    },
                                    [_triggerTime, _unit]
                                ] call CBA_fnc_waitUntilAndExecute;
                            }];
                        };
                    } forEach _vehiclesToUnconsciousDriver;

                    // -----------------
                    // | Explode trees |
                    // -----------------
                    private _listOfNearestTreeBushAndDamagedTreesToDest = [getPos _this, colsog_deforestation_explosionSearchRadiusTree] call COLSOG_fnc_getNearestTreesAndBushes;

                    private _temporaryUnit = [getPos _this] call COLSOG_fnc_createInvisibleUnit;

                    {
                        private _modelInfo = getModelInfo _x;
                        private _treeP3dName = _modelInfo select 0;

                        private _boundingBoxCorrection = [_treeP3dName] call COLSOG_fnc_get3dModelBoundingBoxCorrection;
                        private _isIndestructibleTree = _boundingBoxCorrection select 0;
                        private _correctionOrientation = _boundingBoxCorrection select 1;
                        private _correctionDistance = _boundingBoxCorrection select 2;

                        private _orientation = direction _x;

                        private _correctedPos = [_orientation, getPosATL _x, _correctionOrientation, _correctionDistance] call COLSOG_fnc_getCorrected3dModelPos;

                        if (_this distance2D _correctedPos < colsog_deforestation_explosionDestructionRadiusTree) then {
                            if !(isObjectHidden _x) then {
                                if (_isIndestructibleTree) then {
                                    [_x, _correctedPos] call COLSOG_fnc_destroyTree;
                                } else {
                                    _x setDamage [1, true, _temporaryUnit];
                                };
                            };
                        };
                    } forEach _listOfNearestTreeBushAndDamagedTreesToDest;

                    deleteVehicle _temporaryUnit;
                },
                _explosive
            ] call CBA_fnc_waitUntilAndExecute;
        };
    };
}] call CBA_fnc_addEventHandler;