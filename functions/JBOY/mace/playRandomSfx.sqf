// ********************************************************
// play sound fx from a collection of similar named sounds.
// ********************************************************
//playRandomSfx =
params ["_unit","_path","_suffixArray","_ext",["_volume",1],["_lip",false]];

//if (_lip) then {[_unit, 1] call JBOY_Lip;};
private _sound = _path + selectRandom _suffixArray + _ext;
private _pitch = 1;
if (_unit isKindOf "Man") then {_pitch = pitch _unit;};
playSound3D [_sound,_unit, false, getPosASL _unit, _volume, _pitch, 0];

