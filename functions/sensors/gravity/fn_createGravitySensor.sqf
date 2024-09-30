player removeItem colsog_sensor_gravityInventoryItem;

private _playerPosition = getPosATL player;
private _pos = [_playerPosition select 0, _playerPosition select 1, (_playerPosition select 2) - 2];
private _sensor = createVehicle [colsog_sensor_gravityThingItem, _pos, [], 5, "CAN_COLLIDE"]; // item to be configurable.
// Drops it towards the ground.
_sensor setVelocity [0, 0, -5];

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
      [colsog_sensor_gravityInventoryItem],
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
