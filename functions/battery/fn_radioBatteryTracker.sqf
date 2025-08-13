[
    {
        _updatedRadios = [];

        _radios = missionNamespace getVariable "COLSOG_radios";

        {
            _radioId = _x select 0;
            _isRadioOn = [_radioId] call acre_api_fnc_getRadioOnOffState;

            _previousBatteryLevel = _x select 1;
            _newBatteryLevel = _previousBatteryLevel;

            // Radio is ON;
            if (_isRadioOn == 1) then {
                systemChat "removing 5 sec";
                _newBatteryLevel = (_newBatteryLevel - 5) max 0;
            };

            if (_newBatteryLevel <= 0) then {
                // Needs to be run GLOBALLY... (would need to implement set method in ACRE otherwise).
                [_radioId, "setOnOffState", 0, true] remoteExec ["acre_sys_data_fnc_dataEvent", 0];
            };

            systemChat (_radioId + ": " + str(_newBatteryLevel));

            _updatedRadios pushBack [_radioId, _newBatteryLevel];

        } forEach _radios;

        missionNamespace setVariable ["COLSOG_radios", _updatedRadios, true];
    },
    5,
    []
] call CBA_fnc_addPerFrameHandler;