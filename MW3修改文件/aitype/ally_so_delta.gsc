// IW5 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self._id_3AA1 = "";
    self._id_3AA2 = "juggernaut.csv";
    self.team = "allies";
    self.type = "human";
    self._id_218D = "juggernaut";
    self.accuracy = 0.2;
    self.maxhealth = 2000;
    self.secondaryweapon = "";
    self._id_20A3 = "";
    self.grenadeweapon = "";
    self.grenadeammo = 0;

    if ( isai( self ) )
    {
        self setengagementmindist( 0.0, 0.0 );
        self setengagementmaxdist( 256.0, 1024.0 );
    }

    self.weapon = "none";
	
    _id_05CA::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    _id_05CA::precache();
    _id_05C6::main();
}
