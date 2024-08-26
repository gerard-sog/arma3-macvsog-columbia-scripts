if !(hasInterface) exitWith {};

_triangulate = [
	"COLSOG_triangulate",
	"Triangulate signal",
	"\a3\Modules_F_Curator\Data\iconRadio_ca.paa",
	{
		execVM "functions\triangulate\colsog_fn_triangulate_signal.sqf";
	},
	{
	    [player, colsog_triangulation_requiredAcreRadio] call acre_api_fnc_hasKindOfRadio;
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _triangulate, true] call ace_interact_menu_fnc_addActionToClass;