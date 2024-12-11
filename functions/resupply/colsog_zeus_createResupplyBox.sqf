/*
 * Custom Zeus module: Creates a resupply crate with specific content.
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */

params [["_pos", [0, 0, 0] , [[]], 3], ["_location", objNull, [objNull]]];

private _supplyBox = "O_supplyCrate_F" createVehicle _pos;
clearItemCargoGlobal _supplyBox;
clearWeaponCargoGlobal _supplyBox;
clearMagazineCargoGlobal _supplyBox;
clearBackpackCargoGlobal _supplyBox;
["zen_common_updateEditableObjects", [[_supplyBox], true]] call CBA_fnc_serverEvent;

private _contentAsArrayOfArrays = [];
for "_i" from 0 to (((count colsog_supply_content) / 2) - 1) do
{
    private _item = colsog_supply_content select (_i * 2);
    private _amount = colsog_supply_content select ((_i * 2) + 1);
    _supplyBox addItemCargoGlobal [_item, _amount];
};