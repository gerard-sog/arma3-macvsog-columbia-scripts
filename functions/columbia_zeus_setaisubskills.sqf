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
    Columbia_ai_enable,
    Columbia_ai_general_skill,
    Columbia_ai_aiming_accuracy,
    Columbia_ai_aiming_speed,
    Columbia_ai_aiming_shake,
    Columbia_ai_commanding,
    Columbia_ai_courage,
    Columbia_ai_spot_distance,
    Columbia_ai_spot_time,
    Columbia_ai_reload_speed,
    Columbia_ai_seek_cover,
    Columbia_ai_auto_combat,
    Columbia_ai_suppression
];

publicVariable "zen_ai_skills";

["", zen_ai_skills] call zen_ai_fnc_handleSkillsChange;