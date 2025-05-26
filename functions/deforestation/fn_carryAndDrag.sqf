/*
 * Adds two event handler to manage drag and drop on unconscious AI due to C4-explosion.
 *
 * Return values:
 * None
 */

// Locality: Local
["ace_dragging_stoppedCarry", {
    params 	["_unit", "_target", "_loadCargo"];

    private _hasConcussion = _target getVariable ["COLSOG_hasConcussion", false];

    if ((!isPlayer _target) && (_hasConcussion)) then {
        [_target, "UnconsciousFaceDown", 1] call ace_common_fnc_doAnimation;
    };
}] call CBA_fnc_addEventHandler;

// Locality: Local
["ace_dragging_stoppedDrag", {
    params 	["_unit", "_target"];

    private _hasConcussion = _target getVariable ["COLSOG_hasConcussion", false];

    if ((!isPlayer _target) && (_hasConcussion)) then {
        [_target, "UnconsciousFaceDown", 1] call ace_common_fnc_doAnimation;
    };
}] call CBA_fnc_addEventHandler;