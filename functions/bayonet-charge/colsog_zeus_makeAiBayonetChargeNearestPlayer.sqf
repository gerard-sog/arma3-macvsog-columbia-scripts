/*
 * Custom Zeus module: Makes AI group bayonet charge the nearest player.
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

if (isNull _unit || not (_unit isKindOf "CAManBase")) exitWith {
	["Need an AI unit", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _unitPos = getPos _unit;
private _playerList = allPlayers apply {[_unitPos distanceSqr _x, _x]};
_playerList sort true;
private _closestPlayer = (_playerList select 0) param [1, objNull];

private _unitGroup = group _unit;

// Unit setup (remove ammo, sprint mode, etc.)
{
    _rifle = primaryWeapon _x;
    removeAllWeapons _x;
    _x addWeapon _rifle;
    _x setUnitPos "UP";
    _x disableAI "FSM";
    _x setBehaviour "AWARE";
    _x allowFleeing 0;
    _x forceSpeed (_closestPlayer getSpeed "FAST");
    _x doTarget _closestPlayer;
} foreach units _unitGroup;

// This is to counter the invisible sandbag (with rope attached to it) sliding down slopes.
[
    [_unitGroup, _closestPlayer],
    {
        params ["_attackers", "_target"];

        private _currentWaypointPos = [0, 0, 0];

        while {({ alive _x } count units _attackers != 0) && (alive _target || lifeState _target != "INCAPACITATED")} do {
            sleep 1;

            private _distanceToTarget = (leader _attackers) distance _target;
            if (_distanceToTarget > 3) then {
                private _targetMovedAwayFromLastPos = _currentWaypointPos distanceSqr (getPos _target) > 3;
                if (_targetMovedAwayFromLastPos) then {
                    systemChat "moving";
                    _currentWaypointPos = getPos _target;
                    _attackers move _currentWaypointPos;
                } else {
                    systemChat "continue moving...";
                };
            } else {
                systemChat "attack";
                private _leader = leader _attackers;

                _leader playActionNow selectRandom ["vn_bayonet_bayonetstrike","vn_bayonet_buttstrike"];

                private _stab_audio = selectRandom ["vn_melee_stab_1","vn_melee_stab_2","vn_melee_stab_3","vn_melee_stab_4","vn_melee_stab_5","vn_melee_stab_6","vn_melee_stab_7","vn_melee_stab_8","vn_melee_stab_9","vn_melee_stab_10","vn_melee_stab_11","vn_melee_stab_12","vn_melee_stab_13","vn_melee_stab_14","vn_melee_stab_15","vn_melee_stab_16"];
                [_leader, _stab_audio] remoteExecCall ["say3D", 0, false];

                private _bulletType = "B_9x21_Ball";
                private _bullet = _bulletType createVehicle [10,10,100];
                _bullet setMass 10;
                _bullet setVelocity [0,0,0];
                _bullet setVelocity [0, 0, 50];
                [_bullet, [_leader, _leader]] remoteExecCall ["setShotParents", 2];

                private _relPos = [0.1, 0, 1.2];
                if (stance _target == "CROUCH") then {
                    _relPos = [0.1,0,.8]
                };

                _bullet setpos (_target modelToWorld _relPos);
            };
        };

        systemChat "end";
    }
] remoteExecCall ["spawn", 2, false];

// TODO:
// - One player killed, choose another player to attack.
// - Once near player, makes various AI individual group and attack various players Then once no player near them
//   make them in one group again and search for nearest player.