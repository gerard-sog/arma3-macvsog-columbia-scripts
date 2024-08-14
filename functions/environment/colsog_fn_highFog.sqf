// By ALIAS, modified by Kay and then by Gerard.

params ["_highFogObject", "_mainColor"];

if (!hasInterface) exitWith {}; // only client-side

private _mainColorFade = +_mainColor;
_mainColor pushback 0;
_mainColorFade pushback 0.1;

while {alive _highFogObject} do
{
	waitUntil {sleep 1; player distance _highFogObject < 4000};
	private _reIterate = 0;
	while {(player distance _highFogObject < 4000) and (alive _highFogObject)} do
	{
		_fogHigh = "#particlesource" createVehicle getPosASL _highFogObject;
		_fogHigh setParticleCircle [0,[0,0,0]];
		_fogHigh setParticleRandom [0,[60+(random 100),60+(random 100),1+(random 4)],[0,0,0],0,0,[0,0,0,0],0,0];
		_fogHigh setParticleParams[["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 60, [0, 0, -35], [0, 0, 0], 13, 10, 7.843, 0,[20, 20, 25], [_mainColor, _mainColorFade, _mainColor], [0,0], 0, 0, "", "", _highFogObject];

		_fogHigh setDropInterval 0.001;
		sleep 0.1;
		deleteVehicle _fogHigh;
		_reIterate = _reIterate + 1;
		if (_reIterate==50) then {sleep 29; _reIterate = 0};
	};
};