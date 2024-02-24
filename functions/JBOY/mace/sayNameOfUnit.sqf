// ********************************************************
// If unit is named, say the name.  Else call him out as officer
// medic, one-zero, one-one, or one-two.  If none of those apply, do nothing
// ********************************************************
//sayNameOfUnit =
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
*/	
false

