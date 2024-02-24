// gesture =
// *********************************************
// Perform hand gesture followed by gestureNod which guarantees gesture ends.
// Note:  Many PLP gestures don't end by themselves, so that's why we follow with gestureNod.
// *********************************************
// [frogs,"PLP_Ges_HandsignalHaltR",1] spawn JBOY_gesture;
// [frogs,"PLP_Ges_HandsignalHaltL",1] spawn JBOY_gesture;
// [frogs,"GestureUp",1] spawn JBOY_gesture; // right hand gesture
//gesture =
params["_unit","_gesture","_secs"];
[_unit, _gesture] remoteExec ["playActionNow"];
sleep _secs;
// gestureNod ends gesture.  Note that units won't fire while doing gesture, so this re-enables firing as well.
[_unit, "gestureNod"] remoteExec ["playActionNow"];