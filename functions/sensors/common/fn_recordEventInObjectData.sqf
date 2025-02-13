/*
 * Saves the new recorded event inside the data of the object.
 *
 * Arguments:
 * 0: Sensor (Object)
 * 1: Type of event (String)
 * 2: Color of event type in record (String. ex: "#00FF00")
 * 3: Data for the event (String)
 * 4: If true, will send record to custom unit if unit in the vicinity of sensor (Boolean)
 * 5: Radio wave range in meters (Integer)
 * 6: Logging frequency in seconds (Integer)
 *
 * Return values:
 * None
 */

#define SENSOR_DATA "COLSOG_sensorData"
#define SENSOR_LAST_ENTRY_TIME "COLSOG_sensorLastEntryTime"
#define CAN_MONITOR_SENSOR "canMonitorSensor"

params ["_sensor", ["_eventType", "EVENT"], ["_colorCode", "#000000"], ["_eventData", " - "], ["_transmitDataOverRadio", false], ["_radioTransmissionRange", 1000], ["_logFrequency", 5]];

// Maximum 1 event log per X seconds.
private _sensorLastEntryTime = _sensor getVariable [SENSOR_LAST_ENTRY_TIME, 0];

if ((_sensorLastEntryTime + _logFrequency) > serverTime) exitWith {};

private _sensorId = str (_sensor getVariable "COLSOG_sensorID");
private _data = _sensor getVariable [SENSOR_DATA, ""];
private _timestamp = [dayTime] call BIS_fnc_timeToString; // 07:21:36
private _newEvent = "ID_" + _sensorId + " | " + _timestamp + " | <font color='" + _colorCode + "'>" + _eventType + "</font> | " + _eventData + "<br />";
private _newData = _data + _newEvent;

_sensor setVariable [SENSOR_DATA, _newData, true];

if (_transmitDataOverRadio) then
{
    {
    	private _isListeningToSensor = _x getVariable [CAN_MONITOR_SENSOR, false];
    	if ((_isListeningToSensor) AND (_x distance _sensor < _radioTransmissionRange)) then
    	{
            [_x, ["Diary", ["Received over radio", _newEvent]]] remoteExec ["createDiaryRecord", _x];
    	    // (bip bip bip)
    	    hintSilent format ["ID_" + _sensorId];
    	    "gdtmod_satchel_starttimer" remoteExec ["playSound", _x];
    	};
    } forEach allPlayers;
};

_sensor setVariable [SENSOR_LAST_ENTRY_TIME, serverTime, true];