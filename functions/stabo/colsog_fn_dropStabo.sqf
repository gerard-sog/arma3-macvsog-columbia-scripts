params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _parentHelicopter = _target;

// Need broadcast so allPlayers are aware if rope is deployed (the code in this file is only executed by the player dropping)
_parentHelicopter setVariable ["COLSOG_staboRopeDeployed", true, true];

// Contains the current player vehicle location above terrain level.
private _pos = getPosATL _parentHelicopter;
// Sets the third value in the array (which contains the position above the terrain) to zero.
_pos set [2, 0];
private _droppedSandbag = "vn_prop_sandbag_01" createVehicle ATLToASL _pos;

// Creates a rope under vehicle 55m in length with 50 segments (dropped sandbag attached at end of rope).
private _staboRope = ropeCreate [_parentHelicopter, [0, 0, 0], _droppedSandbag, [0,0,0], colsog_stabo_ropeLength, nil, nil, nil, 63];

// store the rope created on parent helicopter (broadcast needed might be another player detaching)
_parentHelicopter setVariable ["COLSOG_staboRope", _staboRope, true];

[
    {
        // Delayed HoldActionAdd until sandbag touches (almost) ground.
        (getPos (_this select 0) select 2) <= 0.25 ;
    },
    {
        systemChat "TOUCHING GROUND";
        [(_this select 0), true] remoteExec ["hideObjectGlobal", 2];

        private _frozenDroppedSandbag = "vn_prop_sandbag_01" createVehicle (getPosATL (_this select 0));
        _frozenDroppedSandbag enableSimulation false;

        // store the parent helicopter on sandbag (broadcast needed for condition shown in holdActionAdd)
        _frozenDroppedSandbag setVariable ["COLSOG_staboParentHelicopter", (_this select 1), true];

        // store the sandbag created on parent helicopter (broadcast needed might be another player detaching)
        (_this select 1) setVariable ["COLSOG_staboSandbag", _frozenDroppedSandbag, true];

        // Remote exec the HoldActionAdd
        [
        	_frozenDroppedSandbag,										    // Object the action is attached
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
        	[_this select 1],											    // Arguments passed to the scripts (see doc for arguments)
        	colsog_stabo_climbDuration,								        // Action duration in seconds
        	0,																// Priority
        	false,															// Remove on completion (removes for allPlayers !)
        	false															// Show in unconscious state
        ] remoteExec ["BIS_fnc_holdActionAdd", 0];                          // no need for JIP parameter in remoteExec

        // This is to counter the invisible sandbag (with rope attached to it) sliding down slopes.
        [
            [(_this select 1) getVariable "COLSOG_staboRope", (_this select 0), _frozenDroppedSandbag],
            {
                params ["_rope", "_invisibleSandbag", "_frozenDroppedSandbag"];
                while {alive _rope} do {
                    sleep 1;
                    if ((_invisibleSandbag distance _frozenDroppedSandbag) > 0.5) then {
                        _invisibleSandbag setPos getPos _frozenDroppedSandbag;
                    };
                };
            }
        ] remoteExecCall ["spawn", 2, false];

        // If helicopter too far, rope should break and holdAction disappear.
        [
            {
                // Delayed HoldActionAdd until sandbag touches ground (a bit more long than the rope itself to avoid rope breaking when sandbag touches the ground).
                ((_this select 0) distance (_this select 1)) >= 55;
            },
            {
                systemChat "ROPE BREAK!";
                // If rope already detached, we exit and do not execute this script.
                if (not ((_this select 1) getVariable "COLSOG_staboRopeDeployed")) exitWith {};

                // Need broadcast so allPlayers are aware if rope is NOT deployed (the code in this file is only executed by the player detaching)
                (_this select 1) setVariable ["COLSOG_staboRopeDeployed", false, true];

                // get rope created from parent helicopter
                private _rope = (_this select 1) getVariable "COLSOG_staboRope";
                ropeDestroy _rope;

                // get sandbag created from parent helicopter
                private _sandbag = (_this select 1) getVariable "COLSOG_staboSandbag";

                [_sandbag, 0] remoteExec["removeAction"];
            },
            [_frozenDroppedSandbag, _this select 1]
        ] call CBA_fnc_waitUntilAndExecute;
    },
    [_droppedSandbag, _parentHelicopter]
] call CBA_fnc_waitUntilAndExecute;