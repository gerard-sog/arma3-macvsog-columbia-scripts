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

private _unitGroup = group _unit;

{
    private _closestTarget = [_x] call COLSOG_fnc_getClosestTarget;
    if (isNull _closestTarget) exitWith {
        systemChat "No player in a 500m radius";
    };

    [
        [_x, _closestTarget],
        {
            params ["_attacker", "_target"];

            [_attacker] join grpNull;
            private _newGroup = group _attacker;

            _leader = leader _newGroup;

            // Unit setup (remove ammo, sprint mode, etc.)
            _rifle = primaryWeapon _leader;
            removeAllWeapons _leader;
            _leader addWeapon _rifle;
            _leader setUnitPos "UP";
            _leader disableAI "FSM";
            _leader setBehaviour "AWARE";
            _leader allowFleeing 0;
            _leader forceSpeed (_target getSpeed "FAST");
            _leader doTarget _target;
            private _stop = false;

            while {(({ alive _x } count units _newGroup != 0) && (!_stop))} do {
                sleep 1;

                private _distanceToTarget = (leader _newGroup) distance _target;

                if (_distanceToTarget > 3) then {
                    [
                        [_newGroup, _target],
                        {
                            params ["_a", "_b"];
                            [_a, _b] call COLSOG_fnc_moveAi;
                        }
                    ] remoteExecCall ["call", groupOwner _newGroup];
                } else {
                    [_newGroup, _target] call COLSOG_fnc_attackAi;
                };

                // Update targeted player.
                if (!alive _target || lifeState _target == "INCAPACITATED") then {
                    _target = [leader _newGroup] call COLSOG_fnc_getClosestTarget;
                    if (isNull _target) then {
                        _stop = true;
                    } else {
                        "switching target" remoteExec ["systemChat", 0];
                    };
                };
            };

            "end" remoteExec ["systemChat", 0];
        }
    ] remoteExecCall ["spawn", owner _x, false];
} foreach units _unitGroup;
