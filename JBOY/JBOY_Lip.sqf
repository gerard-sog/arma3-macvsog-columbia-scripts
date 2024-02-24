// ***********************************************************************************
// JBOY_Lip.sqf
// Do random lip for X seconds
// Compile in init.sqf:    JBOY_Lip =  compile preprocessFileLineNumbers "Scripts\JBOY_Lip.sqf";
// Call:                   _n = [dude, 3] call JBOY_Lip;
// ***********************************************************************************
params["_speaker","_seconds"];

_n = [_speaker,_seconds] spawn
{
    params["_speaker","_seconds"];
    _speaker setRandomLip true;
    sleep _seconds;
    _speaker setRandomLip false;
};