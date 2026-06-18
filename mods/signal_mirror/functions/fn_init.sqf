if (!hasInterface) exitWith {};

["weapon", {
    params ["_unit", "_weapon"];

    if (_weapon == "vn_ak_01") then {
        [_unit] call SM_fnc_startAirScanner;
    };
}, true] call CBA_fnc_addPlayerEventHandler;