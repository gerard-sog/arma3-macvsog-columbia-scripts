/*
 * Get battery level in seconds. Battery level is stored in missionNamespace and retrieved using a custom ID.
 *
 * Arguments:
 * 0: acre radio id (String)
 *
 * Return values:
 * Battery level in seconds (Number)
 */

#define BATTERY_LEVEL "battery_level_"

params ["_radioId"];

_radios = missionNamespace getVariable "COLSOG_radios";

_result = nil;

{
    _colsogRadioId = _x select 0;
    if (_colsogRadioId == _radioId) then {
        _result = _x select 1;
    };
} forEach _radios;

_result;