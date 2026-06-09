/*
 * initPlayerlocal.sqf
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 * https://community.bistudio.com/wiki/Initialisation_Order
 *
 * PArameters:
 * 0: _player
 * 1: _didJIP
 *
 */

params ["_player", "_didJIP"];

_handle = [] execVM "functions\init\init_colsog_PlayerLocalVar.sqf"; // player exists we can set variables on object player
waitUntil { scriptDone _handle };

// ACRE BABEL config
colsog_available_languages = [["en", "English"], ["vn", "Vietnamese"]];
{
	_x call acre_api_fnc_babelAddLanguageType;
} forEach colsog_available_languages;
// exec only for players https://github.com/IDI-Systems/acre2/blob/master/addons/api/fnc_babelAddLanguageType.sqf#L20

// Safety to be sure player has finished downloading the mission, is on map screen, alive (inventory loaded, acre initialized)
[
	{_this == _this}, // waitUntil {player == player}
	{
		[
			{alive _this}, // waitUntil {alive player}
			{
				// sets the default loadout for respawn to initial loadout when player joined the server.
				_this setVariable ["saved_loadout", getUnitLoadout _this];

				// force vietnamese face if needed
				call COLSOG_fnc_faces;

				// init Babel spoken language
				execVM "functions\init\init_colsog_PlayerBabel.sqf";
				// init Babel zeus switch language
				execVM "functions\init\init_colsog_ZeusBabelSwitch.sqf";

				// add custom footprint creator (using markers) event handler.
				call COLSOG_fnc_prey;
			}, 
			_this // argument (still player)
		] call CBA_fnc_waitUntilAndExecute;
	}, 
	player // argument passes to condition & statement
] call CBA_fnc_waitUntilAndExecute;

player addEventHandler ["GetInMan", {

    params ["_unit", "_role", "_vehicle"];

    if (_role == "driver" && {_vehicle isKindOf "Helicopter"}) then {

        if !(isNil {_unit getVariable "heliWeatherHandle"}) exitWith {};

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

                // Only active between 5m and 100m
                if (_alt > 5 && {_alt < 100}) then {

                    private _windMag = vectorMagnitude wind;

                    // Weather severity
                    private _severity =
                        (overcast * 0.2) +
                        (rain * 0.5) +
                        (fog * 0.2) +
                        (_windMag / 14);

                    if (_severity > 0.35) then {

                        private _vel = velocity _heli;

                        // Stronger closer to terrain
                        private _groundFactor =
                            1 - ((_alt - 5) / 95);

                        private _weatherRamp =
                            _severity ^ 1.6;

                        // AFM scaling
                        private _strength =
                            if (difficultyEnabledRTD) then {
                                _weatherRamp *
                                (0.55 + (_groundFactor * 0.55))
                            } else {
                                _weatherRamp *
                                (0.80 + (_groundFactor * 0.80))
                            };

                        // Completely random gust direction
                        private _gustAngle =
                            random 360;

                        private _gustPower =
                            random [0.6, 1.5, 2.5] *
                            _strength;

                        private _gustX =
                            (sin _gustAngle) *
                            _gustPower;

                        private _gustY =
                            (cos _gustAngle) *
                            _gustPower;

                        // Vertical turbulence
                        private _vertical =
                            random [-1.0,-0.3,0.6] *
                            _strength;

                        _heli setVelocity [
                            (_vel # 0) + _gustX,
                            (_vel # 1) + _gustY,
                            (_vel # 2) + _vertical
                        ];

                        // Camera shake
                        addCamShake [1.5 * _strength, 0.4, 12];

                        // Debug every 5 sec
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

            player setVariable [
                "heliWeatherHandle",
                nil
            ];
        };

        _unit setVariable [
            "heliWeatherHandle",
            _handle
        ];
    };
}];


player addEventHandler ["GetOutMan", {

    params ["_unit"];

    private _handle =
        _unit getVariable [
            "heliWeatherHandle",
            scriptNull
        ];

    if !(isNull _handle) then {
        terminate _handle;
        _unit setVariable [
            "heliWeatherHandle",
            nil
        ];
    };
}];