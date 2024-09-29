
params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

// Get equivalent inventory item.
private _inventorySensorItem = colsog_sensor_gunshotInventoryItem;

if (_caller canAdd _inventorySensorItem) then
{
    _caller addItem _inventorySensorItem;
    private _trigger = _target getVariable "COLSOG_sensorTrigger";
    deleteVehicle _trigger;
    deleteVehicle _target;
} else
{
    hintSilent format ["Not enough place in inventory!"];
};
