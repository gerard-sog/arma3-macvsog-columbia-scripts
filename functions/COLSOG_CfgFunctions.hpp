class COLSOG {
	class Faces
	{
		file ="functions\player";
		class faces {};
	};
	class Triangulate
	{
		file ="functions\triangulate";
		// 1 will execute the function for each player downloading the mission.
		class triangulate {postInit = 1;};
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
    };
}