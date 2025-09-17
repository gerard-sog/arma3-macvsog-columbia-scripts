/*
 * Set all variables on player
 * (most are local use only, no broadcast)
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 * Called again when player respawn
 *
 */

if (!hasInterface) exitWith {};

switch ((roleDescription player splitString "@") select 0) do {
    // HQ
    case "Chief SOG": {
        player setVariable ["hasUsface", true];
        player setUnitTrait ["vn_artillery", true, true];
        player setVariable ["canReadIntel", true];
        player setVariable ["canUseSimplex", true];
        player setVariable ["canMonitorSensor", true];
    };

    // Pilots
    case "Pilot": {
        player setVariable ["hasUsface", true];
        player setVariable ["canMonitorSensor", true];
        player setVariable ["canUseSimplex", true];
    };

    // Columbia
    case "0-1 Tail Gunner": {
        player setVariable ["canSpeak", ["en", "vn"]];
        player setVariable ["canClimb", true];
        player setVariable ["canReadIntel", true];
        player setVariable ["visibleFootprint", true];
    };
    case "0-2 Machine Gunner": {
        player setVariable ["canSpeak", ["en", "vn"]];
        player setVariable ["canReadIntel", true];
        player setVariable ["visibleFootprint", true];
    };
    case "0-3 Grenadier": {
        player setVariable ["canSpeak", ["en", "vn"]];
        player setVariable ["canReadIntel", true];
        player setVariable ["visibleFootprint", true];
    };
    case "0-4 Point man": {
        player setVariable ["canSpeak", ["en", "vn"]];
        player setVariable ["canClimb", true];
        player setVariable ["canReadIntel", true];
        player setVariable ["visibleFootprint", true];
    };
    case "1-0 Squad Leader": {
        player setVariable ["hasUsface", true];
        player setVariable ["visibleFootprint", true];
    };
    case "1-1 RTO": {
        player setVariable ["hasUsface", true];
        player setVariable ["visibleFootprint", true];
    };
    case "1-2 Medic": {
        player setVariable ["hasUsface", true];
        player setVariable ["visibleFootprint", true];
    };

    // Opfor
    case "Tracker": {
        player setVariable ["canSpeak", ["vn"]];
    };

    // Reserves
    default {
        player setVariable ["canSpeak",["en", "vn"]];
        player setVariable ["visibleFootprint", true];
    };
};

// if covertops flag is set, all players will have vietnamese faces
if(colsog_faces_iscovertops) then {
    player setVariable ["hasUsface", false];
};