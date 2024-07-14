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
	    // Maximum delay for the support to arrive, regardless of the time calculated from distance to support module.
	    delay_max = 15;
	    // Radio Support should only be called in by Covey plane. This radio backpack is in case no covey pilot present for an operation and we still want Columbia to be able to use Radio Support.
        radio_backpacks[] = {"vn_b_pack_lw_06"};
        // Radio Support should only be called from Covey plane.
        radio_vehicles[] = {"JK_B_Cessna_T41_Armed_F", "vnx_b_air_ac119_01_01", "vn_b_air_ch34_03_01", "vn_b_air_ch34_03_01", "vn_b_air_ch34_04_01", "vn_b_air_ch34_04_02", "vn_b_air_oh6a_04", "vn_i_air_ch34_02_02"};
        player_types[] = {"vn_b_men_sog_05", "vn_b_men_sog_17", "vn_b_men_army_08", "vn_o_men_nva_dc_13", "vn_o_men_nva_65_27", "vn_o_men_nva_65_13", "vn_o_men_nva_27", "vn_o_men_nva_13", "vn_o_men_nva_marine_13", "vn_o_men_nva_navy_13", "vn_o_men_vc_local_27", "vn_o_men_vc_local_13", "vn_o_men_vc_regional_13"};
        // Planes
        class aircraft
        {
                class he
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_HE_NAME;
                         class commando_vault // A 15, 000lb BLU-82 dropped from an aircraft (aka "Daisy Cutter").
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_COMMANDO_VAULT_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_29tas_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_COMMANDO_VAULT_DESCRIPTION;
                                function = "vn_fnc_artillery_commando_vault";
                                divergence = -45;
                                delay_max = 120;
                                cooldown = (60*5);
                                cost = 50;
                                condition = "DAISY_CUTTER_SUPPORT_ENABLED";
                        };
                        class arc_light // Carpet bombing run of 20x 750lb M117 demolition bombs from an B-52.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_ARC_LIGHT_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_69bs_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_ARC_LIGHT_DESCRIPTION;
                                function = "vn_fnc_artillery_arc_light";
                                divergence = 200;
                                cooldown = (60*5);
                                cost = 50;
                                condition = "ARC_LIGHT_SUPPORT_ENABLED";
                        };
                        class rambler // A fast strike of 2x Mk82 500lb bombs from an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_CLUSTER_RAMBLER_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_433tfs_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_VESPA_DESCRIPTION;
                                magazines[] = {"vn_bomb_500_mk82_he_mag_x1","vn_bomb_500_mk82_he_mag_x1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 10;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class sundowner // A strike of 2x BLU/1B Napalm bombs dropped from an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SUNDOWNER_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vf111_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SUNDOWNER_DESCRIPTION;
                                magazines[] = {"vn_bomb_500_blu1b_fb_mag_x1", ""};
                                vehicleclass = "vn_b_air_f4c_cas";
                                allow_double = 1;
                                cooldown = (60*5);
                                cost = 15;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class snake // 125mm high-explosive rockets fired from an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SNAKE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmfa323_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SNAKE_DESCRIPTION;
                                magazines[] = {"vn_rocket_s5_he_x16"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 10;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class showtime // 20mm high-explosive Gunpod fired from an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_SHOWTIME_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vf96_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_SHOWTIME_DESCRIPTION;
                                magazines[] = {"vn_m61a1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 6;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class hobo // 20mm high-explosive Vulcan Minigun support provided by an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_HOBO_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_1sos_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_HOBO_DESCRIPTION;
                                magazines[] = {"vn_m61a1"};
                                vehicleclass = "vn_b_air_f4c_cas";
                                cooldown = (60*5);
                                cost = 6;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class condor // 14x Rockets 70mm high-explosive fired from a AH-1G Cobra.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_CONDOR_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_b101_ca";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_CONDOR_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_m229_he_x7", "vn_rocket_ffar_m229_he_x7"};
                                vehicleclass = "vn_b_air_ah1g_01";
                                cooldown = (5*60);
                                cost = 6;
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
                        };
                        class dragon // 38x 70mm high-explosive rockets fired from a UH-1C Huey gunship.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_HE_DRAGON_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_a477_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_HE_DRAGON_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_m229_he_x19", "vn_rocket_ffar_m229_he_x19"};
                                vehicleclass = "vn_b_air_uh1c_01_02";
                                cooldown = (5*60);
                                cost = 16;
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
                        };
                };
                class flechette
                {
                        displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_FLECHETTE_NAME;
                        class combat // 70mm Flechette rockets fired from an F-4 Phantom.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_COMBAT_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmfa314_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_COMBAT_DESCRIPTION;
                                magazines[] = {"","","vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_f4c_cas";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 8;
                                condition = "CAS_JETS_SUPPORT_ENABLED";
                        };
                        class banshee // 70mm Flechette rockets fired from an AH-1G Cobra.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_BANSHEE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_29tas_ca.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_BANSHEE_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_ah1g_04";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 6;
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
                        };
                        class scarface // 70mm Flechette rockets fired from an UH-1C Huey gunship.
                        {
                                displayname = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_SCARFACE_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_vmo3_co.paa";
                                description = $STR_VN_ARTILLERY_AIRCRAFT_FLECHETTE_SCARFACE_DESCRIPTION;
                                magazines[] = {"vn_rocket_ffar_wdu4_flechette_x7",""};
                                vehicleclass = "vn_b_air_uh1c_01_01";
                                allow_double = 1;
                                cooldown = (5*60);
                                cost = 12;
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
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
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
                        };
                        class dawn_1
                        {
                                displayname = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_DAWN_1_NAME;
                                icon = "vn\ui_f_vietnam\data\decals\vn_callsign_src_usarmy_ca.paa";
                                description = $STR_VN_ARTILLERY_ARTILLERY_ILLUMINATION_DAWN_1_DESCRIPTION;
                                function = "vn_fnc_artillery_dawn_1";
                                allow_double = 0;
                                cooldown = (60*5);
                                illumination = 1;
                                cost = 0;
                                condition = "CAS_HELICOPTER_SUPPORT_ENABLED";
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