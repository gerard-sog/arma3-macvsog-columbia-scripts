params ["_target", "_caller", "_actionId", "_arguments"]; // specials parameters passed to a script by addAction

deleteVehicleCrew _target;

_target setVariable ["COLSOG_HasCrew", false, true];