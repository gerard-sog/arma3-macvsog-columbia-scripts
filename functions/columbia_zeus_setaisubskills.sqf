/*
 * Custom Zeus module
 * Set AI sub-skills
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

zen_ai_skills = [
    Columbia_CBA_ai_enable,
    Columbia_CBA_ai_general_skill,
    Columbia_CBA_ai_aiming_accuracy,
    Columbia_CBA_ai_aiming_speed,
    Columbia_CBA_ai_aiming_shake,
    Columbia_CBA_ai_commanding,
    Columbia_CBA_ai_courage,
    Columbia_CBA_ai_spot_distance,
    Columbia_CBA_ai_spot_time,
    Columbia_CBA_ai_reload_speed,
    Columbia_CBA_ai_seek_cover,
    Columbia_CBA_ai_auto_combat,
    Columbia_CBA_ai_suppression
];

publicVariable "zen_ai_skills";

["", zen_ai_skills] call zen_ai_fnc_handleSkillsChange;