// ******************************************************************
// Script:  JBOY_punjiMaceTrap.sqf
// Author:  johnnyboy
// Credits: Savage Game Design for the objects and sound files used by this script.
//
// Place a Whip Trap on the map, and put this call in it:
//   [this,'WEST'] spawn {sleep 3; params ["_trap","_triggerActivatedBy"];[_trap,_triggerActivatedBy] spawn JBOY_maceTrapCreate;};
// ******************************************************************
/*
ToDo:
=======
- AddAction to players to create a Mace Trap IF they have a Whip Trap in inventory.
	Place the whip trap and run my script on it.
	Remove action from player if no more Whip Traps in inventory
- AI react by covering all directions?
- Improve AI reaction to victim with anims
	Acts_Taking_Cover_From_Jets_action
	Acts_Watching_Fire_Loop  Hand up high...why why ?
	AinvPknlMstpSnonWnonDnon_healed_1  Kneel with head down mourning
	AinvPknlMstpSnonWnonDnon_healed_2
	evasive moves
	step back fast
- More attached death anims
	- Halo could be fun death anim
	- good kia anim vn_static_zpu4_gunner_kia
- Fire off the trigger via a script
	_triggers = (getPos player) nearObjects ["EmptyDetector", 6]; 
	(_triggers #0) setTriggerArea [10,10, 0, false, 100];


*/
// ********************************************************
// Initialize stuff shared by all placed mace traps.
// ********************************************************
JBOY_maceTrapInit =
{
	if (!isServer) exitWith {};
	if !((missionNamespace getVariable ["vn_us_death_screams",[]]) isEqualTo []) exitWith {};
	// initialize death scream array.  Thank you Savage Game Design!
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
	_topOfRope setObjectTexture [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa']; 
	//TopRope = _topOfRope; 
	_topOfRope setPos (getpos _trapProxy vectorAdd [0,0,11.0]); 
	_topOfRope setDir (_swingDir + 180); 
	
	// ***************************************************************************
	// Create sphere used later to hide mace uav.  And camoflage the sphere.
	// ***************************************************************************
	private _maceStartPos = ([_topOfRope, 8, (_swingDir + 180)] call BIS_fnc_relPos); 
	private _maceSphere = "Sign_Sphere100cm_F" createVehicle [10,10000,0]; 
	_maceSphere setPos [_maceStartPos#0, _maceStartPos#1, 9.0]; 
	_maceSphere setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"]; // makes sphere no longer transparent
	_maceSphere setObjectTexture [0,'vn\characters_f_vietnam\opfor\uniforms\data\vn_o_nva_army_bdu_shirt_03_co.paa']; 
	 
	// ***************************************************************************
	// Create tree to left of trapProxy position. This tree will have the mace trap attached to it.
	// ***************************************************************************
	private _tree = createSimpleObject ["vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d", [0,0,0]]; 
	//tree1 = _tree; 
	_tree setPosatl (_trapProxy modelToWorld [3.8,-4,0]); 
	_tree setDir ((getDir _trapProxy)-120); 
	_tree enableSimulation false;

	// ***************************************************************************
	// Create tree where mace is suspended in air to camouflage it
	// ***************************************************************************
	private _maceStartTreePos = ([_topOfRope, 12, (_swingDir + 180)] call BIS_fnc_relPos); 
	private _tree2 = createSimpleObject ["vn\vn_vegetation_f_enoch\tree\vn_t_fagussylvatica_1fc.p3d", [0,0,0]]; 
	//tree2 = _tree2; 
	_tree2 setPosatl [_maceStartTreePos#0,_maceStartTreePos#1,-6]; 
	_tree2 enableSimulation false;
	//_tree2 setDir (random 360); 

	// ***************************************************************************
	// Create path blocker object to left of tree so AI won't try to go around tree instead of walking thru trap.
	// Otherwise stupid AI walks around spawned tree instead of walking thru trap.
	// ***************************************************************************
	//private _blockers = ["vn\vn_plants_f\bush\vn_b_ficusc1s_f.p3d"];
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
	//ropeTop = _ropeTopObj; 
	_ropeTopObj  attachTo [_topOfRope,[0,0,0]]; 
	_ropeTopObj allowdamage false; 
	_dirTo = ([_maceSphere, _ropeTopObj] call BIS_fnc_dirTo);  
	_ropeTopObj setDir _dirTo; 

	// ***************************************************************************
	// Create the mace vehicle (UAV) B_UAV_01_F C_Kart_01_F B_UGV_02_Science_F
	// ***************************************************************************
	_mace = createVehicle ["B_UGV_02_Science_F", [30,0,0], [], 0, "CAN_COLLIDE"]; //B_UGV_02_Science_F
	_mace setVariable ["victimAnimsAlreadyUsed",[],true]; // used to ensure different impale anim applied to many dudes impaled on same mace
// missionNameSpace setVariable ["JBOY_scaleDownPerFrameRunning",true,false];
// _maceTraps = missionNameSpace getVariable ["JBOY_maceObjects",[]];
// missionNameSpace setVariable ["JBOY_maceObjects",_maceTraps + [_mace],true];
// [] call JBOY_scaleDownMacePerFrame; // keep drone vehicle small so hidden within sphere
	//mace = _mace; 
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

	_rope1 = ropeCreate [_mace, [0,0,-.3],_ropeTopObj, [0,0,-.2]]; //,(_ropeTopObj distance _mace)+ 1]; 
	_trapProxy setVariable ["JBOY_springTrap",false,true];

	_trigger = createTrigger ["EmptyDetector", [100,0,0]];
	_trigger setVariable ["trapObject",_trapProxy,true];
	_trigger setTriggerArea [2.5, 1, 0, false];
	_trigger setTriggerActivation [_triggerActivatedBy, "PRESENT", false];
	_trigger setTriggerStatements ["this and ({!(typeOf _x in ['B_UAV_01_F','B_UGV_02_Science_F'])} count thislist > 0)", '',""];
	// _trigger setTriggerStatements ["this and ({!(typeOf _x isEqualTo 'B_UAV_01_F')} count thislist > 0)", 'hintcadet "wtf";(thisTrigger getVariable "trapObject") setVariable ["JBOY_springTrap",true];',""];
	_trigger setPos getpos _trapProxy;
	//trig1 = _trigger;
	// ***************************************************************************
	// Trap is now ready to be sprung, so spawn a functiont to monitor it
	// ***************************************************************************
	[_trapProxy,_mace,_rope1,_ropeTopObj,_maceSphere,_trigger] spawn JBOY_monitorMaceTrap;
};

// ********************************************************
// Attach sprung whip trap punji object to object.  
// To see the sprung trap stakes you have to animateSource the object first.
// ********************************************************
// [_mace,[0.55,0,0.03],[0.999972,-1.70678e-006,-0.0075168],1.55] call JBOY_attachSprungWhipTrap;
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
	//_punji attachTo [_mace,[0.55,0,0.03]]; _punji setVectorUp [0.999972,-1.70678e-006,-0.0075168];_punji setObjectScale 1.55; 
};

// ************************************************************
// Find punji traps and run my scripts on them.
// Every 10 seconds look for new punji traps and add the FX to them.
// ************************************************************
/* Not using this. 
JBOY_initPunjiTrapsNearPlayer = 
{
	if (!isServer) exitWith {};
	sleep 2;
	while {true} do
	{
		{
			//player globalChat str ["_x",_x, typeOf _x];
			if (typeOf _x == "vn_mine_punji_03_ammo" and _x getVariable ["isMaceTrap",false]) then 
			{
systemchat "found punji3";
				[_x] spawn JBOY_monitorMaceTrap;
			};
		
		} forEach ([player nearobjects ["TimeBombCore", 200],{typeOf _x find "punji_03" >-1}] call BIS_fnc_conditionalSelect);
		sleep 10;
	};
};
 */
// ********************************************************
// Spring the trap when any unit trips it.
// ********************************************************
JBOY_monitorMaceTrap =
{
	params ["_trapProxy","_mace","_rope1","_ropeTopObj","_maceSphere","_trigger"];
	private _trapPos = getPos _trapProxy;
	private _trapDir = getDir _trapProxy;
	
	waitUntil {triggerActivated _trigger or (_trapProxy getVariable ["JBOY_springTrap",false])}; 
	private _unit = nearestObject [_trapPos,'Man'];
	// _sound = "vn\sounds_f_vietnam\traps\punji_activate.ogg";
	// playSound3D [_sound,_trapProxy, false, getPosASL _trapProxy, 1.5];
	playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss",_trapProxy, false, _trapProxy, 4];
	deleteVehicle _trapProxy;
	// *******************************************************
	// Delete cosmetic rope and attach swing rope.  Then detach mace from original position to start the swing
	// *******************************************************
	deleteVehicle _rope1; 
	_mace enableSimulation true;
// _ropeTopObj enableSimulation true; // Do NOT enable simulation on top UAV because that makes it bounce like crazy

	private _rope2 = ropeCreate [_mace, [0,0,.1],_ropeTopObj, [0,0,-.5],_mace distance _ropeTopObj]; 
//rope2 = _rope2;
	detach _mace; 
	_maceSphere attachTo [_mace,[0,0,0]]; 
	//_mace  setSpeaker "NoVoice";
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
	[_unit] spawn JBOY_initialReactionToMace;
	private _group = group _unit;

	// *******************************************************
	// sound FX and accelerate swing when mace lower (waiting so it won't just piledrive into the ground)
	// *******************************************************
	_sound = "a3\sounds_f\characters\movements\bush_004.wss";
	playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
	//playSound3D ["a3\sounds_f\characters\movements\bush_004.wss",_mace]; 
	waitUntil {_mace distance2D _trapPos < 3};
	playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
// _mace setVelocity ([velocity mace #0, velocity mace #1,0]);
// _mace setVelocityModelSpace [0,10,0];
	// *******************************************************
	// Deal with victims of mace
	// *******************************************************
	[_unit,_mace, _trapDir, _trapPos] spawn JBOY_maceVictims;
	sleep 1;
	_group setBehaviour "AWARE";

	// *******************************************************
	// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity...argggh!!!).
	// *******************************************************
	sleep 2;
	sleep 1;
// _mace setVectorUp surfaceNormal getPosWorld mace; 
// _mace setVelocity ([velocity mace #0, velocity mace #1,0]);
//_mace setMass 220; // 170
	private _future = time + 10;
	waitUntil {!alive _unit or _trapPos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};
	if (_trapPos distance _unit > 3 or !(vehicle _unit == _unit)) then 
	{
		if (alive _unit and !isPlayer _unit) then 
		{
			_unit doMove (_unit modelToWorld [0,9,0]); 
			_unit setSpeedMode "FULL"; 
			_unit forcespeed -1;
			// if (stance _unit == "PRONE") then
			// {
				// [_unit, selectRandom ["EvasiveLeft","EvasiveRight"]] remoteExec ["playActionNow"]; 
			// } else
			// {
				[_unit, "FastF"] remoteExec ["playActionNow"];
			// };
			// if !(face _unit find "Asian" >= 0) then  // Say an english phrase
			// {
				[_unit, selectRandom ["KeepFocused","StayAlert"]] call JBOY_Speak;  
			//};
			sleep 2;
			_unit setUnitPOS "UP"; 
			sleep 2; 
			group _unit setBehaviour "AWARE";
			_unit setUnitPOS "AUTO";
		};
	};
	[_mace] spawn JBOY_endMaceSwinging;
};

// ********************************************************
// Team reacts to mace
// ********************************************************
JBOY_initialReactionToMace =
{
	params ["_unit"];
	private _group = group _unit;
	if (count (units _group select {alive _x}) == 0) exitWith {};
	//{[_x] call JBOY_speakerMute;} forEach units _group;
	private _dude = objNull;
	
	// SHOUT WARNING
	if (count units _group > 1) then 
	{
		_dude = (units _group #1);
		private _nameWasSaid = [_dude,_unit] call JBOY_sayNameOfUnit; // Shouts name of point man who triggered trap
		sleep .5;
		[_dude, selectRandom ["GoProne_1","GoProne_2","Danger","takecover"],2.5] call JBOY_Speak; 
	};
	
	// SOMETIMES UNIT THAT TRIGGERED TRAP WILL ATTEMPT TO DUCK
	// if (selectRandom [true,false,false,false] and !isPlayer _unit) then 
	// {
		// [_unit, "Down"] remoteExec ["playActionNow"];
		// [_unit, "Down"] remoteExec ["playActionNow"];
	// };
	
	// UNITS IN GROUP REACT BY GETTING LOW
	{  
		if (!isPlayer _x //and !(_x isEqualTo _unit)
		) then 
		{
			[_x, "Down"] remoteExec ["playActionNow"];sleep.3;[_x, "Down"] remoteExec ["playActionNow"];
			_x setUnitPOS "DOWN";
			_x doWatch _unit;
		};
	} forEach units _group;
	sleep 1;
	//_unit forceSpeed 0;
	
	// SOME PANIC SHOUTS
	if (count units _group > 1) then 
	{
		if ((speaker _dude find 'eng' >= 0)) then 
		{
			private _sounds = ["vn_sam_uscomba_004", // Get your ass Down!
								"vn_sam_uscomba_010"]; // get down get down!
			[units _group #0, (selectRandom _sounds)] remoteExecCall ["say3D",0,false];
		};
	};
	sleep 2;
	if (count (units _group select {alive _x}) == 0) exitWith {};
	
	// DEFINE SOME CONTEXT SPECIFIC SOUND FILES
	private _leader = units _group #0;
	_shortPlaySounds = ["a3\dubbing_f_epa\a_in2\24_mine\a_in2_24_mine_ico_0.ogg", //  Fuck!
		"a3\dubbing_f_epa\a_m01\45_survivor_dead\a_m01_45_survivor_dead_med_0.ogg", // fuck
		"a3\dubbing_f_epa\a_m02\115_take_cover\a_m02_115_take_cover_bra_0.ogg", // Take cover
		"a3\dubbing_f_epa\a_in2\25_mine\a_in2_25_mine_ker_0.ogg", //  Fuck!
		"a3\dubbing_f_epa\a_in2\25_mine\a_in2_25_mine_ker_2.ogg"]; // Jesuus!
	_saySounds = ["vn_sam_uscomba_007","vn_sam_uscomba_008","vn_sam_uscomba_008","vn_sam_uscomba_008"];  // Fuck!, Shit!
	
	// IF GROUP BIG ENOUGH MORE PANIC SHOUTING AND LEADER CALMS THEM DOWN
	_unitsMinusLeader = (units _group) - [_leader];
	if (speaker _leader find 'eng' >= 0) then 
	{
		if (count (units _group select {alive _x}) > 1) then 
		{
			// Team members reacting
			_dude = selectRandom _unitsMinusLeader;
			[_dude, selectRandom ["EndangeredE_2"],1] call JBOY_Speak; // son of a bitch
			sleep 1.5;
			_dude = selectRandom _unitsMinusLeader;
			if (selectRandom [true,false]) then
			{
				// [_dude, (selectRandom _saySounds)] remoteExecCall ["say3D",0,false];
				// sleep .5;
				playSound3D [selectRandom _shortPlaySounds,_dude, false, _dude, 2.5];
				sleep .5;
			// } else
			// {
				// playSound3D [selectRandom _playSounds,_dude, false, getPosASL _dude, 2.5];
				// sleep 4.5;
			};
			// Leader restores order
			sleep 1;
			_leader = units _group #0; // refresh leader in case he's dead
			[_leader, selectRandom ["Silence","DownAndQuiet"],1] call JBOY_Speak;
			// sleep 1.5;
			// [_leader, selectRandom ["scanhorizon","KeepFocused"]] call JBOY_Speak;
			
		} ;
	};
};

// *********************************************************************
// 
// *********************************************************************
/* JBOY_addMaceKilledEH =
{
	params["_unit"];
	_unit addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if () then
		{
			[_unit,_mace, _trapDir, _trapPos] spawn JBOY_maceVictim;
		};
	}];
};
 */
// *********************************************************************
// Find units near unit that triggered mace as a list of potential victims.
// Then call function to make them a victim if they are hit by the mace.
// *********************************************************************
JBOY_maceVictims = 
{
	params ["_unit","_mace","_trapDir","_trapPos"];
	_mace setVariable ["_triggerUnit",_unit,true];
	_victims = (_unit nearEntities ["Man", 20]) select {_x isKindOf "Man"}; // nearEntities 'Man' includes UGV, so we exclude those with isKindOf
//systemChat str ["JBOY_maceVictims",_this,_victims];
	{
		[_x,_mace, _trapDir, _trapPos] spawn JBOY_maceVictim;
	} forEach _victims;
};
// ********************************************************
// Attachd victim to mace and play various fx (sound, blood, etc.)
// ********************************************************
JBOY_maceVictim = 
{
	params ["_unit","_mace","_trapDir","_trapPos"];
//systemChat str ["JBOY_maceVictim",_this];
	private _group = group _unit;
	if ((_unit distance _mace) < 3) then
	{
		[_unit,"a3\Sounds_f_orange\missionsfx\pumpkin_destroy_0",["1","2","3"],".wss",2] spawn JBOY_playRandomSfx; // squishy sound fx
		//[_unit] call JBOY_dustFxMace;
		private _dirTo = ([_unit, _mace] call BIS_fnc_dirTo);
		if ([ position _unit, _dirTo, 180, position _mace ] call BIS_fnc_inAngleSector) then
		{
			_dirTo = _dirTo +180;
		};
				private _unitDir = getDir _unit;
		_group setBehaviour "COMBAT";
		{_x forceSpeed 0;} forEach units _group;  // Stop the group so they react
		{_x enableCollisionWith _mace; _x setUnitPOS "MIDDLE";} forEach units _group;
		_unit setDamage 1;
		_unit setPos getpos _unit;
		_mace setDir (_trapDir);
		[_mace,_unit] call JBOY_impaleOnMace;
		//_unit attachTo [_mace,[0.5,-.5,-0.4]];
		_unit setDir _dirTo;
		_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
		_mace setdir _trapDir;
		_mace setVelocityModelSpace [0,5,0]; // keep the dude swinging
		[_unit] call JBOY_bloodCloud;
		[_unit] call JBOY_unitDropsWeapon;
		[_unit,_trapDir,_trapPos] spawn JBOY_makeBloodUnderMace;
		sleep .5;
		//_mace say3D (selectRandom (missionNamespace getVariable "vn_us_death_screams")); // victim screams
		[_mace, (selectRandom (missionNamespace getVariable "vn_us_death_screams"))] remoteExecCall ["say3D",0,false]; // victim screams
		sleep 1;
//_mace setMass 220; //186.5; // Make mace hang at correct level above ground, and reduce bouncing
		//_mace say3D (selectRandom (missionNamespace getVariable "vn_us_death_screams")); // victim screams again
		[_mace, (selectRandom (missionNamespace getVariable "vn_us_death_screams"))] remoteExecCall ["say3D",0,false]; // victim screams again
		sleep 1;
		private _sound = "a3\sounds_f\characters\movements\bush_004.wss"; // play sound to mask the ugv motor sound
		playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
		sleep 1.5;
		[_mace] call JBOY_PainSfx;
	};
	sleep 7;
	// ********************************************************
	// Ensure group reaction to impalement runs for first victim, not for each victim
	// ********************************************************
	if (_unit isEqualTo (_mace getVariable "_triggerUnit")) then
	{
		[_group,_unit] call JBOY_reactToImpale;
	};
	// ********************************************************
	// Allow units to move on if not handled by the reaction function
	// ********************************************************
	sleep 30;
	{ _x setUnitPOS "UP";} forEach units _group;
	_group setBehaviour "AWARE";
	{_x setUnitPOS "AUTO"; _x forceSpeed -1;} forEach units _group;

};

// ********************************************************
// Team reacts to impalement (or miss) of a unit.
// ********************************************************
JBOY_reactToImpale =
{
	params ["_group","_unit"];
	if (count (units _group select {alive _x}) == 0) exitWith {};
	private _dude = objNull;
	private _leader = leader _group;
	_unitsMinusLeader = (units _group) - [_leader];
	if (!alive _unit) then 
	{
		if (speaker _leader find 'eng' >= 0) then 
		{
			// IF TEAM BIG ENOUGH, LEADER ORDERS TO HEAL, AND MEDIC SAYS NOCANDO HES DEAD
			if (count (units _group select {alive _x}) > 1) then 
			{
				if (selectRandom [true,false]) then
				{
					[_leader, selectRandom ["HealThatSoldier","HelpThatSoldier"]] call JBOY_Speak;
					sleep 2;
				} else
				{
					private _playSounds = ["a3\dubbing_f_epa\a_m02\20_point_man_dead\a_m02_20_point_man_dead_alp_1.ogg", //  doc check on him, rest of you covering fire
						"a3\dubbing_f_epa\a_m01\20_survivor\a_m01_20_survivor_alp_1.ogg" //Doc take care of him, we'll take up defensive positions
						];
					playSound3D [selectRandom _playSounds,_leader, false, _leader, 3.5];
					sleep 4;
				};
				_dude = selectRandom _unitsMinusLeader;
				[_dude, selectRandom ["NoCanDo_1","NoCanDo_2"]] call JBOY_Speak;
				sleep 1;
				[_dude, selectRandom["HeIsDown","HeIsDeadE"]] call JBOY_Speak;
			} ;
		} else
		{
			// IF ONLY ONE UNIT LEFT HE JUST SAYS HES DEAD
			[leader _group, selectRandom ["HeIsDeadE"]] call JBOY_Speak;
		};
	} else
	{
		// IF TEAM BIG ENOUGH, A DUDE SAYS SOMETHING CONTEXT SENSITIVE ABOUT TRAP NEAR MISS
		if (count _unitsMinusLeader > 0) then
		{
			_dude = selectRandom _unitsMinusLeader;
			_saySounds = ["vn_sam_uscarel_006", // Watch out, you fuckin cherry, you want to get yourself killed!
				"vn_sam_ussteal_001", // Keep off the trails
				"vn_sam_ussteal_014", // dont touch nuthin, vc booby trap everything
				"vn_sam_ussteal_002", // Hey, watch where you're walkin
				"vn_sam_ussteal_005", // keep an eye out for trip lines and punji pits
				"vn_sam_ussteal_006", // watch for vc markers, usually point to a trap or something
							"vn_sam_uscarel_001" // I can't take another year in this hellhole
						];
			_playSounds = [
				"a3\dubbing_f_epa\a_in\145_fubar\a_in_145_fubar_ker_0.ogg", // What the literal fuck, are you kidding me
				"a3\dubbing_f_epa\a_in\150_safer\a_in_150_safer_ker_0.ogg",  // What was that you said about it being safer on foot?
				"a3\dubbing_f_epa\a_in\175_bad_sign\a_in_175_bad_sign_ker_0.ogg" // thats not exactly a good sign
				];
			if (selectRandom [true,false]) then
			{
				[_dude, (selectRandom _saySounds)] remoteExecCall ["say3D",0,false];
			} else 
			{
				playSound3D [selectRandom _playSounds,_dude, false, _dude, 1];
			};
		};
		// sleep 4;
		// [_dude, selectRandom ["CombatGenericE_4","CombatGenericE_1","CheeringE_2","CheeringE_3","CheeringE_5"]] call JBOY_Speak; // Missed, so relief yells
	}; // end if not alive unit
	// sleep 1.5;
	// [leader _group, selectRandom ["EndangeredE_2"]] call JBOY_Speak; // Son of a bitch
	// TEAM WAITS A BIT, THEN RESUMES MOVEMENT
	sleep 4;
	{ _x setUnitPOS "UP";} forEach units _group;
	_group setBehaviour "AWARE";
	{_x setUnitPOS "AUTO";} forEach units _group;
	sleep 2;
	//[leader _group, selectRandom ["CoverMeE_2"],.7] call JBOY_Speak; // Ok lets go
	[leader _group, selectRandom ["KeepFocused","StayAlert"]] call JBOY_Speak;  
	sleep 2;
	_unit forceSpeed -1;
	{_x forceSpeed -1;} forEach units _group; 
	[leader _group, selectRandom ["Clear","AreaClear"]] call JBOY_Speak; // Ok lets go
	sleep 2;
	sleep 1;
	[leader _group, selectRandom ["RallyUp","formonme"]] call JBOY_Speak;
	//{[_x] call JBOY_speakerUnmute;} forEach units _group;
};

// ********************************************************
// If unit is named, say the name.  Else call him out as officer
// medic, one-zero, one-one, or one-two.  If none of those apply, do nothing
// ********************************************************
JBOY_sayNameOfUnit =
{
	params ["_unit","_deadUnit"];
	//sleep 1;
	if !(nameSound _deadUnit == "") exitWith
	{
//systemChat str ["found nameSound",_unit,_deadUnit,toLower(nameSound _deadUnit)];
		[_unit, toLower(nameSound _deadUnit),2.5] call JBOY_Speak;
		sleep .7;
		true
	};
	// Parse type of unit from description
/*	private _description = getDescription _deadUnit#2;
	if (_description find "One-Zero" >= 0) exitWith
	{
//systemChat str ["found one zero",_unit,_description];
		[_unit, "one",2] call JBOY_Speak;
		sleep .7;
		[_unit, "zero",2] call JBOY_Speak;
		sleep .7;
		true
	};
	if (_description find "One-One" >= 0) exitWith
	{
		[_unit, "one",2] call JBOY_Speak;
		sleep .7;
		[_unit, "one",2] call JBOY_Speak;
		sleep .7;
		true
	};
	if (_description find "One-One" >= 0) exitWith
	{
		[_unit, "one",2] call JBOY_Speak;
		sleep .7;
		[_unit, "two",2] call JBOY_Speak;
		sleep .7;
		true
	};
 	if (_description find "medic" >= 0) exitWith
	{
		[_unit, "veh_infantry_medic_s"] call JBOY_Speak;
		sleep 1;
		true
	};
	if (_description find "officer" >= 0) exitWith
	{
		[_unit, "veh_infantry_officer_s"] call JBOY_Speak;
		sleep 1;
		true
	};
	if (_description find "pilot" >= 0) exitWith
	{
		[_unit, "veh_infantry_pilot_s"] call JBOY_Speak;
		sleep 1;
		true
	};
 */	false
};

// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
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
//systemChat "UNIT FACING MACE";
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
//player groupchat str ["victimAnimsAlreadyUsed",(_mace getVariable "victimAnimsAlreadyUsed"), _victimAnimsAlreadyUsed, _option];
};

// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
JBOY_endMaceSwinging =
{
	params ["_mace"];
	//_mace setMass 186.5; // Make mace hang at correct level above ground, and reduce bouncing
	sleep 60;
	_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
	sleep 10;
	_mace enableSimulation false;
};

// ********************************************************
// UGV drone makes a small noise while moving, so lets mask it with cool creaking noise.
// ********************************************************
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
	//private _maxMass = 220;
	private _once = true;
	while {simulationEnabled _mace} do
	{
		if (abs(speed _mace) > 1) then
		{
			playSound3D [_sound,_mace, false, getPosASL _mace, .7]; // play sound to mask the ugv motor sound 
			private _currentMass = getMass _mace;
			// if (_maxMass > _currentMass) then {_mace setMass (_currentMass +3);}; // failed attempt to stabilize mace
			if (getPos _mace #2 < .2 and _once) then 
			{
				_mace setMass (270); // // 300 mass will have mace drag on ground once to stabilize it, then here we raise back up with a lesser mass.
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
		//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
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
		//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
		_unit removeWeapon (secondaryWeapon _unit);  
		_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
		_weaponHolderV addMagazineCargoGlobal [_mag,1];
		_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
		_weaponHolderV disableCollisionWith _unit;  
		private _dir = random(360);  
		private _speed = 1.5;  
		_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
	};
/* 	if !(headGear _unit == "") then
	{
		private _headGear = headGear _unit;         
		sleep .1;  
		private _weaponHolderB = "WeaponHolderSimulated" createVehicle [0,0,0]; 
		//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
		removeHeadgear _unit;  
		_weaponHolderB addItemCargoGlobal [_headGear,1];
		_weaponHolderB setPos (_unit modelToWorld [0,.2,1.2]);  
		_weaponHolderB disableCollisionWith _unit;  
		private _dir = random(360);  
		private _speed = 1.5;  
		_weaponHolderB setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
		_weaponHolderB addTorque [random 0.02, random 0.02, random 0.02];
	};
	if !(goggles _unit == "") then
	{
		private _goggles = goggles _unit;         
		sleep .1;  
		private _weaponHolderC = "WeaponHolderSimulated" createVehicle [0,0,0]; 
		//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
		removeGoggles _unit;  
		_weaponHolderC addItemCargoGlobal [_goggles,1];
		_weaponHolderC setPos (_unit modelToWorld [0,.2,1.2]);  
		_weaponHolderC disableCollisionWith _unit;  
		private _dir = random(360);  
		private _speed = 1.5;  
		_weaponHolderC setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
		_weaponHolderC addTorque [random 0.02, random 0.02, random 0.02];
	}; */
};

// ********************************************************
// Add some blood under swinging mace with victim
// ********************************************************
JBOY_makeBloodUnderMace =
{
	params ["_unit","_dir","_trapPos"];
	private _pos = asltoAGL eyePos _unit;
	private _blood = createSimpleObject [selectRandom ["BloodSplatter_01_Large_New_F","BloodSplatter_01_Medium_New_F","BloodPool_01_Medium_New_F","BloodPool_01_Large_New_F"], [0,0,0]]; 
	_blood setdir random 360;
	_blood setVectorUp (surfaceNormal _pos);
	_blood setPos _trapPos;
	//sleep .5;
	_pos = getPos _unit;
	_pos = [_pos #0,_pos #1,0];
	_blood = createSimpleObject [selectRandom ["BloodTrail_01_New_F","BloodTrail_01_New_F"], [0,0,0]]; 
	// _blood = createSimpleObject [selectRandom ["BloodSplatter_01_Large_New_F","BloodSplatter_01_Medium_New_F","BloodPool_01_Medium_New_F","BloodPool_01_Large_New_F","BloodTrail_01_New_F","BloodTrail_01_New_F","BloodSpray_01_New_F"], [0,0,0]]; 
	_blood setDir _dir;
	_blood setVectorUp (surfaceNormal _pos);
	_blood setPos _pos;

};

// ********************************************************
// Make small blood cloud when victim first hit.  Helps obscure 
// animation change when attached to mace.
// ********************************************************
JBOY_bloodCloud =
{
	params ["_unit"]; 
	drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,0.5,[0,0,0],[0,0,0],
		2, // rotationVelocity
		3,//10,// weight
		2,//7.9,// volume
		0,// rubbing
		[0.1,2], //[0.5,5], // size
		[[1,0,0,1],[1,0,0,1]],[1],1,0,"","",_unit];
	drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,1,[0,0,1],[0,0,0],2,10,7.9,0,[0.5,5],[[1,0,0.1,1],[1,0,0,0]],[1],1,0,"","",_unit];
	drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,0.5,[0,0,1.5],[0,0,0],2,10,7.9,0,[0.5,5],[[1,0,0,1],[1,0,0,1]],[1],1,0,"","",_unit];
};

// ********************************************************
// play sound fx from a collection of similar named sounds.
// ********************************************************
JBOY_playRandomSfx =
{
	params ["_unit","_path","_suffixArray","_ext",["_volume",1],["_lip",false]];

	//if (_lip) then {[_unit, 1] call JBOY_Lip;};
	private _sound = _path + selectRandom _suffixArray + _ext;
	private _pitch = 1;
	if (_unit isKindOf "Man") then {_pitch = pitch _unit;};
	playSound3D [_sound,_unit, false, getPosASL _unit, _volume, _pitch, 0];
};

// ********************************************************
// Dust FX fro when mace impacts unit or ground.
// ********************************************************
// Not using
/*
JBOY_dustFxMace =
{ 
	_unit = _this select 0; 
	_pos = _unit modelToWorld [0,1.5,0]; 
	_xpos = _pos select 0; 
	_ypos = _pos select 1; 
	_zpos = _pos select 2; 
//	sleep 0.3; 
	for "_i" from 0 to 2 do  // was 3 times
	{ 
		_xvel = 0;_yvel = 0;_zvel = 0;_tnt = 0; 
		// \A3\Plants_F\_Leafs\leaf_damage_small_green.p3d
		//drop[["A3\Data_F\ParticleEffects\Universal\universal.p3d",16,7,48],"","Billboard",0,
		drop[["\A3\Plants_F\_Leafs\leaf_damage_small_green.p3d",1,0,1],"","SpaceObject",0,
//		1 + random 0.5, // lifetime
		.2 + random 0.5, // lifetime
		[_xpos,_ypos,_zpos],  
		[_xvel,_yvel,_zvel],1,1.2,1.3,0,
//		[2], // size
		[3], // size
		[[0.55,0.5,0.45,0],[_tnt + 0.55,_tnt + 0.5,_tnt + 0.45,0.16], 
		[_tnt + 0.55,_tnt + 0.5,_tnt + 0.45, 0.12],[_tnt + 0.5,_tnt + 0.45,_tnt + 0.4,0.08], 
		[_tnt + 0.45,_tnt + 0.4,_tnt + 0.35,0.04],[_tnt + 0.4,_tnt + 0.35,_tnt + 0.3,0.01]],[0],0.1,0.1,"","",""]; 
	}; 
};
*/
// ***************************************************************
// Not using this to hide mace vehicle because causes flickering
// ***************************************************************
/* JBOY_scaleDownMacePerFrame =
{
	params ["_unit"]; 
	if !(missionNameSpace getVariable ["JBOY_scaleDownPerFrameRunning",false]) then 
	{
		missionNameSpace setVariable ["JBOY_scaleDownPerFrameRunning",true,true];
		addMissionEventHandler ["EachFrame", { {_x setObjectScale .5;} foreach (missionNameSpace getVariable "JBOY_maceObjects"); }];
	};
}; */