// ********************************************************
// Team reacts to impalement (or miss) of a unit.
// ********************************************************
// reactToImpale =
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
			[_leader,"HandSignalPoint",1.5] spawn JBOY_gesture; 
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
			[_dude,"GestureNo",2] spawn JBOY_gesture; 
			[_dude, selectRandom ["NoCanDo_1","NoCanDo_2"]] call JBOY_Speak;
			sleep 1;
			//[_dude, selectRandom["HeIsDown","HeIsDeadE"]] call JBOY_Speak;
			[_dude, "HeIsDeadE"] call JBOY_Speak;
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
		sleep 5;
	};
	// sleep 4;
	// [_dude, selectRandom ["CombatGenericE_4","CombatGenericE_1","CheeringE_2","CheeringE_3","CheeringE_5"]] call JBOY_Speak; // Missed, so relief yells
}; // end if not alive unit
// sleep 1.5;
// [leader _group, selectRandom ["EndangeredE_2"]] call JBOY_Speak; // Son of a bitch
// TEAM WAITS A BIT, THEN RESUMES MOVEMENT
sleep 6;
sleep 2;
//[leader _group, selectRandom ["CoverMeE_2"],.7] call JBOY_Speak; // Ok lets go
[leader _group, selectRandom ["KeepFocused","StayAlert"]] call JBOY_Speak;  
sleep 2;
_unit forceSpeed -1;
{_x forceSpeed -1;} forEach units _group; 
[leader _group, selectRandom ["Clear","AreaClear"]] call JBOY_Speak; // Ok lets go
{ _x setUnitPOS "UP";} forEach units _group;
_group setBehaviour "AWARE";
{_x setUnitPOS "AUTO";} forEach units _group;
sleep 2;
sleep 1;
[leader _group,"vn_handsignal_regroup",1.5] spawn JBOY_gesture; 
[leader _group, selectRandom ["RallyUp","formonme"]] call JBOY_Speak;
//{[_x] call JBOY_speakerUnmute;} forEach units _group;
sleep 2;
[leader _group,"vn_handsignal_move_out",1.5] spawn JBOY_gesture; 
