params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

private _sensorType = _target getVariable "COLSOG_sensorType";

if !(isNil "_sensorType") then
{
    // Get equivalent inventory item according to _sensorType.
    private _inventorySensorItem = "Chemlight_blue";

    if (_caller canAdd _inventorySensorItem) then
    {
        _caller addItem _inventorySensorItem;
        deleteVehicle _target;
    } else
    {
        hintSilent format ["Not enough place in inventory!"];
    };
};

