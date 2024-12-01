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

params ["_player"];

[
    5,
    [_player],
    {
        params ["_args"];
        _args params ["_player"];

        private _invisibleBarrier = _player getVariable "COLSOG_invisibleBarrier";
        deleteVehicle _invisibleBarrier;

        private _playerPos = getPos _player;
        _player setPos [_playerPos select 0, _playerPos select 1, 0];
        _player hideObjectGlobal false;
        _player switchMove "";

        _player setVariable ["COLSOG_isUpInTree", false, true];
    },
    {},
    "Climbing down!"
] call ace_common_fnc_progressBar;