{
	systemChat format [
		"%1 got %2 kills",
		name _x,
                         (getPlayerScores _x) select 0
	];
} forEach allPlayers;
systemChat format ["%1 total kills", scoreSide west];