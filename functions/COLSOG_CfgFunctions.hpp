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
	};
}