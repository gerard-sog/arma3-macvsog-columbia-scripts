/*
 * Create intel document in/near the unit's corpse.
 */

if (!isServer) exitWith {};

[
    "O_Soldier_base_F",
    "Killed",
    {
        params ["_unit"];
        [
            {
                params ["_unit"];

                private _chanceOfUnitCarryingIntel = [1, 100] call BIS_fnc_randomNum;
                if (_chanceOfUnitCarryingIntel <= colsog_intel_chanceOfUnitCarryingIntel) then
                {
                    private _chanceOfIntelFallingOnGround = [1, 100] call BIS_fnc_randomNum;
                    if (_chanceOfIntelFallingOnGround <= colsog_intel_chanceOfIntelFallingOnGround) then
                    {
                        // Intel can be found on the ground.
                        private _groundWeaponHolder = createVehicle ["groundweaponholder", getPosATL _unit, [], 1, "CAN_COLLIDE"];
                        _groundWeaponHolder addMagazineCargo [colsog_intel_inventoryItem, 1];
                    } else
                    {
                        // Intel can be found in the inventory of the unit.
                        _unit addMagazine colsog_intel_inventoryItem;
                    };
                };
            }, [_unit]
        ] call CBA_fnc_execNextFrame;
    }, true, [], true
] call CBA_fnc_addClassEventHandler;
