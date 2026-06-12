if (!TS_weather_system_enabled) exitWith {
    hintSilent parseText (
        "<t size='1.2' color='#B8D8FF'>AIR CONTROL</t><br/><br/>" +
        "<t color='#FFFFFF'>Dynamic weather system is currently disabled.</t><br/>" +
        "<t color='#D6D6D6'>No forecast is available.</t>"
    );
};

private _nextPreset = missionNamespace getVariable ["TS_weatherSystem_nextPreset", -1];

if (_nextPreset < 0) exitWith {
    hintSilent parseText "<t size='1.2' color='#B8D8FF'>AIR CONTROL</t><br/><br/><t color='#FFFFFF'>No weather forecast is currently available.</t>";
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

private _timeLeft = round (_remainingTime - CBA_missionTime);
_timeLeft = _timeLeft max 0;

private _minutes = floor (_timeLeft / 60);
private _seconds = _timeLeft mod 60;

private _timeText = "";

if (_minutes > 0) then {
    _timeText = format ["%1m %2s", _minutes, _seconds];
} else {
    _timeText = format ["%1s", _seconds];
};

private _turbulenceColor = "#66CCFF";

switch (_nextPreset) do {
    case 0: {
        _turbulenceColor = "#66CCFF";
    };

    case 1: {
        _turbulenceColor = "#66CCFF";
    };

    case 2: {
        _turbulenceColor = "#FFFF66";
    };

    case 3: {
        _turbulenceColor = "#FFA500";
    };

    case 4: {
        _turbulenceColor = "#FF6600";
    };

    case 5: {
        _turbulenceColor = "#FF3333";
    };
};

private _msg = format [
    "<t size='1.2' color='#B8D8FF'>AIR CONTROL</t><br/><br/>" +
    "<t color='#FFFFFF'>Forecasted weather:</t> <t color='#D6D6D6'>%1</t><br/>" +
    "<t color='#FFFFFF'>Turbulence:</t> <t color='%2'>%3</t><br/>" +
    "<t color='#FFFFFF'>Expected in:</t> <t color='#90EE90'>%4</t>",
    _condition,
    _turbulenceColor,
    _turbulenceText,
    _timeText
];

hintSilent parseText _msg;