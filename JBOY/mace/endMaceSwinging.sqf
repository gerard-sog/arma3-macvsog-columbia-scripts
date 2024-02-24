// ********************************************************
// Lower mace to ground to end physics so physics no longer eating CPU.
// ********************************************************
// endMaceSwinging =
params ["_mace"];
//_mace setMass 186.5; // Make mace hang at correct level above ground, and reduce bouncing
sleep 60;
_mace setMass 290; // Make mace settle down to ground so no more physics eating CPU
sleep 10;
_mace enableSimulation false;
