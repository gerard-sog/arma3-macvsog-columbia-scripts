/*
 * Saves the new recorded event inside the data of the object.
 *
 * Arguments:
 * 0: Sensor (Object)
 * 1: Type of event (String)
 * 2: Color of event type in record (String. ex: "#00FF00")
 * 3: Data for the event (String)
 * 4: If true, will send record to custom unit if unit in the vicinity of sensor (Boolean)
 *
 * Return values:
 * None
 */

#define SENSOR_DATA "COLSOG_sensorData"
#define SENSOR_LAST_ENTRY_TIME "COLSOG_sensorLastEntryTime"
#define SENSOR_IS_LISTENING_TO_SENSOR "COLSOG_isListeningToSensor"

params ["_sensor", ["_eventType", "EVENT"], ["_colorCode", "#000000"], ["_eventData", " - "], ["_transmitDataOverRadio", false]];

// Maximum 1 event log per X seconds.
private _sensorLastEntryTime = _sensor getVariable [SENSOR_LAST_ENTRY_TIME, 0];

if ((_sensorLastEntryTime + colsog_sensor_log_frequency) > serverTime) exitWith {};

private _sensorId = str (_sensor getVariable "COLSOG_sensorID");
private _data = _sensor getVariable [SENSOR_DATA, ""];
private _timestamp = [dayTime] call BIS_fnc_timeToString; // 07:21:36
private _newEvent = "ID_" + _sensorId + " | " + _timestamp + " | <font color='" + _colorCode + "'>" + _eventType + "</font> | " + _eventData + "<br />";
private _newData = _data + _newEvent;

_sensor setVariable [SENSOR_DATA, _newData, true];

if (_transmitDataOverRadio) then
{
    {
    	private _isListeningToSensor = _x getVariable [SENSOR_IS_LISTENING_TO_SENSOR, false];
    	if ((_isListeningToSensor) AND (_x distance _sensor < colsog_sensor_radioTransmissionRange)) then
    	{
            player createDiaryRecord ["Diary", ["Data", _newEvent]];
    	    // (bip bip bip)
    	    "gdtmod_satchel_starttimer" remoteExec ["playSound", _x];
    	};
    } forEach allPlayers;
};

_sensor setVariable [SENSOR_LAST_ENTRY_TIME, serverTime, true];