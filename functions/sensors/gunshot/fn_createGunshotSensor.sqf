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
