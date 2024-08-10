// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
params ["_mace"];
uiSleep 60;
_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
uiSleep 10;
_mace enableSimulation false;
