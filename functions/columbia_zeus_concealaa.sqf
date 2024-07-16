params [["_pos", [0,0,0] , [[]], 3], ["_staticweapondobj", objNull, [objNull]]];

// if param is empty or not a static weapon, exit
if (isNull _staticweapondobj || !(_staticweapondobj isKindOf "StaticWeapon")) exitWith {
	["Need a static weapon", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _isconcealed = _staticweapondobj getVariable ["COLSOG_concealed", false];

// Conceal static weapon and make AI unable to fire.
if !(_isconcealed) then {
	["Hiding AA gun", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;

	// Hiding static weapon
	private _staticweaponpos = _staticweapondobj getRelPos [0, 0];
    private _shelter = createSimpleObject ["Land_vn_o_shelter_01", _staticweaponpos];
    _shelter setPos [_staticweaponpos select 0, _staticweaponpos select 1, 1];

    _staticweapondobj setVariable ["COLSOG_concealed", true, true];
    _staticweapondobj setVariable ["COLSOG_shelter", _shelter, true];

} else {
    // ELSE already concealed, remove concealment and make AI able to fire.
    private _shelter = _staticweapondobj getVariable "COLSOG_shelter";
    deleteVehicle _shelter;
    _staticweapondobj setVariable ["COLSOG_concealed", false, true];
};