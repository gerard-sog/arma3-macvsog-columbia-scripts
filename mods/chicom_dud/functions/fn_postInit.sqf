/*
 *  50% chance that thrown Chicom grenades fail to explode.
 */

if (isNil "chicom_dud_chance") then {
    chicom_dud_chance = 0.5;
};

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];

    if (!local _projectile) exitWith {};

    private _projectileType = typeOf _projectile;

    if (_projectileType != "vn_chicom_grenade_ammo") exitWith {};

    if ((random 1) >= chicom_dud_chance) exitWith {};

    [_projectile] spawn {
        params ["_grenade"];

        // Wait before the normal explosion
        sleep 4.4;

        if (isNull _grenade) exitWith {};

        // Get grenade XY position
        private _pos = getPosWorld _grenade;

        // Snap to terrain height
        private _groundZ = getTerrainHeightASL [
            _pos select 0,
            _pos select 1
        ];

        // Slight negative offset prevents floating
        private _groundPosASL = [
            _pos select 0,
            _pos select 1,
            _groundZ - 0.02
        ];

        deleteVehicle _grenade;

        private _holder = createVehicle [
            "GroundWeaponHolder",
            ASLToATL _groundPosASL,
            [],
            0,
            "CAN_COLLIDE"
        ];

        _holder addMagazineCargoGlobal ["vn_chicom_grenade_mag", 1];
        _holder setPosASL _groundPosASL;

        // Auto cleanup after 30 seconds if still present
        [
            {
                params ["_holder"];

                if (!isNull _holder) then {
                    deleteVehicle _holder;
                };
            },
            [_holder],
            30
        ] call CBA_fnc_waitAndExecute;
    };
}];