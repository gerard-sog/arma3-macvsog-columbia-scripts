params ["_wire_trap", "_trap_height", "_tree_type"];
if (!isServer) exitWith {};

_selected_tree_configuration = [
    ["None", 0, 0],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_ficus_big_f.p3d", 23, 60],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_inocarpus_f.p3d", 13, 0],
    ["\vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d", 12, 200]
    ] select _tree_type;

_selected_tree_type = _selected_tree_configuration select 0;
_selected_tree_height = _selected_tree_configuration select 1;
_selected_tree_rotation_correction = _selected_tree_configuration select 2;

// Allow to force height of trap.
if (_trap_height != 0) then {
    _selected_tree_height = _trap_height;
};

_wire_trap setPos (getPos _wire_trap vectorAdd [0, 0, -.05]);
private _swing_dir = getDir _wire_trap;
_wire_trap enableSimulation false; // We don't want the Whip Trap to pop out and kill the unit.

// *******************************************************
// Create sphere top of trap position (at selected height)
// *******************************************************
private _mace_sphere = "Sign_Sphere100cm_F" createVehicle [10, 10000, 0];
_mace_sphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer see thru
_mace_sphere setObjectTextureGlobal [0, 'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
_mace_sphere setPos (getPos _wire_trap vectorAdd [0, 0, _selected_tree_height]);
_mace_sphere setDir (_swing_dir + 180);

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
_clutter setPosATL (_wire_trap modelToWorld [1, 0, 0]);
_clutter setDir (random 360);

// *******************************************************
// Create UAV vehicle (present in the sphere)
// *******************************************************
_mace = createVehicle ["B_UGV_02_Science_F", [20, 20, 0], [], 0, "CAN_COLLIDE"];
_mace allowDamage false;
_mace setFuel 0;
_mace engineOn false;
_mace disableAI "ALL";

// *******************************************************
// Attach bush to mace and mace to sphere
// *******************************************************
_bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0,0,0]];
_bush enableCollisionWith _mace;
_bush attachTo [_mace, [0, 0, 0]];
_mace attachTo [_mace_sphere, [0, 0, 0]];
_mace allowDamage false;
_mace setMass 170; // relatively low mass so initial swing doesn't hit the ground, then set higher so hangs lower.
_mace setCenterOfMass [0, 0, -.3];

// *******************************************************
// Creating the tree where mace will be hidden.
// *******************************************************
if (_selected_tree_type != "None") then {
    _tree = createSimpleObject [_selected_tree_type, [0, 0, 0]];
    _tree setPosATL (_wire_trap modelToWorld [3.8, -4, 0]);
    _tree setDir ((getDir _wire_trap) + _selected_tree_rotation_correction);
    _tree enableSimulation false;
    _mace enableCollisionWith _tree;
    _bush enableCollisionWith _tree;
};

// *******************************************************
// Attach 4 whip trap objects to mace so it has spikes
// *******************************************************
[[_mace, [0.55,0,0.03],	[0.999972,-1.70678e-006,-0.0075168],	1.55], "functions\TRAPS\columbia_fnc_attach_sprung_whip_trap.sqf"] remoteExec ["execVM", 0, true];
[[_mace, [-0.5,0.14,0],	[-0.998451,-2.64464e-006,-0.0556383],	1.60], "functions\TRAPS\columbia_fnc_attach_sprung_whip_trap.sqf"] remoteExec ["execVM", 0, true];
[[_mace, [0.07,-.55,0.2],	[0.0363626,-0.998937,0.263383],		1.55], "functions\TRAPS\columbia_fnc_attach_sprung_whip_trap.sqf"] remoteExec ["execVM", 0, true];
[[_mace, [0.07,.55,0.0],	[0.0363626,0.998112,-0.3495081],	1.55], "functions\TRAPS\columbia_fnc_attach_sprung_whip_trap.sqf"] remoteExec ["execVM", 0, true];

// *******************************************************
// Create invisible trigger for the trap
// *******************************************************
_trigger = createTrigger ["EmptyDetector", [100, 0, 0]];
_trigger setTriggerArea [2.5, 1, 0, false];
_trigger setTriggerActivation [Columbia_CBA_traps_trigger_activated_by, "PRESENT", false];
_trigger setTriggerStatements [
    "this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)",
    "",
    ""
    ];
_trigger setPos getPos _wire_trap;

// *******************************************************
// Trap is now ready
// *******************************************************
uiSleep 2.0; // REQUIRED else _trigger might be undefined in waitUntil (bug: https://community.bistudio.com/wiki/waitUntil).
waitUntil {triggerActivated _trigger};
[[_wire_trap, _mace, _mace_sphere, _selected_tree_height], "functions\TRAPS\falling\columbia_fnc_release_falling_mace_trap.sqf"] remoteExec ["execVM", 0, true];
