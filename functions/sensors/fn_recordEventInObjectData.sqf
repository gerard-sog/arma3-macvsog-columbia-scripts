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
#define SENSOR_IS_PILOT "COLSOG_isPilot"

params ["_sensor", ["_eventType", "EVENT"], ["_colorCode", "#000000"], ["_eventData", " - "], ["_sendToCustomUnits", false]];

private _data = _sensor getVariable [SENSOR_DATA, ""];
private _timestamp = [dayTime] call BIS_fnc_timeToString; // 07:21:36
private _newEvent = _timestamp + ":<font color='" + _colorCode + "'>" + _eventType + "</font>: " + _eventData + "<br />";
private _newData = _data + _newEvent;

_sensor setVariable [SENSOR_DATA, _newData, true];

if (_sendToCustomUnits) then
{
    {
    	private _isPilot = _x getVariable [SENSOR_IS_PILOT, false];
    	if (_isPilot) then {
            player createDiaryRecord ["Diary", ["Data", _newEvent]];
    	    // (bip bip bip)
    	    "gdtmod_satchel_starttimer" remoteExec ["playSound", _x];
    	};
    } forEach allPlayers;
};