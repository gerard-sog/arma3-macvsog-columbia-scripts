/*
 * Author: Kay
 * Custom Zeus module
 * 2 Transition Text with optional date change inbetween (empty text are not displayed)
 * Date change during 5 sec fadetoblack, optional show new date
 * 
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_text1", "_timing1", "_dummy1", "_datechange", "_day", "_month", "_hours", "_minutes", "_show", "_text2", "_timing2"];

	if (_text1 == "" && _text2 == "" && _datechange == false) exitWith {
		["Need at least 1 text or date change", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
        playSound "FD_Start_F";
	};
	
	// spawn texts & date change	
	[ 
		[_text1, _timing1, _text2, _timing2, _datechange, _month+1, _day+1, _hours, _minutes, _show], { 
		
			params ["_text1", "_timing1", "_text2", "_timing2", "_datechange", "_month", "_day", "_hours", "_minutes", "_show"];

			private "_handle";
			private _idlayer1 = ["Text1Display"] call BIS_fnc_rscLayer;
			private _idlayer2 = ["Text2Display"] call BIS_fnc_rscLayer;
			
			if !(_text1 == "") then {
				_text1 = [ format ["<t align = 'center' shadow = '1' size = '0.7' font='tt2020style_e_vn'>%1</t>", _text1], -1, 0.2, _timing1, 1, 0];
				_handle = (_text1 + [_idlayer1]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			
			if (_datechange) then {
				_idlayer1 cutText ["", "BLACK OUT", 1];
				date params ["_year"];
				setDate [_year, _month, _day, _hours, _minutes]; // shitty performance rework with CBA server event
				sleep 4;
				
				if (_show) then {
					if ((date select 3) < 10) then {
						_hours = format ["0%1", (date select 3)]; // Add 0 to before hours
					} else {
						_hours = str (date select 3);
					};
					if ((date select 4) < 10) then {
						_minutes = format ["0%1", (date select 4)]; // Add 0 before minutes
					} else {
						_minutes = str (date select 4);
					};

                    [
                     [
                      ["Suddenly gunshots could be heard...,", "<t align = 'center' shadow = '1' size = '0.7' font='tt2020style_e_vn'>%1</t>"] ]
                    ] spawn BIS_fnc_typeText;

					[
						[[format [ "%1", _hours + "H" + _minutes], "<t align = 'right' size = '0.8'>%1</t>", 64]], safezoneX + safeZoneW / 2, safeZoneH / 2, "<t font='tt2020style_e_vn'>%1</t>"
					] spawn BIS_fnc_typeText; // display new date
				};
				
				sleep 1;
				_idlayer1 cutText ["", "BLACK IN", 1];
			};
			
			if !(_text2 == "") then {
				_text2 = [ format ["<t align = 'center' shadow = '1' size = '0.7' font='tt2020style_e_vn'>%1</t>", _text2], -1, 0.2, _timing2, 1, 0];
				_handle = (_text2 + [_idlayer2]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
		}
	] remoteExecCall ["spawn", 0, false];
	
};

// Module dialog 
date params ["_year", "_month", "_day", "_hours", "_minutes"];

[
	"Transition Time Change", 
	[
		["EDIT:MULTI", "Text 1", ["", nil, 4], false],
		["SLIDER", "Timer Text 1", [2, 20, 5, 0], false],
		["LIST", [">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CHANGE DATE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"], [[false], [""], 0, 0]], // Dummy line for spacing
		["TOOLBOX:YESNO", "Change Date Between texts", [true], true],
		["TOOLBOX:WIDE", "Day", [ _day-1, 3, 11, ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]], true],
		["TOOLBOX:WIDE", "Month", [_month-1, 2, 6, ["January","February","March","April","May","June","July","August","September","October","November","December"]], true],
		["TOOLBOX:WIDE", "Hours", [_hours, 3, 8, ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]], true],
		["TOOLBOX:WIDE", "Minutes", [_minutes, 5, 12, ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]], true],
		["TOOLBOX:YESNO", "Show new Date after change", [false], true],
		["EDIT:MULTI", "Text 2", ["", nil, 4], false],
		["SLIDER", "Timer Text 2" , [2, 20, 5, 0], false]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;
