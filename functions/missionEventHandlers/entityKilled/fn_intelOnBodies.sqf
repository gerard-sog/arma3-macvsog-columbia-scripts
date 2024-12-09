/*
 * Add intel OPFOR units when killed.
 *
 * Arguments:
 * 0: killed OPFOR unit.
 *
 * Return values:
 * None
 */

params ["_killed"];

if (_killed isKindOf "O_Soldier_base_F") then {
    private _unit = _this select 0;
    private _items = items _unit;

    // Intel
    private _chanceOfUnitCarryingIntel = [1, 100] call BIS_fnc_randomNum;
    if (_chanceOfUnitCarryingIntel <= colsog_intel_chanceOfUnitCarryingIntel) then
    {
        private _chanceOfIntelFallingOnGround = [1, 100] call BIS_fnc_randomNum;
        if (_chanceOfIntelFallingOnGround <= colsog_intel_chanceOfIntelFallingOnGround) then
        {
            // Intel can be found on the ground.
            private _groundWeaponHolder = createVehicle ["groundweaponholder", getPosATL _unit, [], 1, "CAN_COLLIDE"];
            _groundWeaponHolder addItemCargoGlobal [colsog_intel_inventoryItem, 1];
        } else
        {
            // Intel can be found in the inventory of the unit.
            private _uniform = uniformContainer _unit;
            _uniform addItemCargoGlobal [colsog_intel_inventoryItem, 1];
        };
    };
};