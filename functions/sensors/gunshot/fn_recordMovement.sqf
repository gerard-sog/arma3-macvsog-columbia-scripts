params ["_sensor"]; // specials parameters passed to a script by addAction

[_sensor, "MOVEMENT", "#00FF00", nil, colsog_sensor_gunshotSendToCustomUnits] call COLSOG_fnc_recordEventInObjectData;
