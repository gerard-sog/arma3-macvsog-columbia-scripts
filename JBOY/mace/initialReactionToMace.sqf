// ********************************************************
// Team reacts to mace
// ********************************************************
// initialReactionToMace =

params ["_unit","_mace"];
private _group = group _unit;
if (count (units _group select {alive _x}) == 0) exitWith {};
//{[_x] call JBOY_speakerMute;} forEach units _group;
private _dude = objNull;

// SHOUT WARNING
if (count units _group > 1) then 
{
	_dude = (units _group #1);
	private _nameWasSaid = [_dude,_unit] call JBOY_sayNameOfUnit; // Shouts name of point man who triggered trap
	[_dude,"vn_handsignal_down",1.5] spawn JBOY_gesture; 

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
	if (!isPlayer _x) then
	{	
		if (_mace distance _x < 6.5) then //and !(_x isEqualTo _unit)
		{
			[_x, "Down"] remoteExec ["playActionNow"];sleep.3;[_x, "Down"] remoteExec ["playActionNow"];
			_x setUnitPOS "DOWN";
			_x doWatch _unit;
		} else
		{
			[_x, "Down"] remoteExec ["playActionNow"];
			_x setUnitPOS "MIDDLE";
			_x doWatch _unit;
		};
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
		[units _group #0,"vn_handsignal_move_out",1.5] spawn JBOY_gesture; 
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

