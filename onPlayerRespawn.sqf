removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;
player setUnitLoadout(player getVariable["saved_loadout", []]);
_randomAsianHead = selectRandom ["vn_b_AsianHead_A3_06_02","vn_b_AsianHead_A3_07_02","vn_b_AsianHead_A3_07_03","vn_b_AsianHead_A3_07_04","vn_b_AsianHead_A3_07_05","vn_b_AsianHead_A3_07_06","vn_b_AsianHead_A3_07_07","vn_b_AsianHead_A3_07_08","vn_b_AsianHead_A3_07_09"];
player setFace _randomAsianHead; // sets the face of a player to one of the above asian faces (this forces the new asian face and overides player's default face) [DUPLICATED in initPlayerlocal.sqf].