// ********************************************************
// Create the trap composition around the placed Whip Trap.
// Composition includes a tree to suspend the rope.  Another tree
// for starting point of mace to be suspended, and small plant to hide
// one side of the trip wire.
// Also creates a trigger to fire off the trap.
// ********************************************************
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

_wire_trap setPos (getPos _wire_trap vectorAdd [0,0,-.05]);
private _swingDir = getDir _wire_trap;
_wire_trap enableSimulation false; // We don't want the Whip Trap to pop out and kill the unit.

// ***************************************************************************
// Create top of rope object directly above trapProxy position.  Will be where tree branch is.
// For rope physics to work we must use UAV vehicles (the smallest ones). To hide those
// vehicles from player, we create spheres around them, and camouflage the sphere with color and attaching
// a bush.
// ***************************************************************************
private _maceSphere = "Sign_Sphere100cm_F" createVehicle [10,10000,0];
_maceSphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer see thru
_maceSphere setObjectTextureGlobal [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
_maceSphere setPos (getPos _wire_trap vectorAdd [0,0, _selected_tree_height]);
_maceSphere setDir (_swingDir + 180);

// ***************************************************************************
// Create a clutter object help hide the tripwire.
// ***************************************************************************
private _clutters  = ["vn\vn_vegetation_f_enoch\clutter\vn_c_fern.p3d","vn\vn_vegetation_f_exp\clutter\grass\vn_c_grass_tropic.p3d","vn\vn_vegetation_f_exp\clutter\red_dirt\vn_c_red_dirt_sparse_grass.p3d","vn\vn_vegetation_f_exp\clutter\volcano\vn_c_volcano_grass.p3d"];
private _clutter = createSimpleObject [selectRandom _clutters, [0,0,0]];
_clutter setPosATL (_wire_trap modelToWorld [1,0,0]);
_clutter setDir (random 360);

// ***************************************************************************
// Create UAV vehicle at rope top to attach the rope to.  Ropes need to attach to vehicles.
// ***************************************************************************
_mace = createVehicle ["B_UGV_02_Science_F", [20,20,0], [], 0, "CAN_COLLIDE"];
_mace allowDamage false;
_mace setFuel 0;
_mace engineOn false;
_mace disableAI "ALL";

// ***************************************************************************
// Attach sphere and bush to UAV to hide it from players.
// ***************************************************************************
_bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0,0,0]];
_bush enableCollisionWith _mace;
_bush attachTo [_mace,[0,0,0]];
_mace attachTo [_maceSphere,[0,0,0]];
_mace allowDamage false;
_mace setMass 170; // relatively low mass so initial swing doesn't hit the ground, then set higher so hangs lower (in controlMaceSwing function)
_mace setCenterOfMass [0,0,-.3];

// ***************************************************************************
// Creating the tree where mace will be hidden.
// ***************************************************************************
if (_selected_tree_type != "None") then {
    _tree = createSimpleObject [_selected_tree_type, [0,0,0]];
    _tree setPosATL (_wire_trap modelToWorld [3.8,-4,0]);
    _tree setDir ((getDir _wire_trap) + _selected_tree_rotation_correction);
    _tree enableSimulation false;
    _mace enableCollisionWith _tree;
    _bush enableCollisionWith _tree;
};

// ***************************************************************************
// Attach 4 whip trap punji objects to mace so it has wicked spikes
// ***************************************************************************
[[_mace,[0.55,0,0.03],	[0.999972,-1.70678e-006,-0.0075168],	1.55], "functions\TRAPS\attachSprungWhipTrap.sqf"] remoteExec ["execVM", 0, true];
[[_mace,[-0.5,0.14,0],	[-0.998451,-2.64464e-006,-0.0556383],	1.60], "functions\TRAPS\attachSprungWhipTrap.sqf"] remoteExec ["execVM", 0, true];
[[_mace,[0.07,-.55,0.2],	[0.0363626,-0.998937,0.263383],			1.55], "functions\TRAPS\attachSprungWhipTrap.sqf"] remoteExec ["execVM", 0, true];
[[_mace,[0.07,.55,0.0],	[0.0363626,0.998112,-0.3495081],		1.55], "functions\TRAPS\attachSprungWhipTrap.sqf"] remoteExec ["execVM", 0, true];

_trigger = createTrigger ["EmptyDetector", [100,0,0]];
_trigger setTriggerArea [2.5, 1, 0, false];
_trigger setTriggerActivation ['WEST', "PRESENT", false];
_trigger setTriggerStatements [
    "this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)",
    "",
    ""
    ];
_trigger setPos getPos _wire_trap;

// ***************************************************************************
// Trap is now ready to be sprung, so spawn a function to monitor it
// ***************************************************************************
uiSleep 2.0; // required else _trigger might be undefined in waitUntil (bug: https://community.bistudio.com/wiki/waitUntil)
waitUntil {triggerActivated _trigger};
[[_wire_trap, _mace, _maceSphere, _selected_tree_height], "functions\TRAPS\falling\monitorFallingMaceTrap.sqf"] remoteExec ["execVM", 0, true];
