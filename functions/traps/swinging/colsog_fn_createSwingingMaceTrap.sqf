/*
 * Locality:
 * On the server.
 */

// *******************************************************
// Create the trap composition around the placed Whip Trap.
// Composition includes a tree to suspend the rope.  Another tree
// for starting point of mace to be suspended, and small plant to hide
// one side of the trip wire.
// Also creates a trigger to fire off the trap.
// *******************************************************
params ["_wireTrap"];
if (!isServer) exitWith {};

_wireTrap setPos (getPos _wireTrap vectorAdd [0, 0, -.05]);
private _swingDirection = getDir _wireTrap;
_wireTrap enableSimulation false; // We don't want the Whip Trap to pop out and kill the unit.

// *******************************************************
// Create top of rope object directly above trapProxy position.  Will be where tree branch is.
// For rope physics to work we must use UAV vehicles (the smallest ones). To hide those
// vehicles from player, we create spheres around them, and camouflage the sphere with color and attaching
// a bush.
// *******************************************************
private _topOfRope = "Sign_Sphere100cm_F" createVehicle [10, 10000, 0];
_topOfRope setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer see thru
_topOfRope setObjectTextureGlobal [0, 'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
_topOfRope setPos (getPos _wireTrap vectorAdd [0,0,11.0]);
_topOfRope setDir (_swingDirection + 180);

// *******************************************************
// Create sphere used later to hide mace uav.  And camouflage the sphere.
// *******************************************************
private _maceStartPosition = ([_topOfRope, 8, (_swingDirection + 180)] call BIS_fnc_relPos);
private _maceSphere = "Sign_Sphere100cm_F" createVehicle [10,10000,0];
_maceSphere setPos [_maceStartPosition#0, _maceStartPosition#1, 9.0];
_maceSphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer transparent
_maceSphere setObjectTextureGlobal [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
 
// *******************************************************
// Create tree to left of trapProxy position. This tree will have the mace trap attached to it.
// *******************************************************
private _tree = createSimpleObject ["vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d", [0, 0, 0]];
_tree setPosATL (_wireTrap modelToWorld [3.8, -4, 0]);
_tree setDir ((getDir _wireTrap) - 120);
_tree enableSimulation false;

// *******************************************************
// Create tree where mace is suspended in air to camouflage it
// *******************************************************
private _maceStartTreePosition = ([_topOfRope, 12, (_swingDirection + 180)] call BIS_fnc_relPos);
private _secondTree = createSimpleObject ["vn\vn_vegetation_f_enoch\tree\vn_t_fagussylvatica_1fc.p3d", [0, 0, 0]];
_secondTree setPosATL [_maceStartTreePosition#0, _maceStartTreePosition#1, -6];
_secondTree enableSimulation false;

// *******************************************************
// Create a clutter object help hide the tripwire.
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

// *******************************************************
// Create UAV vehicle at rope top to attach the rope to.  Ropes need to attach to vehicles.
// *******************************************************
 private _ropeTopObject = createVehicle ["B_UGV_02_Science_F", [20, 20, 0], [], 0, "CAN_COLLIDE"];
_ropeTopObject allowDamage false;
_ropeTopObject enableCollisionWith _tree;
_ropeTopObject setFuel 0;
_ropeTopObject engineOn false;
_ropeTopObject disableAI "ALL";

// *******************************************************
// Attach sphere and bush to UAV to hide it from players.
// *******************************************************
 private _bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0, 0, 0]];
_bush enableCollisionWith _ropeTopObject;
_bush enableCollisionWith _tree;
_bush attachTo [_ropeTopObject, [0, 0, 0]];
_ropeTopObject attachTo [_topOfRope, [0, 0, 0]];
_ropeTopObject allowDamage false;
private _directionTo = ([_maceSphere, _ropeTopObject] call BIS_fnc_dirTo);
_ropeTopObject setDir _directionTo;

// *******************************************************
// Create the mace vehicle (UAV) B_UAV_01_F C_Kart_01_F B_UGV_02_Science_F
// *******************************************************
_mace = createVehicle ["B_UGV_02_Science_F", [30, 0, 0], [], 0, "CAN_COLLIDE"];
_mace setVariable ["COLSOG_victimAnimationAlreadyUsed", [], true]; // used to ensure different impale anim applied to many dudes impaled on same mace
_mace disableAI "ALL";
_mace allowDamage false;
_mace setFuel 0;
_mace engineOn false;
_mace setMass 170; // relatively low mass so initial swing doesn't hit the ground, then set higher so hangs lower (in controlMaceSwing function)
_mace setCenterOfMass [0, 0, -.3];
_mace enableCollisionWith _secondTree;

// *******************************************************
// Add bush and sphere to mace to hide it
// *******************************************************
_mace attachTo [_maceSphere, [0, 0, 0]];
_bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0, 0, 0]];
_bush attachTo [_mace, [0, 0, 0]];
_bush setObjectScale .85; 

// *******************************************************
// Attach 4 whip trap punji objects to mace so it has wicked spikes
// *******************************************************
[_mace, [0.55,0,0.03],	[0.999972,-1.70678e-006,-0.0075168],	1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
[_mace, [-0.5,0.14,0],	[-0.998451,-2.64464e-006,-0.0556383],	1.60] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
[_mace, [0.07,-.55,0.2],	[0.0363626,-0.998937,0.263383],		1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
[_mace, [0.07,.55,0.0],	[0.0363626,0.998112,-0.3495081],	1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";

// *******************************************************
// Attach rope between mace and and the pivot point on the trap tree.  This gives a straight rope
// before trap is sprung, and is for visual effect later.  We will use a different rope when trap is sprung.
// *******************************************************
_trigger = createTrigger ["EmptyDetector", [100, 0, 0]];
_trigger setTriggerArea [2.5, 1, 0, false];
_trigger setTriggerActivation [colsog_traps_activatedBySide, "PRESENT", false];
_trigger setTriggerStatements [
    "this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)",
    "",
    ""
    ];
_trigger setPos getPos _wireTrap;

// *******************************************************
// Trap is now ready
// *******************************************************
uiSleep 2.0; // REQUIRED else _trigger might be undefined in waitUntil (bug: https://community.bistudio.com/wiki/waitUntil).
waitUntil {triggerActivated _trigger};
[_wireTrap, _mace, _ropeTopObject, _maceSphere] execVM "functions\traps\swinging\colsog_fn_releaseSwingingMaceTrap.sqf";
