// ********************************************************
// Attach victim to mace and play various fx (sound, blood, etc.)
// ********************************************************
params ["_unit","_mace","_trapDir","_trapPos"];
private _group = group _unit;
if ((_unit distance _mace) < Columbia_CBA_traps_mace_kill_radius) then
{
	private _dirTo = ([_unit, _mace] call BIS_fnc_dirTo);
	if ([ position _unit, _dirTo, 180, position _mace ] call BIS_fnc_inAngleSector) then
	{
		_dirTo = _dirTo + 180;
	};
	private _unitDir = getDir _unit;
	{_x enableCollisionWith _mace; _x setUnitPOS "MIDDLE";} forEach units _group;
	_unit setDamage 1;   
	_unit setPos getPos _unit;
	_mace setDir (_trapDir);
	[[_mace,_unit], "functions\TRAPS\impaleOnMace.sqf"] remoteExec ["execVM", 0, true];
	_unit setDir _dirTo;
	_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
	_mace setDir _trapDir;
	_mace setVelocityModelSpace [0,5,0]; // keep the dude swinging
	[[_unit], "functions\TRAPS\unitDropsWeapon.sqf"] remoteExec ["execVM", 0, true];
	uiSleep .5;

	vn_us_death_screams = [
	    "vn_sam_usdeath_001",
	    "vn_sam_usdeath_002",
	    "vn_sam_usdeath_003",
	    "vn_sam_usdeath_004",
	    "vn_sam_usdeath_005",
	    "vn_sam_usdeath_006",
	    "vn_sam_usdeath_007",
	    "vn_sam_usdeath_008",
	    "vn_sam_usdeath_009",
	    "vn_sam_usdeath_010",
	    "vn_sam_usdeath_011",
	    "vn_sam_usdeath_012",
	    "vn_sam_usdeath_013",
	    "vn_sam_usdeath_014",
	    "vn_sam_usdeath_015",
	    "vn_sam_usdeath_016",
	    "vn_sam_usdeath_017",
	    "vn_sam_usdeath_018",
	    "vn_sam_usdeath_019",
	    "vn_sam_usdeath_020",
	    "vn_sam_usdeath_021",
	    "vn_sam_usdeath_022",
	    "vn_sam_usdeath_023",
	    "vn_sam_usdeath_024",
	    "vn_sam_usdeath_025",
	    "vn_sam_usdeath_026",
	    "vn_sam_usdeath_027",
	    "vn_sam_usdeath_028",
	    "vn_sam_usdeath_029",
	    "vn_sam_usdeath_030",
	    "vn_sam_usdeath_031",
	    "vn_sam_usdeath_032",
	    "vn_sam_usdeath_033",
	    "vn_sam_usdeath_034",
	    "vn_sam_usdeath_035",
	    "vn_sam_usdeath_036",
	    "vn_sam_usdeath_037",
	    "vn_sam_usdeath_038",
	    "vn_sam_usdeath_039",
	    "vn_sam_usdeath_040",
	    "vn_sam_usdeath_041",
	    "vn_sam_usdeath_042",
	    "vn_sam_usdeath_043",
	    "vn_sam_usdeath_044",
	    "vn_sam_usdeath_045",
	    "vn_sam_usdeath_046",
	    "vn_sam_usdeath_047",
	    "vn_sam_usdeath_048",
	    "vn_sam_usdeath_049",
	    "vn_sam_usdeath_050",
	    "vn_sam_usdeath_051",
	    "vn_sam_usdeath_052",
	    "vn_sam_usdeath_053",
	    "vn_sam_usdeath_054",
	    "vn_sam_usdeath_055",
	    "vn_sam_usdeath_056",
	    "vn_sam_usdeath_057",
	    "vn_sam_usdeath_058"
	    ];

    if (Columbia_CBA_traps_screaming_enable) then {
        [_mace, selectRandom vn_us_death_screams] remoteExecCall ["say3D",0,false]; // victim screams
    	uiSleep 3;
    	[_mace, selectRandom vn_us_death_screams] remoteExecCall ["say3D",0,false]; // victim screams again
    	uiSleep 1;
    };

	private _sound = "a3\sounds_f\characters\movements\bush_004.wss"; // play sound to mask the ugv motor sound
	playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
	uiSleep 1.5;
};
uiSleep 30;

