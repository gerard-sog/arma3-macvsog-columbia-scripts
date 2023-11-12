# arma3-macvsog-columbia-scripts

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
this setObjectTexture [0, "images\YOUR_IMAGE.paa"]
```

</details>

<details>

<summary>Allow Radio Support based on trait</summary>

Radio support from the Prairie fire DLC is available in a mission if all of the above are true for a player:
- Radio Support module is present in the mission
- The player has one of the following radio: ["vn_o_pack_t884_01", "vn_o_pack_t884_ish54_01_pl", "vn_o_pack_t884_m1_01_pl", "vn_o_pack_t884_m38_01_pl", "vn_o_pack_t884_ppsh_01_pl", "vn_b_pack_prc77_01_m16_pl", "vn_b_pack_03_m3a1_pl", "vn_b_pack_03_xm177_pl", "vn_b_pack_03_type56_pl", "vn_b_pack_03", "vn_b_pack_prc77_01", "vn_b_pack_trp_04", "vn_b_pack_trp_04_02", "vn_b_pack_03", "vn_b_pack_03_02", "vn_b_pack_lw_06", "vn_b_pack_m41_05"]
- Player has the below code in its 'init' section

```
this setUnitTrait["vn_artillery", true, true];
```

</details>