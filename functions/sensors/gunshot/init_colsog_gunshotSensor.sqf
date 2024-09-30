if (!isServer) exitWith {};

[
    colsog_sensor_gunshotThingItem, "InitPost",
    {
        params ["_unit"];
        [
            {
                params ["_unit"];
                // Proximity sensor
                private _pos = getPosATL _unit;
                private _trigger = createTrigger ["EmptyDetector", _pos];
                // Required in order to pass as argument in trigger statement.
                _trigger setVariable ["COLSOG_sensorObject", _unit, true];
                _trigger setTriggerArea [50, 50, 0, false];
                _trigger setTriggerInterval 5;
                _trigger setTriggerActivation ["EAST", "PRESENT", true];
                _trigger setTriggerStatements
                [
                    "this",
                    "[thisTrigger getVariable 'COLSOG_sensorObject'] execVM 'functions\sensors\gunshot\fn_recordOpforMovement.sqf'",
                    ""
                ];
                _trigger setPos getPos _unit;
                // Required in order to delete trigger when object is deleted/picked up.
                _unit setVariable ["COLSOG_sensorTrigger", _trigger, true];

                // Gunshot sensor
                _unit addEventHandler
                [
                    "FiredNear",
                    {
                        params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

                        private _eventData = "distance " + (str _distance) + "meters.";
                        [_unit, "GUNSHOT", "#FF0000", _eventData, colsog_sensor_gunshotTransmitDataOverRadio, colsog_sensor_gunshotRadioTransmissionRange, colsog_sensor_gunshotLogFrequency] execVM "functions\sensors\common\fn_recordEventInObjectData.sqf";
                    }
                ];
            }, [_unit]
        ] call CBA_fnc_execNextFrame;
    }, true, [], true
] call CBA_fnc_addClassEventHandler;
