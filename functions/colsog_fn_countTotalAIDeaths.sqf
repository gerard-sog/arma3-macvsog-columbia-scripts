if (!isServer) exitWith {};
totalAIDeaths = 0;

["O_Soldier_base_F", "Killed", 
{
	totalAIDeaths = totalAIDeaths + 1;
}
, true, [], true] call CBA_fnc_addClassEventHandler;