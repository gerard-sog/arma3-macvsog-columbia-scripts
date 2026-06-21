/*
    Turbulent Skies
    Picks the next logical weather preset.
*/

params [
    ["_currentPreset", 0, [0]]
];

if (_currentPreset <= 0) exitWith { 1 };
if (_currentPreset >= 5) exitWith { 4 };

if ((random 1) < 0.5) then {
    _currentPreset + 1
} else {
    _currentPreset - 1
}
