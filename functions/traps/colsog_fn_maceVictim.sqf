/*
 * Locality:
 * On player local computer OR on Server if AI.
 */

// *******************************************************
// Attach victim to mace and play various fx (sound, blood, etc.)
// *******************************************************
params ["_unit", "_mace", "_trapDirection", "_trapPosition"];
private _group = group _unit;
private _directionTo = ([_unit, _mace] call BIS_fnc_dirTo);
if ([position _unit, _directionTo, 180, position _mace] call BIS_fnc_inAngleSector) then
{
    _directionTo = _directionTo + 180;
};
{_x enableCollisionWith _mace; _x setUnitPOS "MIDDLE";} forEach units _group;

private _oddOfBeingImpaled = [1, 100] call BIS_fnc_randomNum;
if (_oddOfBeingImpaled <= colsog_traps_chanceOfBeingImpaled) then
{
    // Kills the unit in kill radius.
    _unit setDamage 1;
    _unit setPos getPos _unit;
    _mace setDir (_trapDirection);
    [_unit, _mace] execVM "functions\traps\colsog_fn_impaleOnMace.sqf";
    _unit setDir _directionTo;
    _unit setVectorUp [0.0363626, 0.998112, 0.9995081];
} else
{
    private _firstRandomBodyPart = selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
    private _firstRandomDamage = [1, 10] call BIS_fnc_randomNum;
    private _firstRandomDamageType = selectRandom ["stab", "bullet", "punch"];
    [_unit, _firstRandomDamage, _firstRandomBodyPart, _firstRandomDamageType] call ace_medical_fnc_addDamageToUnit;

    private _secondRandomBodyPart = selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
    private _secondRandomDamage = [1, 10] call BIS_fnc_randomNum;
    private _secondRandomDamageType = selectRandom ["stab", "bullet", "punch"];
    [_unit, _secondRandomDamage, _secondRandomBodyPart, _secondRandomDamageType] call ace_medical_fnc_addDamageToUnit;

    private _brokenLimbs = selectRandom
    [
        "0, 0, 0, 0", // Nothing.
        "0, 0, 0, 1", // 1 leg.
        "0, 0, 1, 0", // 1 leg.
        "0, 0, 1, 1", // 2 legs.
        "0, 1, 0, 0", // 1 arm.
        "1, 0, 0, 0", // 1 arm.
        "1, 0, 0, 1", // 1 arm & 1 leg.
        "1, 0, 1, 0", // 1 arm & 1 leg.
        "0, 1, 0, 1", // 1 arm & 1 leg.
        "0, 1, 1, 0"  // 1 arm & 1 leg.
    ];

    private _currentMedicalState = [_unit] call ace_medical_fnc_serializeState;
    private _index = _currentMedicalState find "ace_medical_fractures";
    private _firstPart = _currentMedicalState select [0, _index];
    private _fracturePart = "ace_medical_fractures"": [0, 0, " + _brokenLimbs + "]";
    private _lastPart = _currentMedicalState select [_index + 42, count _currentMedicalState];
    private _newMedicalState = _firstPart + _fracturePart + _lastPart;
    [_unit, _newMedicalState] call ace_medical_fnc_deserializeState;
};

_mace setDir _trapDirection;
_mace setVelocityModelSpace [0, 5, 0]; // keep the dude swinging
uiSleep .5;

vn_us_death_screams = [
    "vn_sam_usdeath_001",
    "vn_sam_usdeath_002",
    "vn_sam_usdeath_003",
    "vn_sam_usdeath_004",
    "vn_sam_usdeath_005",
    "vn_sam_usdeath_006",
    "vn_sam_usdeath_007",
    "vn_sam_usdeath_008",
    "vn_sam_usdeath_009",
    "vn_sam_usdeath_010",
    "vn_sam_usdeath_011",
    "vn_sam_usdeath_012",
    "vn_sam_usdeath_013",
    "vn_sam_usdeath_014",
    "vn_sam_usdeath_015",
    "vn_sam_usdeath_016",
    "vn_sam_usdeath_017",
    "vn_sam_usdeath_018",
    "vn_sam_usdeath_019",
    "vn_sam_usdeath_020",
    "vn_sam_usdeath_021",
    "vn_sam_usdeath_022",
    "vn_sam_usdeath_023",
    "vn_sam_usdeath_024",
    "vn_sam_usdeath_025",
    "vn_sam_usdeath_026",
    "vn_sam_usdeath_027",
    "vn_sam_usdeath_028",
    "vn_sam_usdeath_029",
    "vn_sam_usdeath_030",
    "vn_sam_usdeath_031",
    "vn_sam_usdeath_032",
    "vn_sam_usdeath_033",
    "vn_sam_usdeath_034",
    "vn_sam_usdeath_035",
    "vn_sam_usdeath_036",
    "vn_sam_usdeath_037",
    "vn_sam_usdeath_038",
    "vn_sam_usdeath_039",
    "vn_sam_usdeath_040",
    "vn_sam_usdeath_041",
    "vn_sam_usdeath_042",
    "vn_sam_usdeath_043",
    "vn_sam_usdeath_044",
    "vn_sam_usdeath_045",
    "vn_sam_usdeath_046",
    "vn_sam_usdeath_047",
    "vn_sam_usdeath_048",
    "vn_sam_usdeath_049",
    "vn_sam_usdeath_050",
    "vn_sam_usdeath_051",
    "vn_sam_usdeath_052",
    "vn_sam_usdeath_053",
    "vn_sam_usdeath_054",
    "vn_sam_usdeath_055",
    "vn_sam_usdeath_056",
    "vn_sam_usdeath_057",
    "vn_sam_usdeath_058"
    ];

if (colsog_traps_screamingEnable) then {
    [_mace, selectRandom vn_us_death_screams] remoteExecCall ["say3D", 0, false]; // victim screams
};

uiSleep 30;
