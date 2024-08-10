// ********************************************************
// Attach sprung whip trap punji object to object.  
// To see the sprung trap stakes you have to animateSource the object first.
// ********************************************************
params ["_obj","_attachPos","_vectorUp","_scale"];
private _trap = createVehicle ["vn_mine_punji_02_ammo", [0,2,0], [], 0, "CAN_COLLIDE"]; 
private _model_info = getModelInfo _trap; 
private _file_path = format["%1%2",(_model_info#1) select [0, count (_model_info#1) - 4], "_ammo.p3d"]; 
private _punji = createSimpleObject [_file_path, [0,0,0]]; 
_punji animateSource ["mine_trigger_source", 1]; 
deleteVehicle _trap; 
_punji attachTo [_obj,_attachPos];
_punji setVectorUp _vectorUp;
_punji setObjectScale _scale;