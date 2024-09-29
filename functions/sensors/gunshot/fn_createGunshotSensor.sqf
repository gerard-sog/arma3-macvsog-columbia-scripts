player removeItem colsog_sensor_gunshotInventoryItem;
private _pos = getPosATL player;
private _sensor = colsog_sensor_gunshotThingItem createVehicle _pos; // item to be configurable.

[
	_sensor,
	[
      "<t color='#FF0000'>Pick up</t>",
      "functions\sensors\gunshot\fn_pickUp.sqf",
      nil,
      0,
      true,
      true,
      "",
      "",
      50,
      false,
      "",
      ""
    ]
] remoteExec ['addAction', 0];

[
	_sensor,
	[
      "<t color='#00FF00'>Collect data</t>",
      "functions\sensors\gunshot\fn_collectData.sqf",
      nil,
      0,
      true,
      true,
      "",
      "",
      50,
      false,
      "",
      ""
    ]
] remoteExec ['addAction', 0];

// Proximity sensor
private _trigger = createTrigger ["EmptyDetector", _pos];
// Required in order to pass as argument in trigger statement.
_trigger setVariable ["COLSOG_sensorObject", _sensor, true];
_trigger setTriggerArea [50, 50, 0, false];
_trigger setTriggerInterval 5;
_trigger setTriggerActivation ["EAST", "PRESENT", true];
_trigger setTriggerStatements
[
    "this",
    "[thisTrigger getVariable 'COLSOG_sensorObject'] execVM 'functions\sensors\gunshot\fn_recordMovement.sqf'",
    ""
];
_trigger setPos getPos _sensor;
// Required in order to delete trigger when object is deleted/picked up.
_sensor setVariable ["COLSOG_sensorTrigger", _trigger, true];

// Gunshot sensor
_sensor addEventHandler
[
    "FiredNear",
    {
        params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

        private _eventData = "distance " + (str _distance) + "meters.";
        [_unit, "GUNSHOT", "#FF0000", _eventData, colsog_sensor_gunshotSendToCustomUnits] call COLSOG_fnc_recordEventInObjectData;
    }
];
