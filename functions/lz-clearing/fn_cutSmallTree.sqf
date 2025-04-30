/*
 * Adds an event handler on a 'GestureDone' that will only trigger for the 'vn_bayonet_knife_swing' gesture. This
 * new event handler will allow the player to cut down trees.
 *
 * Return values:
 * None
 */

if !(hasInterface) exitWith {};

player addEventHandler [
    "GestureDone", {
    params ["_unit", "_gesture"];
    if (_gesture == "vn_bayonet_knife_swing") then {

        private _listOfAuthorizedCuttingTool = [
            "vn_m_axe_01",
            "vn_m_bolo_01",
            "vn_m_machete_02"
        ];

        if ((_listOfAuthorizedCuttingTool find currentWeapon _unit) != -1) then {
            private _object = cursorObject;
            private _modelInfo = getModelInfo _object;
            private _objectP3dName = _modelInfo select 0;

            private _isAuthorizedTree = false;
            private _treeCuttingTime = 0;

            private _hashMapOfTreeAndTimeToCut = [
                ["vn_pine_tree_01.p3d", 6],
                ["vn_t_agathis_tall_f.p3d", 6],
                ["vn_t_cyathea_f.p3d", 4],
                ["vn_b_cycas_f.p3d", 2],
                ["vn_t_banana_slim_f.p3d", 1],
                ["vn_t_banana_f.p3d", 1],
                ["vn_b_calochlaena_f.p3d", 1],
                ["vn_t_palaquium_f.p3d", 8],
                ["vn_elephant_grass_01_lc.p3d", 1],
                ["vn_t_pritchardia_f.p3d", 2],
                ["vn_b_leucaena_f.p3d", 2],
                ["vn_bamboo_bush_01.p3d", 1],
                ["vn_dried_t_ficus_medium_01.p3d", 8],
                ["vn_t_cocos_bend_f.p3d", 6],
                ["vn_t_cocosnucifera3s_tall_f.p3d", 6],
                ["vn_t_agathis_wide_f.p3d", 8]
            ];

            {
                private _key = _x select 0;
                if ([_key, _objectP3dName] call BIS_fnc_inString) exitWith {
                    _isAuthorizedTree = true;
                    _treeCuttingTime = _x select 1;
                };
            } forEach _hashMapOfTreeAndTimeToCut;

            if (_isAuthorizedTree) then {
                if (_unit distance2D _object < 4) then {

                    _key = str _object;

                    _hp = _unit getVariable _key;
                    if (isNil "_hp") then {
                        _unit setVariable[_key, _treeCuttingTime, true];
                        hintSilent format ["Progress: " + str _treeCuttingTime + "/" + str _treeCuttingTime];
                    } else {
                        _newHp = _hp - 1;
                        _unit setVariable[_key, _newHp, true];
                        hintSilent format ["Progress: " + str (_newHp) + "/" + str _treeCuttingTime];
                        if (_newHp < 1) then {
                            _object setDamage 1;
                        };
                    };
                };
            };
        };
    };
}];