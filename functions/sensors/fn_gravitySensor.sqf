if !(hasInterface) exitWith {};

_gravitySensor = [
	"COLSOG_gravitySensor",
	"Throw Gravity sensor",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\listen_ca.paa",
	{
	    player removeItem colsog_sensor_gravityInventoryItem;
		[player] remoteExec ["COLSOG_fnc_createGravitySensor", 2];
	},
	{
	    private _hasItem = [player, colsog_sensor_gravityInventoryItem] call BIS_fnc_hasItem;
	    private _isInVehicle = !(isNull objectParent player);
	    _result = (_hasItem AND _isInVehicle AND !(isTouchingGround (vehicle player)));
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _gravitySensor, true] call ace_interact_menu_fnc_addActionToClass;