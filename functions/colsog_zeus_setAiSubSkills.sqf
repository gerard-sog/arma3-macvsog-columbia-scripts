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
    colsog_ai_enable,
    colsog_ai_generalSkill,
    colsog_ai_aimingAccuracy,
    colsog_ai_aimingSpeed,
    colsog_ai_aimingShake,
    colsog_ai_commanding,
    colsog_ai_courage,
    colsog_ai_spotDistance,
    colsog_ai_spotTime,
    colsog_ai_reloadSpeed,
    colsog_ai_seekCover,
    colsog_ai_autoCombat,
    colsog_ai_suppression
];

publicVariable "zen_ai_skills";

["", zen_ai_skills] call zen_ai_fnc_handleSkillsChange;