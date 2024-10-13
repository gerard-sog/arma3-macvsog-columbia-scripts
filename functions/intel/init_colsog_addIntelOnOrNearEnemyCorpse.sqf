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
                        // private _groundWeaponHolder = "groundweaponholder" createVehicle getpos _unit;
                        private _groundWeaponHolder = createVehicle ["groundweaponholder", getPosATL _unit, [], 1, "CAN_COLLIDE"];
                        _groundWeaponHolder addMagazineCargo [colsog_intel_inventoryItem, 1];

                        systemChat "+ intel -> ground."
                    } else
                    {
                        // grab the old unit (corpse)
                        _oldUnit = _unit select 0;

                        // determine which containers the unit has
                        _uniform = uniformContainer _oldUnit;
                        _vest = vestContainer _oldUnit;
                        _backpack = backpackContainer _oldUnit;

                        _possibleContainers = [_uniform, _vest, _backpack];

                        // check each container to see if it a) exists, and b) has space
                        {
                            if ( !(isNull _x) ) then {
                                if ( _x canAdd [colsog_intel_inventoryItem, 1] ) exitWith {
                                    _x addMagazineCargoGlobal [colsog_intel_inventoryItem, 1];
                                    systemChat "+ intel -> inventory."
                                };
                            };
                        } foreach _possibleContainers;
                    };
                };
            }, [_unit]
        ] call CBA_fnc_execNextFrame;
    }, true, [], true
] call CBA_fnc_addClassEventHandler;

[1, 100] call BIS_fnc_randomNum;