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
	case "Chief SOG": {
		player setVariable ["hasUSface", true];
		player setUnitTrait ["vn_artillery", true, true];
	};
	case "Pilot": {
		player setVariable ["hasUSface", true];
	};
	case "1-0 Squad Leader": {
		player setVariable ["hasUSface", true];
	};
	case "1-1 RTO": {
		player setVariable ["hasUSface", true];
	};
	case "1-2 Medic": {
		player setVariable ["hasUSface", true];
	};
	case "0-1 Team Leader": {
		player setVariable ["canSpeak", ["en", "vn"]];
		player setVariable ["canClimb", true];
	};
	case "0-4 Point man": {
		player setVariable ["canSpeak", ["en", "vn"]];
		player setVariable ["canClimb", true];
	};
	default {
		player setVariable ["canSpeak", ["en", "vn"]];
	};
};