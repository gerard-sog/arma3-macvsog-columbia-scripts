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

    if (_alt > 5 && {_alt < _maxAlt}) then {

        private _windMag = vectorMagnitude wind;

        private _severity =
            (overcast * 0.2) +
            (rain * 0.5) +
            (fog * 0.2) +
            (_windMag / 14);

        if (_severity > 0.35) then {

            private _vel = velocity _heli;

            private _groundFactor =
                1 - ((_alt - 5) / (_maxAlt - 5));

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
            };

            // Camera shake: everyone inside feels it
            if (
                TS_camera_shake_enabled &&
                {player in crew _heli}
            ) then {
                addCamShake [
                    1.5 * _strength,
                    0.4,
                    12
                ];
            };

            if (
                TS_debug_enabled &&
                {time > _lastDebug + 5}
            ) then {
                systemChat format [
                    "[TS] ACTIVE | Alt:%1 | Sev:%2 | Str:%3 | Local:%4",
                    round _alt,
                    (_severity toFixed 2),
                    (_strength toFixed 2),
                    local _heli
                ];

                _lastDebug = time;
            };
        };
    };

    sleep 0.25;
};