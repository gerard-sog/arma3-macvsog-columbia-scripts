/*
 *
 * Set general AI skill. Could be expanded to set specific skill values later. Currently only works on AI spawned during the game - all AI spawned in the editor retain their pre-set skills.
 *
 * https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html
 * https://cbateam.github.io/CBA_A3/docs/files/common/fnc_execNextFrame-sqf.html
 *
 */

if (!isServer) exitWith {};

[
	"O_Soldier_base_F", "Init", { 	

		params ["_unit"];

		[{
				params ["_unit"];
				_unit setSkill ["general", 0.33];
				_unit setSkill ["aimingAccuracy", 0.33];
				_unit setSkill ["aimingSpeed", 0.33];
				_unit setSkill ["endurance", 0.33];
				_unit setSkill ["spotTime", 0.10];
				_unit setSkill ["courage", 0.33];
				_unit setSkill ["aimingShake", 0.33];
				_unit setSkill ["commanding", 0.33];
				_unit setSkill ["spotDistance", 0.10];
				_unit setSkill ["reloadSpeed", 0.33];

		}, [_unit]] call CBA_fnc_execNextFrame;										

}, true, [], true] call CBA_fnc_addClassEventHandler;