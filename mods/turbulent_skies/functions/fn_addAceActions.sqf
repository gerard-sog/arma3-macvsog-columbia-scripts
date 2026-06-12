if (!hasInterface) exitWith {};

if (isNil "ace_interact_menu_fnc_createAction") exitWith {};
if (isNil "ace_interact_menu_fnc_addActionToObject") exitWith {};

private _action = [
    "TS_RequestWeatherForecast",
    "Request Weather Forecast",
    "",
    {
        [] call TS_fnc_showWeatherForecast;
    },
    {
        [player] call TS_fnc_isPilotOrCopilot
    }
] call ace_interact_menu_fnc_createAction;

[
    player,
    1,
    ["ACE_SelfActions"],
    _action
] call ace_interact_menu_fnc_addActionToObject;