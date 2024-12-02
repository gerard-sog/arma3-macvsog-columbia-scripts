/*
 * Makes player executing the action climbing up a tree and allows movement again.
 *
 * Arguments:
 *
 * Return values:
 * None
 */

[
    colsog_climbing_timeToClimbDown,
    [],
    {
        private _invisibleBarrier = player getVariable "COLSOG_invisibleBarrier";
        deleteVehicle _invisibleBarrier;

        private _playerPos = getPos player;
        player setPos [_playerPos select 0, _playerPos select 1, 0];

        // remote-executes hideObjectGlobal from a client to the server
        [player, false] remoteExec ["hideObjectGlobal", 2];

        player switchMove "";

        player setVariable ["COLSOG_isUpInTree", false, false];
    },
    {},
    "Climbing down!"
] call ace_common_fnc_progressBar;