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