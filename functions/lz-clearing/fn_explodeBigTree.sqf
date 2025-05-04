/*
 * Adds an event handler on 'ace_explosives_place' ACE event. It will only trigger for the explosive
 * 'c4_charge_small.p3d' and will destroy the tree in a radius around the explosion.
 *
 * Return values:
 * None
 */

if (!isServer) exitWith {};

["ace_explosives_place", {
    params ["_explosive", "_dir", "_pitch", "_unit"];

    private _modelInfo = getModelInfo _explosive;
    private _explosiveP3dName = _modelInfo select 0;

    if (_explosiveP3dName == "c4_charge_small.p3d") then {
        [
            {!alive _this},
            {
                // -------------------
                // | Set unconscious |
                // -------------------
                private _unitsToUnconscious = nearestObjects [_this, ["CAManBase"], 20];

                {
                    if (isPlayer _x) then {
                        [_x, true, 30, true] call ace_medical_fnc_setUnconscious;
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

                _vehiclesToUnconsciousDriver = nearestObjects [_this, ["LandVehicle"], 20];
                {
                    _driver = driver _x;
                    if (isPlayer _driver) then {
                        [_driver, true, 30, true] call ace_medical_fnc_setUnconscious;
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

                // -------------
                // | Cut trees |
                // -------------
                private _listOfNearestTerrainTreesAndBushes = nearestTerrainObjects [_this, ["Tree", "Bush"], 5, true, true];

                {
                    private _modelInfo = getModelInfo _x;
                    private _treeP3dName = _modelInfo select 0;

                    private _listOfIndestructibleTrees = [
                        "vn_t_ficus_big_f.p3d",
                        "vn_t_inocarpus_f.p3d",
                        "vn_dried_t_ficus_big_01.p3d"
                    ];

                    if ((_listOfIndestructibleTrees find _treeP3dName) != -1) then {
                        [_x, true] remoteExec ["hideObjectGlobal", 2];
                        _pos = getPosATL _x;
                        createVehicle ["land_vn_burned_t_ficus_big_04", _pos, [], 0, "CAN_COLLIDE"];
                    } else {
                        _x setDamage 1;
                    };
                } forEach _listOfNearestTerrainTreesAndBushes;
            },
            _explosive
        ] call CBA_fnc_waitUntilAndExecute;
    };
}] call CBA_fnc_addEventHandler;

["ace_dragging_stoppedCarry", {
    params 	["_unit", "_target", "_loadCargo"];

    private _hasConcussion = _target getVariable ["COLSOG_hasConcussion", false];

    if ((!isPlayer _target) && (_hasConcussion)) then {
        _target switchMove "UnconsciousFaceDown";
    };
}] call CBA_fnc_addEventHandler;

["ace_dragging_stoppedDrag", {
    params 	["_unit", "_target"];

    private _hasConcussion = _target getVariable ["COLSOG_hasConcussion", false];

    if ((!isPlayer _target) && (_hasConcussion)) then {
        _target switchMove "UnconsciousFaceDown";
    };
}] call CBA_fnc_addEventHandler;