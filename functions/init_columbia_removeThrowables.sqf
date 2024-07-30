/*
 * Remove throwables from Opfor units
 * (add to global array other throwables)
 *
 * !! Only works for "magazines", throwbales are magazines, others items might not be !!
 *
 */

if (!isServer) exitWith {};

// Removing throwables
["O_Soldier_base_F", "InitPost", {
	params ["_unit"];

	[{
		params ["_unit"];
    private _items = itemsWithMagazines _unit;
		{
      if (_x in _items) then {
        _unit removeMagazines _x;
      }
		} forEach Columbia_CBA_remove_throwable;
	}, [_unit]] call CBA_fnc_execNextFrame;
		
}, true, [], true] call CBA_fnc_addClassEventHandler;
