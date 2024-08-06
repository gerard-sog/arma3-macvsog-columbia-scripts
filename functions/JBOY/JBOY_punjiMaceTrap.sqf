// ******************************************************************
// Script:  JBOY_punjiMaceTrap.sqf
// Author:  johnnyboy
// Credits: Savage Game Design for the objects and sound files used by this script.
// ******************************************************************
// ********************************************************
// Initialize stuff shared by all placed mace traps.
// ********************************************************
// ========> Same content as "maceTrapInit.sqf"
JBOY_maceTrapInit =
{
	if (!isServer) exitWith {};
	if !((missionNamespace getVariable ["vn_us_death_screams",[]]) isEqualTo []) exitWith {};
	missionNamespace setVariable ["vn_us_death_screams",
	["vn_sam_usdeath_001","vn_sam_usdeath_002","vn_sam_usdeath_003","vn_sam_usdeath_004","vn_sam_usdeath_005","vn_sam_usdeath_006","vn_sam_usdeath_007","vn_sam_usdeath_008","vn_sam_usdeath_009","vn_sam_usdeath_010","vn_sam_usdeath_011","vn_sam_usdeath_012","vn_sam_usdeath_013","vn_sam_usdeath_014","vn_sam_usdeath_015","vn_sam_usdeath_016","vn_sam_usdeath_017","vn_sam_usdeath_018","vn_sam_usdeath_019","vn_sam_usdeath_020","vn_sam_usdeath_021","vn_sam_usdeath_022","vn_sam_usdeath_023","vn_sam_usdeath_024","vn_sam_usdeath_025","vn_sam_usdeath_026","vn_sam_usdeath_027","vn_sam_usdeath_028","vn_sam_usdeath_029","vn_sam_usdeath_030","vn_sam_usdeath_031","vn_sam_usdeath_032","vn_sam_usdeath_033","vn_sam_usdeath_034","vn_sam_usdeath_035","vn_sam_usdeath_036","vn_sam_usdeath_037","vn_sam_usdeath_038","vn_sam_usdeath_039","vn_sam_usdeath_040","vn_sam_usdeath_041","vn_sam_usdeath_042","vn_sam_usdeath_043","vn_sam_usdeath_044","vn_sam_usdeath_045","vn_sam_usdeath_046","vn_sam_usdeath_047","vn_sam_usdeath_048","vn_sam_usdeath_049","vn_sam_usdeath_050","vn_sam_usdeath_051","vn_sam_usdeath_052","vn_sam_usdeath_053","vn_sam_usdeath_054","vn_sam_usdeath_055","vn_sam_usdeath_056","vn_sam_usdeath_057","vn_sam_usdeath_058"]
	,true];
};

