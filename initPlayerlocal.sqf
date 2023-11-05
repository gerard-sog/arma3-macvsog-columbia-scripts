params ["_player", "_didJIP"];
_player setVariable ["saved_loadout", getUnitLoadout _player];	// sets the default loadout for respawn to initial loadout when player joined the server.