class CfgPatches
{
	class Dash_AdvancedPickupRope
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"AR_AdvancedRappelling"};
	};
};

class CfgFunctions
{
	class Dash
	{
		class AdvancedPickupRope
		{
			file = "\stabo\functions";

			class AdvancedPickupRopeInit
			{
				postInit = 1;
			};
		};
	};
};