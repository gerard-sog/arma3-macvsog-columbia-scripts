params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _parentHelicopter = _target;
// Need broadcast so allPlayers are aware if rope is NOT deployed (the code in this file is only executed by the player detaching)
_parentHelicopter setVariable ["COLSOG_staboRopeDeployed", false, true];

// get rope created from parent helicopter
private _rope = _parentHelicopter getVariable "COLSOG_staboRope";
ropeDestroy _rope;

// get sandbag created from parent helicopter
private _sandbag = _parentHelicopter getVariable "COLSOG_staboSandbag";

// reset the parent helicopter on sandbag (needed for ace unconconscious loading)
_sandbag setVariable ["COLSOG_staboParentHelicopter", nil, true];

[_sandbag, 0] remoteExec["removeAction"];