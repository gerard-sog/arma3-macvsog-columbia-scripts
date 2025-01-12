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
        private _playerPos = getPos player;
        player setPos [_playerPos select 0, _playerPos select 1, 0];
    },
    {},
    "Climbing down!"
] call ace_common_fnc_progressBar;