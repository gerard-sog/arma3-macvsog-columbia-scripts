if !(hasInterface) exitWith {};

private _triangulate = [
	"Columbia_triangulate",
	"Triangulate signal",
	"\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_deploy_prone_ca.paa",
	{
		execVM "functions\TRIANGULATE\columbia_triangulate_signal.sqf";
	},
	{"vn_b_item_radio_urc10" in (flatten getUnitLoadout player)}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _triangulate, true] call ace_interact_menu_fnc_addActionToClass;