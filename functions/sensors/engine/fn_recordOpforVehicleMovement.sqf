params ["_sensor", "_thisList"]; // specials parameters passed to a script by addAction

private _heavierVehicle = -1;
{
    private _objectType = (_x call BIS_fnc_objectType) select 1;

	if ((_heavierVehicle < 0) && (_objectType == "Car" || _objectType == "Motorcycle")) then
	{
        _heavierVehicle = 0;
	};
	if ((_heavierVehicle < 1) && (_objectType == "TrackedAPC" || _objectType == "WheeledAPC")) then
	{
        _heavierVehicle = 1;
    };
    if ((_heavierVehicle < 2) && (_objectType == "Tank")) then
    {
        _heavierVehicle = 2;
    };
} forEach _thisList;

if (_heavierVehicle != -1) then
{
    private _data = "light vehicle";
    if (_heavierVehicle == 1) then
    {
        _data = "vehicle";
    };
    if (_heavierVehicle == 2) then
    {
        _data = "heavy vehicle";
    };
    [_sensor, "ENGINE", "#0000FF", _data, colsog_sensor_engineTransmitDataOverRadio, colsog_sensor_engineRadioTransmissionRange, colsog_sensor_engineLogFrequency] execVM "functions\sensors\common\fn_recordEventInObjectData.sqf";
};
