class CfgPatches
{
    class turbulent_skies
    {
        name = "Turbulent Skies";
        author = "Gerard";
        requiredAddons[] = {"cba_main"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class TS
    {
        class Main
        {
            file = "turbulent_skies\functions";

            class init {};
            class startMonitor {};
            class startTurbulence {};
            class registerZeusModules {};
            class zeusWeatherPreset {};
            class applyWeatherPreset {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class turbulent_skies_settings
    {
        init = "call compile preprocessFileLineNumbers 'turbulent_skies\CBASettings.sqf'";
    };
};

class Extended_PostInit_EventHandlers
{
    class turbulent_skies
    {
        init = "call TS_fnc_init";
    };
};