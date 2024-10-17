params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _parentHelicopter = _target;

// Need broadcast so allPlayers are aware if rope is deployed (the code in this file is only executed by the player dropping)
_parentHelicopter setVariable ["COLSOG_staboRopeDeployed", true, true];

// Contains the current player vehicle location above terrain level.
private _pos = getPosATL _parentHelicopter;
// Sets the third value in the array (which contains the position above the terrain) to zero.
_pos set [2, 0];
private _droppedSandbag = "vn_prop_sandbag_01" createVehicle ATLToASL _pos;

// store the parent helicopter on sandbag (broadcast needed for condition shown in holdActionAdd)
_droppedSandbag setVariable ["COLSOG_staboParentHelicopter", _parentHelicopter, true];

// store the sandbag created on parent helicopter (broadcast needed might be another player detaching)
_parentHelicopter setVariable ["COLSOG_staboSandbag", _droppedSandbag, true];

// Creates a rope under vehicle 100m in length with 63 segments (dropped sandbag attached at end of rope).
private _staboRope = ropeCreate [_parentHelicopter, [0, 0, 0], _droppedSandbag, [0,0,0], 100, nil, nil, nil, 63];

// store the rope created on parent helicopter (broadcast needed might be another player detaching)
_parentHelicopter setVariable ["COLSOG_staboRope", _staboRope, true];

// Remote exec the HoldActionAdd
[
	_droppedSandbag,												// Object the action is attached
	"Attach STABO rig",												// Title of the action
	"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",	            // Idle icon
	"\z\ace\addons\fastroping\UI\Icon_Waypoint.paa",	            // Progress icon
	"(_this distance _target < 6) AND ((_target getVariable 'COLSOG_staboParentHelicopter') getVariable 'COLSOG_staboRopeDeployed')",	// Condition for the action to be shown
	"true",									                        // Condition for the action to progress (need true)
	{},																// Code executed when action starts
	{},																// Code executed on every progress tick
	{
		params ["_target", "_caller", "_actionId", "_arguments"];	// special arguments passed to the code exec'd on completion
		_caller moveInCargo (_arguments select 0);					// _parentHelicopter passed as argument, it's first in array (contains whole BIS_fnc_holdActionAdd params)
	},
	{},																// Code executed on interrupted
	[_parentHelicopter],											// Arguments passed to the scripts (see doc for arguments)
	colsog_stabo_climbDuration,								// Action duration in seconds
	0,																// Priority
	false,															// Remove on completion (removes for allPlayers !)
	false															// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0]; // no need for JIP parameter in remoteExec

//There needs to be a sleep here, otherwise the physics of the rope falling causes some latent movement in the sandbag.
sleep 1;
_droppedSandbag enableSimulation false;