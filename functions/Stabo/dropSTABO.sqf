private _parentHelicopter = vehicle player;
PARENT_HELICOPTER = _parentHelicopter;
publicVariable "PARENT_HELICOPTER";

// Contains the current player vehicle location above terrain level.
private _pos = getPosATL _parentHelicopter;
// Sets the third value in the array (which contains the position above the terrain) to zero.
_pos set [2, 0];
private _droppedSandbag = "vn_prop_sandbag_01" createVehicle ATLToASL _pos;
DROPPED_SANDBAG = _droppedSandbag;
// Broadcast the _droppedSandbag variable to all players.
publicVariable "DROPPED_SANDBAG";

// Creates a rope under vehicle 55m in length with 50 segments (dropped sandbag attached at end of rope).
private _staboRope = ropeCreate [_parentHelicopter, [0, 0, 0], _droppedSandbag, [0,0,0], 50, nil, nil, nil, 63];
STABO_ROPE = _staboRope;
// Broadcast the _staboRope variable to all players.
publicVariable "STABO_ROPE";

STABO_ROPE_DEPLOYED = true;
publicVariable "STABO_ROPE_DEPLOYED";

[
	_droppedSandbag,												                    // Object the action is attached to
	"Attach STABO rig",												                    // Title of the action
	"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",	                                // Idle icon shown on screen
	"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",	                                // Progress icon shown on screen
	"_this distance _target < 3 AND STABO_ROPE_DEPLOYED AND alive PARENT_HELICOPTER",   // Condition for the action to be shown
	"true",									                                            // Condition for the action to progress
	{},																                    // Code executed when action starts
	{},																                    // Code executed on every progress tick
	{ _caller moveInCargo PARENT_HELICOPTER; },						                    // Code executed on completion
	{},																                    // Code executed on interrupted
	[],																                    // Arguments passed to the scripts as _this select 3
	5,																                    // Action duration in seconds
	0,																                    // Priority
	false,															                    // Remove on completion
	false															                    // Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _droppedSandbag];