/*
    tri_border: vectored map borders for the 10240 x 10240 map.

    Based on vet_border\init.sqf (veteran29, PUDDY300, commy2), but the border
    lines are hardcoded as world coordinates instead of being read from
    editor marker layers, so nothing has to be placed in the mission.

    Coordinates were traced from the reference picture (2D, [x, y] in metres,
    origin at the bottom left of the map). Line ends that touch the map edge
    are pushed slightly outside it, like the map corners below.

    The three lines meet at one tri-border point (_junction):
      _lineNorth : tri-border -> north along the east side -> west along the top -> top map edge
      _lineWest  : tri-border -> west -> south-west -> bottom map edge
      _lineSouth : tri-border -> south-west -> south -> bottom map edge

    Usage (init.sqf):
        [] spawn compileScript ["tri_border\init.sqf"];
*/
if (!hasInterface) exitWith {};
if (worldSize != 10240) exitWith {
    diag_log format ["[tri_border] init.sqf skipped: worldSize is %1, expected 10240", worldSize];
};
call compileScript ["tri_border\functions.sqf"];

// draw polygon outlines instead of shading, useful for debugging
// #define DEBUG_BORDER
// disable shading and triangulation, useful for debugging invalid polygons that hang the script
// #define DEBUG_NO_SHADE

//----- fill texture for drawTriangle
#define SHADE_FILL "#(rgb,1,1,1)color(1,1,1,0.07)"

//----- shading colors (same as Cam Lao Nam)
private _colorWest = [0,0,0,1];  // west and north part of the map (Laos)
private _colorEast = [1,1,0,1];  // east strip with the airfield (South Vietnam)
private _colorSouth = [0,0,1,1]; // southern wedge between the two lower lines (Cambodia)

//----- border lines [x, y]
private _lineNorth = [
    [9165,5270], [9250,5565], [9348,5698], [9400,5928], [9418,6138], [9465,6250],
    [9548,6335], [9572,6518], [9440,6988], [9432,7370], [9328,7520], [9160,7695],
    [9145,7788], [9085,7870], [9018,8110], [9018,8162], [9042,8235], [9092,8275],
    [9105,8315], [9108,8465], [9082,8690], [9098,8725], [9175,8810], [9208,8925],
    [9142,9215], [9130,9228], [9068,9208], [8938,9108], [8888,9090], [8600,9072],
    [8510,9078], [8265,9150], [8135,9232], [7935,9255], [7712,9255], [7428,9312],
    [6742,9668], [6695,9680], [6660,9670], [6440,9515], [6395,9498], [6070,9488],
    [5860,9445], [5740,9410], [5488,9295], [5068,9152], [4918,9150], [4775,9220],
    [4755,9252], [4722,9418], [4750,9562], [4728,9800], [4450,10122], [4393,10240]
];

private _lineWest = [
    [9165,5270], [8948,5398], [8835,5408], [8670,5400], [8495,5452], [8192,5512],
    [8122,5512], [7798,5435], [7692,5438], [7232,5592], [7102,5750], [6930,5755],
    [6798,5708], [6778,5575], [6732,5470], [6678,5430], [6568,5395], [6415,5310],
    [6338,5195], [6298,5035], [6232,4912], [6188,4895], [6012,4875], [5850,4890],
    [5882,4620], [5835,4465], [5765,4338], [5568,4195], [5518,3992], [5508,3875],
    [5540,3618], [5570,3002], [5630,2780], [5585,2635], [5308,2278], [5275,2215],
    [5240,1868], [5305,1680], [5305,1632], [5005,1322], [4635,1148], [4305,930],
    [3948,838], [3875,740], [3855,685], [3895,445], [3892,382], [3680,62],
    [3660,40], [3224,-160]
];

private _lineSouth = [
    [9165,5270], [9135,5200], [9002,5108], [8885,4995], [8782,4925], [8728,4738],
    [8700,4590], [8532,4508], [8362,4442], [8335,4402], [8322,4158], [8332,4115],
    [8368,4070], [8382,4020], [8370,3778], [8338,3652], [8215,3548], [8205,3510],
    [8210,3468], [8252,3415], [8390,3290], [8678,3112], [8682,3042], [8662,2940],
    [8638,2850], [8512,2780], [8432,2695], [8402,2540], [8342,2478], [8265,2435],
    [8210,2380], [8135,2248], [8122,2030], [8175,1888], [8238,1782], [8238,1715],
    [7565,255], [7468,50], [7188,-160]
];

//----- draw the border lines as polyline markers
{
    _x params ["_name", "_points", "_color"];
    [_name, _points, _color] call tri_border_fnc_drawPolyline;
} forEach [
    ["tri_border_north", _lineNorth, "ColorBlack"],
    ["tri_border_west", _lineWest, "ColorBlack"],
    ["tri_border_south", _lineSouth, "ColorBlack"]
];

// polygons and triangulation work on 3D positions
private _to3D = {_this apply {[_x#0, _x#1, 0]}};
private _north = _lineNorth call _to3D;
private _west = _lineWest call _to3D;
private _south = _lineSouth call _to3D;
private _northRev = +_north; reverse _northRev;
private _southRev = +_south; reverse _southRev;

// map corners X,Y,Z adjusted by 160 due to satmap rendering
private _leftTop = [0, worldSize, 0];
private _rightTop = [worldSize + 160, worldSize, 0];
private _rightBottom = [worldSize + 160, -160, 0];
private _leftBottom = [0, -160, 0];

//----- map shading polygons (the shared tri-border point is only listed once per polygon)
tri_border_polygons = [
    // West / north: top edge -> tri-border -> bottom edge -> left corners
    [_northRev + (_west select [1, 1e7]) + [_leftBottom, _leftTop], _colorWest],
    // East: tri-border -> top edge -> right corners -> bottom edge -> back towards tri-border
    [_north + [_rightTop, _rightBottom] + (_southRev select [0, count _southRev - 1]), _colorEast],
    // South: tri-border -> bottom edge (west line) -> bottom edge (south line) -> back towards tri-border
    [_west + (_southRev select [0, count _southRev - 1]), _colorSouth]
];

// triangulate the polygons for rendering
tri_border_areas = [];
#ifndef DEBUG_NO_SHADE
{
    private _area = _x#0 call tri_border_fnc_triangulate;
    tri_border_areas pushBack [_area, _x#1];
} forEach tri_border_polygons;
#endif

// draw area shading on main map
waitUntil {!isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_ctrlMap"];
    {
        _x params ["_triangle", "_color"];
        _ctrlMap drawTriangle [_triangle, _color, SHADE_FILL];
    } forEach tri_border_areas;

    #ifdef DEBUG_BORDER
    {_ctrlMap drawPolygon _x} forEach tri_border_polygons;
    #endif
}];
