/*
    Turbulent Skies
    Applies helicopter turbulence physics.

    Physics force:
    - only applied where helicopter is local
    - prevents duplicated wind force in multiplayer
*/

params ["_heli"];

private _lastDebug = 0;

while {
    alive player &&
    {vehicle player == _heli}
} do {

    if (local _heli) then {

        private _alt = (getPosATL _heli) # 2;
        private _maxAlt = (missionNamespace getVariable ["TS_maximum_altitude", 300]) max 6;

        if (_alt > 3 && {_alt < _maxAlt}) then {

            private _severity =
                (overcast * (missionNamespace getVariable ["TS_overcast_factor", 0.2])) +
                (rain * (missionNamespace getVariable ["TS_rain_factor", 0.5])) +
                (windStr * (missionNamespace getVariable ["TS_wind_factor", 1]));

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

                private _gustAngle = random 360;
                private _gustPower =
                    random [0.6, 1.5, 2.5] * _strength;

                private _gustX = (sin _gustAngle) * _gustPower;
                private _gustY = (cos _gustAngle) * _gustPower;

                private _vertical =
                    random [-1.0, -0.3, 0.6] * _strength;

                private _forceMultiplier = (getMass _heli) * 2.0;

                _heli addForce [
                    [
                        _gustX * _forceMultiplier,
                        _gustY * _forceMultiplier,
                        _vertical * _forceMultiplier
                    ],
                    getCenterOfMass _heli
                ];

                // Optional small damage in extreme turbulence
                if (
                    (missionNamespace getVariable ["TS_damage_enabled", false]) &&
                    {_severity > (missionNamespace getVariable ["TS_damage_threshold", 1.4])} &&
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

                    if (missionNamespace getVariable ["TS_debug_enabled", false]) then {
                        systemChat format [
                            "[TS] Turbulence damage applied | Damage:%1",
                            (_newDamage toFixed 2)
                        ];
                    };
                };

                if (
                    (missionNamespace getVariable ["TS_debug_enabled", false]) &&
                    {time > _lastDebug + 5}
                ) then {
                    systemChat format [
                        "[TS] PHYSICS | Alt:%1 | Max:%2 | Sev:%3 | Str:%4 | Mass:%5 | Force:%6 | Local:%7",
                        round _alt,
                        round _maxAlt,
                        (_severity toFixed 2),
                        (_strength toFixed 2),
                        round _mass,
                        round (_strength * _forceMultiplier),
                        local _heli
                    ];

                    _lastDebug = time;
                };
            };
        };
    };

    sleep 0.25;
};