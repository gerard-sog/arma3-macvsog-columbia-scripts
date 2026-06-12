private _nextPreset = missionNamespace getVariable ["TS_weatherSystem_nextPreset", -1];

if (_nextPreset < 0) exitWith {
    TS_airControl sideChat "AIR CONTROL: No weather forecast is currently available.";
};

private _forecastData = switch (_nextPreset) do {
    case 0: {
        ["CLEAR WEATHER", 45, 3, 0, 0, "No rain", "No significant low-level turbulence expected"]
    };

    case 1: {
        ["OVERCAST DEVELOPING", 45, 6, 50, 0, "No rain", "No significant low-level turbulence expected"]
    };

    case 2: {
        ["POOR WEATHER DEVELOPING", 45, 9, 70, 20, "Light rain expected", "Light low-level turbulence possible"]
    };

    case 3: {
        ["RAINY CONDITIONS", 45, 15, 85, 50, "Moderate rain expected", "Moderate low-level turbulence expected"]
    };

    case 4: {
        ["STORM CONDITIONS DEVELOPING", 45, 23, 95, 75, "Heavy rain expected", "Severe low-level turbulence possible"]
    };

    case 5: {
        ["STORM CONDITIONS", 45, 30, 100, 100, "Heavy rain expected", "Severe low-level turbulence expected"]
    };

    default {
        ["UNKNOWN CONDITIONS", 45, 0, 0, 0, "Unknown rain conditions", "Turbulence forecast unavailable"]
    };
};

_forecastData params [
    "_condition",
    "_windDir",
    "_windKnots",
    "_overcastPercent",
    "_rainPercent",
    "_rainText",
    "_turbulenceText"
];

private _bearing = round _windDir;
private _bearingText = str _bearing;

if (_bearing < 100) then {
    _bearingText = format ["0%1", _bearingText];
};

if (_bearing < 10) then {
    _bearingText = format ["0%1", _bearingText];
};

private _msg = format [
    "AIR CONTROL: Forecast calls for %1. Winds %2 at %3 knots. Overcast %4 percent. Rain %5 percent. %6. %7.",
    _condition,
    _bearingText,
    _windKnots,
    _overcastPercent,
    _rainPercent,
    _rainText,
    _turbulenceText
];

TS_airControl sideChat _msg;