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
call COLUMBIA_fnc_faces;

// on respawn we need to redefine the player's language.
_languagesPlayerSpeaks = player getVariable ["f_languages", []];

switch (playerside) do {
case west: {
        if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["en"];};   // Have the MACVSOG team able to talk and understand each other (using English)
    };
case east: {
        if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
    };
case independent: {
        if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
    };
case civilian: {
        if (_languagesPlayerSpeaks isEqualTo []) then {_languagesPlayerSpeaks = ["vn"];};
    };
};
_languagesPlayerSpeaks call acre_api_fnc_babelSetSpokenLanguages;