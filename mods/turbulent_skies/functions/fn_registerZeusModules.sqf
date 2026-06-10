if (!hasInterface) exitWith {};

private _hasZen =
    isClass (configFile >> "CfgPatches" >> "zen_custom_modules");

if !(_hasZen) exitWith {};

[
    "Turbulent Skies",
    "Weather Preset",
    {
        _this call TS_fnc_zeusWeatherPreset;
    },
    "\a3\Modules_F_Curator\Data\iconLightning_ca.paa"
] call zen_custom_modules_fnc_register;