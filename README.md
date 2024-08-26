# Arma 3 S.O.G. RT Columbia

Compilation of scripts used during multiplayer PVE/PVP mission on Arma 3. Also featuring defaults loadouts and missions as well as providing CBA settings in order to easily update the scripts to your convenience. 

If you want to contribute to this project, see [CONTRIBUTING.md](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/CONTRIBUTING.md).

## Table of contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Default values](#default-values)
- [Zeus modules](#zeus-modules)
- [CBA Settings](#cba-settings)
- [Features](#features)

## Requirements
- [Prairie Fire DLC](https://store.steampowered.com/app/1227700/Arma_3_Creator_DLC_SOG_Prairie_Fire/)
- [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997)
- [ace](https://steamcommunity.com/workshop/filedetails/?id=463939057)
- [ACRE2](https://steamcommunity.com/workshop/filedetails/?id=751965892)

## Installation
Installation of all the scripts/zeus modules is done by **copying the below files and folder directly into your mission folder** where your **"mission.sqm"** file is located (ex: C:\Users\<user_name>\Documents\Arma 3 - Other Profiles\<profile_name>\missions\KheSanhMission01.vn_khe_sanh).
- [functions](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions) (<i>Folder</i>)
- [description.ext](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/description.ext) (<i>File</i>)
- [init.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/init.sqf) (<i>File</i>)
- [initPlayerlocal.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initPlayerlocal.sqf) (<i>File</i>)
- [initServer.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initServer.sqf) (<i>File</i>)
- [onPlayerRespawn.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/onPlayerRespawn.sqf) (<i>File</i>)

## Default values
- Default <b>loadouts</b>:
  - [covey](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/covey.json)
  - [rifleman](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/default_rifleman.json)
  - [grenadier](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/Grenadier.json)
  - [medic](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/Medic.json)
  - [RPD Gunner](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/MG_RPD.json)
  - [pointman](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/Pointman_AK.json)
  - [RTO](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/RTO.json)
  - [Squad leader](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/squad_leader.json)
- Default <b>missions</b>:
  - [Cam_Lao_Nam](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/Cam_Lao_Nam/mission.sqm): Includes borders between ARVN (South Vietnam), PAVN (North Vietnam), Khmer Republic, Laos and Cambodia.
  - [fox_pamai](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/fox_pamai/mission.sqm): Includes FOB from vn_the_bra and an Airfield in out of bound area.
  - [vn_khe_sanh](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/vn_khe_sanh/mission.sqm)
  - [vn_the_bra](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/vn_the_bra/mission.sqm)
- Default <b>addons</b> for missions: [defaultAddons.txt](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/defaultAddons.txt)
- Default whitelist <b>arsenal</b>: [defaultWhitelistArsenal.json](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/defaultWhitelistArsenal.json)

## Zeus modules
- A - COLSOG AI
  - **Set AI Skills**: define sub-skills of AI.
  - **Toggle Trackers**: manage Tracker module (behaviour, speed, presence).
  - **Un-Garrison (enable PATH)**: make a unit/group move out of building.
- A - COLSOG Env
  - **Fog Low**
  - **Fog Ring**
  - **Transition Time**: transition with optional text to whenever in time.
  - **Vanilla Fog**: manage fog.
- A - COLSOG Radio
  - **Init PF77s**: add 3 new racks to vehicle (requires player to get in/exit vehicle before executing module on vehicle).
  - **NVA radio chatter**: enables to make tape-recorder object produce vietnamese radio like voice (used to simulate wire taping).
  - **Toggle CAS**: manage CAS asset available in the Radio Support module.
- A - COLSOG Vehicle
  - **Add STABO**: add the ability to deploy a rope from a helicopter to allow player on the ground to get into the helicopter.
  - **Add Crew management**: add the ability for the pilot of a helicopter to request AI crew members (door gunners).
  - **Conceal AA**: conceal static gun with a shelter.
- A - COLSOG Punji Traps
  - **Fall Trap**: create mace with punji sticks falling from a tree above trap wire.
  - **Swing Trap**: create mace with punji sticks swinging from a tree towards the trap wire.

see [init_colsog_zeus.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/init_colsog_zeus.sqf)

## CBA Settings
In the Addons configuration menu, you will have the ability to update the following values on the fly:

- **Vanilla medical items conversion to ace medical items**
  - Medikit
    - field dressing: <i>Integer</i>
    - saline IV 500: <i>Integer</i>
    - epinephrine: <i>Integer</i>
    - morphine: <i>Integer</i>
    - tourniquet: <i>Integer</i>
    - split: <i>Integer</i>
  - First Aid:
    - field dression: <i>Integer</i>
    - morphine: <i>Integer</i>

- **AI skills**
  - enable: <i>Boolean</i>
  - general: <i>Float</i>
  - aiming accuracy: <i>Float</i>
  - aiming speed: <i>Float</i>
  - aiming shake: <i>Float</i>
  - commanding: <i>Float</i>
  - courage: <i>Float</i>
  - spot distance: <i>Float</i>
  - sport time: <i>Float</i>
  - reload speed: <i>Float</i>
  - seek cover: <i>Boolean</i>
  - auto combat: <i>Boolean</i>
  - suppression: <i>Boolean</i>

- **Tracker module**
  - enable: <i>Boolean</i>
  - Tracker module name: <i>String</i>
  - Default behaviour: <i>["Careless", "Safe", "Aware", "Combat"]</i>
  - Default combat: <i>["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"]</i>
  - Default speed: <i>["Limited", "Normal", "Full"]</i>

- **Support module**
  - enable artillery: <i>Boolean</i>
  - enable helicopter: <i>Boolean</i>
  - enable jets: <i>Boolean</i>
  - enable arc light (B52): <i>Boolean</i>
  - enable daisy cutter: <i>Boolean</i>

- **STABO**
  - Action duration in seconds: <i>Integer</i>

- **AI Throwable**
  - Throwable to Remove from AI: <i>List\<String\> separated with , and no " required</i> 

- **Triangulation**
  - Required ACRE radio: <i>String</i>
  - Items to detect: <i>List\<String\> separated with , and no " required</i>
  - Cool down in seconds: <i>Integer</i>
  - Requires ACRE spike 'vhf30108spike' nearby (10m away max): <i>Boolean</i>
  - Threshold distance for signal strength 1/5: <i>Integer</i>
  - Threshold distance for signal strength 2/5: <i>Integer</i>
  - Threshold distance for signal strength 3/5: <i>Integer</i>
  - Threshold distance for signal strength 4/5: <i>Integer</i>
  - Threshold distance for signal strength 5/5: <i>Integer</i>

- **Punji Mace Traps**
  - Mace kill radius (m): <i>Integer</i>
  - Enable screams: <i>Boolean</i>
  - Side activating trap: <i>["BLUFOR", "OPFOR", "Independent", "Civilian", "Any player", "Any AI or player"]</i>

- **Battery**
  - PRC77 Battery capacity in seconds: <i>Integer</i>
  - Amount of radio calls before enemy detection: <i>Integer</i>
  - Item used as spare battery: <i>List\<String\> separated with , and no " required</i>
  - Groups impacted by enemy radio call detection: <i>List\<String\> separated with , and no " required</i>

## Features

### Gameplay

<details>

<summary>1. Radio Support</summary>

<h3>Allow Radio Support based on trait</h3>
Radio support from the Prairie Fire CDLC is available in a mission if all of the below points are true for a player:
- Radio Support module is present in the mission
- The player has the following radio (should only be the case for RTO if no Covey in a mission):

  ```
  "vn_b_pack_lw_06"
  ```

- Or if the player is flying one of the aircraft in the list:

  ```
  "JK_B_Cessna_T41_Armed_F", 
  "vnx_b_air_ac119_01_01", 
  "vn_b_air_ch34_03_01", 
  "vn_b_air_ch34_03_01", 
  "vn_b_air_ch34_04_01", 
  "vn_b_air_ch34_04_02", 
  "vn_b_air_oh6a_04"
  ```

- (IF unit_trait_required = 1 in description.ext) Player has the below code in its 'init' section

  ```
  this setUnitTrait["vn_artillery", true, true];
  ```

- All this can be modified in the vn_artillery_settings class in [artillery.hpp](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/artillery/artillery.hpp)

<h3>Enable/Disable Radio Support</h3>
We created a custom Zeus module to manage the availability of various supports (by default, none are available):
- artillery availability
- CAS (helicopter) availability
- CAS (jet) availability
- B-52 Arc Light strike availability
- Daisy Cutter availability

Here is how we emulate FOB with artillery support capabilities. By this we mean that the FOB can provide artillery support
within a perimeter (it will be 3.5km in our example).

- To do so, we use a public variable called 'SUPPORT_ENABLED' defined in [initServer.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initServer.sqf) and it is used as the condition in [artillery.hpp](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/artillery/artillery.hpp).

  ```
  SUPPORT_ENABLED = true; // Used with the artillery support from Prairie Fire. By default condition on artillery strike will be true thanks to this public variable.
  publicVariable "SUPPORT_ENABLED";
  ```

- then add a trigger that updates that variable (see example below).
  - Condition:
    ```
    this
    ```
  - On Activation:
    ```
    SUPPORT_ENABLED = true; 
    publicVariable "SUPPORT_ENABLED";
    ```
  - On Deactivation:
    ```
    SUPPORT_ENABLED = false; 
    publicVariable "SUPPORT_ENABLED";
    ```
</details>

<details>

<summary>2. Punji mace traps</summary>

<h3>Credits</h3>
- **Johnnyboy** for original implementation of mace trap that my scripts are based on.
- **Savage Game Design** for the objects and sound files used by this script.

<h3>HOW TO ADD THESE TRAPS TO YOUR MISSION</h3>
1. Place a Whip Trap object in the editor.  The direction you set the trap
   will be the direction the mace will swinging.
2. In the Whip Trap object's init field, put the following code:

```
[[this, 'WEST'], "functions\traps\swinging\colsog_fn_createSwingingMaceTrap.sqf"] remoteExec ["execVM", 0, true];
```

or

```
[[this, _trapHeight, _treeType], "functions\traps\falling\colsog_fn_createFallingMaceTrap.sqf"] remoteExec ["execVM", 0, true];
```

- _trapHeight: <i>Integer</i> (default 0, will allow the height to be automatically managed depending on _treeType)
- _treeType: <i>Integer</i>
  - 0: no tree.
  - 1: "\vn\vn_vegetation_f_exp\tree\vn_t_ficus_big_f.p3d"
  - 2: "\vn\vn_vegetation_f_exp\tree\vn_t_inocarpus_f.p3d"
  - 3: "vn\vn_vegetation_f_exp\tree\vn_t_palaquium_f.p3d"

</details>

<details>

<summary>3. ACRE2</summary>

<h3>Babel</h3>
Babel configuration present in:

- [init.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/init.sqf)
- [onPlayerRespawn.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/onPlayerRespawn.sqf)

Key to change languages: 'Right Alt'

We are using Babel to provide the following behaviour during our MACVSOG missions:
- Have the MACVSOG team able to talk and understand each other (using English)
- Have some members of the MACVSOG team that could speak and understand Vietnamese (be used as translator) by adding the below line in the 'init' section of the playable unit
  ```
  this setVariable ["f_languages",["en", "vn"]];
  ```

- Have the Zeus player speak Vietnamese when controlling an OPFOR unit. This makes the dialog between OPFOR and MACVSOG team possible only via the members speaking English and Vietnamese.

<h3>Adding PRC77 Racks to vehicle</h3>

Here are the steps to follow if you want to add 3 news acre radio racks to a vehicle:
- Place a vehicle in the editor or during a mission
- During the mission a player/zeus must enter the plane once in order to initialize ACRE radios in the plane
- Use the zeus module implemented in [colsog_zeus_initPf77Rack.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/colsog_zeus_initPf77Rack.sqf) and click on the vehicle
- The vehicle will now have 3 more racks of PRC77 radios:
  - A2A
  - A2G
  - HQ

</details>

<details>

<summary>4. Tracker module</summary>
We created a custom Zeus module to manage the AI trackers spawned by the tracker module. To use that module, the tracker module placed in the Eden editor needs to have the below name:

  ```
  TrackermoduleNAME
  ```

and the below code in its 'init' section.

  ```
  COLSOG_TrackersEnabled
  ```

By default:
- tracker module is disabled
- tracker behaviour is set as "CARELESS", "BLUE", "LIMITED".

</details>

<details>

<summary>5. Disable mine detector panel</summary>
For immersion purposes, we removed the HUD for mine detector.

see: [minedetector_disable_panel.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/minedetector_disable_panel.sqf)

</details>

<details>

<summary>6. Remove throwables from OPFOR AI</summary>
We removed the below items for OPFOR AIs:

```
"vn_rdg2_mag", 
"vn_molotov_grenade_mag"]
```

see [init_colsog_removeThrowables.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/init_colsog_removeThrowables.sqf)

</details>

<details>

<summary>7. Convert AI medikit/First aid kit to ace medical</summary>
At the death of a unit (AI/Player):

- Medikit are converted to:

  ```
  20x "ACE_fieldDressing"
  2x "ACE_salineIV_500"
  2x "ACE_epinephrine"
  2x "ACE_morphine"
  4x "ACE_tourniquet"
  2x "ACE_splint"
  ```

- FirstAidKit are converted to:

  ```
  5x "ACE_fieldDressing"
  1x "ACE_morphine"
  ```

see [colsog_fn_firstAidConvertAce.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/colsog_fn_firstAidConvertAce.sqf)

</details>

<details>

<summary>8. Add 'STABO' action on chopper in Eden Editor</summary>

Adds the ability to **any player** in the vehicle to drop/detach the STABO rig.

Place the below lines of code into the 'init' section of the vehicle.

```
this setVariable ["COLSOG_staboRopeDeployed", false, true]; 
this addAction 
[ 
    "<t color='#FF0000'>Drop the STABO rig</t>", 
    "functions\stabo\colsog_fn_dropStabo.sqf", 
    nil, 
    0, 
    true, 
    true, 
    "", 
    "(_this in _target) AND !(_target getVariable 'COLSOG_staboRopeDeployed')", 
    50, 
    false, 
    "", 
    "" 
]; 
this addAction 
[ 
    "<t color='#FF0000'>Detach ropes</t>", 
    "functions\stabo\colsog_fn_detatchRopes.sqf", 
    nil, 
    0, 
    true, 
    true, 
    "", 
    "(_this in _target) AND (_target getVariable 'COLSOG_staboRopeDeployed')", 
    50, 
    false, 
    "", 
    "" 
];
```

</details>

<details>

<summary>9. Add 'request crew' action on chopper in Eden Editor</summary>

Adds the ability to the **pilot** in the vehicle to request AI door gunners (crew) if:
- helicopter is touching the ground AND
- engine is off

(Crew can only be added once).

Place the below lines of code into the 'init' section of the vehicle.

```
this setVariable ["COLSOG_HasCrew", false, true]; 
this addAction 
[ 
    "<t color='#FFFF00'>Request crew</t>", 
    "functions\crew\colsog_fn_addCrew.sqf", 
    nil, 
    0, 
    true, 
    true, 
    "", 
    "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND !(_target getVariable 'COLSOG_HasCrew')", 
    50, 
    false, 
    "", 
    "" 
];
this addAction 
[ 
    "<t color='#FFFF00'>Remove crew</t>", 
    "functions\crew\colsog_fn_deleteCrew.sqf", 
    nil, 
    0, 
    true, 
    true, 
    "", 
    "(_this in _target) AND (driver _target isEqualTo _this) AND (isTouchingGround _target) AND !(isEngineOn _target) AND (_target getVariable 'COLSOG_HasCrew')", 
    50, 
    false, 
    "", 
    "" 
];
```

</details>

<details>

<summary>10. Radio battery/power management</summary>

Now the RTO will need to carry batteries for his radio. Currently managed ACRE radio:
- PRC77

You will have two new action under 'ace equipment' interaction:
- "Show battery level": If you have one of the above radio types in your inventory.
- "Add new battery": If you have one of the above radio types and a battery item in your inventory.

If your battery is **EMPTY**, the radio will be turned OFF (will not update radio GUI) and once a new battery has been added, 
you will have to turn it OFF/ON again in the radio GUI.

</details>

### Tips

<details>

<summary>1. Respawn with saved loadout</summary>

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

Then, by looking at the arsenal (from 2 meters maximum) and using the scroll wheel, you will have the option to 'save loadout'. This will allow you to respawn with the saved loadout instead of default loadout at connection.
</details>

<details>

<summary>2. Add image on map stand</summary>

To display any image on a map stand, follow the below steps:
- convert your .png into one of these resolution: 256x256, 512x512, 1024x1024 or 2048x2048
- 2 ways to convert .png to .paa:
  - Manual: use the TexView 2 (Arma 3 Tool) to convert the .png into a .paa (Use 'RGBA' and in the other section use 'DXT5')
  - Web: [ARMA 3 PAA CONVERTER](https://paa.gruppe-adler.de/)
- add .paa file into the 'images' folder
- add the below code in the 'init' section of the map stand:

  ```
  this setObjectTexture [0, "images\YOUR_IMAGE.paa"]
  ```

</details>

<details>

<summary>3. Add teleport flag</summary>

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

<summary>4. Force vietnamese face on players</summary>

N.B: Roles 1-0, 1-1 and 1-2 will not be impacted by the face change since they were US soldiers.

Playing as early MACV-SOG team, we are playing as south vietnamese thus we force vietnamese faces on all playable character.
At player initilization or at player respawn, one random asian face is selected from the below list and set for the current player.

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

To disable this feature, you can comment or remove the below line from [initPlayerlocal.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initPlayerlocal.sqf) and [onPlayerRespawn.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/onPlayerRespawn.sqf):

```
call COLSOG_fnc_faces;
```

You can also directly execute the below command on the server to directly reset all players faces to a random asian face:
```
call COLSOG_fnc_faces;
```

</details>

<details>

<summary>5. Add drinkable beer</summary>

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

<summary>6. Fuel consumption</summary>

Here is the code to place in the 'init' section of the vehicle you to change the fuel consumption of:
  ```
  _this setFuelConsumptionCoef 3; // Fuel consumption will be 3x default consumption.
  ```

</details>

<details>

<summary>7. Display kill counter</summary>
To add an action to display kill counter for each player on the server, add the below line in the 'init' section of an object:

```
this addAction ["Display total kills", "functions\colsog_fn_killCounter.sqf"]
```

this will give you a scroll wheel action to diplay the kill counter when looking at the object. see [colsog_fn_killCounter.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/colsog_fn_killCounter.sqf)

</details>