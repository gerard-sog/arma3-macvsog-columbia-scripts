// ********************************************************
// Attach victim to mace and play various fx (sound, blood, etc.)
// ********************************************************
//maceVictim = 
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

sleep 30;
