if (!hasInterface) exitWith {};
if (!isNil "TS_initialized") exitWith {};
TS_initialized = true;

player addEventHandler ["GetInMan", {

    params ["_unit", "_role", "_vehicle"];

    if (_role == "driver" && {_vehicle isKindOf "Helicopter"}) then {

        if !(isNil {_unit getVariable "TS_handle"}) exitWith {};

        systemChat "[HELI WEATHER] Activated";

        private _handle = [_vehicle] spawn {

            params ["_heli"];

            private _lastDebug = 0;

            while {
                alive player &&
                {vehicle player == _heli} &&
                {driver _heli == player}
            } do {

                private _alt = (getPosATL _heli) # 2;

                if (_alt > 5 && {_alt < 100}) then {

                    private _windMag = vectorMagnitude wind;

                    private _severity =
                        (overcast * 0.2) +
                        (rain * 0.5) +
                        (fog * 0.2) +
                        (_windMag / 14);

                    if (_severity > 0.35) then {

                        private _vel = velocity _heli;
                        private _groundFactor = 1 - ((_alt - 5) / 95);
                        private _weatherRamp = _severity ^ 1.6;

                        private _strength = if (difficultyEnabledRTD) then {
                            _weatherRamp * (0.55 + (_groundFactor * 0.55))
                        } else {
                            _weatherRamp * (0.80 + (_groundFactor * 0.80))
                        };

                        private _gustAngle = random 360;
                        private _gustPower = random [0.6, 1.5, 2.5] * _strength;

                        private _gustX = (sin _gustAngle) * _gustPower;
                        private _gustY = (cos _gustAngle) * _gustPower;

                        private _vertical = random [-1.0, -0.3, 0.6] * _strength;

                        _heli setVelocity [
                            (_vel # 0) + _gustX,
                            (_vel # 1) + _gustY,
                            (_vel # 2) + _vertical
                        ];

                        addCamShake [1.5 * _strength, 0.4, 12];

                        if (time > _lastDebug + 5) then {
                            systemChat format [
                                "[HELI WEATHER] Alt:%1m | Sev:%2 | Str:%3",
                                round _alt,
                                (_severity toFixed 2),
                                (_strength toFixed 2)
                            ];
                            _lastDebug = time;
                        };
                    };
                };

                sleep 0.25;
            };

            systemChat "[HELI WEATHER] Deactivated";
            player setVariable ["TS_handle", nil];
        };

        _unit setVariable ["TS_handle", _handle];
    };
}];

player addEventHandler ["GetOutMan", {
    params ["_unit"];

    private _handle = _unit getVariable ["TS_handle", scriptNull];

    if !(isNull _handle) then {
        terminate _handle;
        _unit setVariable ["TS_handle", nil];
    };
}];