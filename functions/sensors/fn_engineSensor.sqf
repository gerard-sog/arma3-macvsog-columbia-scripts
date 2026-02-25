if !(hasInterface) exitWith {};

_engineSensor = [
	"COLSOG_engineSensor",
	"Place Engine sensor",
	"x\zen\addons\attributes\ui\engine_on_ca.paa",
	{
		// Needs to be sent to server.
        [[], "functions\sensors\engine\fn_createEngineSensor.sqf"] remoteExec ["execVM", 2, false];
	},
	{
	    private _hasItem = [player, colsog_sensor_engineInventoryItem] call BIS_fnc_hasItem;
	    private _isNotInVehicle = (isNull objectParent player);
	    _result = (_hasItem AND _isNotInVehicle);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _engineSensor, true] call ace_interact_menu_fnc_addActionToClass;