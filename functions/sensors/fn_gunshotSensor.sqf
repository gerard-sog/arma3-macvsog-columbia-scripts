if !(hasInterface) exitWith {};

_gunshotSensor = [
	"COLSOG_gunshotSensor",
	"Place Gunshot sensor",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\listen_ca.paa",
	{
		// Needs to be sent to server.
        [[], "functions\sensors\gunshot\fn_createGunshotSensor.sqf"] remoteExec ["execVM", 2, false];
	},
	{
	    private _hasItem = [player, colsog_sensor_gunshotInventoryItem] call BIS_fnc_hasItem;
	    private _isNotInVehicle = (isNull objectParent player);
        _result = (_hasItem AND _isNotInVehicle);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _gunshotSensor, true] call ace_interact_menu_fnc_addActionToClass;