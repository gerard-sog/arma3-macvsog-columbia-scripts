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
                _currentWaypointPos = [_attackers, _target, _currentWaypointPos] call COLSOG_fnc_moveAi;
            } else {
                [_attackers, _target] call COLSOG_fnc_attackAi;
            };
        };

        systemChat "end";
    }
] remoteExecCall ["spawn", 2, false];

// TODO:
// - One player killed, choose another player to attack.
// - Once near player, makes various AI individual group and attack various players Then once no player near them
//   make them in one group again and search for nearest player.