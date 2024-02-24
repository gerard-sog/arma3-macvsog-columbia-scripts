// JBOY_PainGrunt
// Purpose:         Have unit say one of the loud ingame pain grunts
// Precompile:      JBOY_PainGrunt =  compile preprocessFileLineNumbers "Scripts\JBOY_PainGrunt.sqf";
// Credits:         Bohemia Interactive, and Greenfist and Gunter Severloh for finding path to the sounds.
//                  
// Example call:   [player] call JBOY_PainGrunt;
params["_unit"];
// _n = [_unit] = spawn
// {
    // params["_unit"];
	[_unit, .5] call JBOY_Lip;
    playSound3D [selectRandom [
        "a3\sounds_f\characters\human-sfx\P07\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P08\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P09\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P10\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P11\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P12\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P13\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P14\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P15\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P16\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P17\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P18\Hit_Max_3.wss",
        "a3\sounds_f\characters\human-sfx\P04\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P05\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P06\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P07\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P08\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P09\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P10\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P11\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P12\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P13\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P14\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P15\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P16\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P17\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P18\Hit_Max_4.wss",
        "a3\sounds_f\characters\human-sfx\P04\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P05\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P06\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P07\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P08\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P09\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P10\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P11\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P12\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P13\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P14\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P15\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P16\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P17\Hit_Max_5.wss",
        "a3\sounds_f\characters\human-sfx\P18\Hit_Max_5.wss"],_unit];
//};