/*
 * Decrypts intel by consuming the object and removing an intel from the global intel list.
 *
 * Return values:
 * None
 */

params ["_player"];

private _isIntelExpert = _player getVariable ["COLSOG_intelExpert", !(colsog_intel_intelExpertRequired)];

if (_isIntelExpert) then {
    _player removeItem colsog_intel_inventoryItem;

    if ((count COLSOG_intelPool) > 0) then {
        private _intelPool = COLSOG_intelPool;
        private _selectedIntel = _intelPool select 0;

        // Remove selected intel from pool of intel.
        _intelPool deleteAt 0;
        COLSOG_intelPool = _intelPool;
        publicVariable "COLSOG_intelPool";

        player createDiaryRecord ["Diary", ["Intel", _selectedIntel]];
    } else {
        hintSilent format ["Contains no valuable information."];
    };
} else {
    hintSilent format ["You cannot read the document..."];
};
