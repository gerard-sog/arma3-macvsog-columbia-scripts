// JBOY_BreatheSfx
// Purpose:         Have unit say one of the loud ingame pain grunts
// Precompile:      JBOY_PainGrunt =  compile preprocessFileLineNumbers "Scripts\JBOY_PainGrunt.sqf";
// Credits:         Bohemia Interactive, and Greenfist and Gunter Severloh for finding path to the sounds.
//                  
// Example call:   [player] call JBOY_BreatheSfx;
params["_unit",["_volume",1]];
// _n = [_unit] = spawn
// {
    // params["_unit"];
	[_unit, .5] call JBOY_Lip;
    _s = selectRandom [
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Low_1.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Low_2.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Low_3.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Low_4.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Low_5.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Mid_1.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Mid_2.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Mid_3.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Mid_4.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Mid_5.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Max_1.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Max_2.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Max_3.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Max_4.wss",
			"A3\sounds_f\characters\human-sfx\P15\Soundbreathinjured_Max_5.wss",
			
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Low_1.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Low_2.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Low_3.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Low_4.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Low_5.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Mid_1.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Mid_2.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Mid_3.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Mid_4.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Mid_5.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Max_1.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Max_2.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Max_3.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Max_4.wss",
			"A3\sounds_f\characters\human-sfx\P16\Soundbreathinjured_Max_5.wss",
			
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Low_1.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Low_2.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Low_3.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Low_4.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Low_5.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Mid_1.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Mid_2.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Mid_3.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Mid_4.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Mid_5.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Max_1.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Max_2.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Max_3.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Max_4.wss",
			"A3\sounds_f\characters\human-sfx\P17\Soundbreathinjured_Max_5.wss",
			
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Low_1.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Low_2.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Low_3.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Low_4.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Low_5.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Mid_1.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Mid_2.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Mid_3.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Mid_4.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Mid_5.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Max_1.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Max_2.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Max_3.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Max_4.wss",
			"A3\sounds_f\characters\human-sfx\P18\Soundbreathinjured_Max_5.wss"];
    playSound3D [_s,_unit, false, getPosASL _unit, _volume, pitch _unit, 0];
//};