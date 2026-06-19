/*
	STABO Pickup Rope init
*/

APR_STABO_SEGMENT_LENGTH = 3.5;

APR_STABO_GetSlotCount = {
	floor (APR_STABO_ROPE_LENGTH / APR_STABO_SEGMENT_LENGTH)
};

APR_STABO_SANDBAG_CLASS = "vn_prop_sandbag_01";
APR_STABO_HOLD_ACTION_ICON = "\z\ace\addons\fastroping\UI\Icon_Waypoint.paa";

if (hasInterface) then {
	[] spawn {
		waitUntil {
			sleep 1;
			!isNull player
		};

		if (alive player) then {
			[player] call Dash_fnc_AddPlayerActions;
		};
	};

	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];

		if !(_entity isKindOf "Man") exitWith {};
		if (!isPlayer _entity) exitWith {};

		[_entity] spawn {
			params ["_unit"];
			sleep 1;

			if (local _unit && {alive _unit} && {isPlayer _unit}) then {
				[_unit] call Dash_fnc_AddPlayerActions;
			};
		};
	}];
};