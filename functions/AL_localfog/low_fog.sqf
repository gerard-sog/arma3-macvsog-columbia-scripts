// by ALIAS
// [_low_fog_obj, _maincolor] execvm "AL_localfog\low_fog.sqf";
//
// Modified for 1er RCC by Kay
//

params ["_low_fog_obj", "_maincolor"];

if (!hasInterface) exitWith {}; // only client-side

// NOTE: need to lower alpha for colors different than pure white
// todo: experiment with _re_iterate, slider for Z position -2/+2, size, random velocity

private _maincolorfade = +_maincolor;
_maincolor pushback 0;
_maincolorfade pushback 0.3;

while {alive _low_fog_obj} do
{
	waitUntil {sleep 2; player distance _low_fog_obj < 2000}; // no need to check that every sec, 2k seems very distant
	private _re_iterate = 0;

	while {(player distance _low_fog_obj < 2000) AND (alive _low_fog_obj)} do
	{
		_fog_low = "#particlesource" createVehicle getPosASL _low_fog_obj;
		_fog_low setParticleCircle [0, [0, 0, 0]];
		_fog_low setParticleRandom [0, [20 + (random 30), 20 + (random 30), -1], [0 , 0, 0], 3, 0, [0, 0, 0, 0.3], 0, 0];

		_fog_low setParticleParams[["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 60, [0, 0, -2], [0, 0, 0], 13, 10, 7.843, 0.005, [5, 5, 5], [_maincolor, _maincolorfade, _maincolor], [0, 0], 0, 0, "", "", _low_fog_obj];
		//_fog_low setParticleParams[["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 60, [0, 0, -2], [0, 0, 0], 13, 10, 7.843, 0.005, [5, 5, 5], [[1, 1, 1, 0], [1, 1, 1, 0.3], [1, 1, 1, 0]], [0, 0], 0, 0, "", "", _low_fog_obj];

		_fog_low setDropInterval 0.001;
		sleep 0.1;
		deleteVehicle _fog_low;
		_re_iterate = _re_iterate + 1;
		if (_re_iterate == 50) then {sleep 30; _re_iterate = 0};
	};
};