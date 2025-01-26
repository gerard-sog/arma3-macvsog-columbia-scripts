/*
 * Manage attack logic for bayonet charge.
 *
 * Arguments:
 * 0: AI group attacking (Object)
 * 1: Targeted player (Object)
 *
 * Return values: None
 */

params ["_attacker", "_target"];

systemChat "attack";
private _leader = leader _attacker;

_leader playActionNow selectRandom ["vn_bayonet_bayonetstrike","vn_bayonet_buttstrike"];

private _stab_audio = selectRandom ["vn_melee_stab_1","vn_melee_stab_2","vn_melee_stab_3","vn_melee_stab_4","vn_melee_stab_5","vn_melee_stab_6","vn_melee_stab_7","vn_melee_stab_8","vn_melee_stab_9","vn_melee_stab_10","vn_melee_stab_11","vn_melee_stab_12","vn_melee_stab_13","vn_melee_stab_14","vn_melee_stab_15","vn_melee_stab_16"];
[_leader, _stab_audio] remoteExecCall ["say3D", 0, false];

private _bulletType = "B_762x51_Ball";
private _bullet = _bulletType createVehicle [15, 15, 100];
_bullet setMass 10;
_bullet setVelocity [0, 0, 0];
_bullet setVelocity [0, 0, 150];
[_bullet, [_leader, _leader]] remoteExecCall ["setShotParents", 2];

private _relPos = [0.1, 0, 1.2];
if (stance _target == "CROUCH") then {
    _relPos = [0.1, 0, .8]
};

_bullet setpos (_target modelToWorld _relPos);