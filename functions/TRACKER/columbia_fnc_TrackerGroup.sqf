/*
    This script shows example usage of columbia_fnc_onTrackerSpawn to customize the loadouts of spawned groups.
    columbia_fnc_customizeTrackerGroup - function that randomly assigns loadouts to the group units depending on type of the tracker group
*/


columbia_fnc_customizeTrackerGroup = {
    params [["_group", grpNull, [grpNull]]];

    if (isNull _group) exitWith {
      // sometimes tracker module triggers with empty groups, systemChat will not show in dedicated server
      systemChat str ["Exit NULL group", _group];
    };

    _group setVariable ["COLSOG_trackedGroup", true, true];

    _group setBehaviour (COLSOG_TrackersDefault select 0);
    _group setCombatMode (COLSOG_TrackersDefault select 1);
    _group setSpeedMode (COLSOG_TrackersDefault select 2);
};