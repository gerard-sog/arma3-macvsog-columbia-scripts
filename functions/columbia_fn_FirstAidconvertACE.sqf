if !(isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {};

ClassFirstAidConvertACE = "FirstAidKit";
ClassMediConvertACE = "Medikit";
if (isClass (configFile >> "CfgPatches" >> "vn_emm")) then {
	ClassFirstAidConvertACE = "vn_o_item_firstaidkit";
	ClassMediConvertACE = "vn_b_item_medikit_01";
};

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer"];
	if (_killed isKindOf "CAManBase") then {
		private _unit = _this select 0;
		private _items = items _unit;

		if (ClassMediConvertACE in _items) then {
			_unit removeItems ClassFirstAidConvertACE;
			_unit removeItem ClassMediConvertACE;
			_backpack = BackpackContainer _unit;
			_backpack addItemCargoGlobal ["ACE_fieldDressing", Columbia_medikit_convert_ace_field_dressing];
			_backpack addItemCargoGlobal ["ACE_salineIV_500", Columbia_medikit_convert_ace_saline_iv_500];
			_backpack addItemCargoGlobal ["ACE_epinephrine", Columbia_medikit_convert_ace_epinephrine];
			_backpack addItemCargoGlobal ["ACE_morphine", Columbia_medikit_convert_ace_morphine];
			_backpack addItemCargoGlobal ["ACE_tourniquet", Columbia_medikit_convert_ace_tourniquet];
			_backpack addItemCargoGlobal ["ACE_splint", Columbia_medikit_convert_ace_splint];
		};

		if (ClassFirstAidConvertACE in _items) then {
			while {({_x == ClassFirstAidConvertACE} count items _unit) > 0} do {
				_unit removeItem ClassFirstAidConvertACE;
				_vest = vestContainer _unit;
				_vest addItemCargoGlobal ["ACE_fieldDressing", Columbia_first_aid_convert_ace_field_dressing];
				_vest addItemCargoGlobal ["ACE_morphine", Columbia_first_aid_convert_ace_morphine];
			};
		};
	};
}];