class CfgPatches
{
    class chicom_dud
    {
        name = "Chicom Dud";
        author = "Gerard";
        requiredVersion = 2.00;
        requiredAddons[] = {"A3_Functions_F"};
        units[] = {};
        weapons[] = {};
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