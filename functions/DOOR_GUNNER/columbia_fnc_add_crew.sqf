params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

createVehicleCrew _target;

_target setVariable ["COLSOG_has_crew", true, true];