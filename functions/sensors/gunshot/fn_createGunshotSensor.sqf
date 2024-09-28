
private _pos = getPosATL player;
private _sensor = "vn_prop_sandbag_01" createVehicle _pos; // item to be configurable.
_sensor setVariable ["COLSOG_sensorType", "gunshot", true];

_sensor addAction
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
];

_sensor addAction
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
];

// Proximity sensor
private _trigger = createTrigger ["EmptyDetector", _pos];
_trigger setVariable ["sensor", _sensor];
_trigger setTriggerArea [50, 50, 0, false];
_trigger setTriggerInterval 5;
_trigger setTriggerActivation ["EAST", "PRESENT", true];
_trigger setTriggerStatements
[
    "this",
    "[thisTrigger getVariable 'sensor'] execVM 'functions\sensors\gunshot\fn_saveProximityData.sqf'",
    ""
];
_trigger setPos getPos _sensor;

// Gunshot sensor
_sensor addEventHandler
[
    "FiredNear",
    {
        params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

        systemChat "FiredNear";
        systemChat (_unit getVariable ["COLSOG_sensorData", "1"]);

        private _data = _unit getVariable ["COLSOG_sensorData", ""];
        private _time = [dayTime] call BIS_fnc_timeToString; // 07:21:36

        systemChat _time;

        private _newData = _data + "|" + _time + ":<font color='#FF0000'>gunshot</font> dst " + str _distance + "<br />";

        systemChat _newData;

        _unit setVariable ["COLSOG_sensorData", _newData, true];

        // TODO: send ping to pilot OR dairy record if in distance ?
    }
];
