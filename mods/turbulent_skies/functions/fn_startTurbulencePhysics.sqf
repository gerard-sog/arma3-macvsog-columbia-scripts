/*
    Turbulent Skies
    Applies helicopter turbulence physics.

    Physics force:
    - only applied where helicopter is local
    - prevents duplicated wind force in multiplayer
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

    if (local _heli) then {

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

                private _gustAngle = random 360;
                private _gustPower = random [0.25, 0.65, 1.15] * _strength;

                private _gustX = (sin _gustAngle) * _gustPower;
                private _gustY = (cos _gustAngle) * _gustPower;
                private _vertical = random [-0.35, -0.1, 0.25] * _strength;

                // Mass compensation keeps small and large helicopters closer in felt acceleration.
                private _mass = getMass _heli;
                private _forceMultiplier = _mass * 0.75;

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
                    // About 12–14 minutes to 50% damage in extreme turbulence
                    private _severityScale =
                        linearConversion [
                            missionNamespace getVariable ["TS_damage_threshold", 1.4],
                            1.7,
                            _severity,
                            0.5,
                            1.5,
                            true
                        ];

                    private _damage =
                        random [0.010, 0.015, 0.020]
                        * _severityScale;

                    private _newDamage = ((damage _heli) + _damage) min 0.85;

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
                            "[TS] Turbulence damage applied | +%1 | Damage:%2",
                            (_damage toFixed 3),
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
                        round _altitude,
                        round _maxAltitude,
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