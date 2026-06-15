class CfgPatches
{
	class Dash_AdvancedPickupRope
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"AR_AdvancedRappelling", "cba_main"};
	};
};

class CfgFunctions
{
	class Dash
	{
		class AdvancedPickupRope
		{
			file = "\stabo\functions";

			class AdvancedPickupRopeInit { postInit = 1; };
			class AddPlayerActions {};
			class AddSandbagHoldAction {};
			class BreakDeployRope {};
			class ClientPickupRope {};
			class ClientRefreshBottomRope {};
			class DetachStabo {};
			class DetachUnitFromStabo {};
			class DropStaboRope {};
			class FindFreeSlot {};
			class HasAttachedPlayers {};
			class PickupRope {};
			class RefreshBottomRopes {};
			class ResetStaboState {};
			class ServerKeepSandbagPinned {};
		};
	};
};
