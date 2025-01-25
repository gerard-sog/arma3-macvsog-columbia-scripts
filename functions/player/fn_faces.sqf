/*
 * Sets the face of a player to one of asian faces
 * Depending on the slot, this forces the new asian face and overrides player's default face if he has not one
 *
 * Arguments:
 * No parameters
 *
 * Locality:
 * Local execute per player (ie: initPlayerLocal & onPlayerRespawn)
 *
 * Example:
 * call COLSOG_fnc_faces;
 *
 * Return values:
 * None
 *
 */

if (!hasInterface) exitWith {};

private _availableAsianHeads = [
    "vn_b_AsianHead_A3_06_02",
    "vn_b_AsianHead_A3_07_02",
    "vn_b_AsianHead_A3_07_03",
    "vn_b_AsianHead_A3_07_04",
    "vn_b_AsianHead_A3_07_05",
    "vn_b_AsianHead_A3_07_06",
    "vn_b_AsianHead_A3_07_07",
    "vn_b_AsianHead_A3_07_08",
    "vn_b_AsianHead_A3_07_09"
];

private _hasUsface = player getVariable ["hasUsface", false];

if (!_hasUsface) then {
    private _currentFace = face player;
    if (not (_currentFace in _availableAsianHeads)) then
    {
        private _randomAsianHead = selectRandom _availableAsianHeads;
        [player, _randomAsianHead] remoteExec ["setFace", 0, true];
        // sets the face of a player to one of the above asian faces (this forces the new asian face and overrides player's default face)
    };
};
