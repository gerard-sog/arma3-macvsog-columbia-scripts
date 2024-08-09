// ********************************************************
// Victim drops weapon (create a physics enabled weapon holder for his currentWeapon)
// ********************************************************
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
	uiSleep .1;
	private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0]; 
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
	uiSleep .1;
	private _weaponHolderV = "WeaponHolderSimulated" createVehicle [0,0,0]; 
	_unit removeWeapon (secondaryWeapon _unit);
	_weaponHolderV addWeaponCargoGlobal [_weaponV,1];  
	_weaponHolderV addMagazineCargoGlobal [_mag,1];
	_weaponHolderV setPos (_unit modelToWorld [0,.2,1.2]);  
	_weaponHolderV disableCollisionWith _unit;  
	private _dir = random(360);  
	private _speed = 1.5;  
	_weaponHolderV setVelocity [_speed * sin(_dir), _speed * cos(_dir),8]; 
};

