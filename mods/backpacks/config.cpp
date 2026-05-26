class CfgPatches
{
    class rt_columbia_backpacks
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"A3_Characters_F", "rtbf_rucks"};
    };
};

class CfgVehicles
{
    class B_Kitbag_cbr;

    class rtbf_arvn_1_od: B_Kitbag_cbr
    {
        maximumLoad = 100;
        mass = 30;
    };

    class rtbf_mountain_1_od: B_Kitbag_cbr
    {
        maximumLoad = 100;
        mass = 30;
    };
};