/*
 * Creates a 'Gunshot' sensor.
 *
 * Arguments:
 * 0: (Optional) Sensor Object, needed when sensor created in Eden Editor (Object)
 * 1: (Optional) Sensor ID, needed when sensor created in Eden Editor (Integer)
 *
 * Return values:
 * None
 */

[
    5,
    [],
    {
        private _invisibleBarrier = player getVariable "COLSOG_invisibleBarrier";
        deleteVehicle _invisibleBarrier;

        private _playerPos = getPos player;
        player setPos [_playerPos select 0, _playerPos select 1, 0];
        player hideObjectGlobal false;
        player switchMove "";

        player setVariable ["COLSOG_isUpInTree", false, false];
    },
    {},
    "Climbing down!"
] call ace_common_fnc_progressBar;