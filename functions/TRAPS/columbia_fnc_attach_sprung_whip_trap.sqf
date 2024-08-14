// *******************************************************
// Attach sprung whip trap punji object to object.  
// To see the sprung trap stakes you have to animateSource the object first.
// *******************************************************
params ["_object", "_attachPosition", "_vectorUp", "_scale"];
private _trap = createVehicle ["vn_mine_punji_02_ammo", [0, 2, 0], [], 0, "CAN_COLLIDE"];
private _modelInformation = getModelInfo _trap;
private _filePath = format["%1%2", (_modelInformation#1) select [0, count (_modelInformation#1) - 4], "_ammo.p3d"];
private _punji = createSimpleObject [_filePath, [0, 0, 0]];
_punji animateSource ["mine_trigger_source", 1]; 
deleteVehicle _trap; 
_punji attachTo [_object, _attachPosition];
_punji setVectorUp _vectorUp;
_punji setObjectScale _scale;