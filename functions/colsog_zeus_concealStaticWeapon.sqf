params [["_pos", [0,0,0] , [[]], 3], ["_staticWeaponObject", objNull, [objNull]]];

// if param is empty or not a static weapon, exit.
if (isNull _staticWeaponObject || !(_staticWeaponObject isKindOf "StaticWeapon")) exitWith {
	["Need a static weapon", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _isConcealed = _staticWeaponObject getVariable ["COLSOG_concealed", false];

if !(_isConcealed) then {
	["Hiding AA gun", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;

	private _staticWeaponPosition = _staticWeaponObject getRelPos [0, 0];

    // Make AI unable to fire.
    _staticWeaponObject setCombatMode "BLUE";
    [_staticWeaponObject, "ALL"] remoteExec ["disableAI", _staticWeaponObject];

    // Remove ammo to avoid AI shooting last bullet.
    _staticWeaponObject setVehicleAmmoDef 0;
    uiSleep 1;

	// Conceal static weapon.
    private _shelter = createSimpleObject ["Land_vn_o_shelter_01", _staticWeaponPosition];
    _shelter setPos [_staticWeaponPosition select 0, _staticWeaponPosition select 1, 1.4];

    _staticWeaponObject setVariable ["COLSOG_concealed", true, true];
    _staticWeaponObject setVariable ["COLSOG_shelter", _shelter, true];

} else {
    // Remove concealment.
    private _shelter = _staticWeaponObject getVariable "COLSOG_shelter";
    deleteVehicle _shelter;
    _staticWeaponObject setVariable ["COLSOG_concealed", false, true];

    uiSleep 1;
    _staticWeaponObject setVehicleAmmoDef 1;

    // Make AI able to fire.
    _staticWeaponObject setCombatMode "YELLOW";
    [_staticWeaponObject, "ALL"] remoteExec ["enableAI", _staticWeaponObject];
};