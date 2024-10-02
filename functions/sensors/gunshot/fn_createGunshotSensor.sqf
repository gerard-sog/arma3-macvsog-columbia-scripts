/*
 * Creates a 'Gunshot' sensor.
 *
 * Arguments:
 * 0: (Optional) Sensor Object, needed when sensor created in Eden Editor (Object)
 * 1: (Optional) Sensor ID, needed when sensor created in Eden Editor (Integer)
 *
 * Return values:
 * None
 */

params ["_sensor", "_sensorId"];

// If only one of the two parameter is passed (not authorized).
if ((!(isNil "_sensor") && (isNil "_sensorId")) || ((isNil "_sensor") && !(isNil "_sensorId"))) exitWith
{
    "Missing one of the two parameters for 'fn_createGunshotSensor.sqf'!" call BIS_fnc_error;
};

// If used during mission.
if ((isNil "_sensor") && (isNil "_sensorId")) then
{
    player removeItem colsog_sensor_gunshotInventoryItem;
    _sensor = createVehicle [colsog_sensor_gunshotThingItem, getPosATL player, [], 0.5, "CAN_COLLIDE"];

    // Giving an idea to log it in records, this will give the ability to differentiate them.
    COLSOG_sensorIdCounter = COLSOG_sensorIdCounter + 1;
    _sensor setVariable ["COLSOG_sensorID", COLSOG_sensorIdCounter, true];
    hintSilent format ["ID_" + str (COLSOG_sensorIdCounter)];
    publicVariable "COLSOG_sensorIdCounter";
};

// If used in Eden Editor.
if (!(isNil "_sensor") && !(isNil "_sensorId")) then
{
    _sensor setVariable ["COLSOG_sensorID", _sensorId, true];
};

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
