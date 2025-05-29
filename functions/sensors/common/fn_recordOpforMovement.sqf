params ["_sensor", "_transmitDataOverRadio", "_radioTransmissionRange", "_logFrequency"];

[_sensor, "MOVEMENT", "#00FF00", nil, _transmitDataOverRadio, _radioTransmissionRange, _logFrequency] execVM "functions\sensors\common\fn_recordEventInObjectData.sqf";
