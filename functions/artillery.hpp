class vn_artillery_settings
{
        // Add your NUMBER variable that will be used as a cost variable - leave empty if you don't want the cost to matter.
        cost_variable = "";
        // Array - { Always available, `radio_backpacks`, `radio_vehicles`, `player_types`, "vn_artillery" unit trait}
        // Make the first true for the radio to be always avaliable
        availability[] = {0, 1, 1, 0, 0};
        unit_trait_required = 0;
	    // Distance from the edge of a blacklisted marker that a artillery/aircraft cannot be called in.
	    danger_distance = 0;
        radio_backpacks[] = {"vn_o_pack_t884_01", "vn_o_pack_t884_ish54_01_pl", "vn_o_pack_t884_m1_01_pl", "vn_o_pack_t884_m38_01_pl", "vn_o_pack_t884_ppsh_01_pl", "vn_b_pack_prc77_01_m16_pl", "vn_b_pack_03_m3a1_pl", "vn_b_pack_03_xm177_pl", "vn_b_pack_03_type56_pl", "vn_b_pack_03", "vn_b_pack_prc77_01", "vn_b_pack_trp_04", "vn_b_pack_trp_04_02", "vn_b_pack_03", "vn_b_pack_03_02", "vn_b_pack_lw_06", "vn_b_pack_m41_05"};
        radio_vehicles[] = {"vn_b_boat_05_01", "vn_b_wheeled_m54_03", "vn_b_wheeled_m151_01", "vn_b_wheeled_m54_02", "vn_b_wheeled_m54_01", "vn_b_wheeled_m54_mg_02", "vn_i_air_ch34_02_01", "vn_i_air_ch34_01_02", "vn_i_air_ch34_02_02"};
        player_types[] = {"vn_b_men_sog_05", "vn_b_men_sog_17", "vn_b_men_army_08", "vn_o_men_nva_dc_13", "vn_o_men_nva_65_27", "vn_o_men_nva_65_13", "vn_o_men_nva_27", "vn_o_men_nva_13", "vn_o_men_nva_marine_13", "vn_o_men_nva_navy_13", "vn_o_men_vc_local_27", "vn_o_men_vc_local_13", "vn_o_men_vc_regional_13"};
        // Planes
        class aircraft
        {
                class he
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_HE_NAME;
                        class rambler
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_CLUSTER_RAMBLER_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_433tfs_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_VESPA_DESCRIPTION;
                                magazines[] = {"vn_bomb_500_mk82_he_mag_x1","vn_bomb_500_mk82_he_mag_x1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 10;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class sundowner
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SUNDOWNER_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vf111_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SUNDOWNER_DESCRIPTION;
                                magazines[] = {"vn_bomb_500_blu1b_fb_mag_x1", ""};
                                vehicleclass = "vn_b_air_f4c_cas";
                                allow_double = 1;
                                cooldown = (60*5);
                                cost = 15;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class snake
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SNAKE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmfa323_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SNAKE_DESCRIPTION;
                                magazines[] = {"vn_rocket_s5_he_x16"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 10;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class showtime
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SHOWTIME_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vf96_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SHOWTIME_DESCRIPTION;
                                magazines[] = {"vn_m61a1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 6;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class hobo
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_HOBO_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_1sos_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_HOBO_DESCRIPTION;
                                magazines[] = {"vn_m61a1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 6;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class condor
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_CONDOR_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_b101_ca";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_CONDOR_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_m229_he_x7", "vn_rocket_ffar_m229_he_x7"};
                                vehicleclass = "vn_b_air_ah1g_01";
                                cooldown = (5*60);
                                cost = 6;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class dragon
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_DRAGON_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_a477_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_DRAGON_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_m229_he_x19", "vn_rocket_ffar_m229_he_x19"};
                                vehicleclass = "vn_b_air_uh1c_01_02";
                                cooldown = (5*60);
                                cost = 16;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                };
                class flechette
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_FLECHETTE_NAME;
                        class combat
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_COMBAT_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmfa314_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_COMBAT_DESCRIPTION;
                                magazines[] = {"","","vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_f4c_cas";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 8;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class banshee
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_BANSHEE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_29tas_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_BANSHEE_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_ah1g_04";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 6;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class scarface
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_SCARFACE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmo3_co.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_SCARFACE_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_uh1c_01_01";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 12;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                };
                class illumination
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_ILLUMINATION_ILLUMINATION_NAME;
                        class gnat
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_ILLUMINATION_GNAT_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_a101_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_ILLUMINATION_GNAT_DESCRIPTION;
                                magazines[] = {};
                                vehicleclass = "vn_b_air_uh1d_02_03";
                                allow_double = 1;
                                cooldown = (5*60);
                                illumination = 1;
                                cost = 0;
                                condition = "CAS_SUPPORT_ENABLED";
                        };
                        class dawn_1
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_DAWN_1_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_usarmy_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_DAWN_1_DESCRIPTION;
                                condition = "CAS_SUPPORT_ENABLED";
                                function = "vn_fnc_artillery_dawn_1";
                                allow_double = 0;
                                cooldown = (60*5);
                                illumination = 1;
                                cost = 0;
                        };
                };

                // The following config block is for missions running "S.O.G. Nickel Steel"
                // Avaliable at https://steamcommunity.com/sharedfiles/filedetails/?id=3083451905
                // This section is commented out by default, to enable it in your mission, remove the '/*' and '*/' below
                /*
                class support
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_SUPPORT_NAME;
                        class ac119_bomb
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_SUPPORT_AC119_BOMB_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_29tas_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_SUPPORT_AC119_BOMB_DESCRIPTION;
                                function = "vnx_fnc_artillery_ac119_bomb";
                                divergence = -250;
                                delay_max = 120;
                                cooldown = (60*5);
                                cost = 50;
                        };
                        class ac119_orbit
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_SUPPORT_AC119_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_29tas_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_SUPPORT_AC119_DESCRIPTION;
                                function = "vnx_fnc_artillery_ac119_orbit";
                                divergence = -1000;
                                delay_max = 120;
                                cooldown = (60*5);
                                cost = 50;
                        };
                };
                */
        };
        class artillery
        {
                class illumination
                {
                        displayname = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_ILLUMINATION_NAME;
                        class baker_1
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_BAKER_1_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l176_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_BAKER_1_DESCRIPTION;
                                ammo[] = {"vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 150;
                                count = 1;
                                illumination = 1;
                                cost = 0;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                        class mike_1
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_MIKE_1_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l119_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_MIKE_1_DESCRIPTION;
                                ammo[] = {"vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo","vn_flare_plane_med_w_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 150;
                                count = 1;
                                illumination = 1;
                                cost = 0;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                };
                class wp
                {
                        displayname = $STR_VN_ARTILLERY_ARTILLERY_WP_WP_NAME;
                        class baker_2
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_WP_BAKER_2_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l176_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_WP_BAKER_2_DESCRIPTION;
                                ammo[] = {"vn_shell_105mm_m60_wp_ammo","vn_shell_105mm_m60_wp_ammo","vn_shell_105mm_m60_wp_ammo","vn_shell_105mm_m60_wp_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 50;
                                count = 1;
                                cost = 10;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                };
                class he
                {
                        displayname = $STR_VN_ARTILLERY_ARTILLERY_HE_HE_NAME;
                        class baker_3
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_HE_BAKER_3_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l176_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_HE_BAKER_3_DESCRIPTION;
                                ammo[] = {"vn_shell_105mm_m1_he_ammo","vn_shell_105mm_m1_he_ammo","vn_shell_105mm_m1_he_ammo","vn_shell_105mm_m1_he_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 50;
                                count = 1;
                                cost = 16;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                };
                class frag
                {
                        displayname = $STR_VN_ARTILLERY_ARTILLERY_FRAG_FRAG_NAME;
                        class baker_5
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_FRAG_BAKER_5_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l176_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_FRAG_BAKER_5_DESCRIPTION;
                                ammo[] = {"vn_shell_105mm_m546_frag_ammo","vn_shell_105mm_m546_frag_ammo","vn_shell_105mm_m546_frag_ammo","vn_shell_105mm_m546_frag_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 50;
                                count = 1;
                                cost = 8;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                };
                class airburst
                {
                        displayname = $STR_VN_ARTILLERY_ARTILLERY_AIRBURST_AIRBURST_NAME;
                        class baker_6
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_AIRBURST_BAKER_6_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_l176_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_AIRBURST_BAKER_6_DESCRIPTION;
                                ammo[] = {"vn_shell_105mm_m1_ab_ammo","vn_shell_105mm_m1_ab_ammo","vn_shell_105mm_m1_ab_ammo","vn_shell_105mm_m1_ab_ammo"};
                                allow_double = 1;
                                cooldown = (60*5);
                                divergence = 50;
                                count = 1;
                                cost = 16;
				                condition = "ARTILLERY_SUPPORT_ENABLED";
                        };
                };
        };
};