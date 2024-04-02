/*
 * Custom Zeus module
 * Add 2 SOG ACRE Racks on a plane
 * Radios Racks need to have been already initialized
 * (player has to enter the plane to first init ACRE Racks no dismount needed afterward) 
 *
 * Using acre_api_fnc_addRackToVehicle (need to be executed on server)
 * https://github.com/IDI-Systems/acre2/blob/master/addons/api/fnc_addRackToVehicle.sqf
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object (restricted to planes)
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

// If clicked object is not a plane exit
if ((isNull _object) OR !(_object isKindOf "Plane_Base_F")) exitWith {
    ["Select a plane!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

private _isRadioInitialized = _object getVariable "ColSOG_radioInitialized";

// If already initialized, exit
if !(isNil "_isRadioInitialized") exitWith {
    ["Radio already set on this object!", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
    playSound "FD_Start_F";
};

[_object, ["ACRE_VRC64", "HQ PRC77", "PRC77", false, ["inside"], [], "ACRE_PRC77", [], ["intercom_1"] ], false] remoteExec ["acre_api_fnc_addRackToVehicle", 2];
[_object, ["ACRE_VRC64", "Columbia PRC77", "PRC77", false, ["inside"], [], "ACRE_PRC77", [], ["intercom_1"] ], false] remoteExec ["acre_api_fnc_addRackToVehicle", 2];

_object setVariable ["ColSOG_radioInitialized", true, true];

systemChat "Radio PF77 initialized";