/*
 * Custom Zeus module
 * Set AI sub-skills
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

if (!isServer) exitWith {};

zen_ai_skills = [
    true,   // enable
    0.33,   // general
    0.33,   // aiming accuracy
    0.33,   // aiming speed
    0.33,   // aiming shake
    0.33,   // commanding
    0.33,   // courage
    0.10,   // spot distance
    0.10,   // spot time
    0.33,   // reload speed
    true,   // seek cover
    true,   // auto combat
    true    // suppression
];

publicVariable "zen_ai_skills";

["", zen_ai_skills] call zen_fnc_ai_handleSkillsChange;