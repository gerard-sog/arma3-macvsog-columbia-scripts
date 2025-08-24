/*
 * Set battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 * 2: new battery level (Number)
 *
 * Return values:
 * None
 */

#define BATTERY_LEVEL "battery_level_"

params ["_radioType", "_player", "_newBatteryLevel"];

private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;

_radios = missionNamespace getVariable "COLSOG_radios";

_updatedRadios = [];

{
    _colsogRadioId = _x select 0;
    _colsogBatteryLevel = _x select 1;

    if (_colsogRadioId == _radioId) then {
        _colsogBatteryLevel = _newBatteryLevel;
    };

    _updatedRadios pushBack [_colsogRadioId, _colsogBatteryLevel];
} forEach _radios;

missionNamespace setVariable ["COLSOG_radios", _updatedRadios, true];