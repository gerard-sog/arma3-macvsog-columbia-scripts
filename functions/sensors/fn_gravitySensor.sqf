if !(hasInterface) exitWith {};

_gravitySensor = [
	"COLSOG_gravitySensor",
	"Throw Gravity sensor",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\listen_ca.paa",
	{
		// Needs to be sent to server.
        [[], "functions\sensors\gravity\fn_createGravitySensor.sqf"] remoteExec ["execVM", 2, false];
	},
	{
	    private _hasItem = [player, colsog_sensor_gravityInventoryItem] call BIS_fnc_hasItem;
	    private _isInVehicle = !(isNull objectParent player);
	    _result = (_hasItem AND _isInVehicle AND !(isTouchingGround (vehicle player)));
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _gravitySensor, true] call ace_interact_menu_fnc_addActionToClass;