/*
    Turbulent Skies
    ZEN Zeus weather preset dialog.
*/

params [
    ["_pos", [0, 0, 0], [[]], 3],
    ["_unit", objNull, [objNull]]
];

private _onConfirm = {
    params ["_dialogResult", "_args"];

    _args params ["_zeus"];
    _dialogResult params ["_preset"];

    private _weatherData = [_preset] call TS_fnc_getWeatherPresetData;

    [
        "TS_applyWeatherPreset",
        _weatherData + [_zeus, _preset]
    ] call CBA_fnc_serverEvent;
};

[
    "Turbulent Skies - Weather Preset",
    [
        [
            "LIST",
            "Preset",
            [
                [0, 1, 2, 3, 4, 5],
                [
                    "CALM",
                    "CALM to OVERCAST",
                    "OVERCAST to RAINY",
                    "RAINY",
                    "RAINY to STORMY",
                    "STORMY"
                ],
                0
            ],
            true
        ]
    ],
    _onConfirm,
    {},
    [_unit]
] call zen_dialog_fnc_create;
