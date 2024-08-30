class COLSOG {
	class Faces
	{
		file ="functions\player";
		// nothing means the function will exists on every machine at mission start as callable functions
		class faces {};
	};
	class Triangulate
	{
		file ="functions\triangulate";
		// postInit=1 will execute the function for each machine starting the mission.
		// (see https://community.bistudio.com/wiki/Initialisation_Order 4th from the bottom)
		//
		// this particular function will only execute for players because the file is exiting if dedicated !(hasInterface)
		class triangulate {postInit = 1;};
		class isAcreSpikeRequiredAndNearby {};
		class getCurrentPrc77RadioFrequency {};
	};
	class Battery
    {
        file ="functions\battery";
        // 1 will execute the function for each player downloading the mission.
        class batteryManager {postInit = 1;};
        // ACE self-interact actions.
        class displayBatteryLevel {};
        class increaseBatteryLevel {};
        // Utils methods.
        class getBatteryLevelFromRadioId {};
        class setBatteryLevelFromRadioId {};
        class getBatteryLevelFromRadioType {};
        class setBatteryLevelFromRadioType {};
        class getLastStartOfTransmission {};
        class setLastStartOfTransmission {};
        class incrementRadioCallsCounter {};
    };
}