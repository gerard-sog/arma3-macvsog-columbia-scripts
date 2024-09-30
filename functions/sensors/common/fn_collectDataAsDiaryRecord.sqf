#define SENSOR_DATA "COLSOG_sensorData"

params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _sensorData = _target getVariable [SENSOR_DATA, ""];

if (_sensorData != "") then
{
    player createDiaryRecord ["Diary", ["Collected", _sensorData]];
    _target setVariable [SENSOR_DATA, "", true];
};
