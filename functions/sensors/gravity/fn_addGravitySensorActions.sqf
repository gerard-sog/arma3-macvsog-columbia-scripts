params ["_sensor"];

_sensor addAction [
    "<t color='#FF0000'>Pick up</t>",
    "functions\sensors\common\fn_pickUp.sqf",
    [colsog_sensor_gravityInventoryItem],
    0,
    true,
    true,
    "",
    "",
    50,
    false,
    "",
    ""
];

_sensor addAction [
    "<t color='#00FF00'>Collect data</t>",
    "functions\sensors\common\fn_collectDataAsDiaryRecord.sqf",
    nil,
    0,
    true,
    true,
    "",
    "",
    50,
    false,
    "",
    ""
];