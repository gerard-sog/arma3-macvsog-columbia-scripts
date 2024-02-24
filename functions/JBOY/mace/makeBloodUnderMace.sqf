// ********************************************************
// Add some blood under swinging mace with victim
// ********************************************************
//makeBloodUnderMace =
params ["_unit","_dir","_trapPos"];
private _pos = asltoAGL eyePos _unit;
private _blood = createSimpleObject [selectRandom ["BloodSplatter_01_Large_New_F","BloodSplatter_01_Medium_New_F","BloodPool_01_Medium_New_F","BloodPool_01_Large_New_F"], [0,0,0]]; 
_blood setdir random 360;
_blood setVectorUp (surfaceNormal _pos);
_blood setPos _trapPos;
//sleep .5;
_pos = getPos _unit;
_pos = [_pos #0,_pos #1,0];
_blood = createSimpleObject [selectRandom ["BloodTrail_01_New_F","BloodTrail_01_New_F"], [0,0,0]]; 
// _blood = createSimpleObject [selectRandom ["BloodSplatter_01_Large_New_F","BloodSplatter_01_Medium_New_F","BloodPool_01_Medium_New_F","BloodPool_01_Large_New_F","BloodTrail_01_New_F","BloodTrail_01_New_F","BloodSpray_01_New_F"], [0,0,0]]; 
_blood setDir _dir;
_blood setVectorUp (surfaceNormal _pos);
_blood setPos _pos;


