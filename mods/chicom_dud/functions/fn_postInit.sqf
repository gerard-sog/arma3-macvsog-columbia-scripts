/*
 *   50% chance that thrown hand grenades fail to explode.
*/

if (!isServer) exitWith {};

DUD_grenadeDudChance = 0.5;

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];

    private _projectileType = typeOf _projectile;

    // Only affect the S.O.G. Prairie Fire Chicom grenade projectile
    if (_projectileType != "vn_chicom_grenade_ammo") exitWith {};

    if ((random 1) >= DUD_grenadeDudChance) exitWith {};

    [_projectile] spawn {
        params ["_grenade"];

        sleep 4.4;

        if (isNull _grenade) exitWith {};

        private _pos = getPos _grenade;

        deleteVehicle _grenade;

        private _holder = createVehicle [
            "GroundWeaponHolder",
            _pos,
            [],
            0,
            "CAN_COLLIDE"
        ];

        _holder addMagazineCargoGlobal ["vn_chicom_grenade_mag", 1];
        _holder setPosATL _pos;
    };
}];
