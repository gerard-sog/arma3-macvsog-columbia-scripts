totalAIDeaths = 0;

["O_Soldier_base_F", "Killed", 
{
	totalAIDeaths = totalAIDeaths + 1;
	systemChat str totalAIDeaths
}
, true, [], true] call CBA_fnc_addClassEventHandler;