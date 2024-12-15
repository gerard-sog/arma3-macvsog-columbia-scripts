/*
 * Create falling mace trap
 *
 * Arguments:
 * 0: _wireTrap
 * 1: _trapHeight
 * 2: _treeType
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [[_wireTrap, _trapHeight, _treeType], "functions\traps\falling\colsog_fn_createFallingMaceTrap.sqf"] remoteExec ["execVM", 2, false];
 *
 * Return values:
 * None
 *
 */

params ["_wireTrap", "_trapHeight", "_treeType"];
if (!isServer) exitWith {};

private _selectedTreeConfiguration = [
    ["None", 0, 0],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_ficus_big_f.p3d", 23, 60],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_inocarpus_f.p3d", 13, 0],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d", 12, 200]
] select _treeType;

private _selectedTreeType = _selectedTreeConfiguration select 0;
private _selectedTreeHeight = _selectedTreeConfiguration select 1;
private _selectedTreeRotationCorrection = _selectedTreeConfiguration select 2;

// Allow to force height of trap.
if (_trapHeight != 0) then {
    _selectedTreeHeight = _trapHeight;
};

_wireTrap setPos (getPos _wireTrap vectorAdd [0, 0, -.05]);
private _swingDirection = getDir _wireTrap;

_wireTrap enableSimulationGlobal false; // We don't want the Whip Trap to pop out and kill the unit.

// *******************************************************
// Create sphere top of trap position (at selected height)
// *******************************************************
private _maceSphere = "Sign_Sphere100cm_F" createVehicle [10, 10000, 0];
_maceSphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer see thru
_maceSphere setObjectTextureGlobal [0, 'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
_maceSphere setPos (getPos _wireTrap vectorAdd [0, 0, _selectedTreeHeight]);
_maceSphere setDir (_swingDirection + 180);

["zen_common_updateEditableObjects", [[_maceSphere], true]] call CBA_fnc_serverEvent; // add macesphere to zeus, this will be our deletion object
private _trapObjDeleteArray = []; // variable to store objects of the composition
_trapObjDeleteArray pushBack _wireTrap; // wiretrap deleted if macesphere deleted

// *******************************************************
// Create a clutter object help hide the tripwire
// *******************************************************
private _clutters  = [
    "vn\vn_vegetation_f_enoch\clutter\vn_c_fern.p3d",
    "vn\vn_vegetation_f_exp\clutter\grass\vn_c_grass_tropic.p3d",
    "vn\vn_vegetation_f_exp\clutter\red_dirt\vn_c_red_dirt_sparse_grass.p3d",
    "vn\vn_vegetation_f_exp\clutter\volcano\vn_c_volcano_grass.p3d"
    ];
private _clutter = createSimpleObject [selectRandom _clutters, [0, 0, 0]];
_clutter setPosATL (_wireTrap modelToWorld [1, 0, 0]);
_clutter setDir (random 360);

_trapObjDeleteArray pushBack _clutter; // deleted if macesphere deleted

// *******************************************************
// Create UAV vehicle (present in the sphere)
// *******************************************************
private _mace = createVehicle ["B_UGV_02_Science_F", [20, 20, 0], [], 0, "CAN_COLLIDE"]; // deleted when trap triggered
_mace allowDamage false;
_mace setFuel 0;
_mace engineOn false;
_mace disableAI "ALL";

_trapObjDeleteArray pushBack _mace; // deleted if macesphere deleted

// *******************************************************
// Attach bush to mace and mace to sphere
// *******************************************************
private _bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0,0,0]];
_bush enableCollisionWith _mace;
_bush attachTo [_mace, [0, 0, 0]];
_mace attachTo [_maceSphere, [0, 0, 0]];
_mace allowDamage false;
_mace setMass 170; // relatively low mass so initial swing doesn't hit the ground, then set higher so hangs lower.
_mace setCenterOfMass [0, 0, -.3];

_trapObjDeleteArray pushBack _bush; // deleted if macesphere deleted

// *******************************************************
// Creating the tree where mace will be hidden.
// *******************************************************
if (_selectedTreeType != "None") then {
    private _tree = createSimpleObject [_selectedTreeType, [0, 0, 0]];
    _tree setPosATL (_wireTrap modelToWorld [3.8, -4, 0]);
    _tree setDir ((getDir _wireTrap) + _selectedTreeRotationCorrection);
    _tree enableSimulation false;
    _mace enableCollisionWith _tree;
    _bush enableCollisionWith _tree;

    _trapObjDeleteArray pushBack _tree; // deleted if macesphere deleted
};

