// ********************************************************
// Make small blood cloud when victim first hit.  Helps obscure 
// animation change when attached to mace.
// ********************************************************
//bloodCloud =
params ["_unit"]; 
drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,0.5,[0,0,0],[0,0,0],
	2, // rotationVelocity
	3,//10,// weight
	2,//7.9,// volume
	0,// rubbing
	[0.1,2], //[0.5,5], // size
	[[1,0,0,1],[1,0,0,1]],[1],1,0,"","",_unit];
drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,1,[0,0,1],[0,0,0],2,10,7.9,0,[0.5,5],[[1,0,0.1,1],[1,0,0,0]],[1],1,0,"","",_unit];
drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,1],"","Billboard",1,0.5,[0,0,1.5],[0,0,0],2,10,7.9,0,[0.5,5],[[1,0,0,1],[1,0,0,1]],[1],1,0,"","",_unit];
