/*
 * init.sqf
 * Executes at mission start (last in order in dedicated context, sooner in MP)
 *
 * https://community.bistudio.com/wiki/Initialisation_Order
 *
 * No parameters are passed to this script
 *
 */

// init COLSOG Zeus Custom Modules
execVM "functions\init_colsog_zeus.sqf";

// init removeThrowables on Opfor units
execVM "functions\init_colsog_removeThrowables.sqf";

// init Gunshot sensors placed by player
execVM "functions\sensors\gunshot\init_colsog_gunshotSensor.sqf";

// init Engine sensors placed by player
execVM "functions\sensors\engine\init_colsog_engineSensor.sqf";

// init Gravity sensors placed by player
execVM "functions\sensors\gravity\init_colsog_gravitySensor.sqf";

// init convertMedicKit on killed units
execVM "functions\colsog_fn_firstAidConvertAce.sqf";

// init deforestation
execVM "functions\deforestation\init_colsog_deforestation.sqf";

// init spectator settings
execVM "functions\init_colsog_spectatorSetup.sqf";

// run the script to create the nice vectored map borders
// commented out by default as currently we only have borders for Cam Lao Nam
// [] spawn compileScript ["vet_border\init.sqf"];