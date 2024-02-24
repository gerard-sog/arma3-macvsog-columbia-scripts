//JBOY_StackSpeak.sqf
// [player, "Halt"] call JBOY_StackSpeak;
if (!isServer)  exitwith {};
params["_unit","_soundFileName",["_volume",1]];
if (isNull _unit or !alive _unit) exitWith {};
// If only one guy in stack, then don't say anything.  Except swearing/grunting when hit by a nade.
if (!(_unit getVariable ["JBOY_chatterOn",true]) and _soundfileName find "Endangered" < 0 and _soundfileName != "Grunt") exitWith {};
if (_soundFileName == "Breathe") exitWith
{
	[_unit,_volume] call JBOY_BreatheSfx;  // Randomly play 1 of many breathing sfx
};
if (_soundFileName == "Pain") exitWith
{
	[_unit,_volume] call JBOY_PainSfx;  // Randomly play 1 of many pain/moan/groan sfx
};

if (_soundFileName == "Grunt") then
{
	[_unit,_volume] call JBOY_PainGrunt;  // Randomly play 1 of a 100 pain grunts, and exit this script
} else
{
	_speaker = "";
	if (isNull _unit) exitwith {};
	_speaker = speaker _unit;
	//if (isNil _speaker) exitWith{};
	_behaviour = behaviour _unit;
	if (["CARELESS","AWARE"] find _behaviour >= 0) then {_behaviour = "NORMAL";}; // No sound file path exists for "CARELESS","AWARE"
	//_behaviour = "STEALTH";
	_s = format["JBOY_Speak: No match found for _soundFileName %1",_soundFileName];

	_lastSubDir = "100_Commands"; // most stack related commands are in this subdirectory
	switch (true) do 
	{	
		case (_soundFileName find "EnemyDetected" >= 0):{_lastSubDir = "150_reporting"; }; //Contacte_1 is contact, 2 Hostiles, 3 Enemy!
		case (_soundFileName find "Sitrep" >= 0):{_lastSubDir = "120_Com_Ask"; };
		case (_soundFileName find "Confirmation" >= 0):{_lastSubDir = "130_Com_Reply"; }; // Confirmation2_4,5,6 understood. Confirmation2_1,2,3 roger, Confirmation`_* all Copy-whatever
		case (_soundFileName find "OnTheWay_1" >= 0):{_lastSubDir = "130_Com_Reply"; };
		case (_soundFileName find "CantGetThere" >= 0):{_lastSubDir = "130_Com_Reply"; };
		case (_soundFileName find "NoCanDo" >= 0):{_lastSubDir = "130_Com_Reply"; }; // NoCanDo_1, 2 (2 is No Sir.
		case (_soundFileName find "Negative" >= 0):{_lastSubDir = "130_Com_Reply"; }; // Negative_1, 2,3
		case (_soundFileName find "Attacking" >= 0):{_lastSubDir = "130_Com_Reply"; _behaviour = "COMBAT";}; // Negative_1, 2,3
		case (_soundFileName find "Suppressing" >= 0):{_lastSubDir = "130_Com_Reply"; _behaviour = "COMBAT";}; // Negative_1, 2,3
		case (_soundFileName find "Engage" >= 0):{_lastSubDir = "015_Targeting"; };
		case (_soundFileName find "Attack_" >= 0):{_lastSubDir = "015_Targeting"; };
		case (_soundFileName find "CancelTarget" >= 0):{_lastSubDir = "015_Targeting"; };
		case (_soundFileName find "moveUp" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
		case (_soundFileName find "moveLeft" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
		case (_soundFileName find "moveRight" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
		case (_soundFileName find "moveBack" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
		case (_soundFileName find "mgun" >= 0):{_lastSubDir = "005_Weapons"; _behaviour = "Normal";}; // mgun, heat, sabot, cannon
		case (_soundFileName find "veh" >= 0):{_lastSubDir = "010_Vehicles"; };
		case (_soundFileName find "at" >= 0 and !(_soundFileName find "at" >= 0)):{_lastSubDir = "DirectionRelative2"; }; // at12_1 is "12 O'Clock"
		case (_soundFileName find "Team" >= 0):{_lastSubDir = "030_Teams"; }; // redTeam, blueTeam, greenTeam, yellowTeam, whiteTeam
		case (_soundFileName find "TakingCommand" >= 0):{_lastSubDir = "110_Com_Announce"; _behaviour = "Normal";};
		case (_soundFileName find "AwaitingOrders" >= 0):{_lastSubDir = "110_Com_Announce"; _behaviour = "Normal";};
		case (_soundFileName find "ReadyForOrders" >= 0):{_lastSubDir = "110_Com_Announce"; _behaviour = "Normal";};
		case (_soundFileName find "HeIsDown" >= 0):{_lastSubDir = "110_Com_Announce"; _behaviour = "Normal";};
		case (_soundFileName find "Health" >= 0):{_lastSubDir = "140_Com_Status"; _behaviour = "Normal";};
		case (_soundFileName find "HeIs" >= 0):{_lastSubDir = "140_Com_Status"; _behaviour = "Normal";};
		case (_soundFileName find "CriticalDamage" >= 0):{_lastSubDir = "140_Com_Status"; _behaviour = "Normal";};
		case (_soundFileName find "CombatGeneric" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "UnderFire" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Witness" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Throwing" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "IncomingGren" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Reloading" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Suppressing" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Contacte" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Screaming" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Cheering" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";};
		case (_soundFileName find "Endangered" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";}; 		
		case (_soundFileName find "Cover" >= 0):{_lastSubDir = "200_CombatShouts"; _behaviour = "COMBAT";}; //EndangeredE_1
		case (_soundFileName find "SetCharge" >= 0):{ _behaviour = "Stealth";};
		case (_soundFileName find "DetonateCharge" >= 0):{ _behaviour = "Stealth";};
		case (_soundFileName find "ThrowingGrenadeE_1" >= 0):{ _behaviour = "Stealth";}; // Fire in the hole!
		case (_soundFileName find "OpenThatDoor" >= 0):{ _behaviour = "Stealth";}; //
		case (_soundFileName find "dist" >= 0):{_lastSubDir = "DistanceAbsolute1"; _behaviour = "COMBAT";};
		case (_soundFileName find "reportBack_2" >= 0):{_lastSubDir = "DirectionRelative3";}; //  reportBack_2 is to the rear!
		case (_soundFileName find "veh_air_plane_s" >= 0):{_lastSubDir = "010_Vehicles";}; //  fast mover
		case (_soundFileName find "veh_infantry_s_2" >= 0):{_lastSubDir = "010_Vehicles";}; //  man
		case (_soundFileName find "veh_infantry_diver_s" >= 0):{_lastSubDir = "010_Vehicles";}; //  diver
		case (_soundFileName find "loc_" >= 0):{_lastSubDir = "090_MoveLocations";}; //  loc_forest
		case (_soundFileName in [
			"adams",
			"amin",
			"anthis",
			"armstrong",
			"bennett",
			"campbell",
			"costa",
			"dimitirou",
			"dixon",
			"elias",
			"everett",
			"fahim",
			"fox",  //
			"franklin",
			"frost",
			"gekas",
			"ghost",  //
			"givens",
			"habibi",
			"hardy",
			"hawkins",
			"jackson",
			"james",
			"jawadi",
			"jester", //
			"kerry",
			"korneedler",
			"kouris",
			"kushan",
			"lacey",
			"larkin",
			"leventis",
			"levine",
			"lopez",
			"markos",
			"martinez",
			"masood",
			"mckay",
			"mckendrick",
			"miller",
			"nazari",
			"nichols",
			"nicolo",
			"nikas",
			"nomad",
			"northgate",
			"oconnor",
			"panas",
			"patterson",
			"petros",
			"razer",  //
			"reynolds",
			"rosi",
			"ryan",
			"samaras",
			"siddiqi",
			"snake",  //
			"stavrou",
			"stranger",  //
			"sykes",
			"takhtar",
			"tanny",
			"taylor",
			"thanos",
			"vega",
			"viper",
			"walker",
			"wardak", //
			"yousuf"]):
		{_lastSubDir = "020_names";  };	
		case (_soundFileName in [
			"alpha",
			"bravo",
			"charlie",
			"delta",
			"echo",
			"foxtrot",
			"golf",
			"hotel",
			"india",
			"juliet",
			"kilo",
			"lima",
			"mike",
			"november",
			"oscar",
			"papa",
			"quebec",
			"romeo",
			"sierra",
			"tango",
			"uniform",
			"victor",
			"whiskey",
			"xray",
			"yankee",
			"zulu"]):
		{_lastSubDir = "080_movealphabet";  };	
		case (_soundFileName in [
			"zero",
			"one",
			"two",
			"three",
			"four",
			"five",
			"six",
			"seven",
			"eight",
			"nine",
			"ten",
			"eleven",
			"twelve",
			"thirteen",
			"fourteen",
			"fifteen",
			"sixteen",
			"seventeen",
			"eighteen",
			"nineteen",
			"twenty",
			"thirty",
			"forty",
			"fifty",
			"sixty",
			"seventy",
			"eighty",
			"ninety",
			"hundred"
			]):
		{_lastSubDir = "025_numbers";  };	
		case (_soundFileName in [
			"HealthInjured","HealthSomebodyHelpMe","HealthNeedHelp","HealthWounded","HealthMedic",
			"CriticalDamage_1","HealthINeedHelpNow","HealthIAmBadlyHurt","HealthNeedMedicNow","HealthIAmWounded","HeIsHitE","CriticalDamage_2",
			"AmmoCritical_3","ManDownE_1","WeLostOneE_1","HeIsDeadE"
			]):
		{_lastSubDir = "140_Com_Status";  };	
/* 100_Commands are the default, so don't need to spell them all out
 		case (_soundFileName in [
			"PrepareForContact","GetReadyToFight","LockAndLoad","KeepFocused","StayAlert", "WatchThatTarget"
			{_lastSubDir = "100_Commands";  };	
 */		case (_soundFileName in [
			"Clear","AreaClear","IAmTheNewActual","ReadyToFire","TargetInSight", "TargetAcquired",
			"EyesOnTarget","StandingBy","ScratchOne","HeIsDown","IVeGotHim","HostileDown","IAmReady","ReadyForOrders",
			"AwaitingOrders","TakingCommand","Waiting","Ready"
			,"TargetIsDown"
			]):
			{_lastSubDir = "110_Com_Announce";  };	
		case (_soundFileName in [
			"heat","sabot","cannon","cannonLow","cannonHigh", // all 3 cannons are just "cannon"
			"RocketsPairs","RocketsSalvo", // both of these are just "rockets"
			"Bombs",
			"Flares","missiles", // missles not working
			"mgun"
			]):
			{_lastSubDir = "005_Weapons";  };	
//"A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\DistanceAbsolute1\dist400_2.ogg" 400 meters

		// case (_soundFileName find "HealThatSoldier" >= 0):{ _lastSubDir = "100_commands";_behaviour = "COMBAT";}; // 
		// case (_soundFileName find "HelpThatSoldier" >= 0):{ _behaviour = "COMBAT";}; // 
		//case (_soundFileName find "SetCharge" >= 0):{_lastSubDir = "015_Targeting"; };
//playsound3d ["A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\005_Weapons\mgun.ogg",player];  
//playsound3d ["A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\010_Vehicles\veh_infantry_MG_s.ogg",player];   
// playsound3d ["A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Combat\DirectionRelative2\at12_1.ogg",player];  
	};
	
	switch (alive _unit) do 
	{ 	
		// hardcoded sounds for certain languages and sounds
		case (_speaker find "eng" >= 0 and _soundFileName == 'Clear'): {_s = "a3\dubbing_f_bootcamp\boot_m04\85_All_Clear\boot_m04_85_all_clear_LAC_0.ogg";};
		// sounds per language
		case (_speaker find "pervr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolPER\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "grevr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolGRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "engvr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "engb" >= 0): {_s = "A3\Dubbing_Radio_F\data\ENGB\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "engfre" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\ENGFRE\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "eng" >= 0): {_s = "A3\Dubbing_Radio_F\data\ENG\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "gre" >= 0): {_s = "A3\Dubbing_Radio_F\data\GRE\"+_speaker+"\RadioProtocolGRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "per" >= 0): {_s = "A3\Dubbing_Radio_F\data\PER\"+_speaker+"\RadioProtocolPER\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "fre" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\FRE\"+_speaker+"\RadioProtocolFRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "chi" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\CHI\"+_speaker+"\RadioProtocolCHI\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "pol" >= 0): {_s = "A3\Dubbing_Radio_F_Enoch\data\POL\"+_speaker+"\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "rus" >= 0): {_s = "A3\Dubbing_Radio_F_Enoch\data\RUS\"+_speaker+"\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
		case (_speaker find "ger" >= 0 and _soundFileName find "CS_" >= 0): {_s = "WW2\Core_s\IF_DubbingRadio_s\Radio\"+_speaker+"\DEFAULT\combat\" + _soundFileName + ".wss";};
		case (_speaker find "ger" >= 0): {_s = "WW2\Core_s\IF_DubbingRadio_s\Radio\"+_speaker+"\DEFAULT\" + _soundFileName + ".wss";};

	};
	//player sidechat _s;
	//copyToClipboard  _s;
	if (!isNull _unit and alive _unit) then
	{
		//playSound3D [_s, _unit];
		playSound3D [_s, _unit, false, getPosASL _unit, _volume, pitch _unit, 0];
		[_unit, 1] call JBOY_Lip;
		//[_s, _unit] remoteExec ["playSound3D",-2];
	};
};
/*  Sample calls
[_unit, selectRandom ["IncomingGrenadeE_1","IncomingGrenadeE_2","IncomingGrenadeE_3","TakeCover"]] call JBOY_StackSpeak; // if ai spots incoming grenade
[_unit,selectRandom ["EndangeredE_1","EndangeredE_2","EndangeredE_3","Grunt","Grunt","Grunt"]] call JBOY_StackSpeak; // react after grenade explodes
[_unit,selectRandom ["moveUp_1","moveUp_2","advance"]] call JBOY_StackSpeak;
[player,selectRandom ["moveBack_1","moveBack_2"]] call JBOY_StackSpeak; [_leader, selectRandom ["FormOnMe","RallyUp"]] call JBOY_StackSpeak;
[_unit, selectRandom ["AwaitingOrders","ReadyForOrders"]] call JBOY_StackSpeak;
[player,selectRandom ["CombatOpenFire_4","Attack_1"]] call JBOY_StackSpeak;
[_unit,selectRandom ["Stop","Halt"]] call JBOY_StackSpeak;
[_unit, selectRandom ["GoProne_1","GoProne_2","TakeCover"]] call JBOY_StackSpeak;
[selectRandom _stackMembers,selectRandom ["CheeringE_1","CheeringE_2","CheeringE_3"]] call JBOY_StackSpeak;
*/
