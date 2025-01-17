#include "script_component.hpp"

//Add uncon info EH
private _id = ["ace_unconscious", {
	_this params ["_unit", "_state"];
	if ( _state &&  _unit isEqualTo player && GVAR(enableUnconInfo)) then {
		_handle = [{
			if (!(player getVariable ["ACE_isUnconscious", false]) || {!alive player}) exitWith {
				cutText ["", "PLAIN NOFADE", -1, false, true];
				[_handle] call CBA_fnc_removePerFrameHandler; 
			};

			[] call FUNC(unconInfo);

		}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
	};
}] call CBA_fnc_addEventHandler;

GVAR(isBeingHelped) = false;

{// Based on FPARMA version, credits to them for it. Modified to use uncon info text.
	["ace_medical_treatment_" + _x, {
		if (lifeState ace_player == "INCAPACITATED" && GVAR(enableShowIfTreated)) then {
			GVAR(isBeingHelped) = true;
		};
	}] call CBA_fnc_addEventHandler;
} foreach ["bandageLocal", "checkBloodPressureLocal", "cprLocal", "fullHealLocal", "ivBagLocal", "medicationLocal", "splintLocal", "tourniquetLocal"];