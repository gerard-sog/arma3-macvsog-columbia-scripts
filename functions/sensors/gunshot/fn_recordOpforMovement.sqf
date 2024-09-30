params ["_sensor"]; // specials parameters passed to a script by addAction

[_sensor, "MOVEMENT", "#00FF00", nil, colsog_sensor_transmitDataOverRadio] execVM "functions\sensors\common\fn_recordEventInObjectData.sqf";
