params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

// If module click into void, exit
if (isNull _unit) exitWith {
    ["Select an object!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

private _isRadioInitialized = _unit getVariable "radioInitialized";

// If already initialized, exit
if !(isNil "_isRadioInitialized") exitWith {
    ["Radio already set!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

// If object not a plane, exit
if !(_unit isKindOf "Plane_Base_F") exitWith {
    ["Select a plane!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

// Adding first rack with PRC77
Columbia_fnc_addRack = {
    params ["_plane"];
    [_plane, [
        "ACRE_VRC64",
        "1-Rack PRC77",
        "1-Rack PRC77",
        false,
        ["inside"],
        [],
        "ACRE_PRC77",
        [],
        []
    ], false] call acre_api_fnc_addRackToVehicle;
};

["zen_common_execute", [Columbia_fnc_addRack, [_unit]]] call CBA_fnc_serverEvent;

// Adding second rack with PRC77
Columbia_fnc_addRack2 = {
    params ["_plane"];
    [_plane, [
        "ACRE_VRC64",
        "2-Rack PRC77",
        "2-Rack PRC77",
        false,
        ["inside"],
        [],
        "ACRE_PRC77",
        [],
        []
    ], false] call acre_api_fnc_addRackToVehicle;
};

["zen_common_execute", [Columbia_fnc_addRack2, [_unit]]] call CBA_fnc_serverEvent;

_unit setVariable ["radioInitialized", true, true];
systemChat "Radio PF77 initialized"