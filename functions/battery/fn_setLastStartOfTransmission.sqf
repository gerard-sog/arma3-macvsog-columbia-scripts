/*
 * Set the start time (server time) of the last transmission on a specific radio (using a custom ID).
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * None
 */

#define START_TRANSMIT "start_transmit_"

params ["_startTransmissionServerTime", "_radioId"];

private _startTransmitRadioId = START_TRANSMIT + _radioId;
missionNamespace setVariable [_startTransmitRadioId, _startTransmissionServerTime];