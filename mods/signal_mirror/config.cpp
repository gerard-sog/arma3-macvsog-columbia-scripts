class CfgPatches
{
    class gg_signal_mirror
    {
        name = "Signal Mirror";
        author = "Gerard";
        requiredAddons[] = {"cba_main"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class SM
    {
        class SignalMirror
        {
            file = "\signal_mirror\functions";

            class init {};
            class startAirScanner {};
            class showSignalMirrorIcon {};
        };
    };
};

class Extended_PostInit_EventHandlers
{
    class signal_mirror
    {
        init = "[] call SM_fnc_init";
    };
};