/*
 * Remove throwable from OPFOR units
 *
 * !! Only works for "magazines", throwbales are magazines, others items might not be !!
 *
 */

if (!isServer) exitWith {};

["O_Soldier_base_F", "InitPost", {
	params ["_unit"];

	[{
		params ["_unit"];
    private _items = itemsWithMagazines _unit;
		{
      if (_x in _items) then {
        _unit removeMagazines _x;
      }
		} forEach colsog_throwable_remove;
	}, [_unit]] call CBA_fnc_execNextFrame;
		
}, true, [], true] call CBA_fnc_addClassEventHandler;
