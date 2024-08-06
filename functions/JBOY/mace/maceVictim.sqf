// ********************************************************
// Attach victim to mace and play various fx (sound, blood, etc.)
// ********************************************************
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
