/*
 * Get the start time (server time) of the last transmission on a specific radio (retrieved using a custom ID).
 *
 * Arguments:
 * 0: acre radio type (String) (see https://acre2.idi-systems.com/wiki/class-names).
 * 1: player triggering action (Object)
 *
 * Return values:
 * Server time of last transmission in seconds (Number)
 */

#define START_TRANSMIT "start_transmit_"

params ["_radioId"];

private _startTransmitRadioId = START_TRANSMIT + _radioId;
private _serverTimeLastTransmissionInSeconds = missionNamespace getVariable _startTransmitRadioId;
_serverTimeLastTransmissionInSeconds;