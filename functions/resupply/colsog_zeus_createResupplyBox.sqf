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

_contentAsString = loadFile "functions\resupplyBoxContent.json" splitString " " joinString "";
_contentAsStringNoBrackets = _contentAsString trim ["[]", 0];
_contentAsArray = _contentAsStringNoBrackets splitString ",";

private _myArray = [];
private _mySubArray = [];

private _index = 0;
private _dualIndex = 0;
{
    if (((_index + 1) % 2) != 0) then
    {
        _mySubArray pushBack (_x select [3, (count _x) - 4]);
    } else
    {
        _mySubArray pushBack (parseNumber _x);
    };
    _index = _index + 1;

    if (_dualIndex == 1) then
    {
        _myArray pushBack _mySubArray;
        _mySubArray = [];
        _dualIndex = 0;
    } else {
        _dualIndex = _dualIndex +1;
    };
} forEach _contentAsArray;

private _supplyBox = "O_supplyCrate_F" createVehicle _pos;
clearItemCargoGlobal _supplyBox;
clearWeaponCargoGlobal _supplyBox;
clearMagazineCargoGlobal _supplyBox;
clearBackpackCargoGlobal _supplyBox;

{
    private _item = _x select 0;
    private _amount = _x select 1;
    _supplyBox addItemCargoGlobal [_item, _amount];
} forEach _myArray;