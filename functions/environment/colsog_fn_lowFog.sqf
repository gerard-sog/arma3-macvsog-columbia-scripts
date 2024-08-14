// By ALIAS, modified by Kay and then by Gerard.

params ["_lowFogObject", "_mainColor"];

if (!hasInterface) exitWith {}; // only client-side

// NOTE: need to lower alpha for colors different than pure white
private _mainColorFade = +_mainColor;
_mainColor pushback 0;
_mainColorFade pushback 0.3;

while {alive _lowFogObject} do
{
	waitUntil {sleep 2; player distance _lowFogObject < 2000}; // no need to check that every sec, 2k seems very distant
	private _reIterate = 0;

	while {(player distance _lowFogObject < 2000) AND (alive _lowFogObject)} do
	{
		_fogLow = "#particlesource" createVehicle getPosASL _lowFogObject;
		_fogLow setParticleCircle [0, [0, 0, 0]];
		_fogLow setParticleRandom [0, [20 + (random 30), 20 + (random 30), -1], [0 , 0, 0], 3, 0, [0, 0, 0, 0.3], 0, 0];

		_fogLow setParticleParams[["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 60, [0, 0, -2], [0, 0, 0], 13, 10, 7.843, 0.005, [5, 5, 5], [_mainColor, _mainColorFade, _mainColor], [0, 0], 0, 0, "", "", _lowFogObject];

		_fogLow setDropInterval 0.001;
		sleep 0.1;
		deleteVehicle _fogLow;
		_reIterate = _reIterate + 1;
		if (_reIterate == 50) then {sleep 30; _reIterate = 0};
	};
};