/*
 *  Attach sprung whip trap punji object to mace
 *
 * Arguments:
 * 0: _object
 * 1: _attachPosition
 * 2: _vectorUp
 * 3: _scale
 *
 * Locality:
 * Execute only on server
 *
 * Example:
 * [_mace, [0.55,0,0.03], [0.999972,-1.70678e-006,-0.0075168], 1.55] execVM "functions\traps\colsog_fn_attachSprungWhipTrap.sqf";
 *
 * Return values:
 * None
 *
 */

// *******************************************************
// To see the sprung trap stakes you have to animateSource the object first.
// *******************************************************
params ["_object", "_attachPosition", "_vectorUp", "_scale"];
if (!isServer) exitWith {}; // safety

private _trap = createVehicle ["vn_mine_punji_02_ammo", [0, 2, 0], [], 0, "CAN_COLLIDE"]; // really needed to create this object ? cant we use a fixed _filePath ?
private _modelInformation = getModelInfo _trap;
private _filePath = format["%1%2", (_modelInformation#1) select [0, count (_modelInformation#1) - 4], "_ammo.p3d"];
private _punji = createSimpleObject [_filePath, [0, 0, 0]];
_punji animateSource ["mine_trigger_source", 1]; 
deleteVehicle _trap; 
_punji attachTo [_object, _attachPosition];
_punji setVectorUp _vectorUp;
_punji setObjectScale _scale;