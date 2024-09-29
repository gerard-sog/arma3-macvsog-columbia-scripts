if !(hasInterface) exitWith {};

_gunshotSensor = [
	"COLSOG_gunshotSensor",
	"Place Gunshot sensor",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\listen_ca.paa",
	{
		execVM "functions\sensors\gunshot\fn_createGunshotSensor.sqf";
	},
	{
	    [player, colsog_sensor_gunshotInventoryItem] call BIS_fnc_hasItem;
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _gunshotSensor, true] call ace_interact_menu_fnc_addActionToClass;