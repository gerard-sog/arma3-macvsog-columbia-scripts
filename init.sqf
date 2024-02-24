//
// init.sqf
// Executes at mission start
// No parameters are passed to this script

// init COLUMBIA Zeus Custom Modules
execVM "functions\init_columbia_zeus.sqf";

// **********************************************************************
// Place the following in your mission's init.sqf
// **********************************************************************
// **********************************************************************
// Compile general JBOY functions
// **********************************************************************
_n = execVM  "functions\JBOY\JBOY_compileFuncs.sqf"; // Compile general JBOY functions
call compile preprocessFile "functions\JBOY\mace\compileMaceScripts.sqf"; // Compile all Mace functions
