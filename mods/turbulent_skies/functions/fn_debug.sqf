/*
    Turbulent Skies
    Debug helper.
*/

params [
    ["_message", "", [""]]
];

if (missionNamespace getVariable ["TS_debug_enabled", false]) then {
    systemChat format ["[TS] %1", _message];
};
