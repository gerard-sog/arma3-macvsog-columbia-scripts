// JBOY_PainSfx
// Purpose:         Have unit say one of the loud ingame pain grunts
// Precompile:      JBOY_PainSfx =  compile preprocessFileLineNumbers "JBOY\JBOY_PainSfx.sqf";
// Credits:         Bohemia Interactive, and Greenfist and Gunter Severloh for finding path to the sounds.
//                  
// Example call:   [player] call JBOY_BreatheSfx;
params["_unit",["_volume",1]];
// _n = [_unit] = spawn
// {
    // params["_unit"];
	[_unit, 1] call JBOY_Lip;
    _s = selectRandom [
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_01.wss",
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_02.wss",
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_03.wss",
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_04.wss",
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_05.wss",
			"a3\sounds_f_orange\missionsfx\pastambiences\idaphospitaltent\orange_idaphospitaltent_pain_06.wss"
		];
    playSound3D [_s,_unit, false, getPosASL _unit, _volume, pitch _unit, 0];
//};