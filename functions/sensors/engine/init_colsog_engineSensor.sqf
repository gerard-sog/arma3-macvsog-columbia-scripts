if (!isServer) exitWith {};

[
    colsog_sensor_engineThingItem, "InitPost",
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
                _trigger setTriggerArea [100, 100, 0, false];
                _trigger setTriggerInterval 5;
                _trigger setTriggerActivation ["EAST", "PRESENT", true];
                _trigger setTriggerStatements
                [
                    "this",
                    "[thisTrigger getVariable 'COLSOG_sensorObject', thisList] execVM 'functions\sensors\engine\fn_recordOpforVehicleMovement.sqf'",
                    ""
                ];
                _trigger setPos getPos _unit;
                // Required in order to delete trigger when object is deleted/picked up.
                _unit setVariable ["COLSOG_sensorTrigger", _trigger, true];
            }, [_unit]
        ] call CBA_fnc_execNextFrame;
    }, true, [], true
] call CBA_fnc_addClassEventHandler;
