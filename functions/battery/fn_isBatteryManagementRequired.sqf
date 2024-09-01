/*
 * Returns if battery management should be applied to a specific radio being used.
 *
 * Arguments:
 * 0: True if talking over radio, else false.
 * 1: radioId (String).
 * 2: Radio Type. ex: "ACRE_PRC77" (String).
 * 3: player triggering action (Object).
 *
 * Return values:
 * True if player is talking over radio AND radio in the inventory of the player (to avoid adding battery management to
 * radios in vehicles) AND if radio is of a specific type.
 */

params ["_onRadio", "_radioId", "_radioType", "_player"];

private _condition = (
    _onRadio AND
    ([_player, _radioId] call BIS_fnc_hasItem) AND
    ([_radioType, _radioId] call BIS_fnc_inString)
    );
_condition;