// *******************************************************
// Attach 4 whip trap objects to mace so it has spikes
// *******************************************************
COLSOG_fnc_attachSprungWhipTrap = {
    params ["_object", "_attachPosition", "_vectorUp", "_scale"];
    private _punji = createSimpleObject ["vn\weapons_f_vietnam\mines\punji\vn_mine_punji_02_ammo.p3d", [0, 0, 0]];
    _punji animateSource ["mine_trigger_source", 1]; 
    _punji attachTo [_object, _attachPosition];
    _punji setVectorUp _vectorUp;
    _punji setObjectScale _scale;
    _punji; // return object from function
};

private _sprungwhip1 = [_mace, [0.55,0,0.03], [0.999972,-1.70678e-006,-0.0075168], 1.55] call COLSOG_fnc_attachSprungWhipTrap;
_trapObjDeleteArray pushBack _sprungwhip1; // deleted if macesphere deleted

private _sprungwhip2 = [_mace, [-0.5,0.14,0], [-0.998451,-2.64464e-006,-0.0556383], 1.60] call COLSOG_fnc_attachSprungWhipTrap;
_trapObjDeleteArray pushBack _sprungwhip2; // deleted if macesphere deleted

private _sprungwhip3 = [_mace, [0.07,-.55,0.2], [0.0363626,-0.998937,0.263383], 1.55] call COLSOG_fnc_attachSprungWhipTrap;
_trapObjDeleteArray pushBack _sprungwhip3; // deleted if macesphere deleted

private _sprungwhip4 = [_mace, [0.07,.55,0.0], [0.0363626,0.998112,-0.3495081], 1.55] call COLSOG_fnc_attachSprungWhipTrap;
_trapObjDeleteArray pushBack _sprungwhip4; // deleted if macesphere deleted

//[_mace, [0.55,0,0.03],	[0.999972,-1.70678e-006,-0.0075168],	1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
//[_mace, [-0.5,0.14,0],	[-0.998451,-2.64464e-006,-0.0556383],	1.60] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
//[_mace, [0.07,-.55,0.2],	[0.0363626,-0.998937,0.263383],		1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
//[_mace, [0.07,.55,0.0],	[0.0363626,0.998112,-0.3495081],	1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
// 4 whip need deletion if wiretrap deleted
// to do later, need to pass _trapObjDeleteArray or return object from execVM

// *******************************************************
// Create invisible trigger for the trap
// *******************************************************
private _trigger = createTrigger ["EmptyDetector", [100, 0, 0]]; // deleted when trap triggered
_trigger setTriggerArea [2.5, 1, 0, false];
_trigger setTriggerActivation [colsog_traps_activatedBySide, "PRESENT", false];
_trigger setTriggerStatements [
    "this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)",
    "",
    ""
    ];
_trigger setPos getPos _wireTrap;

_trapObjDeleteArray pushBack _trigger; // deleted if macesphere deleted

WATCHARRAY = _trapObjDeleteArray;
publicVariable "WATCHARRAY"; // broadcast for debug

// Whole composition deletion on _maceSphere
[
    {!alive (_this select 0)}, // (_this select 0) is 1st argument _maceSphere
    {
        {
            if !(isNull _x) then {
                deleteVehicle _x;
            };
        } forEach (_this select 1); // (_this select 1) is 2nd argument _trapObjDeleteArray
    }, 
    [_maceSphere, _trapObjDeleteArray] // arguments passes to statement & condition
] call CBA_fnc_waitUntilAndExecute;

// *******************************************************
// Trap is now ready
// *******************************************************
uiSleep 2.0; // REQUIRED else _trigger might be undefined in waitUntil (bug: https://community.bistudio.com/wiki/waitUntil).
waitUntil {triggerActivated _trigger};
// TO DO rewrite with CBA_waitUntilAndExecute

[_wireTrap, _mace, _maceSphere, _selectedTreeHeight, _trigger] execVM "functions\traps\falling\colsog_fn_releaseFallingMaceTrap.sqf";
