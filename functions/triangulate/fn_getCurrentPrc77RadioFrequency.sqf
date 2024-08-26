/*
 * Returns frequency currently used by the 'colsog_triangulation_requiredAcreRadio' radio.
 *
 * Arguments:
 * 0: player triggering action (Object).
 *
 * Return values:
 * Number (ex: 56.80)
 */

params ["_player"];

private _radioId = [colsog_triangulation_requiredAcreRadio, _player] call acre_api_fnc_getRadioByType;
if (isNil "_radioId") exitWith {};

// Gives something like "Frequency: 52.85 MHz", wee need to parse this into a Number.
private _channelDescription = [_radioId, "getChannelDescription"] call acre_sys_data_fnc_dataEvent;
private _parsedChannelDescription = _channelDescription splitString " ";
private _frequency = parseNumber (_parsedChannelDescription select 1);
_frequency;
