#define CBA_SETTINGS_STABO "STABO Pickup Rope"

[
	"APR_STABO_ROPE_LENGTH",
	"SLIDER",
	[
		"STABO rope length",
		"Total STABO rope length in meters. Slots are automatically calculated at 3.5m per slot."
	],
	[CBA_SETTINGS_STABO, "General"],
	[3.5, 56, 28, 1],
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	"APR_STABO_HOLD_DURATION",
	"SLIDER",
	[
		"STABO attach duration",
		"Time in seconds required to attach to the STABO rope."
	],
	[CBA_SETTINGS_STABO, "General"],
	[1, 30, 1, 0],
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	"APR_STABO_CLIMB_SUPPRESSION_ENABLED",
	"CHECKBOX",
	[
		"Enable climb suppression",
		"When enabled, STABO load directly reduces helicopter climb rate. At 100% sling load, the helicopter cannot gain altitude."
	],
	[CBA_SETTINGS_STABO, "Physics"],
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	"APR_STABO_DEBUG_ENABLED",
	"CHECKBOX",
	[
		"Enable STABO debug",
		"Displays STABO debug information in systemChat."
	],
	[CBA_SETTINGS_STABO, "Debug"],
	false,
	1,
	{},
	false
] call CBA_fnc_addSetting;