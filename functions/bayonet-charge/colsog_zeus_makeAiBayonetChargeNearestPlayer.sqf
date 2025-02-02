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

private _closestTarget = [_unit] call COLSOG_fnc_getClosestTarget;
if (isNull _closestTarget) exitWith {
    private _info = "No player in a " + str colsog_bayonet_searchRadius + "m radius";
    systemChat _info;
};
    
[
    [_unit],
    {
        params ["_unit"];

        if !(local group _unit) then {
          group _unit setGroupOwner 2;
          waitUntil {local group _unit};
        };

        {
          private _civGroup = createGroup civilian;
          [_x] join _civGroup;
          private _newGroup = group _x;        
          
          private _attacker = leader _newGroup;
          private _target = [_attacker] call COLSOG_fnc_getClosestTarget;

          // Unit setup (remove ammo, sprint mode, etc.)
          removeAllWeapons _attacker;
          private _rifle = selectRandom ["vn_m38_bayo", "vn_m1891_bayo", "vn_sks_bayo"];
          _attacker addWeapon _rifle;
          _attacker setUnitPos "UP";

          _attacker disableAI "FSM";
          _attacker disableAI "COVER";
          _attacker disableAI "SUPPRESSION";

          _attacker setBehaviour "AWARE";
          _attacker allowFleeing 0;
          _attacker forceSpeed (_target getSpeed "FAST");
          _attacker doTarget _target;

          [_attacker, _target] spawn {
          
            params ["_attacker" , "_target"];
            
            private _stop = false;
            private _currentWaypointPos = [0, 0, 0];

            while {(({ alive _attacker } count units _attacker != 0) && (!_stop))} do {
                sleep 1;

                private _distanceToTarget = _attacker distance _target;

                // AUDIO
                if (colsog_bayonet_screamingEnable) then {
                    private _chanceOfUnitScreamingOrWhistling = [1, 100] call BIS_fnc_randomNum;
                    if (_chanceOfUnitScreamingOrWhistling > 95) then {
                        private _audio = selectRandom [
                            "\vn\sounds_f_vietnam\sfx\missiondesign\enemy_whistle_4.ogg",
                            "uns_dsaiviet\sounds\combat\vc96.ogg",
                            "uns_dsaiviet\sounds\combat\vc145.ogg",
                            "\vn\music_f_vietnam\m_samaudio\pavn\death\vn_sam_vcdeath_005.ogg"
                        ];
                        playSound3D [_audio, _attacker];
                    };
                };

                // MOVE/ATTACK
                if (_distanceToTarget > 3) then {
                    _currentWaypointPos = [_attacker, _target, _currentWaypointPos] call COLSOG_fnc_moveAi;
                } else {
                    [_attacker, _target] call COLSOG_fnc_attackAi;
                };

                // Update targeted player.
                if (!alive _target || lifeState _target == "INCAPACITATED") then {
                    _target = [_attacker] call COLSOG_fnc_getClosestTarget;
                    if (isNull _target) then {
                        _stop = true;
                    } else {
                        "switching target" remoteExec ["systemChat", 0];
                    };
                };
            };
            "end" remoteExec ["systemChat", 0];
            
          };

        } foreach units group _unit;
    }
] remoteExecCall ["spawn", 2, false];

