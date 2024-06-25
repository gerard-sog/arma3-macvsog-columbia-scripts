ropeDestroy globalStaboRope;							//This destroys the rope contained in the global variable
[globalDroppedSandbag, 0] remoteExec["removeAction"]; 	//This removes the Attach STABO Rig option from the sandbag on the ground
[globalParentHelicopter, ["Drop the STABO rig", "dropSTABO.sqf", nil, 100]] remoteExec ["addAction"];	//Re-adds the Drop the STABO rig action after the ropes are detatched.