// ********************************************************
// Create the trap composition around the placed Whip Trap.
// Composition includes a tree to suspend the rope.  Another tree
// for starting point of mace to be suspended, and small plant to hide
// one side of the trip wire.
// Also creates a trigger to fire off the trap.
// ********************************************************
// ========> Same content as "maceTrapCreate.sqf"
JBOY_maceTrapCreate =
{ 
	params ["_trapProxy","_triggerActivatedBy"]; 
	if (!isServer) exitWith {};
	[] call JBOY_maceTrapInit;
	_trapProxy setVariable ["isMaceTrap",true,false]; // Tells other JBOY punji victim FX scripts that this Whip Trap is a Mace Trap
	_trapProxy setpos (getpos _trapProxy vectorAdd [0,0,-.05]);
	private _swingDir = getDir _trapProxy; 
	_trapProxy enableSimulation false; // We don't want the Whip Trap to pop out and kill the unit.
	
	// ***************************************************************************
	// Create top of rope object directly above trapProxy position.  Will be where tree branch is.
	// For rope physics to work we must use UAV vehicles (the smallest ones). To hide those
	// vehicles from player, we create spheres around them, and camoflage the sphere with color and attaching
	// a bush.
	// ***************************************************************************
	private _topOfRope = "Sign_Sphere100cm_F" createVehicle [10,10000,0]; 
	_topOfRope setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer see thru 
	_topOfRope setObjectTextureGlobal [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
	_topOfRope setPos (getpos _trapProxy vectorAdd [0,0,11.0]);
	_topOfRope setDir (_swingDir + 180); 
	
	// ***************************************************************************
	// Create sphere used later to hide mace uav.  And camoflage the sphere.
	// ***************************************************************************
	private _maceStartPos = ([_topOfRope, 8, (_swingDir + 180)] call BIS_fnc_relPos); 
	private _maceSphere = "Sign_Sphere100cm_F" createVehicle [10,10000,0]; 
	_maceSphere setPos [_maceStartPos#0, _maceStartPos#1, 9.0]; 
	_maceSphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer transparent
	_maceSphere setObjectTextureGlobal [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa'];
	 
	// ***************************************************************************
	// Create tree to left of trapProxy position. This tree will have the mace trap attached to it.
	// ***************************************************************************
	private _tree = createSimpleObject ["vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d", [0,0,0]]; 
	_tree setPosatl (_trapProxy modelToWorld [3.8,-4,0]);
	_tree setDir ((getDir _trapProxy)-120); 
	_tree enableSimulation false;

	// ***************************************************************************
	// Create tree where mace is suspended in air to camouflage it
	// ***************************************************************************
	private _maceStartTreePos = ([_topOfRope, 12, (_swingDir + 180)] call BIS_fnc_relPos); 
	private _tree2 = createSimpleObject ["vn\vn_vegetation_f_enoch\tree\vn_t_fagussylvatica_1fc.p3d", [0,0,0]]; 
	_tree2 setPosatl [_maceStartTreePos#0,_maceStartTreePos#1,-6];
	_tree2 enableSimulation false;

	// ***************************************************************************
	// Create path blocker object to left of tree so AI won't try to go around tree instead of walking thru trap.
	// Otherwise stupid AI walks around spawned tree instead of walking thru trap.
	// ***************************************************************************
	private _blockers = ["vn\vn_vegetation_f_enoch\bush\vn_b_caragana_arborescens.p3d",
			"vn\structures_f_vietnam\civ\fences\vn_fence_punji_02_05.p3d",
			"vn\vn_vegetation_f_exp\shrub\vn_b_ficusc2d_tanoa_f.p3d",
			"vn\vn_plants_f\bush\vn_b_ficusc1s_f.p3d"];
	private _pathblocker = createSimpleObject [selectRandom _blockers, [0,0,0]];  
	_pathblocker setPosatl (_trapProxy modelToWorld [5.8,-2,0]); 
	_pathblocker setDir ((getDir _trapProxy)-180); 

	// ***************************************************************************
	// Create a clutter object help hide the tripwire.
	// ***************************************************************************
	private _clutters  = ["vn\vn_plants_f\clutter\vn_c_thistle_small.p3d","vn\vn_vegetation_f_enoch\clutter\vn_c_fern.p3d","vn\vn_vegetation_f_exp\clutter\grass\vn_c_grass_tropic.p3d","vn\vn_plants_f\clutter\vn_c_plant_greenbunch.p3d","vn\vn_vegetation_f_exp\clutter\red_dirt\vn_c_red_dirt_sparse_grass.p3d","vn\vn_vegetation_f_exp\clutter\volcano\vn_c_volcano_grass.p3d"];
	private _clutter = createSimpleObject [selectRandom _clutters, [0,0,0]];  
	_clutter setPosatl (_trapProxy modelToWorld [1,0,0]); 
	_clutter setDir (random 360); 
	
	// ***************************************************************************
	// Create UAV vehicle at rope top to attach the rope to.  Ropes need to attach to vehicles.
	// ***************************************************************************
	 private _ropeTopObj = createVehicle ["B_UGV_02_Science_F", [20,20,0], [], 0, "CAN_COLLIDE"]; 
	_ropeTopObj allowDamage false;
	_ropeTopObj enableCollisionWith _tree;
	_ropeTopObj setFuel 0; 
	_ropeTopObj engineOn false; 
	_ropeTopObj disableAI "ALL";
	// ***************************************************************************
	// Attach sphere and bush to UAV to hide it from players.
	// ***************************************************************************
	 private _bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0,0,0]]; 
	_bush enableCollisionWith _ropeTopObj;
	_bush enableCollisionWith _tree;
	_bush attachto [_ropeTopObj,[0,0,0]];  
	_ropeTopObj  attachTo [_topOfRope,[0,0,0]];
	_ropeTopObj allowdamage false; 
	_dirTo = ([_maceSphere, _ropeTopObj] call BIS_fnc_dirTo);  
	_ropeTopObj setDir _dirTo; 

	// ***************************************************************************
	// Create the mace vehicle (UAV) B_UAV_01_F C_Kart_01_F B_UGV_02_Science_F
	// ***************************************************************************
	_mace = createVehicle ["B_UGV_02_Science_F", [30,0,0], [], 0, "CAN_COLLIDE"]; //B_UGV_02_Science_F
	_mace setVariable ["victimAnimsAlreadyUsed",[],true]; // used to ensure different impale anim applied to many dudes impaled on same mace
	_mace disableAI "ALL"; 
	_mace allowDamage false; 
	_mace setFuel 0; 
	_mace engineOn false; 
	_mace setMass 180; // low mass 130 so initial swing doesn't hit the ground, then set higher so hangs lower (180)
	_mace setDir _dirTo; 
	_mace setCenterOfMass [0,0,-.3]; 
	_mace enableCollisionWith _tree2;

	// ***************************************************************************
	// Add bush and sphere to mace to hide it
	// ***************************************************************************
	_mace  attachTo [_maceSphere,[0,0,0]]; 
	_bush = createSimpleObject ["vn\vn_vegetation_f_enoch\bush\vn_b_betula_nana.p3d", [0,0,0]]; 
	_bush attachto [_mace,[0,0,0]];  
	_bush setObjectScale .85; 

	// ***************************************************************************
	// Attach 4 whip trap punji objects to mace so it has wicked spikes
	// ***************************************************************************
	[_mace,[0.55,0,0.03],	[0.999972,-1.70678e-006,-0.0075168],	1.55] call JBOY_attachSprungWhipTrap;
	[_mace,[-0.5,0.14,0],	[-0.998451,-2.64464e-006,-0.0556383],	1.60] call JBOY_attachSprungWhipTrap;
	[_mace,[0.07,-.55,0.2],	[0.0363626,-0.998937,0.263383],			1.55] call JBOY_attachSprungWhipTrap;
	[_mace,[0.07,.55,0.0],	[0.0363626,0.998112,-0.3495081],		1.55] call JBOY_attachSprungWhipTrap;
 
	// ***************************************************************************
	// Attach rope between mace and and the pivot point on the trap tree.  This gives a straight rope
	// before trap is sprung, and is for visual effect later.  We will use a different rope when trap is sprung.
	// ***************************************************************************
	_mace enableSimulation false;
	_ropeTopObj enableSimulation false;

	_trapProxy setVariable ["JBOY_springTrap",false,true];

	_trigger = createTrigger ["EmptyDetector", [100,0,0]];
	_trigger setVariable ["trapObject",_trapProxy,true];
	_trigger setTriggerArea [2.5, 1, 0, false];
	_trigger setTriggerActivation [_triggerActivatedBy, "PRESENT", false];
	_trigger setTriggerStatements ["this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)", '',""];
	_trigger setPos getpos _trapProxy;
	// ***************************************************************************
	// Trap is now ready to be sprung, so spawn a functiont to monitor it
	// ***************************************************************************
	[_trapProxy,_mace,_ropeTopObj,_maceSphere,_trigger] spawn JBOY_monitorMaceTrap;
};

// ********************************************************
// Attach sprung whip trap punji object to object.  
// To see the sprung trap stakes you have to animateSource the object first.
// ********************************************************
// ========> Same content as "attachSprungWhipTrap.sqf"
JBOY_attachSprungWhipTrap =
{
	params ["_obj","_attachPos","_vectorUp","_scale"];
	private _trap = createVehicle ["vn_mine_punji_02_ammo", [0,2,0], [], 0, "CAN_COLLIDE"]; 
	private _model_info = getModelInfo _trap; 
	private _file_path = format["%1%2",(_model_info#1) select [0, count (_model_info#1) - 4], "_ammo.p3d"]; 
	private _punji = createSimpleObject [_file_path, [0,0,0]]; 
	_punji animateSource ["mine_trigger_source", 1]; 
	deleteVehicle _trap; 
	_punji attachTo [_obj,_attachPos];
	_punji setVectorUp _vectorUp;
	_punji setObjectScale _scale; 
};

// ********************************************************
// Spring the trap when any unit trips it.
// ********************************************************
// ========> Same content as "monitorMaceTrap.sqf"
JBOY_monitorMaceTrap =
{
	params ["_trapProxy","_mace","_ropeTopObj","_maceSphere","_trigger"];
	private _trapPos = getPos _trapProxy;
	private _trapDir = getDir _trapProxy;
	
	waitUntil {triggerActivated _trigger or (_trapProxy getVariable ["JBOY_springTrap",false])}; 
	private _unit = nearestObject [_trapPos,'Man'];
	playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss",_trapProxy, false, _trapProxy, 4];
	deleteVehicle _trapProxy;
	// *******************************************************
	// Delete cosmetic rope and attach swing rope.  Then detach mace from original position to start the swing
	// *******************************************************
	_mace enableSimulation true;

	private _rope2 = ropeCreate [_mace, [0,0,.1],_ropeTopObj, [0,0,-.5],_mace distance _ropeTopObj]; 
	detach _mace;
	_maceSphere attachTo [_mace,[0,0,0]]; 
	private _dirTo = ([_maceSphere, _ropeTopObj] call BIS_fnc_dirTo);
	_mace setDir _dirTo;
	
	// *******************************************************
	// stablilizes mace swing and plays creaking noise
	// *******************************************************
	[_mace,_ropeTopObj] spawn JBOY_controlMaceSwing;
	// *******************************************************
	// Units react to springing of trap
	// *******************************************************
	sleep 1.5;
	private _group = group _unit;

	// *******************************************************
	// sound FX and accelerate swing when mace lower (waiting so it won't just piledrive into the ground)
	// *******************************************************
	_sound = "a3\sounds_f\characters\movements\bush_004.wss";
	playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
	waitUntil {_mace distance2D _trapPos < 3};
	playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
	// *******************************************************
	// Deal with victims of mace
	// *******************************************************
	[_unit,_mace, _trapDir, _trapPos] spawn JBOY_maceVictims;
	sleep 1;

	// *******************************************************
	// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity...argggh!!!).
	// *******************************************************
	sleep 2;
	sleep 1;
	private _future = time + 10;
	waitUntil {!alive _unit or _trapPos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};
	if (_trapPos distance _unit > 3 or !(vehicle _unit == _unit)) then 
	{
		if (alive _unit and !isPlayer _unit) then 
		{
			_unit doMove (_unit modelToWorld [0,9,0]); 
			_unit setSpeedMode "FULL"; 
			_unit forcespeed -1;
			sleep 2;
			{_x forceSpeed 0;} forEach units _group;
		};
	};
	[_mace] spawn JBOY_endMaceSwinging;
};

// *********************************************************************
// Find units near unit that triggered mace as a list of potential victims.
// Then call function to make them a victim if they are hit by the mace.
// *********************************************************************
// ========> Same content as "maceVictims.sqf"
JBOY_maceVictims = 
{
	params ["_unit","_mace","_trapDir","_trapPos"];
	_mace setVariable ["_triggerUnit",_unit,true];
	_victims = (_unit nearEntities ["Man", 20]) select {_x isKindOf "Man"}; // nearEntities 'Man' includes UGV, so we exclude those with isKindOf
	{
		[_x,_mace, _trapDir, _trapPos] spawn JBOY_maceVictim;
	} forEach _victims;
};
// ********************************************************
// Attachd victim to mace and play various fx (sound, blood, etc.)
// ********************************************************
// ========> Same content as "maceVictim.sqf"
JBOY_maceVictim = 
{
	params ["_unit","_mace","_trapDir","_trapPos"];
	private _group = group _unit;
	if ((_unit distance _mace) < 3) then
	{
		private _dirTo = ([_unit, _mace] call BIS_fnc_dirTo);
		if ([ position _unit, _dirTo, 180, position _mace ] call BIS_fnc_inAngleSector) then
		{
			_dirTo = _dirTo +180;
		};
				private _unitDir = getDir _unit;
		{_x enableCollisionWith _mace; _x setUnitPOS "MIDDLE";} forEach units _group;
		_unit setDamage 1;
		_unit setPos getpos _unit;
		_mace setDir (_trapDir);
		[_mace,_unit] call JBOY_impaleOnMace;
		_unit setDir _dirTo;
		_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		_mace setdir _trapDir;
		_mace setVelocityModelSpace [0,5,0]; // keep the dude swinging
		[_unit] call JBOY_unitDropsWeapon;
		sleep .5;
		[_mace, (selectRandom (missionNamespace getVariable "vn_us_death_screams"))] remoteExecCall ["say3D",0,false]; // victim screams
		sleep 1;
		[_mace, (selectRandom (missionNamespace getVariable "vn_us_death_screams"))] remoteExecCall ["say3D",0,false]; // victim screams again
		sleep 1;
		private _sound = "a3\sounds_f\characters\movements\bush_004.wss"; // play sound to mask the ugv motor sound
		playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
		sleep 1.5;
	};
	sleep 30;
};

// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
// ========> Same content as "impaleOnMace.sqf"
JBOY_impaleOnMace =
{
	params ["_mace","_unit"];
	private _dirTo = ([_unit, _mace] call BIS_fnc_dirTo);
	private _unitFacingMace = false;
	if ([ position _unit, _dirTo, 180, position _mace ] call BIS_fnc_inAngleSector) then
	{
		_dirTo = _dirTo +180;
		_unitFacingMace = true;
	};
	private _animOptions = [];
	if (_unitFacingMace) then 
	{
		_animOptions = [1,3,5];  // Good ones: 1,3
	} else
	{
		_animOptions = [1,2,4,5]; // 5 is AWESOME
	};
	_animOptions = _animOptions - (_mace getVariable ["victimAnimsAlreadyUsed",[]]); // When more than one guy impaled on same mace, each get different anim
	private _option = selectRandom _animOptions;
	switch (_option) do
	{  
		case 1: // 
		{ 
			[_unit, "vn_armor_m41_commander_out_kia"] remoteExec ["switchMove"];    
			_unit attachTo [_mace,[0.5,-.5,-0.4]];
			_unit setDir _dirTo;
			_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		};
		case 2: // 
		{ 
			[_unit, "KIA_driver_scooter_01"] remoteExec ["switchMove"];    
			_unit attachTo [_mace,[0.8,-0.1,-0.1]];
			_unit setDir _dirTo;
			_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		};
		case 3: // 
		{ 
			[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
			_unit attachTo [_mace,[0.3,.5,-0.16]]; // positive y value move unit backward
			_unit setDir (_dirTo+180);
			_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		};
		case 4: // 
		{ 
			[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
			_unit attachTo [_mace,[0.1,.2,-0.16]]; // positive y value move unit backward
			_unit setDir (_dirTo+180);
			_unit setVectorUp [-0.0363626,0.198112,0.9995081]; 
		};
		case 5: // THIS ONE AWESOME IF HIT FROM BEHIND!!!
		{ 
			[_unit, "vn_boat_05_gunner_06_kia"] remoteExec ["switchMove"];    
			_unit attachTo [_mace,[0.5,-.5,-0.7]]; // positive y value move unit backward
			_unit setDir (_dirTo+180);
			_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		};
	};
	_victimAnimsAlreadyUsed = _mace getVariable ["victimAnimsAlreadyUsed",[]];
	_victimAnimsAlreadyUsed pushBack _option;
	_mace setVariable ["victimAnimsAlreadyUsed",_victimAnimsAlreadyUsed,true];
};

// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
// ========> Same content as "endMaceSwinging.sqf"
JBOY_endMaceSwinging =
{
	params ["_mace"];
	sleep 60;
	_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
	sleep 10;
	_mace enableSimulation false;
};

// ********************************************************
// UGV drone makes a small noise while moving, so lets mask it with cool creaking noise.
// ********************************************************
// ========> Same content as "controlMaceSwing.sqf"
JBOY_controlMaceSwing =
{
	params ["_mace","_ropeTopObj"];
	private _sound = selectRandom [
		"a3\sounds_f\characters\movements\bush_004.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_1.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_2.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_3.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_4.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_5.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_6.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_7.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_8.wss",
		"a3\sounds_f\environment\sfx\tree_creaking\creacking_9.wss",
		"a3\sounds_f\characters\movements\bush_002.wss"
	]; 
	// *****************************************************************
	// When mace swings down and then up first time, set mass to 300.
	// This will force it to drag on ground once which stabilizes goofy bouncing.
	// *****************************************************************
	waitUntil {_mace distance2D _ropeTopObj < 1};
	waitUntil {_mace distance2D _ropeTopObj > 2};
	_mace setMass 300;
	// *****************************************************************
	// Loop below plays groovy creaking sound on each swing, and will detect
	// when mace hits ground first time, when it will set mace to 270
	// thus allowing mace to lift off of ground and swing some more (hopefully more stable)
	// *****************************************************************
	private _once = true;
	while {simulationEnabled _mace} do
	{
		if (abs(speed _mace) > 1 or abs(velocity _mace #2)> .5) then
		{
			playSound3D [_sound,_mace, false, getPosASL _mace, .7]; // play sound to mask the ugv motor sound 
			private _currentMass = getMass _mace;
			if (getPos _mace #2 < .2 and _once) then
			{
				_mace setMass (270); // // 300 mass will have mace drag on ground once to stabilize it, then here we raise back up with a lesser mass.
				_mace setVelocityModelSpace [0,2,0];
				_once = false;
				sleep .2; 
			}; 
		};
		sleep 2.5;
	};
};

// ********************************************************
// Victim drops weapon (create a physics enabled weapon holder for his currentWeapon)
// ********************************************************
// ========> Same content as "unitDropsWeapon.sqf"
JBOY_unitDropsWeapon =
{
	params ["_unit"];
	private _dropLauncher = false;
	if (!(currentWeapon _unit == "") and !(currentWeapon _unit == secondaryWeapon _unit) and !(secondaryWeapon _unit == "")) then
	{
		_dropLauncher = true;
	};
	if !(currentWeapon _unit == "") then
	{
		private _weaponV = currentWeapon _unit;         
		private _mag = currentMagazine _unit;
		sleep .1;  
		private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0]; 
		_unit removeWeapon (currentWeapon _unit);
		_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
		_weaponHolderV addMagazineCargoGlobal [_mag,1];
		_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
		_weaponHolderV disableCollisionWith _unit;  
		private _dir = random(360);  
		private _speed = 1.5;  
		_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
	};
	if (_dropLauncher) then
	{
		private _weaponV = secondaryWeapon _unit;         
		private _mag = currentMagazine _unit;
		sleep .1;  
		private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0];
		_unit removeWeapon (secondaryWeapon _unit);  
		_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
		_weaponHolderV addMagazineCargoGlobal [_mag,1];
		_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
		_weaponHolderV disableCollisionWith _unit;  
		private _dir = random(360);  
		private _speed = 1.5;  
		_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
	};
};
