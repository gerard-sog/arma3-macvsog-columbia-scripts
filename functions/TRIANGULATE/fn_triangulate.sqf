if !(hasInterface) exitWith {};

_triangulate = [
	"Columbia_triangulate",
	"Triangulate signal",
	"\a3\Modules_F_Curator\Data\iconRadio_ca.paa",
	{
		execVM "functions\TRIANGULATE\columbia_triangulate_signal.sqf";
	},
	{
	    _fnc_startsWith =
        {
            params ["_string", "_startsWith"];
            _string select [0, count _startsWith] isEqualTo _startsWith
        };

        private _result = false;
        {
            if (typename _x != "STRING") then
            {
                _x = str _x;
            };

            if ([_x, Columbia_CBA_triangulation_required_item] call _fnc_startsWith) then
            {
                _result = true;
            };
        } forEach (flatten getUnitLoadout player);
        _result
	}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _triangulate, true] call ace_interact_menu_fnc_addActionToClass;