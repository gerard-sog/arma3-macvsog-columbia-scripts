# Arma 3 S.O.G. RT Columbia

Compilation of scripts used during multiplayer PVE/PVP mission on Arma 3. Also featuring defaults loadouts and missions as well as providing CBA settings to easily tweak the scripts to your liking. 
- If you want to contribute to this project, see [CONTRIBUTING.md](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/CONTRIBUTING.md).
- For demo of scripts, see [RT Columbia - Youtube videos](https://www.youtube.com/@RTColumbia/videos).

### Special thanks

- <u>Kay</u> (RT Columbia Discord): for the constant help developing and fixing scripts.
- <u>Johnnyboy</u> (S.O.G. Prairie Fire Discord): for the original scripts for the mace trap and bayonet rush.
- <u>Sky</u> (S.O.G. Prairie Fire Discord): for the help regarding the bayonet charge scripts.

---

## Table of contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Default values](#default-values)
- [Zeus modules](#zeus-modules)
- [CBA Settings](#cba-settings)
- [Features](#features)
- [RT Columbia mods](#rt-columbia-mods)

---

## Requirements
- [Prairie Fire DLC](https://store.steampowered.com/app/1227700/Arma_3_Creator_DLC_SOG_Prairie_Fire/)
- [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997)
- [ace](https://steamcommunity.com/workshop/filedetails/?id=463939057)
- [ACRE2](https://steamcommunity.com/workshop/filedetails/?id=751965892)
- [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)

---

## Installation
Installation of all the scripts/zeus modules is done by **copying the below files and folder directly into your mission folder** where your **"mission.sqm"** file is located (ex: C:\Users\<user_name>\Documents\Arma 3 - Other Profiles\<profile_name>\missions\KheSanhMission01.vn_khe_sanh).
- [functions](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions) (<i>Folder</i>)
- [description.ext](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/description.ext) (<i>File</i>)
- [init.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/init.sqf) (<i>File</i>)
- [initPlayerlocal.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initPlayerlocal.sqf) (<i>File</i>)
- [initServer.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initServer.sqf) (<i>File</i>)
- [onPlayerRespawn.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/onPlayerRespawn.sqf) (<i>File</i>)

---

## Default values
- Default <b>loadouts</b>:
  - BLUFOR:
    - [covey](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/covey.json)
    - [rifleman](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/default_rifleman.json)
    - [grenadier](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/Grenadier.json)
    - [medic](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/Medic.json)
    - [RPD Gunner](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/MG_RPD.json)
    - [pointman](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/Pointman_AK.json)
    - [RTO](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/RTO.json)
    - [Squad leader](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/squad_leader.json)
    - [Tail Gunner](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/BLUFOR/tail_gunner.json)
  - OPFOR:
    - [Tracker](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/loadouts/OPFOR/tracker.json)
- Default <b>missions</b>:
  - [Cam_Lao_Nam](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/Cam_Lao_Nam/mission.sqm): Includes borders between ARVN (South Vietnam), PAVN (North Vietnam), Khmer Republic, Laos and Cambodia.
  - [fox_pamai](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/fox_pamai/mission.sqm): Includes FOB from vn_the_bra and an Airfield in out of bound area.
  - [fox_vanam](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/fox_vanam/mission.sqm): Includes border between (South Vietnam) and Cambodia, Special Forces FOB and the Do Lung Bridge (same bridge as Apocalypse Now).
  - [vn_khe_sanh](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/vn_khe_sanh/mission.sqm)
  - [vn_the_bra](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/vn_the_bra/mission.sqm)
  - [Dong_Giang](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/missions/Dong_Giang/mission.sqm)
- Default <b>addons</b> for missions: [defaultAddons.txt](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/defaultAddons.txt)
- Default <b>arsenals</b>: 
  - [defaultWhitelistArsenal.json](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/arsenals/defaultWhitelistArsenal.json)
  - [defaultPilotWhitelistArsenal.json](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/default/arsenals/defaultPilotWhitelistArsenal.json)

---

## Zeus modules
- A - COLSOG AI
  - **Set AI Skills**: define sub-skills of AI.
  - **Toggle Trackers**: manage Tracker module (behaviour, speed, presence).
  - **Un-Garrison (enable PATH)**: make a unit/group move out of building.
  - **Bayonet charge**: make a unit/group rush closest target and only use bayonet attack.
- A - COLSOG Env
  - **Day/Night Cycle**: allows to have day of X hours, dusk of Y hours and night of Z hours.
  - **Fog Low**
  - **Fog Ring**
  - **Transition Time**: transition with optional text to whenever in time.
  - **Vanilla Fog**: manage fog.
- A - COLSOG Radio
  - **Init PF77s**: add 3 new racks to vehicle.
  - **NVA radio chatter**: enables to make tape-recorder object produce vietnamese radio like voice (used to simulate wire taping).
  - **Toggle CAS**: manage CAS asset available in the Radio Support module & SIMPLEX support module.
- A - COLSOG Vehicle
  - **Add STABO**: add the ability to deploy a rope from a helicopter to allow player on the ground to get into the helicopter.
  - **Add Crew management**: add the ability for the pilot of a helicopter to request AI crew members (door gunners).
  - **Conceal AA**: conceal static gun with a shelter.
  - **Create supply box**: create a supply box with customizable content.
- A - COLSOG Punji Traps
  - **Fall Trap**: create mace with punji sticks falling from a tree above trap wire.
  - **Swing Trap**: create mace with punji sticks swinging from a tree towards the trap wire.
- A - COLSOG Intel
  - **Update Intel**: Update array of intel during a mission.

see [init_colsog_zeus.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/init_colsog_zeus.sqf)

---

## CBA Settings
In the Addons configuration menu, you will have the ability to update the following values on the fly:

<details>

<summary>COLSOG Medical and Supply</summary>

vanilla medical items conversion to ace medical items

  - **Medikit**
    - field dressing: <i>Integer</i>
    - saline IV 500: <i>Integer</i>
    - epinephrine: <i>Integer</i>
    - morphine: <i>Integer</i>
    - tourniquet: <i>Integer</i>
    - split: <i>Integer</i>
    
  - **First Aid**
    - field dression: <i>Integer</i>
    - morphine: <i>Integer</i>

</details>

<details>

<summary>COLSOG AI and ENV related</summary>

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
    
  - **AI Throwable**
    - Throwable to Remove from AI: <i>List\<String\> separated with , and no " required</i>
    
  - **Day & Night**
    - Time before day considered as dawn (minutes): <i>Integer</i>
    - Dawn time acceleration: <i>Integer</i>
    - Day time acceleration: <i>Integer</i>
    - Time before night considered as dusk (minutes): <i>Integer</i>
    - Dusk time acceleration: <i>Integer</i>
    - Night time acceleration: <i>Integer</i>

</details>

<details>

<summary>COLSOG Prairie Fire Module</summary>

  - **Tracker module**
    - enable: <i>Boolean</i>
    - Tracker module name: <i>String</i>
    - Default behaviour: <i>["Careless", "Safe", "Aware", "Combat"]</i>
    - Default combat: <i>["Never fire", "Hold fire", "Hold fire, engage at will", "Fire at will", "Fire at will, loose formation"]</i>
    - Default speed: <i>["Limited", "Normal", "Full"]</i>
    
  - **Support module - Radio Support & Simplex**
    - enable artillery: <i>Boolean</i>
    - enable helicopter: <i>Boolean</i>
    - enable jets: <i>Boolean</i>
    - enable arc light (B52): <i>Boolean</i>
    - enable daisy cutter: <i>Boolean</i>

  - **Support module - Simplex**
    - Backpack(s) with Simplex: <i>String</i>

</details>

<details>

<summary>COLSOG Sensors</summary>

  - **Sensors - Gunshot**
    - Inventory item to use: <i>String</i>
    - Thing item used as sensor: <i>String</i>
    - Transmit data over radio: <i>Boolean</i>
      - Player received diary record + audio bip by radio waves requires:
        ```
        this setvariable ["COLSOG_isListeningToSensor", true];
        ```
    - Radio transmission range (m): <i>Integer</i>
    - Sensor logging frequency (sec): <i>Integer</i>

  - **Sensors - Engine**
    - Inventory item to use: <i>String</i>
    - Thing item used as sensor: <i>String</i>
    - Transmit data over radio: <i>Boolean</i>
      - Player received diary record + audio bip by radio waves requires:
        ```
        this setvariable ["COLSOG_isListeningToSensor", true];
        ```
    - Radio transmission range (m): <i>Integer</i>
    - Sensor logging frequency (sec): <i>Integer</i>

  - **Sensors - Gravity**
    - Inventory item to use: <i>String</i>
    - Thing item used as sensor: <i>String</i>
    - Transmit data over radio: <i>Boolean</i>
      - Player received diary record + audio bip by radio waves requires:
        ```
        this setvariable ["COLSOG_isListeningToSensor", true];
        ```
    - Radio transmission range (m): <i>Integer</i>
    - Sensor logging frequency (sec): <i>Integer</i>

</details>

<details>

<summary>COLSOG Miscellaneous</summary>

  - **STABO**
    - Action duration in seconds: <i>Integer</i>
    - Rope length (m): <i>Integer</i>

  - **Punji Mace Traps**
    - Mace kill radius (m): <i>Integer</i>
    - Enable screams: <i>Boolean</i>
    - Side activating trap: <i>["BLUFOR", "OPFOR", "Independent", "Civilian", "Any player", "Any AI or player"]</i>
    - Chance of being impaled (%): <i>Integer</i>

  - **Intel**
    - Intel object (inventory item): <i>String</i>
    - Chance of unit carrying intel (%): <i>Integer</i>
    - Chance of intel falling on ground (%): <i>Integer</i>
    - Requires trait 'COLSOG_intelExpert' to decrypt intel : <i>Boolean</i>

  - **Climbing**
    - Units allowed to climb trees: <i>String</i>
    - Required item to climb: <i>String</i>
    - Time to climb up (sec): <i>Integer</i>
    - Time to climb down (sec): <i>Integer</i>

  - **Covertop**
    - Force all players to vietnamese faces: <i>Boolean</i>

</details>

<details>

<summary>COLSOG Radio and Battery</summary>

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

  - **Battery**
    - PRC77 Battery capacity in seconds: <i>Integer</i>
    - Amount of radio calls before enemy detection: <i>Integer</i>
    - Item used as spare battery: <i>List\<String\> separated with , and no " required</i>
    - Groups impacted by enemy radio call detection: <i>List\<String\> separated with , and no " required</i>

</details>

<details>

<summary>COLSOG Bayonet Charge</summary>

  - **Bayonet Charge**
    - Enable screams: <i>Boolean</i>
    - Search radius (m): <i>Integer</i>
    - Damage given to player: <i>Integer</i>

</details>

<details>

<summary>COLSOG Tree cutting</summary>

  - **Tree cutting**
    - Reach with cutting tool (m): <i>Integer</i>

</details>

<details>

<summary>COLSOG Deforestation</summary>

  - **C4 Explosive - Unconscious**
    - Search radius for units to unconscious (m): <i>Integer</i>
    - Maximum time unconscious in seconds (if at 0m from explosion): <i>Integer</i>

 - **C4 Explosive - Trees**
    - Search radius for trees ( > destruction radius) (m): <i>Integer</i>
    - Destruction radius for trees ( < search radius) (m): <i>Integer</i>

 - **Bombs/Napalm**
    - Activate debug mode (see bomb name): <i>Boolean</i>
    - Time before embers removal (sec): <i>Integer</i>
</details>

<details>

<summary>COLSOG OPFOR</summary>

- **Hunting**
    - Debug mode: <i>Boolean</i>
    - Search time (sec): <i>Integer</i>
    - Detection radius far (m): <i>Integer</i>
    - Detection radius medium (m): <i>Integer</i>
    - Detection radius close (m): <i>Integer</i>
    - marker TTL (sec): <i>Integer</i>
    - 3D footprint TTL (sec): <i>Integer</i>
    - Marker spawn threshold: <i>Integer</i>

</details>
  
see [CBASettings.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/CBASettings.sqf)

---

## Features

Some features such as who is able to climb trees, read intel, etc. are now managed through the unit's name. See [init_colsog_PlayerLocalVar.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/init/init_colsog_PlayerLocalVar.sqf) for more details and if you want to customize it.

Here is a list of roles and their available actions:

| Roles              | Has american face<br/>"hasUsface" | Can climb tree<br/>"canClimb" | Can read intel<br/>"canReadIntel" | Can speak languages<br/>"canSpeak" | Can monitor sensors<br/>"canMonitorSensor" | Can use simplex<br/>"canUseSimplex" | visibleFootprint |
|--------------------|-----------------------------------|-------------------------------|-----------------------------------|------------------------------------|--------------------------------------------|-------------------------------------|------------------|
| Chief SOG          | true                              | false (default)               | true                              | en (default)                       | false (default)                            | true                                | false (default)  | 
| Pilot              | true                              | false                         | false (default)                   | en                                 | true                                       | true                                | false            |
| 0-1 Tail Gunner    | false (default)                   | true                          | true                              | en, vn                             | false                                      | false (default)                     | true             |
| 0-2 Machine Gunner | false                             | false                         | true                              | en, vn                             | false                                      | false                               | true             |
| 0-3 Grenadier      | false                             | false                         | true                              | en, vn                             | false                                      | false                               | true             |
| 0-4 Point man      | false                             | true                          | true                              | en, vn                             | false                                      | false                               | true             |
| 1-0 Squad Leader   | true                              | false                         | false                             | en                                 | false                                      | false                               | true             |
| 1-1 RTO            | true                              | false                         | false                             | en                                 | false                                      | false                               | true             |
| 1-2 Medic          | true                              | false                         | false                             | en                                 | false                                      | false                               | true             |
| Tracker            | false                             | true                          | false                             | vn                                 | false                                      | false                               | false            |
| Reserves           | false                             | false                         | false                             | en, vn                             | false                                      | false                               | true             |

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
- **Johnnyboy** for original implementation of:
  - mace trap
  - bayonet charge
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

and the below code in its 'Run condition' section.

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

If your battery is **EMPTY**, the radio will be turned OFF and once a new battery has been added it will be turned ON again automatically.

</details>

<details>

<summary>11. Triangulation</summary>

In order to triangulate enemy radios, you will need:
- To set the frequency on the in the object (see 'Items to detect' in CBA setting to use other objects) the players will have to triangulate with the below code in the 'init' section of the object (ex: frequency set to 52.50).

```
this setVariable ["COLSOG_radioFrequency", 52.50, true]; 
```

- The players will have to set the frequency of the PRC77 radio to the desired frequency (in this example 52.50) and then use the triangulate action in 'ace self-interact equipment' menu.

There is a timeout on the triangulation process (see 'Cool down in seconds' in CBA setting) after each execution.

</details>

<details>

<summary>12. Sensors</summary>

<details>

<summary>12.1. 'Gunshot' Sensor</summary>

See Addons settings to configure this sensor.

- Detects:
  - When a gunshot is fired in its vicinity (maximum 70 meters).
  - When an OPFOR enters its 25 meters detection radius.
- Stores Data:
  - Locally on the object and can be collect using the 'collect' action on the item. Will be save as diary entry.
  - Sends data over radio wave and player with bellow line of code will receive the diary record from distance (useful for pilots).

    ```
    this setvariable ["COLSOG_isListeningToSensor", true]; 
    ```
    
- To place it in the **Eden Editor**, place the below line in the 'init' section fo the object:
  - 1st parameter: Object used as sensor, needs to be 'this'.
  - 2nd parameter: the ID given to the sensor (it will not update the sensor ID counter so ideally this value should be greater than 25 to avoid duplicate ID during your mission if players are expected to place sensors as well).
      ```
      [this, 25] execVM "functions\sensors\gunshot\fn_createGunshotSensor.sqf";
      ```

</details>

<details>

<summary>12.2. 'Engine' Sensor</summary>

See Addons settings to configure this sensor.

- Detects:
  - When an OPFOR Vehicles enters its 50 meters detection radius.
- Stores Data:
  - Locally on the object and can be collect using the 'collect' action on the item. Will be save as diary entry.
  - Sends data over radio wave and player with bellow line of code will receive the diary record from distance (useful for pilots).

    ```
    this setvariable ["COLSOG_isListeningToSensor", true]; 
    ```

- To place it in the **Eden Editor**, place the below line in the 'init' section fo the object:
  - 1st parameter: Object used as sensor, needs to be 'this'.
  - 2nd parameter: the ID given to the sensor (it will not update the sensor ID counter so ideally this value should be greater than 25 to avoid duplicate ID during your mission if players are expected to place sensors as well).
      ```
      [this, 26] execVM "functions\sensors\engine\fn_createEngineSensor.sqf";
      ```

</details>

<details>

<summary>12.3. 'Gravity' Sensor</summary>

Same as 'Gunshot' Sensor but can only be thrown from a helicopter/plane. The sensor will activate after 30 seconds in order to give it time to land on the ground.

</details>

</details>

<details>

<summary>13. Intel on body</summary>

Now, when a unit is killed, there is a chance that the unit will be carrying intel. And there is also a chance that the intel falls from his pocket onto the ground.

To exploit the intel:
- Pick it up.
- Ace self-interact and under 'ACE equipment' select 'Decrypt intel'.
- This will consume the intel and retrieve one intel from an array of intel that the mission maker can place in [initServer.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/initServer.sqf) and write a diary entry.

Zeus can update the array of available intel using zeus module 'COLSOG - Intel'.

```
COLSOG_intelPool = [
    "intel 1",
    "intel 2",
    "intel 3",
    "intel 4",
    "intel 5"
    ]; 
```

It is also possible to only allow decryption of intel if player has the following attribute set in his 'init' section:

```
this setvariable ["COLSOG_intelExpert", true];
```

Else the player will see "You cannot read the document...".

If intel pool is empty and a player tries to decrypt an intel, the player will receive a hint displaying "Contains no valuable information.".

</details>

<details>

<summary>14. Climbing up/down trees</summary>

Allows player to climb up trees to see further away, orient himself/herself.

To climb up a tree follow this steps:
- Have required role (unit's name), item and make sure tree is in the config of authorized tree to climb (see [fn_climbTree.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/climbing/fn_climbTree.sqf). 

```
private _hashMapOfAuthorizedTreesAndHeightCorrection = [
    ["t_cyathea_f.p3d", 2],
    ["t_cocos_tall_f.p3d", 9],
    ["t_cocosnucifera3s_tall_f.p3d", 0],
    ["t_inocarpus_f.p3d", 8],
    ["t_palaquium_f.p3d", 3],
    ["t_ficus_big_f.p3d", 15],
    ["t_cocosnucifera2s_small_f.p3d", 8]
];
```

- Go close enough to a tree and go in 'ace equipment' --> "Climb up".
- To go down, go in 'ace equipment' --> "Climb down".

It is also configurable through CBA Settings (see 'CBA Settings' section of the readme).

Steps to add/remove trees:
- Get .p3d name of the tree using the below command (to be executed while aiming at a tree):

```
private _object = cursorObject; 
private _modelInfo = getModelInfo _object;
private _objectP3dName = _modelInfo select 0;
_objectP3dName;
```

- Teleport yourself at the top of the tree using the below code (find the appropriate value for "TREE_HEIGHT_CORRECTION"):

```
private _playerPos = getPos player;
player setPos [_playerPos select 0, _playerPos select 1, <TREE_HEIGHT_CORRECTION> + 3];
```

- Update the list of trees with new name and new TREE_HEIGHT_CORRECTION value. 

</details>

<details>

<summary>15. Cutting/Exploding trees</summary>

Allows player clear LZ or path by cutting/exploding trees, bushes, etc.

To cut a tree follow this steps:
- Equip one of the following secondary weapons "vn_m_axe_01" or "vn_m_bolo_01".
- Optional, you can configure amounts of hit required to cut a tree byt updating the hashmap '_hashMapOfTreeAndTimeToCut' in [fn_cutSmallTree.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/deforestation/fn_cutSmallTree.sqf)
```
// Tree name - Amount of hit required to cut the tree.
private _hashMapOfTreeAndTimeToCut = [
    ["vn_pine_tree_01.p3d", 6],
    ["vn_t_agathis_tall_f.p3d", 6],
    ["vn_t_cyathea_f.p3d", 4],
    ["vn_b_cycas_f.p3d", 2],
    ["vn_t_banana_slim_f.p3d", 1],
    ["vn_t_banana_f.p3d", 1],
    ["vn_b_calochlaena_f.p3d", 1],
    ["vn_t_palaquium_f.p3d", 8],
    ["vn_elephant_grass_01_lc.p3d", 1],
    ["vn_t_pritchardia_f.p3d", 2],
    ["vn_b_leucaena_f.p3d", 2],
    ["vn_bamboo_bush_01.p3d", 1],
    ["vn_dried_t_ficus_medium_01.p3d", 8],
    ["vn_t_cocos_bend_f.p3d", 6],
    ["vn_t_cocosnucifera3s_tall_f.p3d", 6],
    ["vn_t_agathis_wide_f.p3d", 8]
];
```

- Hit the tree with the secondary weapon.

Some bigger trees are too though to cut. This is where we can use C-4 (ACE "c4_charge_small") to explode those (see [fn_detonateCharge.sqf](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/deforestation/fn_detonateCharge.sqf)).

To explode a tree follow this steps:
- Using the ACE action, place a C-4 and arm it.
- (Small trees and bush in the blast radius will also be destroyed).

</details>

<details>

<summary>16. C4 explosives for POW snatch</summary>

Adds an unconscious radius to the C4 explosives. 

Currently, we only manage 1 type of explosive:

```
 c4_charge_small.p3d
```

This will:
- Make <u>**any player in the blast radius unconscious for X seconds**</u> (configurable via addons setting), with X lowering the further from the explosion you are.
- Make <u>**AI go unconscious**</u> (not the ACE unconscious, the Arma version. This make this script working if you have AI to die on ace unconscious) and put them in a **<u>specific animation</u>** to easily recognize them.
- Make <u>**drivers (AI and player) go unconscious**</u> (no other crew of the vehicle). For AI driver, they will be put in a <u>**unconscious position**</u> (head against the steering wheel).

Also:
- AI will never wake up once unconscious and if you carry/drag them around, the <u>**specific unconscious position**</u> will be set again each time you drop them.
</details>

<details>

<summary>17. Bomb/Napalm deforestation</summary>

Adds an Event Handler (EH) to "Air" vehicle to detect when a bomb is dropped and if the bomb is in the list of managed bombs (see variable '_hashMapOfBombsAndIsNapalmAndRadius' in [init_colsog_deforestation](https://github.com/gerard-sog/arma3-macvsog-columbia-scripts/blob/main/functions/deforestation/init_colsog_deforestation.sqf)), 
it will trigger a script to either burn or destroy the tree in a radius around the bomb impact point.

Currently, we only manage the below types of bombs:

```
    private _hashMapOfBombsAndIsNapalmAndRadius = [
        // Napalm
        ["frl_blu1b_fly.p3d", true, 40, 0],
        ["frl_mk77_fly.p3d", true, 30, 0],
        ["uns_blu1_fly.p3d", true, 40, 0],
        ["vn_bomb_blu1b_fb.p3d", true, 40, 0],
        ["vn_bomb_blu1b_500_fb.p3d", true, 30, 0],
        // Bombs
        ["frl_mk82.p3d", false, 10, 0],
        ["frl_mk84.p3d", false, 35, 10],
        ["uns_mk82.p3d", false, 10, 0],
        ["uns_mk83.p3d", false, 20, 0],
        ["vn_bomb_mk82_dc.p3d", false, 10, 0],
        ["vn_bomb_mk82_he.p3d", false, 10, 0],
        ["vn_bomb_mk82_se_proxy.p3d", false, 10, 0],
        ["vn_bomb_mk83_he.p3d", false, 20, 0],
        ["vn_bomb_mk84_he.p3d", false, 35, 10],
        ["vn_bomb_m117_01_he.p3d", false, 15, 0]
    ];
```

Structure of the '_hashMapOfBombsAndIsNapalmAndRadius' array. Each element of the array must contain 4 values:
- <u>**1) NAME_OF_BOMB**</u>: Bomb .p3d name (obtained by toggle the debug mod in COLSOG_DEFORESTATION) and dropping a bomb. At the bottom left of your screen you will see the bomb name.
- <u>**2) IS_NAPALM**</u>: True if it contains napalm, false otherwise.
- <u>**3) DESTRUCTION_RADIUS**</u>: Radius in meter (from the bomb impact) where trees and bushes will be burned or destroyed.
- <u>**4) OBLITERATION_RADIUS**</u>: Radius in meter (from the bomb impact) where trees, bushes and other objects will be completely destroyed. (mainly used to have bomb acting as <u>daisy-cutter</u>)

</details>

<details>

<summary>18. OPFOR tracker</summary>

Adds a Per Frame Handler (PFH) on all players with 'visibleFootprint' variable set to true (aka the prey). This will create invisible markers with a specific syntax that can be 
detected by the OPFOR player (aka the hunter) using an ACE action.

Adds a new ACE action to the OPFOR player in order to search for footprints in a configurable radius. Once footprints are detected, it will display a hint towards the freshest footprint.

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

<summary>7. Cam Lao Nam borders</summary>

[Original credit](https://github.com/Savage-Game-Design/A3-Modding-Example/tree/master/missions/map_borders.cam_lao_nam). This script converts a series of vectors to create nice borders. 
Currently only for Cam Lao Nam. To enable, uncomment the line: 

```
[] spawn compileScript ["vet_border\init.sqf"];
```

in the main init.sqf and place down the [Cam Lao Nam borders composition](https://steamcommunity.com/sharedfiles/filedetails/?id=3334463724) which contains the necessary markers.
</details>

---

## RT Columbia mods

- Procedure to create a new Arma 3 inventory object from scratch: https://github.com/gerard-sog/arma3-macvsog-columbia-items.
- Custom gesture wheel: https://steamcommunity.com/sharedfiles/filedetails/?id=3339280489.