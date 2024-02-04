/*
 * Forces a unit to wake up or go unconscious, regardless if they have stable vitals or not.
 * (works with AI without killing them)
 *
 * Arguments:
 * 0: position (not used)
 * 1: attached unit
 *
 */
 params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

 // If opening on a vehicle
 _unit = effectiveCommander _unit;
 
 if !(_unit isKindOf "CAManBase") exitWith {
	 ["Select a unit", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	  playSound "FD_Start_F";
 };
 
 if (!alive _unit) exitWith {
	 ["Unit is dead", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	 playSound "FD_Start_F";
 };
 
 ["zen_common_execute", [ace_medical_fnc_setUnconscious, [_unit, !(_unit getVariable ["ACE_isUnconscious", false])]], _unit] call CBA_fnc_targetEvent;