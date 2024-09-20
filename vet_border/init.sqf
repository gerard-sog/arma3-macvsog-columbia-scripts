/*
    authors:
        map border functions: veteran29
        map borders: veteran29, PUDDY300
        polygon triangulation: commy2
*/
if (!hasInterface) exitWith {};
call compileScript ["vet_border\functions.sqf"];

// draw polygon borders via drawPolygon
// #define DEBUG_BORDER
// disable shading and triangulation, useful for debuging invalid polygons that hang the script
// #define DEBUG_NO_SHADE

//----- fill texture for drawTriangle
#define SHADE_FILL "#(rgb,1,1,1)color(1,1,1,0.07)"

//----- shading colors
private _colorPAVN = (EAST call BIS_fnc_sideID) call BIS_fnc_sideColor;
private _colorARVN = [1,1,0,1];
private _colorLao = [0,0,0,1];
private _colorCam = [0,0,1,1];

//----- border markers
#ifndef DEBUG_BORDER
{
    _x params ["_layer", "_color"];
    [_layer, _layer call vet_border_fnc_getLayerMarkers, _color] call vet_border_fnc_drawPolyline;
} forEach [
    // list of marker layers to draw as polyline
    ["border_pavn_1", "ColorOPFOR"], // South\North Vietnam border
    ["border_pavn_2", "ColorOPFOR"], // North Nam DMZ border
    ["border_arvn_1", "ColorBlack"], // South Nam/Laos border
    ["border_arvn_2", "ColorBlack"], // South Nam/Cambodia border
    ["border_lao_1", "ColorBlack"], // Laos/North Vietnam border
    ["border_lao_2", "ColorBlack"] // Laos/Cambodia border
];
#endif

// map corners X,Y,Z adjusted by 160 due to satmap rendering
private _leftTop = [0, worldSize, 0];
private _rightTop = [worldSize + 160, worldSize, 0];
private _rightBottom = [worldSize + 160, -160, 0];
private _leftBottom = [0, -160, 0];

//----- map shading polygons
vet_border_polygons = [
    // North Vietnam
    [(
        ("border_lao_1" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + ("border_pavn_1" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + [_rightTop]
    ), _colorPAVN],
    // DMZ
    [(
        ("border_pavn_2" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        +(["border_pavn_3", false] call vet_border_fnc_getLayerMarkers apply {markerPos _x})
    ), _colorPAVN],
    // South Vietnam
    [(
        ("border_arvn_2" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + ("border_arvn_1" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + ("border_pavn_1" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + [_rightBottom]
    ), _colorARVN],
    // Laos
    [(
        (["border_lao_2", false] call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + ("border_arvn_1" call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + (["border_lao_1", false] call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + [_leftTop]
    ), _colorLao],
    // Cambodia
    [(
        (["border_lao_2", false] call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + (["border_arvn_2", false] call vet_border_fnc_getLayerMarkers apply {markerPos _x})
        + [_leftBottom]
    ), _colorCam]
];

// triangulate the polygons for rendering
vet_border_areas = [];
#ifndef DEBUG_NO_SHADE
{
    private _area = _x#0 call vet_border_fnc_triangulate;
    vet_border_areas pushBack [_area, _x#1];
} forEach vet_border_polygons;
#endif

// draw area shading on main map
waitUntil {!isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_ctrlMap"];
    {
        _x params ["_triangle", "_color"];
        _ctrlMap drawTriangle [_triangle, _color, SHADE_FILL];
    } forEach vet_border_areas;

    #ifdef DEBUG_BORDER
    {_ctrlMap drawPolygon _x} forEach vet_border_polygons;
    #endif
}];
