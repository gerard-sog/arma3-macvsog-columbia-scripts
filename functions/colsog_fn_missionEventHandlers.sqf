if !(isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {};

if (!isServer) exitWith {};

addMissionEventHandler ["EntityKilled", {
	params ["_killed"];

    [_killed] execVM "functions\missionEventHandlers\entityKilled\fn_firstAidConvertAce.sqf";
    [_killed] execVM "functions\missionEventHandlers\entityKilled\fn_intelOnBodies.sqf";
}];