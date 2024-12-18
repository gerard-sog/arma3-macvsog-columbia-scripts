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

private _hasUSface = player getVariable ["hasUSface", false];

if (!_hasUSface) then {
    private _currentFace = face player;
    if (not (_currentFace in _availableAsianHeads)) then
    {
        private _randomAsianHead = selectRandom _availableAsianHeads;
        [player, _randomAsianHead] remoteExec ["setFace", 0, true]; // sets the face of a player to one of the above asian faces (this forces the new asian face and overrides player's default face)
    };
}


//if (not(["1-0 Squad Leader", _playerRole] call BIS_fnc_inString) &&
//    not(["1-1 RTO", _playerRole] call BIS_fnc_inString) &&
//    not(["1-2 Medic", _playerRole] call BIS_fnc_inString) &&
//    not(["Pilot", _playerRole] call BIS_fnc_inString) &&
//    not(["Chief SOG", _playerRole] call BIS_fnc_inString)) then
