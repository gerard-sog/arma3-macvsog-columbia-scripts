// *******************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// *******************************************************
params ["_mace", "_unit"];
private _dir_to = ([_unit, _mace] call BIS_fnc_dirTo);
private _unit_facing_mace = false;
if ([position _unit, _dir_to, 180, position _mace] call BIS_fnc_inAngleSector) then
{
	_dir_to = _dir_to + 180;
	_unit_facing_mace = true;
};
private _animation_options = [];
if (_unit_facing_mace) then
{
	_animation_options = [1, 3, 5];
} else
{
	_animation_options = [1, 2, 4, 5];
};
_animation_options = _animation_options - (_mace getVariable ["COLSOG_victim_animation_already_used", []]); // When more than one guy impaled on same mace, each get different anim
private _option = selectRandom _animation_options;
switch (_option) do
{  
	case 1:
	{ 
		[_unit, "vn_armor_m41_commander_out_kia"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.5, -.5, -0.4]];
		_unit setDir _dir_to;
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 2:
	{ 
		[_unit, "KIA_driver_scooter_01"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.8, -0.1, -0.1]];
		_unit setDir _dir_to;
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 3:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.3, .5, -0.16]]; // positive y value move unit backward
		_unit setDir (_dir_to + 180);
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 4:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.1, .2, -0.16]]; // positive y value move unit backward
		_unit setDir (_dir_to + 180);
		_unit setVectorUp [-0.0363626, 0.198112, 0.9995081];
	};
	case 5:
	{ 
		[_unit, "vn_boat_05_gunner_06_kia"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.5, -.5, -0.7]]; // positive y value move unit backward
		_unit setDir (_dir_to + 180);
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
};
_COLSOG_victim_animation_already_used = _mace getVariable ["COLSOG_victim_animation_already_used", []];
_COLSOG_victim_animation_already_used pushBack _option;
_mace setVariable ["COLSOG_victim_animation_already_used", _COLSOG_victim_animation_already_used, true];
