if (!hasInterface) exitWith {};

["weapon", {
    params ["_unit", "_weapon"];

    if (_weapon == "vn_m19_binocs_grn") then {
        [_unit] call SM_fnc_startAirScanner;
    };
}, true] call CBA_fnc_addPlayerEventHandler;