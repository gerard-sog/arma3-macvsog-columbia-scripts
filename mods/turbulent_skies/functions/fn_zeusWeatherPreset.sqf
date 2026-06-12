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

        // Transition toward rainy
        case 1: {
            [0.25, 0.2, 0.3, 45, [0.8, 0.8, true], "CALM → RAINY"]
        };

        // Moderate rainy weather
        case 2: {
            [0.5, 0.5, 0.5, 45, [1.5, 1.5, true], "RAINY"]
        };

        // Transition toward storm
        case 3: {
            [0.75, 0.75, 0.75, 45, [2.5, 2.5, true], "RAINY → STORMY"]
        };

        // Worst weather
        case 4: {
            [1, 1, 1, 45, [3.5, 3.5, true], "STORMY"]
        };

        default {
            [0, 0, 0.1, 45, [0.3, 0.3, true], "CALM"]
        };
    };

    [
        "TS_applyWeatherPreset",
        _weatherData + [_zeus]
    ] call CBA_fnc_serverEvent;
};

[
    "Turbulent Skies - Weather Preset",
    [
        [
            "LIST",
            "Preset",
            [
                [0, 1, 2, 3, 4],
                [
                    "CALM",
                    "CALM to RAINY",
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