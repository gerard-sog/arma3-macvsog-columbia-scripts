/*
    Turbulent Skies
    Helicopter turbulence physics

    Runs only where helicopter is local.
    Applies force-based turbulence to reduce MP desync.
*/

params ["_heli"];

if (isNull _heli) exitWith {};

private _forceMultiplier = 5000;    // Tune 3000-8000
private _sleepTime = 0.25;

while {
    alive _heli
    && {vehicle player isEqualTo _heli}
} do {

    if !(local _heli) exitWith {};

    private _altitude = (getPosATL _heli) # 2;

    if (
        _altitude > 3
        && {_altitude < TS_maximum_altitude}
    ) then {

        private _overcast = overcast;
        private _rain = rain;
        private _wind = windStr;

        private _severity =
            (_overcast * TS_overcast_factor)
            + (_rain * TS_rain_factor)
            + (_wind * TS_wind_factor);

        private _weatherRamp = _severity ^ 1.6;

        if (_weatherRamp > 0.05) then {

            /*
                Same turbulence generation logic
                as original implementation
            */

            private _gustX =
                (random 2 - 1)
                * _weatherRamp;

            private _gustY =
                (random 2 - 1)
                * _weatherRamp;

            private _vertical =
                (random 2 - 1)
                * _weatherRamp
                * 0.6;

            _heli addForce [
                [
                    _gustX * _forceMultiplier,
                    _gustY * _forceMultiplier,
                    _vertical * _forceMultiplier
                ],
                getCenterOfMass _heli
            ];

            /*
                Optional turbulence damage
            */

            if (
                TS_damage_enabled
                && {_severity > TS_damage_threshold}
            ) then {

                private _damage =
                    linearConversion [
                        TS_damage_threshold,
                        2,
                        _severity,
                        0,
                        0.005,
                        true
                    ];

                _heli setDamage (
                    (damage _heli) + _damage
                );
            };

            if (TS_debug_enabled) then {
                systemChat format [
                    "TS | local=%1 | sev=%2 | force=%3",
                    local _heli,
                    round (_severity * 100) / 100,
                    round (_weatherRamp * _forceMultiplier)
                ];
            };
        };
    };

    sleep _sleepTime;
};