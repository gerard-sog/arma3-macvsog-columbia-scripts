// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
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
	_animOptions = [1,3,5];
} else
{
	_animOptions = [1,2,4,5];
};
_animOptions = _animOptions - (_mace getVariable ["victimAnimsAlreadyUsed",[]]); // When more than one guy impaled on same mace, each get different anim
private _option = selectRandom _animOptions;
switch (_option) do
{  
	case 1:
	{ 
		[_unit, "vn_armor_m41_commander_out_kia"] remoteExec ["switchMove"];    
		_unit attachTo [_mace,[0.5,-.5,-0.4]];
		_unit setDir _dirTo;
		_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
	};
	case 2:
	{ 
		[_unit, "KIA_driver_scooter_01"] remoteExec ["switchMove"];    
		_unit attachTo [_mace,[0.8,-0.1,-0.1]];
		_unit setDir _dirTo;
		_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
	};
	case 3:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace,[0.3,.5,-0.16]]; // positive y value move unit backward
		_unit setDir (_dirTo+180);
		_unit setVectorUp [0.0363626,0.998112,0.9995081]; 
	};
	case 4:
	{ 
		[_unit, "KIA_driver_boat_transport_02"] remoteExec ["switchMove"];    
		_unit attachTo [_mace,[0.1,.2,-0.16]]; // positive y value move unit backward
		_unit setDir (_dirTo+180);
		_unit setVectorUp [-0.0363626,0.198112,0.9995081]; 
	};
	case 5:
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
