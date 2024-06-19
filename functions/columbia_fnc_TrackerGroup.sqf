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

    _group setVariable ["ColumbiaTrackedGroup", true];

    _group setBehaviour (TRACKERS_DEFAULT select 0);
    _group setCombatMode (TRACKERS_DEFAULT select 1);
    _group setSpeedMode (TRACKERS_DEFAULT select 2);

};

[ TrackermoduleNAME, columbia_fnc_customizeTrackerGroup] call columbia_fnc_onTrackerSpawn;