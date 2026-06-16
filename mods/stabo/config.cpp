class CfgPatches
{
	class Dash_AdvancedPickupRope
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {
			"cba_main",
			"AR_AdvancedRappelling"
		};
	};
};

class CfgFunctions
{
	class Dash
	{
		class AdvancedPickupRope
		{
			file = "\stabo\functions";

			class AdvancedPickupRopeInit {};
			class DropStaboRope {};
			class PickupRope {};
			class ClientPickupRope {};
			class AddPlayerActions {};
			class AddSandbagHoldAction {};
			class BreakDeployRope {};
			class RefreshBottomRopes {};
			class ClientRefreshBottomRope {};
			class ResetStaboState {};
			class HasAttachedPlayers {};
			class FindFreeSlot {};
			class DetachStabo {};
			class DetachUnitFromStabo {};
			class ServerKeepSandbagPinned {};
			class UpdateStaboDownwardForce {};
            class ApplyStaboDownwardForce {};
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class Dash_AdvancedPickupRope_Settings
	{
		init = "call compile preprocessFileLineNumbers '\stabo\CBASettings.sqf'";
	};
};

class Extended_PostInit_EventHandlers
{
	class Dash_AdvancedPickupRope
	{
		init = "call Dash_fnc_AdvancedPickupRopeInit";
	};
};