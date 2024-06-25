private _parentHelicopter = vehicle player; 																					//The vehicle used to drop the rope
globalParentHelicopter = _parentHelicopter;																						//Puts the private variable value into an intermediary (required in order to define globally)
publicVariable "globalParentHelicopter";																						//Broadcast the _parentHelicopter variable to all players

private _pos = getPosATL globalParentHelicopter; 																				//Creates a variable called _pos that contains the current player vehicle location above terrain level
_pos set [2, 0]; 																												//Sets the third value in the array (which contains the position above the terrain) to zero
private _droppedSandbag = "vn_prop_sandbag_01" createVehicle ATLToASL _pos;														//Creates a sandbag that can be attached to the bottom of the rope
globalDroppedSandbag = _droppedSandbag;																							//Puts the private variable value into an intermediary (required in order to define globally)
publicVariable "globalDroppedSandbag";																							//Broadcast the _droppedSandbag variable to all players

private _staboRope = ropeCreate [_parentHelicopter, [0, 0, 0], globalDroppedSandbag, [0,0,0], 50, nil, nil, nil, 63]; 			//Creates a rope under the current player vehicle 55m in length with 50 segments. Has the dropped sandbag as the attached item at the bottom
globalStaboRope = _staboRope;																									//Puts the private variable value into an intermediary (required in order to define globally)
publicVariable "globalStaboRope";																								//Broadcast the _staboRope variable to all players
				 
[globalDroppedSandbag, ["Attach STABO rig", "attachStaboRig.sqf"]] remoteExec ["addAction"];									//Adds the Attach STABO rig option. Has to be done via remoteExec otherwise the option is only for the person who dropped the rope from the vehicle
[globalStaboRope, ["Detatch ropes", "detatchRopes.sqf"]] remoteExec ["addAction"];												//Adds the detatch ropes option. Has to be done via remoteExec otherwise the option is only for the person who dropped the rope from the vehicle																				
[globalParentHelicopter] remoteExec ["removeAllActions"];																		//Note: This usage of removeAllActions is BAD PRACTICE. In the future this will be changed but it works currently as we have no additional custom actions that can be deployed.


//Developer notes 
//There are lots of global variables which probably is not best practice, however it was the only way I could get everything to play ball. I additionally wanted to make sure that if anyone deployed, used and destroyed the ropes it worked as expected. Probably a better way of doing this. 

//Technical Debt
//If any other custom actions are added to the helicopter, they will be removed due to this script when the STABO is deployed. This needs to be updated in future and is a requirement if we ever add additional helicopter custom actions.