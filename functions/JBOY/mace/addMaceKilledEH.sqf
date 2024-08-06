// *********************************************************************
// May convert mace scripts to use killed eventhandlers to fire off victim code.
// as of 2/24/22 this is not inuse.
// *********************************************************************
params["_unit"];
_unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if () then
	{
		[_unit,_mace, _trapDir, _trapPos] spawn JBOY_maceVictim;
	};
}];
