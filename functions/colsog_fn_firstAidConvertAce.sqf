if !(isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {};

ClassFirstAidConvertACE = "FirstAidKit";
ClassMedicConvertACE = "Medikit";
if (isClass (configFile >> "CfgPatches" >> "vn_emm")) then {
	ClassFirstAidConvertACE = "vn_o_item_firstaidkit";
	ClassMedicConvertACE = "vn_b_item_medikit_01";
};

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer"];
	if (_killed isKindOf "CAManBase") then {
		private _unit = _this select 0;
		private _items = items _unit;

		if (ClassMedicConvertACE in _items) then {
			_unit removeItems ClassFirstAidConvertACE;
			_unit removeItem ClassMedicConvertACE;
			_backpack = BackpackContainer _unit;
			_backpack addItemCargoGlobal ["ACE_fieldDressing", colsog_medikit_convertAceFieldDressing];
			_backpack addItemCargoGlobal ["ACE_salineIV_500", colsog_medikit_convertAceSalineIv500];
			_backpack addItemCargoGlobal ["ACE_epinephrine", colsog_medikit_convertAceEpinephrine];
			_backpack addItemCargoGlobal ["ACE_morphine", colsog_medikit_convertAceMorphine];
			_backpack addItemCargoGlobal ["ACE_tourniquet", colsog_medikit_convertAceTourniquet];
			_backpack addItemCargoGlobal ["ACE_splint", colsog_medikit_convertAceSplint];
		};

		if (ClassFirstAidConvertACE in _items) then {
			while {({_x == ClassFirstAidConvertACE} count items _unit) > 0} do {
				_unit removeItem ClassFirstAidConvertACE;
				_vest = vestContainer _unit;
				_vest addItemCargoGlobal ["ACE_fieldDressing", colsog_firstAid_convertAceFieldDressing];
				_vest addItemCargoGlobal ["ACE_morphine", colsog_firstAid_convertAceMorphine];
			};
		};
	};
}];