/*
    Turbulent Skies
    Applies local camera shake for helicopter turbulence.

    Camera shake:
    - applied locally to every player inside the helicopter
*/

params [
    ["_heli", objNull, [objNull]]
];

if (isNull _heli) exitWith {};

private _lastDebug = 0;

while {
    alive player &&
    {alive _heli} &&
    {vehicle player isEqualTo _heli}
} do {

    private _altitude = (getPosATL _heli) # 2;
    private _maxAltitude = (missionNamespace getVariable ["TS_maximum_altitude", 300]) max 6;

    if (_altitude > 3 && {_altitude < _maxAltitude}) then {

        private _severity = [] call TS_fnc_getWeatherSeverity;

        if (_severity > 0.35) then {

            private _groundFactor =
                1 - ((_altitude - 3) / (_maxAltitude - 3));

            // Weather escalation is exponential
            private _weatherRamp = _severity ^ 1.6;

            private _strength = if (difficultyEnabledRTD) then {
                _weatherRamp * (0.55 + (_groundFactor * 0.55))
            } else {
                _weatherRamp * (0.80 + (_groundFactor * 0.80))
            };

            private _shakeMultiplier = missionNamespace getVariable ["TS_camera_shake_multiplier", 0.5];

            if (_shakeMultiplier > 0) then {
                private _camShake = linearConversion [
                    0.35,
                    5.0,
                    _strength,
                    0.5,
                    7.5,
                    true
                ];

                _camShake = _camShake * _shakeMultiplier;

                if (_camShake > 0) then {
                    addCamShake [
                        _camShake,
                        0.4,
                        12
                    ];
                };
            };

            if (
                (missionNamespace getVariable ["TS_debug_enabled", false]) &&
                {time > _lastDebug + 5}
            ) then {
                systemChat format [
                    "[TS] CAMERA | Alt:%1 | Max:%2 | Sev:%3 | Str:%4 | WindStr:%5",
                    round _altitude,
                    round _maxAltitude,
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
