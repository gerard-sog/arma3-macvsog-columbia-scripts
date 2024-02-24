// ********************************************************
// Victim drops weapon (create a physics enabled weapon holder for his currentWeapon)
// ********************************************************
//unitDropsWeapon =
params ["_unit"];
private _dropLauncher = false;
if (!(currentWeapon _unit == "") and !(currentWeapon _unit == secondaryWeapon _unit) and !(secondaryWeapon _unit == "")) then
{
	_dropLauncher = true;
};
if !(currentWeapon _unit == "") then
{
	private _weaponV = currentWeapon _unit;         
	private _mag = currentMagazine _unit;
	sleep .1;  
	private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0]; 
	//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
	_unit removeWeapon (currentWeapon _unit);  
	_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
	_weaponHolderV addMagazineCargoGlobal [_mag,1];
	_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
	_weaponHolderV disableCollisionWith _unit;  
	private _dir = random(360);  
	private _speed = 1.5;  
	_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
};
if (_dropLauncher) then
{
	private _weaponV = secondaryWeapon _unit;         
	private _mag = currentMagazine _unit;
	sleep .1;  
	private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0]; 
	//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
	_unit removeWeapon (secondaryWeapon _unit);  
	_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
	_weaponHolderV addMagazineCargoGlobal [_mag,1];
	_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
	_weaponHolderV disableCollisionWith _unit;  
	private _dir = random(360);  
	private _speed = 1.5;  
	_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
};
/* 	if !(headGear _unit == "") then
{
	private _headGear = headGear _unit;         
	sleep .1;  
	private _weaponHolderB = "WeaponHolderSimulated" createVehicle [0,0,0]; 
	//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
	removeHeadgear _unit;  
	_weaponHolderB addItemCargoGlobal [_headGear,1];
	_weaponHolderB setPos (_unit modelToWorld [0,.2,1.2]);  
	_weaponHolderB disableCollisionWith _unit;  
	private _dir = random(360);  
	private _speed = 1.5;  
	_weaponHolderB setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
	_weaponHolderB addTorque [random 0.02, random 0.02, random 0.02];
};
if !(goggles _unit == "") then
{
	private _goggles = goggles _unit;         
	sleep .1;  
	private _weaponHolderC = "WeaponHolderSimulated" createVehicle [0,0,0]; 
	//_unit action ["DropWeapon", _weaponHolderV, currentWeapon _unit]; // doesn't work on dead unit
	removeGoggles _unit;  
	_weaponHolderC addItemCargoGlobal [_goggles,1];
	_weaponHolderC setPos (_unit modelToWorld [0,.2,1.2]);  
	_weaponHolderC disableCollisionWith _unit;  
	private _dir = random(360);  
	private _speed = 1.5;  
	_weaponHolderC setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
	_weaponHolderC addTorque [random 0.02, random 0.02, random 0.02];
}; */

