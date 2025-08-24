/*
 * Get battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * Battery level in seconds (Number)
 */

params ["_radioType", "_player"];

private _radioId = [_radioType, _player] call acre_api_fnc_getRadioByType;

_radios = missionNamespace getVariable "COLSOG_radios";

_result = nil;

{
    _colsogRadioId = _x select 0;
    if (_colsogRadioId == _radioId) then {
        _result = _x select 1;
    };
} forEach _radios;

_result;