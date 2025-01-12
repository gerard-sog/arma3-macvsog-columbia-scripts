/*
 * Makes player executing the action climbing up a tree (actually teleport on top of tree on invisible platform
 * and is frozen in order to not fall).
 *
 * Return values:
 * None
 */

private _object = cursorObject;
private _modelInfo = getModelInfo _object;

private _hashMapOfAuthorizedTreesAndHeightCorrection = [
    ["t_cyathea_f.p3d", 2],
    ["t_cocos_tall_f.p3d", 9],
    ["t_cocosnucifera3s_tall_f.p3d", 0],
    ["t_inocarpus_f.p3d", 8],
    ["t_palaquium_f.p3d", 3],
    ["t_ficus_big_f.p3d", 15],
    ["t_cocosnucifera2s_small_f.p3d", 8]
];

private _isAuthorizedTree = false;
private _treeHeightCorrection = 0;
private _objectP3dName = _modelInfo select 0;

{
    private _key = _x select 0;
    if ([_key, _objectP3dName] call BIS_fnc_inString) exitWith {
        _isAuthorizedTree = true;
        _treeHeightCorrection = _x select 1;
    };
} forEach _hashMapOfAuthorizedTreesAndHeightCorrection;

if (!_isAuthorizedTree) exitWith {
    hintSilent format ["I cannot climb this."];
};

if (player distance2D _object > 7) exitWith {
    hintSilent format ["I need to get closer."];
};

[
    colsog_climbing_timeToClimbUp,
    [_object, _treeHeightCorrection],
    {
        params ["_args"];
        _args params ["_object", "_treeHeightCorrection"];

        // Makes unit hidden for AI.
        player setVariable ["hatg_mirror_force_hidden", true];

        private _xyzTreeDimension = _object call BIS_fnc_boundingBoxDimensions;
        private _treeHeight = (_xyzTreeDimension select 1) + _treeHeightCorrection;

        private _platform = createVehicle ["Land_vn_o_platform_04", getPos player vectorAdd [0, 0, _treeHeight]];
        private _playerPos = getPos player;
        _platform setPos [_playerPos select 0, _playerPos select 1, _treeHeight + 2];

        player setPos (getPos _platform vectorAdd [0, 0, 1]);

        player setVariable ["COLSOG_isUpInTree", true, false];
        player setVariable ["COLSOG_platform", _platform, false];

        [
            {(player distance _this) > 5},
            {
                deleteVehicle _this;
                // Reveal unit to AI.
                player setVariable ["hatg_mirror_force_hidden", false];
                player setVariable ["COLSOG_isUpInTree", false, false];
            },
            _platform
        ] call CBA_fnc_waitUntilAndExecute;
    },
    {},
    "Climbing up the tree!"
] call ace_common_fnc_progressBar;