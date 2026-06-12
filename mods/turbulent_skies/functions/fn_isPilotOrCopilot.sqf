params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {
    false
};

private _vehicle = vehicle _unit;

if (_vehicle isEqualTo _unit) exitWith {
    false
};

if !(_vehicle isKindOf "Helicopter") exitWith {
    false
};

(
    (driver _vehicle isEqualTo _unit)
    ||
    (effectiveCommander _vehicle isEqualTo _unit)
    ||
    (currentPilot _vehicle isEqualTo _unit)
)