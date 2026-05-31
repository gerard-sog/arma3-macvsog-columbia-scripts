class CfgPatches
{
    class chicom_dud
    {
        name = "Chicom Dud Grenade";
        author = "Gerard";
        requiredVersion = 2.00;
        requiredAddons[] = {
            "A3_Functions_F",
            "cba_main",
            "cba_settings"
        };
        units[] = {};
        weapons[] = {};
    };
};

class Extended_PreInit_EventHandlers
{
    class chicom_dud
    {
        init = "call compile preprocessFileLineNumbers '\chicom_dud\functions\CBASettings.sqf'";
    };
};

class CfgFunctions
{
    class DUD
    {
        class Grenades
        {
            file = "\chicom_dud\functions";

            class postInit
            {
                postInit = 1;
            };
        };
    };
};