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
                private _unitsToUnconscious = nearestObjects [_this, ["CAManBase"], 20];

                {
                    if (isPlayer _x) then {
                        [_x, true, 30, true] call ace_medical_fnc_setUnconscious;
                    } else {
                        _x setUnconscious true;
                    };
                } forEach _unitsToUnconscious;

                private _listOfNearestTerrainTreesAndBushes = nearestTerrainObjects [_this, ["Tree", "Bush"], 10, true, true];

                {
                    private _modelInfo = getModelInfo _x;
                    private _treeP3dName = _modelInfo select 0;

                    private _hashMapOfIndestructibleTreesAndBounfingBoxCorrection = [
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
                    } forEach _hashMapOfIndestructibleTreesAndBounfingBoxCorrection;

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

                    if (_this distance2D _correctedPos < 7) then {
                        if (_isIndestructibleTree) then {
                            [_x, true] remoteExec ["hideObjectGlobal", 2];
                            createVehicle ["land_vn_burned_t_ficus_big_04", _correctedPos, [], 0, "CAN_COLLIDE"];
                        } else {
                            _x setDamage 1;
                        };
                    };
                } forEach _listOfNearestTerrainTreesAndBushes;
            },
            _explosive
        ] call CBA_fnc_waitUntilAndExecute;
    };
}] call CBA_fnc_addEventHandler;