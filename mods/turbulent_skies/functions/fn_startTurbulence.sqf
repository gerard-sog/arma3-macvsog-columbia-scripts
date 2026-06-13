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

            private _vel = velocity _heli;

            private _groundFactor =
                1 - ((_alt - 3) / (_maxAlt - 3));

            // Weather escalation is exponential
            private _weatherRamp = _severity ^ 1.6;

            private _strength = if (difficultyEnabledRTD) then {
                _weatherRamp * (0.55 + (_groundFactor * 0.55))
            } else {
                _weatherRamp * (0.80 + (_groundFactor * 0.80))
            };

            private _gustAngle = random 360;
            private _gustPower =
                random [0.6, 1.5, 2.5] * _strength;

            private _gustX = (sin _gustAngle) * _gustPower;
            private _gustY = (cos _gustAngle) * _gustPower;

            private _vertical =
                random [-1.0, -0.3, 0.6] * _strength;

            // Physics: only one machine applies velocity
            if (local _heli) then {
                _heli setVelocity [
                    (_vel # 0) + _gustX,
                    (_vel # 1) + _gustY,
                    (_vel # 2) + _vertical
                ];

                // Optional small damage in extreme turbulence
                if (
                    TS_damage_enabled &&
                    {_severity > TS_damage_threshold} &&
                    {random 1 < 0.01}
                ) then {
                    // 12–14 minutes to 50%
                    private _newDamage = ((damage _heli) + random [0.008, 0.015, 0.03]) min 0.85;

                    _heli setDamage _newDamage;

                    playSound3D [
                        "A3\Sounds_F\vehicles\crashes\helis\Heli_crash_default_int_1.wss",
                        _heli,
                        false,
                        getPosASL _heli,
                        25,
                        random [0.95, 1.0, 1.1],
                        250
                    ];

                    if (TS_debug_enabled) then {
                        systemChat format [
                            "[TS] Turbulence damage applied | Damage:%1",
                            (_newDamage toFixed 2)
                        ];
                    };
                };
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
                    "[TS] ACTIVE | Alt:%1 | Max:%2 | Sev:%3 | Str:%4 | WindStr:%5 | Local:%6",
                    round _alt,
                    round _maxAlt,
                    (_severity toFixed 2),
                    (_strength toFixed 2),
                    (windStr toFixed 2),
                    local _heli
                ];

                _lastDebug = time;
            };
        };
    };

    sleep 0.25;
};