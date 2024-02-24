// ********************************************************
// Spring the trap when the trap's trigger is fired.
// ********************************************************
// monitorMaceTrap =
params ["_trapProxy","_mace","_rope1","_ropeTopObj","_maceSphere","_trigger"];
private _trapPos = getPos _trapProxy;
private _trapDir = getDir _trapProxy;

waitUntil {triggerActivated _trigger or (_trapProxy getVariable ["JBOY_springTrap",false])}; 
private _unit = nearestObject [_trapPos,'Man'];
// _sound = "vn\sounds_f_vietnam\traps\punji_activate.ogg";
// playSound3D [_sound,_trapProxy, false, getPosASL _trapProxy, 1.5];
playSound3D ["a3\sounds_f\air\sfx\sl_rope_break.wss",_trapProxy, false, _trapProxy, 4];
deleteVehicle _trapProxy;
// *******************************************************
// Delete cosmetic rope and attach swing rope.  Then detach mace from original position to start the swing
// *******************************************************
deleteVehicle _rope1; 
_mace enableSimulation true;
// _ropeTopObj enableSimulation true; // Do NOT enable simulation on top UAV because that makes it bounce like crazy

private _rope2 = ropeCreate [_mace, [0,0,.1],_ropeTopObj, [0,0,-.5],_mace distance _ropeTopObj]; 
//rope2 = _rope2;
detach _mace; 
_maceSphere attachTo [_mace,[0,0,0]]; 
//_mace  setSpeaker "NoVoice";
private _dirTo = ([_maceSphere, _ropeTopObj] call BIS_fnc_dirTo);  
_mace setDir _dirTo;

// *******************************************************
// stablilizes mace swing and plays creaking noise
// *******************************************************
[_mace,_ropeTopObj] spawn JBOY_controlMaceSwing;
// *******************************************************
// Units react to springing of trap
// *******************************************************
sleep 1.5;
[_unit,_mace] spawn JBOY_initialReactionToMace;
private _group = group _unit;

// *******************************************************
// sound FX and accelerate swing when mace lower (waiting so it won't just piledrive into the ground)
// *******************************************************
_sound = "a3\sounds_f\characters\movements\bush_004.wss";
playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
//playSound3D ["a3\sounds_f\characters\movements\bush_004.wss",_mace]; 
waitUntil {_mace distance2D _trapPos < 3};
playSound3D [_sound,_mace, false, getPosASL _mace, 3.5];
// _mace setVelocity ([velocity mace #0, velocity mace #1,0]);
// _mace setVelocityModelSpace [0,10,0];
// *******************************************************
// Deal with victims of mace
// *******************************************************
[_unit,_mace, _trapDir, _trapPos] spawn JBOY_maceVictims;
sleep 1;
_group setBehaviour "AWARE";

// *******************************************************
// After initial swing make mace heavier so hangs closer to the ground (to counter retarded rope elasticity...argggh!!!).
// *******************************************************
sleep 2;
sleep 1;
// _mace setVectorUp surfaceNormal getPosWorld mace; 
// _mace setVelocity ([velocity mace #0, velocity mace #1,0]);
//_mace setMass 220; // 170
private _future = time + 10;
waitUntil {!alive _unit or _trapPos distance _unit > 3 or !(vehicle _unit == _unit) or time > _future};
if (_trapPos distance _unit > 3 or !(vehicle _unit == _unit)) then 
{
	if (alive _unit and !isPlayer _unit) then 
	{
		_unit doMove (_unit modelToWorld [0,9,0]); 
		_unit setSpeedMode "FULL"; 
		_unit forcespeed -1;
		// if (stance _unit == "PRONE") then
		// {
			// [_unit, selectRandom ["EvasiveLeft","EvasiveRight"]] remoteExec ["playActionNow"]; 
		// } else
		// {
			[_unit, "FastF"] remoteExec ["playActionNow"];
		// };
		// if !(face _unit find "Asian" >= 0) then  // Say an english phrase
		// {
			[_unit, selectRandom ["KeepFocused","StayAlert"]] call JBOY_Speak;  
		//};
		sleep 2;
		_unit setUnitPOS "DOWN"; 
		sleep 2; 
		group _unit setBehaviour "AWARE";
		//_unit setUnitPOS "AUTO";
		{_x forceSpeed 0;} forEach units _group;
	};
};
[_mace] spawn JBOY_endMaceSwinging;

