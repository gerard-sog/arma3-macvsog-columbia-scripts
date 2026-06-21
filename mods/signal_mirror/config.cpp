class CfgPatches
{
    class gg_signal_mirror
    {
        name = "Signal Mirror";
        author = "Gerard";
        requiredAddons[] = {"cba_main"};
        units[] = {};
        weapons[] = {"SM_SignalMirror"};
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

class CfgWeapons
{
    class Binocular;

    class SM_SignalMirror: Binocular
    {
        author = "Gerard";
        displayName = "Signal Mirror";

        scope = 2;
        scopeArsenal = 2;

        model = "\signal_mirror\models\signal_mirror.p3d";
        picture = "\signal_mirror\assets\ui\signal_mirror_ca.paa";

        modelOptics = "";
        simulation = "Binocular";
        weaponPoolAvailable = 1;

        class OpticsModes
        {
            class Binocular
            {
                opticsID = 1;
                useModelOptics = 0;

                opticsZoomMin = 0.25;
                opticsZoomMax = 0.25;
                opticsZoomInit = 0.25;

                discretefov[] = {0.25};
                discreteInitIndex = 0;

                distanceZoomMin = 100;
                distanceZoomMax = 100;

                memoryPointCamera = "eye";
                cameraDir = "";

                visionMode[] = {"Normal"};
                opticsFlare = 0;
                opticsDisablePeripherialVision = 0;
                opticsPPEffects[] = {};
            };
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