/*
 * Remove throwables from Opfor units
 * (add to global array other throwables)
 *
 * !! Only works for "magazines", throwbales are magazines, others items might not be !!
 *
 */

if (!isServer) exitWith {};
 
ClassThrowables = ["vn_rg42_grenade_mag", "vn_rgd33_grenade_mag", "vn_rdg2_mag", "vn_molotov_grenade_mag", "vn_chicom_grenade_mag", "vn_f1_grenade_mag", "vn_t67_grenade_mag", "vn_rgd5_grenade_mag", "vn_rkg3_grenade_mag"];
 
["O_Soldier_base_F", "InitPost", {
	params ["_unit"];

	[{
		params ["_unit"];
    private _items = itemsWithMagazines _unit;
		{
      if (_x in _items) then {
        _unit removeMagazines _x;
      }
		} forEach ClassThrowables;
	}, [_unit]] call CBA_fnc_execNextFrame;
		
}, true, [], true] call CBA_fnc_addClassEventHandler;
