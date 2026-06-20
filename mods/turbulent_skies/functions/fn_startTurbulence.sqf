/*
    Turbulent Skies
    Applies helicopter turbulence.

    Physics force:
    - only applied where helicopter is local
    - prevents duplicated wind force in multiplayer

    Camera shake:
    - applied locally to every player inside the helicopter
*/

params ["_heli"];

private _lastDebug = 0;

while {
    alive player &&
    {vehicle player == _heli}
} do {

    private _alt = (getPosATL _heli) # 2;
    private _maxAlt = TS_maximum_altitude max 6;

    if (_alt > 3 && {_alt < _maxAlt}) then {

        private _severity =
            (overcast * TS_overcast_factor) +
            (rain * TS_rain_factor) +
            (windStr * TS_wind_factor);

        if (_severity > 0.35) then {

            private _groundFactor =
                1 - ((_alt - 3) / (_maxAlt - 3));

            // Weather escalation is exponential
            private _weatherRamp = _severity ^ 1.6;

            private _strength = if (difficultyEnabledRTD) then {
                _weatherRamp * (0.55 + (_groundFactor * 0.55))
            } else {
                _weatherRamp * (0.80 + (_groundFactor * 0.80))
            };

            // Camera shake: everyone inside feels it
            if (
                TS_camera_shake_multiplier > 0 &&
                {player in crew _heli}
            ) then {

                private _camShake =
                    linearConversion [
                        0.35,
                        5.0,
                        _strength,
                        0.5,
                        7.5,
                        true
                    ];

                _camShake = _camShake * TS_camera_shake_multiplier;

                if (_camShake > 0) then {
                    addCamShake [
                        _camShake,
                        0.4,
                        12
                    ];
                };
            };

            if (
                TS_debug_enabled &&
                {time > _lastDebug + 5}
            ) then {
                systemChat format [
                    "[TS] CAMERA | Alt:%1 | Max:%2 | Sev:%3 | Str:%4 | WindStr:%5",
                    round _alt,
                    round _maxAlt,
                    (_severity toFixed 2),
                    (_strength toFixed 2),
                    (windStr toFixed 2)
                ];

                _lastDebug = time;
            };
        };
    };

    sleep 0.25;
};