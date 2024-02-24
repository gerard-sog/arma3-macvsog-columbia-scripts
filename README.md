# Arma3 MACV-SOG Columbia
## Scripts

<details>

<summary>Save loadout at arsenal</summary>

To save your loadout, add the below code in the arsenal 'init' section. 

```
this addAction [
"Save loadout",
{player setVariable["saved_loadout",getUnitLoadout player];
hint "Loadout saved";},
nil,
1.5,
true,
true,
"",
"_this distance _target < 2",
50,
false,
"",
""
];
```

Then, by looking at the arsenal (from 2 meters maximum) and using the scroll wheel, you will have the option to 'save loadout'.
</details>

<details>

<summary>Add image on map stand</summary>

To display any image on a map stand, follow the below steps:
- convert your .png into one of these resolution: 256x256, 512x512, 1024x1024 or 2048x2048
- use the TexView 2 (Arma 3 Tool) to convert the .png into a .paa (Use 'RGBA' and in the other section use 'DXT5')
- add .paa file into the 'images' folder
- add the below code in the 'init' section of the map stand

```
this setObjectTexture [0,
"images\YOUR_IMAGE.paa"]
```

</details>

<details>

<summary>Allow Radio Support based on trait</summary>

Radio support from the Prairie fire DLC is available in a mission if all of the below points are true for a player:
- Radio Support module is present in the mission
- The player has one of the following radio: ["vn_o_pack_t884_01",
"vn_o_pack_t884_ish54_01_pl",
"vn_o_pack_t884_m1_01_pl",
"vn_o_pack_t884_m38_01_pl",
"vn_o_pack_t884_ppsh_01_pl",
"vn_b_pack_prc77_01_m16_pl",
"vn_b_pack_03_m3a1_pl",
"vn_b_pack_03_xm177_pl",
"vn_b_pack_03_type56_pl",
"vn_b_pack_03",
"vn_b_pack_prc77_01",
"vn_b_pack_trp_04",
"vn_b_pack_trp_04_02",
"vn_b_pack_03",
"vn_b_pack_03_02",
"vn_b_pack_lw_06",
"vn_b_pack_m41_05"]
- (IF unit_trait_required = 1 in description.ext) Player has the below code in its 'init' section

```
this setUnitTrait["vn_artillery", true, true];
```

- All this can be modified in the vn_artillery_settings class in [description.ext](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/description.ext)


</details>

<details>

<summary>Add teleport flag</summary>

To add a teleport flag (or any other object that player can use to teleport themselves at a predetermined point) follow the below steps:
- Add a invisible marker (point) on the map in editor and give it a name (ex: "airfield")
- add the below code in the 'init' section of the teleport flag (or object you choose)

```
this addAction [
    "Travel to airfield", // This text will be displayed in the action menu (using the scroll wheel).
{
    (_this select 1) setPos (getMarkerPos "airfield");} // This section will teleport the player to the position of the "airfield" marker.
];
```

</details>

<details>

<summary>Force vietnamese face on players</summary>

Playing as early MACV-SOG team, we are playing as south vietnamese and thus we force vietnamese faces on all playable character. At player initilization or at player respawn, one random asian face is selected from the below list and set for the current player.

```
[
    "vn_b_AsianHead_A3_06_02",
    "vn_b_AsianHead_A3_07_02",
    "vn_b_AsianHead_A3_07_03",
    "vn_b_AsianHead_A3_07_04",
    "vn_b_AsianHead_A3_07_05",
    "vn_b_AsianHead_A3_07_06",
    "vn_b_AsianHead_A3_07_07",
    "vn_b_AsianHead_A3_07_08",
    "vn_b_AsianHead_A3_07_09"
]
```

To disable this feature, you can comment or remove the below line from initPlayerlocal.sqf and onPlayerRespawn.sqf:

```
_player setFace _randomAsianHead
```

You can also directly execute the below command on the server to directly reset all players faces to a random asian face:
```
call COLUMBIA_fn_faces;
```

</details>

<details>

<summary>Add drinkable beer</summary>

To create a drinkable beer (or any other object that player can use) follow the below steps:
- Add the beer object 'Savage Bia'
- add the below code in the 'init' section of the beer (or object you choose)

```
this addAction ["Drink Beer", { 
    "dynamicBlur" ppEffectEnable true; 
    "dynamicBlur" ppEffectCommit 1; 
    "dynamicBlur" ppEffectAdjust [6]; 
    addCamShake [5, 60, 1];
    sleep 4; 
    "dynamicBlur" ppEffectEnable false;
}];
```

</details>

<details>

<summary>JBOY mace trap</summary>

```
/* **********************************************************************
JBOY Mace Punji Trap demonstration mission.
Author:  Johnnyboy
Credits: Savage Game Design for the objects and sound files used by this script.

HOW TO ADD THESE TRAPS TO YOUR MISSION
======================================
1.  Include the compile code below in your init.sqf
2. Place a Whip Trap object in the editor.  The direction you set the trap 
will be the direction the mace will swing.
Note that AI may be inclined to walk around the trap, so you might want to place more
objects to funnel the AI path to the trap.
3. In the Whip Trap object's init field, put the following code:

[this,'WEST'] spawn {sleep 3; params ["_trap","_triggerActivatedBy"];[_trap,_triggerActivatedBy] spawn JBOY_maceTrapCreate;};

The second parameter above determines who can activate the trap.  
This script creates a trigger for the trap, so these are the values you can
use for this parameter:
"EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY", "ANYPLAYER"

For a Prairie Fire mission you might want to set it to WEST so only West units
activate the trap.  This simulates the locals (VC and Civs) knowing to avoid the trap.

SCRIPT FEATURES
================
- Direction of mace swing determined by direction of placed Whip Trap (that has call to this script in init)
- What side can activate trap is configurable
- Maximum Sound FX for immersion: (trap activation, screams, swinging rope creaking)
- Weapon flies when hit by mace
- Multiple random death animations for when impaled on mace
- Other AI units in group react to mace when a unit hit
- AI units in group react to mace if mace misses them

*************************************************************************/

// **********************************************************************
// Place the following in your mission's init.sqf
// **********************************************************************
// **********************************************************************
// Compile general JBOY functions
// **********************************************************************
_n = execVM  "functions\JBOY\JBOY_compileFuncs.sqf"; // Compile general JBOY functions
call compile preprocessFile "functions\JBOY\mace\compileMaceScripts.sqf"; // Compile all Mace functions
```

</details>

## Default values

- Default <b>addons</b> for missions: [defaultAddons.txt](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/defaultAddons.txt)
- Default <b>loadouts</b>: [loadouts](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/)
- Default whitelist <b>arsenal</b>: [defaultWhitelistArsenal.txt](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/defaultWhitelistArsenal.txt)
- Default <b>missions</b>:
    - [Cam_Lao_Nam](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/DefaultMission.Cam_Lao_Nam/mission.sqm): Includes borders between ARVN (South Vietnam), PAVN (North Vietnam), Khmer Republic, Laos and Cambodia.
