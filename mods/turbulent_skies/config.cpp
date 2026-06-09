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
            file = "turbulent_skies";
            class init {};
        };
    };
};

class Extended_PostInit_EventHandlers
{
    class turbulent_skies
    {
        init = "call TS_fnc_init";
    };
};