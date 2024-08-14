// *******************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// *******************************************************
params ["_mace", "_unit"];
private _directionTo = ([_unit, _mace] call BIS_fnc_dirTo);
private _unitFacingMace = false;
if ([position _unit, _directionTo, 180, position _mace] call BIS_fnc_inAngleSector) then
{
	_directionTo = _directionTo + 180;
	_unitFacingMace = true;
};
private _animationOptions = [];
if (_unitFacingMace) then
{
	_animationOptions = [1, 3, 5];
} else
{
	_animationOptions = [1, 2, 4, 5];
};
_animationOptions = _animationOptions - (_mace getVariable ["COLSOG_victimAnimationAlreadyUsed", []]); // When more than one guy impaled on same mace, each get different anim
private _option = selectRandom _animationOptions;
switch (_option) do
{  
	case 1:
	{ 
		[_unit, "vn_armor_m41_commander_out_kia"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.5, -.5, -0.4]];
		_unit setDir _directionTo;
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 2:
	{ 
		[_unit, "KIA_driver_scooter_01"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.8, -0.1, -0.1]];
		_unit setDir _directionTo;
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 3:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.3, .5, -0.16]]; // positive y value move unit backward
		_unit setDir (_directionTo + 180);
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
	case 4:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.1, .2, -0.16]]; // positive y value move unit backward
		_unit setDir (_directionTo + 180);
		_unit setVectorUp [-0.0363626, 0.198112, 0.9995081];
	};
	case 5:
	{ 
		[_unit, "vn_boat_05_gunner_06_kia"] remoteExec ["switchMove"];    
		_unit attachTo [_mace, [0.5, -.5, -0.7]]; // positive y value move unit backward
		_unit setDir (_directionTo + 180);
		_unit setVectorUp [0.0363626, 0.998112, 0.9995081];
	};
};
private _victimAnimationAlreadyUsed = _mace getVariable ["COLSOG_victimAnimationAlreadyUsed", []];
_victimAnimationAlreadyUsed pushBack _option;
_mace setVariable ["COLSOG_victimAnimationAlreadyUsed", _victimAnimationAlreadyUsed, true];
