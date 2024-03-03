_availableAsianHeads = ["vn_b_AsianHead_A3_06_02","vn_b_AsianHead_A3_07_02","vn_b_AsianHead_A3_07_03","vn_b_AsianHead_A3_07_04","vn_b_AsianHead_A3_07_05","vn_b_AsianHead_A3_07_06","vn_b_AsianHead_A3_07_07","vn_b_AsianHead_A3_07_08","vn_b_AsianHead_A3_07_09"];
{
    _currentFace = face _x;
    if (not (_currentFace in _availableAsianHeads)) then
    {
        _randomAsianHead = selectRandom _availableAsianHeads;
        _x setFace _randomAsianHead; // sets the face of a player to one of the above asian faces (this forces the new asian face and overides player's default face)
        _x groupChat "Player: " + name _x + ", face: " + _randomAsianHead;
    };
} forEach playableUnits;