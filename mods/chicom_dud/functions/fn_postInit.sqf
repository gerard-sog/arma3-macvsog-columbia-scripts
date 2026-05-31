/*
 *  Chance that thrown Chicom/T67 grenades fail to explode.
 */

if (isNil "chicom_dud_chance") then {
    chicom_dud_chance = 0.5;
};

if (isNil "chicom_dud_audio_enabled") then {
    chicom_dud_audio_enabled = true;
};

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];

    if (!local _projectile) exitWith {};

    private _projectileType = typeOf _projectile;

    private _magazineType = switch (_projectileType) do {
        case "vn_chicom_grenade_ammo": { "vn_chicom_grenade_mag" };
        case "vn_t67_grenade_ammo": { "vn_t67_grenade_mag" };
        default { "" };
    };

    if (_magazineType == "") exitWith {};
    if ((random 1) >= chicom_dud_chance) exitWith {};

    [_projectile, _magazineType] spawn {
        params ["_grenade", "_magazineType"];

        sleep 4.4;

        if (isNull _grenade) exitWith {};

        private _pos = getPosWorld _grenade;

        private _groundZ = getTerrainHeightASL [
            _pos select 0,
            _pos select 1
        ];

        private _groundPosASL = [
            _pos select 0,
            _pos select 1,
            _groundZ - 0.02
        ];

        if (chicom_dud_audio_enabled) then {
            playSound3D [
                "a3\sounds_f_orange\arsenal\explosives\trainingmine\trainingmine_fuse_06.wss",
                objNull,
                false,
                ASLToAGL _groundPosASL,
                1,
                1,
                50
            ];
        };

        deleteVehicle _grenade;

        private _holder = createVehicle [
            "GroundWeaponHolder",
            ASLToATL _groundPosASL,
            [],
            0,
            "CAN_COLLIDE"
        ];

        _holder addMagazineCargoGlobal [_magazineType, 1];
        _holder setPosASL _groundPosASL;

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