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

private _playerRole = roleDescription player;
if (not(["1-0 Squad Leader", _playerRole] call BIS_fnc_inString) &&
    not(["1-1 RTO", _playerRole] call BIS_fnc_inString) &&
    not(["1-2 Medic", _playerRole] call BIS_fnc_inString)) then
{
    private _currentFace = face player;
    if (not (_currentFace in _availableAsianHeads)) then
    {
        private _randomAsianHead = selectRandom _availableAsianHeads;
        [player, _randomAsianHead] remoteExec ["setFace", 0, true]; // sets the face of a player to one of the above asian faces (this forces the new asian face and overides player's default face)
        player groupChat "Player: " + name player + ", face: " + _randomAsianHead;
    };
}