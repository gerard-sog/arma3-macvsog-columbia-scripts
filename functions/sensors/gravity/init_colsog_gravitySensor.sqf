if (!isServer) exitWith {};

[
    colsog_sensor_gravityThingItem, "InitPost",
    {
        params ["_unit"];
        [
            {
                params ["_unit"];
                [
                    {
                        // Proximity sensor
                        private _delayedUnitActivation = _this select 0;
                        private _pos = getPosATL _delayedUnitActivation;
                        private _trigger = createTrigger ["EmptyDetector", _pos];
                        // Required in order to pass as argument in trigger statement.
                        _trigger setVariable ["COLSOG_sensorObject", _delayedUnitActivation, true];
                        _trigger setTriggerArea [50, 50, 0, false];
                        _trigger setTriggerInterval 5;
                        _trigger setTriggerActivation ["EAST", "PRESENT", true];
                        _trigger setTriggerStatements
                        [
                            "this",
                            "[thisTrigger getVariable 'COLSOG_sensorObject'] execVM 'functions\sensors\gravity\fn_recordOpforMovement.sqf'",
                            ""
                        ];
                        _trigger setPos getPos _delayedUnitActivation;
                        // Required in order to delete trigger when object is deleted/picked up.
                        _delayedUnitActivation setVariable ["COLSOG_sensorTrigger", _trigger, true];

                        // Gravity sensor
                        _delayedUnitActivation addEventHandler
                        [
                            "FiredNear",
                            {
                                params ["_delayedUnitActivation", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

                                private _eventData = "distance " + (str _distance) + "meters.";
                                [_delayedUnitActivation, "GUNSHOT", "#FF0000", _eventData, colsog_sensor_gravityTransmitDataOverRadio, colsog_sensor_gravityRadioTransmissionRange, colsog_sensor_gravityLogFrequency] execVM "functions\sensors\common\fn_recordEventInObjectData.sqf";
                            }
                        ];
                    },
                    [_unit],
                    30 // Delay of 30 seconds before sensor is activated.
                ] call CBA_fnc_waitAndExecute;
            }, [_unit]
        ] call CBA_fnc_execNextFrame;
    }, true, [], true
] call CBA_fnc_addClassEventHandler;
