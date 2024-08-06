private ["_path"];

_path = "functions\JBOY\mace\";
_scripts = 
// **********************************************************************
// Immediate Action Scripts
// **********************************************************************
[
"attachSprungWhipTrap",
"controlMaceSwing",
"endMaceSwinging",
"impaleOnMace",
"maceTrapCreate",
"maceTrapInit",
"monitorMaceTrap",
"maceVictim",
"maceVictims",
"unitDropsWeapon"
];

{
	call compile format ["JBOY_%1 = compile preprocessFileLineNumbers ('%2%1.sqf')", _x, _path];
} foreach _scripts;
