// ********************************************************
// Initialize stuff shared by all placed mace traps.
// ********************************************************
maceTrapInit =
{
	if (!isServer) exitWith {};
	if !((missionNamespace getVariable ["vn_us_death_screams",[]]) isEqualTo []) exitWith {};
	missionNamespace setVariable ["vn_us_death_screams",
	["vn_sam_usdeath_001","vn_sam_usdeath_002","vn_sam_usdeath_003","vn_sam_usdeath_004","vn_sam_usdeath_005","vn_sam_usdeath_006","vn_sam_usdeath_007","vn_sam_usdeath_008","vn_sam_usdeath_009","vn_sam_usdeath_010","vn_sam_usdeath_011","vn_sam_usdeath_012","vn_sam_usdeath_013","vn_sam_usdeath_014","vn_sam_usdeath_015","vn_sam_usdeath_016","vn_sam_usdeath_017","vn_sam_usdeath_018","vn_sam_usdeath_019","vn_sam_usdeath_020","vn_sam_usdeath_021","vn_sam_usdeath_022","vn_sam_usdeath_023","vn_sam_usdeath_024","vn_sam_usdeath_025","vn_sam_usdeath_026","vn_sam_usdeath_027","vn_sam_usdeath_028","vn_sam_usdeath_029","vn_sam_usdeath_030","vn_sam_usdeath_031","vn_sam_usdeath_032","vn_sam_usdeath_033","vn_sam_usdeath_034","vn_sam_usdeath_035","vn_sam_usdeath_036","vn_sam_usdeath_037","vn_sam_usdeath_038","vn_sam_usdeath_039","vn_sam_usdeath_040","vn_sam_usdeath_041","vn_sam_usdeath_042","vn_sam_usdeath_043","vn_sam_usdeath_044","vn_sam_usdeath_045","vn_sam_usdeath_046","vn_sam_usdeath_047","vn_sam_usdeath_048","vn_sam_usdeath_049","vn_sam_usdeath_050","vn_sam_usdeath_051","vn_sam_usdeath_052","vn_sam_usdeath_053","vn_sam_usdeath_054","vn_sam_usdeath_055","vn_sam_usdeath_056","vn_sam_usdeath_057","vn_sam_usdeath_058"]
	,true];
};