params ["_sensor"]; // specials parameters passed to a script by addAction

systemChat str _sensor;

private _data = _sensor getVariable ["COLSOG_sensorData", ""];
private _time = [dayTime] call BIS_fnc_timeToString; // 07:21:36
private _newData = _data + "|" + _time + ":<font color='#00FF00'>movement</font><br />";

systemChat _newData;

_sensor setVariable ["COLSOG_sensorData", _newData, true];

// TODO: send ping to pilot OR dairy record if in distance ?