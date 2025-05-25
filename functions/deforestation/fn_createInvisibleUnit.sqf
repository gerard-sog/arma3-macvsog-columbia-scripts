/*
 * Create an invisible BLUEFOR unit.
 *
 * Arguments:
 * 0: position for the unit (Position)
 *
 * Return values:
 * the invisible unit.
 */

params ["_pos"];

private _temporaryGroup = createGroup [west, true];
private _temporaryUnit = _temporaryGroup createUnit ["B_RangeMaster_F", _pos, [], 0, "CAN_COLLIDE"];
_temporaryUnit allowDamage false;
_temporaryUnit enableSimulation false;
_temporaryUnit hideObject true;

_temporaryUnit;