#define SENSOR_DATA "COLSOG_sensorData"

params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _sensorData = _target getVariable SENSOR_DATA;
player createDiaryRecord ["Diary", ["Data", _sensorData]];
_target setVariable [SENSOR_DATA, "", true];
