params ["_unit", "_heli"];

if !(isNil {_unit getVariable "TS_seatMonitorHandle"}) exitWith {};

private _monitor = [_unit, _heli] spawn {

    params ["_unit", "_heli"];

    while {
        alive _unit &&
        {vehicle _unit == _heli}
    } do {

        // Became pilot
        if (
            driver _heli == _unit &&
            {isNil {_unit getVariable "TS_handle"}}
        ) then {

            if (TS_debug_enabled) then {
                systemChat "[TS] Player became pilot";
            };

            private _handle =
                [_heli] spawn TS_fnc_startTurbulence;

            _unit setVariable [
                "TS_handle",
                _handle
            ];
        };

        // Left pilot seat
        if (
            driver _heli != _unit &&
            {!isNil {_unit getVariable "TS_handle"}}
        ) then {

            private _handle =
                _unit getVariable ["TS_handle", scriptNull];

            if !(isNull _handle) then {
                terminate _handle;
            };

            _unit setVariable [
                "TS_handle",
                nil
            ];

            if (TS_debug_enabled) then {
                systemChat "[TS] No longer pilot";
            };
        };

        sleep 0.5;
    };

    _unit setVariable [
        "TS_seatMonitorHandle",
        nil
    ];
};

_unit setVariable [
    "TS_seatMonitorHandle",
    _monitor
];