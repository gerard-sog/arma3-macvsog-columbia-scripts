/*
    Author: veteran29
    Description:
        Execute custom callback on groups spawned by the Tracker Area module.
    Parameter(s):
        _module       - Tracker Area module [OBJECT]
        _fnc_callback - Function to execute on newly created groups, arguments passed to the callback are: [_group, _module] [CODE]
        _interval     - How often to check for new groups [NUMBER, defaults to 3]
*/

colsog_fn_onTrackerSpawn = {
    if (!canSuspend) exitWith {_this spawn colsog_fn_onTrackerSpawn};
    params [
        ["_module", objNull, [objNull]],
        ["_fnc_callback", {}, [{}]],
        ["_interval", 3, [0]]
    ];

    private _fsmId = _module getVariable ["vn_fsm", -1];
    if (_fsmId == -1) exitWith {
        diag_log text format ["Could not get Tracker FSM from module: %1", _module];
    };

    private _handledGroups = [];
    private _fsmGroups = [];
    while {true} do {
        waitUntil {
            sleep _interval;
            // last element always contains all Overlord managed groups
            _fsmGroups = _fsmId call vn_ms_fnc_tracker_overlord_getGroups;
            reverse _fsmGroups;
            _fsmGroups = _fsmGroups select 0;

            _handledGroups isNotEqualTo _fsmGroups
        };
        private _newGroups = _fsmGroups - _handledGroups;
        _handledGroups = _fsmGroups;

        {[_x, _module] call _fnc_callback} foreach _newGroups;
    };
};