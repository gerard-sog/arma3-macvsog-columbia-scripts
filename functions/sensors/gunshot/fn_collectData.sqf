params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _sensorData = _target getVariable "COLSOG_sensorData";
player createDiaryRecord ["Diary", ["Data", _sensorData]];
_target setVariable ["COLSOG_sensorData", "", true];
