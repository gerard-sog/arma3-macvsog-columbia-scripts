/*
 * Set all variable on player
 * (most are local use only, no broadcast)
 * Executed locally when player joins mission (includes both mission start and JIP)
 *
 */

 switch ((roleDescription player splitString "@") select 0) do {
	case "1-0 Squad Leader": {
		player setVariable ["hasUSface", true];
	};
	case "1-1 RTO": {
		player setVariable ["hasUSface", true];
	};
	case "1-2 Medic": {
		player setVariable ["hasUSface", true];
	};
	case "Pilot": {
		player setVariable ["hasUSface", true];
	};
	case "Chief SOG": {
		player setVariable ["hasUSface", true];
		player setVariable ["f_languages",["en", "vn"]];
	};
	case "Pointman": {
		player setVariable ["f_languages",["en", "vn"]];
		player setVariable ["canClimb", true];
	};
	default : {
		player setVariable ["f_languages",["en", "vn"]];
	};
}