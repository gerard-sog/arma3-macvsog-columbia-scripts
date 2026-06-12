private _nextPreset = missionNamespace getVariable ["TS_weatherSystem_nextPreset", -1];

if (_nextPreset < 0) exitWith {
    player sideChat format ["AIR CONTROL: No weather forecast is currently available."];
};

private _forecastData = switch (_nextPreset) do {
    case 0: {
        ["CALM", "No significant low-level turbulence expected"]
    };

    case 1: {
        ["CALM to OVERCAST", "Minimal low-level turbulence expected"]
    };

    case 2: {
        ["OVERCAST to RAINY", "Light low-level turbulence expected"]
    };

    case 3: {
        ["RAINY", "Moderate low-level turbulence expected"]
    };

    case 4: {
        ["RAINY to STORMY", "Heavy low-level turbulence expected"]
    };

    case 5: {
        ["STORMY", "Severe low-level turbulence expected"]
    };

    default {
        ["UNKNOWN", "Turbulence forecast unavailable"]
    };
};

_forecastData params [
    "_condition",
    "_turbulenceText"
];

private _remainingTime = missionNamespace getVariable [
    "TS_weatherSystem_nextTransitionTime",
    0
];

private _timeLeft = round (_remainingTime - serverTime);
_timeLeft = _timeLeft max 0;

private _minutes = floor (_timeLeft / 60);
private _seconds = _timeLeft mod 60;

private _timeText = "";

if (_minutes > 0) then {
    _timeText = format ["%1m %2s", _minutes, _seconds];
} else {
    _timeText = format ["%1s", _seconds];
};

private _msg = format [
    "Forecasted weather: %1\nTurbulence: %2\nExpected in: %3",
    _condition,
    _turbulenceText,
    _timeText
];

player sideChat format ["AIR CONTROL:\n%1", _msg];