// by ALIAS
// [_high_fog_obj, _maincolor] execvm "AL_localfog\high_fog.sqf";
//
// Modified for 1er RCC by Kay
//

params ["_high_fog_obj", "_maincolor"];

if (!hasInterface) exitWith {}; // only client-side

private _maincolorfade = +_maincolor;
_maincolor pushback 0;
_maincolorfade pushback 0.1;

while {alive _high_fog_obj} do
{
	waitUntil {sleep 1; player distance _high_fog_obj < 4000};
	private _re_iterate = 0;
	while {(player distance _high_fog_obj < 4000)and(alive _high_fog_obj)} do
	{
		_fog_high = "#particlesource" createVehicle getPosASL _high_fog_obj;
		_fog_high setParticleCircle [0,[0,0,0]];
		_fog_high setParticleRandom [0,[60+(random 100),60+(random 100),1+(random 4)],[0,0,0],0,0,[0,0,0,0],0,0];
		_fog_high setParticleParams[["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 60, [0, 0, -35], [0, 0, 0], 13, 10, 7.843, 0,[20, 20, 25], [_maincolor, _maincolorfade, _maincolor], [0,0], 0, 0, "", "", _high_fog_obj];
		//_fog_high setParticleParams[["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 60, [0, 0, -35], [0, 0, 0], 13, 10, 7.843, 0,[20, 20, 25], [[1,1,1,0],[1,1,1,0.1],[1,1,1,0]], [0,0], 0, 0, "", "", _high_fog_obj];

		_fog_high setDropInterval 0.001;
		sleep 0.1;
		deleteVehicle _fog_high;
		_re_iterate = _re_iterate + 1;
		if (_re_iterate==50) then {sleep 29; _re_iterate = 0};
	};
};