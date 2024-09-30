player removeItem colsog_sensor_gunshotInventoryItem;
private _pos = getPosATL player;
private _sensor = createVehicle [colsog_sensor_gunshotThingItem, getPosATL player, [], 0.5, "CAN_COLLIDE"]; // item to be configurable.

// Giving an idea to log it in records, this will give the ability to differentiate them.
COLSOG_sensorIdCounter = COLSOG_sensorIdCounter + 1;
_sensor setVariable ["COLSOG_sensorID", COLSOG_sensorIdCounter, true];
hintSilent format ["ID_" + str (COLSOG_sensorIdCounter)];
publicVariable "COLSOG_sensorIdCounter";

[
	_sensor,
	[
      "<t color='#FF0000'>Pick up</t>",
      "functions\sensors\common\fn_pickUp.sqf",
      [colsog_sensor_gunshotInventoryItem],
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
      "functions\sensors\common\fn_collectDataAsDiaryRecord.sqf",
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
