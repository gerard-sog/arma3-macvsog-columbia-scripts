params [
    ["_pos", [0,0,0], [[]], 3],
    ["_unit", objNull, [objNull]]
];

private _onConfirm = {
    params ["_dialogResult", "_args"];

    _args params ["_zeus"];
    _dialogResult params ["_preset"];

    private _weatherData = switch (_preset) do {

        // Clear weather
        case 0: {
            [0, 0, 0.1, 45, [0.3, 0.3, true], "CALM"]
        };

        // Transition toward overcast
        case 1: {
            [0.5, 0, 0.2, 45, [0.5, 0.5, true], "CALM to OVERCAST"]
        };

        // Transition toward rainy
        case 2: {
            [0.7, 0.2, 0.3, 45, [0.8, 0.8, true], "OVERCAST to RAINY"]
        };

        // Moderate rainy weather
        case 3: {
            [0.85, 0.5, 0.5, 45, [1.5, 1.5, true], "RAINY"]
        };

        // Transition toward storm
        case 4: {
            [0.95, 0.75, 0.75, 45, [2.5, 2.5, true], "RAINY to STORMY"]
        };

        // Worst weather
        case 5: {
            [1, 1, 1, 45, [3.5, 3.5, true], "STORMY"]
        };

        default {
            [0, 0, 0.1, 45, [0.3, 0.3, true], "CALM"]
        };
    };

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