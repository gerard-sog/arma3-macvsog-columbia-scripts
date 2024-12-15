/*
 * Control mace swinging
 *
 * Arguments:
 * 0: _mace
 * 1: _ropeTopObject
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [_mace, _ropeTopObject] execVM "functions\traps\swinging\colsog_fn_controlMaceSwing.sqf";
 *
 * Return values:
 * None
 *
 */

params ["_mace", "_ropeTopObject"];

if (!isServer) exitWith {};

// UGV drone makes a small noise while moving, so lets mask it with cool creaking noise.
private _sound = selectRandom [
	"a3\sounds_f\characters\movements\bush_004.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_1.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_2.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_3.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_4.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_5.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_6.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_7.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_8.wss",
	"a3\sounds_f\environment\sfx\tree_creaking\creacking_9.wss",
	"a3\sounds_f\characters\movements\bush_002.wss"
]; 

// When mace swings down and then up first time, set mass to 300.
// This will force it to drag on ground once which stabilizes goofy bouncing.
waitUntil {_mace distance2D _ropeTopObject < 1};
waitUntil {_mace distance2D _ropeTopObject > 2};
_mace setMass 300;

// Loop below plays groovy creaking sound on each swing, and will detect
// when mace hits ground first time, when it will set mace to 270
// thus allowing mace to lift off of ground and swing some more (hopefully more stable)

private _once = true;

// TO DO rewrite with CBA & conditions alive _mace
while {simulationEnabled _mace} do
{
	if (abs(speed _mace) > 1 or abs(velocity _mace #2)> .5) then
	{
		playSound3D [_sound,_mace, false, getPosASL _mace, .7]; // play sound to mask the ugv motor sound 
		if (getPos _mace #2 < .2 and _once) then
		{
			_mace setMass (270); // 300 mass will have mace drag on ground once to stabilize it, then here we raise back up with a lesser mass.
			_mace setVelocityModelSpace [0, 2, 0];
			_once = false; 
			uiSleep .2;
		}; 
	};
	uiSleep 2.5;
};

