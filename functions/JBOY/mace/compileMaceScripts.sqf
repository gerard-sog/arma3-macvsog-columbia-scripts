private ["_path"];

_path = "functions\JBOY\mace\";
_scripts = 
// **********************************************************************
// Immediate Action Scripts
// **********************************************************************
[
//"addMaceKilledEH", // not using for now.  May change to use EHs for calling victim impalement later
"attachSprungWhipTrap",
"bloodCloud",
"controlMaceSwing",
"endMaceSwinging",
"impaleOnMace",
"maceTrapCreate",
"maceTrapInit",
"makeBloodUnderMace",
"monitorMaceTrap",
"maceVictim",
"maceVictims",
"playRandomSfx",
"unitDropsWeapon"
];
// [] call JBOY_test;

{
	call compile format ["JBOY_%1 = compile preprocessFileLineNumbers ('%2%1.sqf')", _x, _path];
} foreach _scripts;
