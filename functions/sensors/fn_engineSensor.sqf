if !(hasInterface) exitWith {};

_engineSensor = [
	"COLSOG_engineSensor",
	"Place Engine sensor",
	"x\zen\addons\attributes\ui\engine_on_ca.paa",
	{
		execVM "functions\sensors\engine\fn_createEngineSensor.sqf";
	},
	{
	    [player, colsog_sensor_engineInventoryItem] call BIS_fnc_hasItem;
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _engineSensor, true] call ace_interact_menu_fnc_addActionToClass;