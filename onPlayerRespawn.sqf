execVM "functions\init\init_colsog_PlayerLocalVar.sqf"; // player respawns reset variables on object player

removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeVest player;
removeVest player;
removeUniform player;
removeAllAssignedItems player;
clearAllItemsFromBackpack player;
removeBackpack player;

// reset vietnamese face if needed
call COLSOG_fnc_faces;

// reset Babel spoken language
execVM "functions\init\init_colsog_PlayerBabel.sqf";