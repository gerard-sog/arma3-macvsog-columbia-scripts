/*
 * If player is part of roles that can increase radio counter threshold, increase counter.
 *
 * Arguments:
 * 0: player (Object)
 *
 * Return values:
 * None
 */

params ["_player"];

private _groupId = groupId group player;

private _isRoleTriggeringIncrease = false;

{
    if ([_x, _groupId] call BIS_fnc_inString) then {
        _isRoleTriggeringIncrease = true;
    };
} forEach colsog_battery_groupsTriggeringEnemySpawnThresholdIncrease;

if (_isRoleTriggeringIncrease) then {
    COLSOG_amountOfRadioCalls = COLSOG_amountOfRadioCalls + 1;
    if (COLSOG_amountOfRadioCalls > colsog_battery_enemySpawnThreshold) then {
        COLSOG_amountOfRadioCalls = 0;
        private _group = [(_player modelToWorld [0,250,0]), 1, east, "VN"] call VN_ms_fnc_tracker_spawnGroup;
        _group move (getPos _player);
    };
    publicVariable "COLSOG_amountOfRadioCalls";
}