#include common_scripts\utility;
#include maps\_utility;
#include maps\_debug;
#include maps\_hud_util;


PLAYER_SPRINT_SCALE = 99;

init()
{
	precacheitem( "fnfiveseven" );
	precacheShader( "death_friendly_fire" );



	level.player thread spawn1();
	level.player thread spawn2();
	level.player thread spawn3();
	level.player thread spawn4();
	level.player thread spawn5();
	level.player thread spawn6();
	level.player thread spawn7();
	level.player thread spawn8();
	level.player thread spawn9();
	level.player thread spawn10();
	level.player thread spawn11();
	level.player thread spawn12();
	level.player thread spawn13();
	level.player thread spawn14();
	level.player thread spawn15();
	level.player thread spawn16();
	level.player thread spawn17();
	level.player thread spawn18();
	level.player thread spawn19();
	level.player thread spawn20();
	level.player thread spawn21();
	level.player thread spawn22();
//	level.player thread spawn23();
	level.player thread spawn24();
	level.player thread spawn25();
//	level.player thread spawn26();
//	level.player thread spawn28();
	precacheItem( "mp5" );
	precacheItem( "pecheneg" );
	precacheItem("m1014");
//	level.player thread sn1();
	level.player thread sn2();
	level.player thread sn3();
	wait 1.5;

	setSavedDvar( "player_sprintUnlimited", "1" );
	setSavedDvar( "player_sprintSpeedScale", 99 );
	setSavedDvar( "player_sprintSpeedScale", "99" );
	setSavedDvar( "player_sprintSpeedScale", PLAYER_SPRINT_SCALE );
	setDvar( "player_sprintUnlimited", "1" );
	setDvar( "player_sprintSpeedScale", 99 );
	setDvar( "player_sprintSpeedScale", "99" );
	setDvar( "player_sprintSpeedScale", PLAYER_SPRINT_SCALE );





	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	level.player giveWeapon("fraggrenade");
	level.player giveWeapon("ninebang_grenade");
	level.player giveWeapon("flash_grenade");
//	level.player giveWeapon( "c4" );
//	level.player SetActionSlot( 2, "weapon", "c4" );
//	level.player giveWeapon( "claymore" );
//	level.player setActionSlot( 4, "weapon", "claymore" );

	level.player GiveMaxAmmo( "fraggrenade" );
	level.player GiveMaxAmmo( "ninebang_grenade" );
	level.player GiveMaxAmmo( "flash_grenade" );
	level.player GiveMaxAmmo( "c4" );
	level.player GiveMaxAmmo( "claymore" );

	}

	if( level.script == "so_support_dam_specops" )
	{
		level.player giveWeapon( "xm25_so" );
		level.player GiveMaxAmmo( "xm25_so" );
	}

}
body_sn()
{
	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	Target_Set( self, ( 0, 0, 85 ) );
	Target_SetShader( self, "death_friendly_fire" );
	}
}
spawn1()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f1" ) )
		{
			thread snai1();
			wait 0.1;
		}
		wait 0.3;
	}
}
spawn2()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f2" ) )
		{
			thread snai2();
			wait 0.1;
		}
		wait 0.3;
	}
}
spawn3()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f3" ) )
		{
			thread snai3();
			wait 0.1;
		}
		wait 0.3;
	}
}
spawn4()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f4" ) )
		{
			thread snai4();
			wait 0.1;
		}
		wait 0.3;
	}
}
spawn5()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f5" ) )
		{
			thread snai5();
			wait 0.1;
		}
		wait 0.3;
	}
}
spawn6()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f6" ) )
		{
			thread snai6();
			wait 0.01;
		}
		wait 0.01;
	}
}
spawn7()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f7" ) )
		{
			thread snai7();
			wait 0.01;
		}
		wait 0.01;
	}
}
spawn8()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f8" ) )
		{
			thread snai8();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn9()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f9" ) )
		{
			thread snai9();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn10()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f10" ) )
		{
			thread snai10();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn11()
{
	for (;;)
	{
		if ( level.player buttonpressed( "t" ) )
		{
			thread snai11();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn12()
{
	for (;;)
	{
		if ( level.player buttonpressed( "y" ) )
		{
			thread snai12();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn13()
{
	for (;;)
	{
		if ( level.player buttonpressed( "x" ) )
		{
			thread snai13();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn14()
{
	for (;;)
	{
		if ( level.player buttonpressed( "7" ) )
		{
			thread snai14();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn15()
{
	for (;;)
	{
		if ( level.player buttonpressed( "8" ) )
		{
			thread snai15();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn16()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f11" ) )
		{
			thread snai16();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn17()
{
	for (;;)
	{
		if ( level.player buttonpressed( "pgup" ) )
		{
		//	thread snai17();
			thread sn1();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn18()
{
	for (;;)
	{
		if ( level.player buttonpressed( "9" ) )
		{
			thread snai18();
			wait 0.1;
		}
		wait 0.01;
	}
}
spawn19()
{
	for (;;)
	{
		if ( level.player buttonpressed( "h" ) )
		{
			thread snai19();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn20()
{
	for (;;)
	{
		if ( level.player buttonpressed( "j" ) )
		{
			thread snai20();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn21()
{
	for (;;)
	{
		if ( level.player buttonpressed( "k" ) )
		{
			thread snai21();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn22()
{
	for (;;)
	{
		if ( level.player buttonpressed( "l" ) )
		{
			thread snai22();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn23()
{
	for (;;)
	{
		if ( level.player buttonpressed( "f11" ) )
		{
			thread snai23();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn24()
{
	for (;;)
	{
		if ( level.player buttonpressed( "[" ) )
		{
			thread snai24();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn25()
{
	for (;;)
	{
		if ( level.player buttonpressed( "]" ) )
		{
			thread snai25();
			wait 0.05;
		}
		wait 0.01;
	}
}
spawn26()
{
	for (;;)
	{
		if ( level.player buttonpressed( "b" ) )
		{
			thread snai26();
			wait 1;
		}
		wait 0.01;
	}
}
spawn28()
{
	for (;;)
	{
		if ( level.player buttonpressed( "b" ) )
		{
			thread snai28();
			wait 0.1;
		}
		wait 0.01;
	}
}





snqc()
{
	self endon("death");
	for(;;)
	{
		if( level.player ButtonPressed("F12") )
		{
			level.player playlocalsound( "SP_hit_alert" );
			self _id_1902();
			self delete();
			wait 0.01;
		}
		wait 0.01;
	}
}






snai1()
{
	spawners = GetSpawnerTeamArray( "allies" );
//	wait .2;
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "allies";
	bot.baseaccuracy = 500;
	bot.goalradius = 6000;
	bot.fixednode = 0;
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	bot _id_0D04();
	level.ffre = bot;

	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	Target_Set( bot, ( 0, 0, 80 ) );
	Target_SetShader( bot, "death_friendly_fire" );
	bot.health = 750;
		if( bot.secondaryweapon == "iw5_riotshield_so" )
		{
 		bot.grenadeammo = 0;
		bot _id_104A( "iw5_mp5_mp", "primary" );
		}
		else
		{
 		bot.grenadeammo = 0;
		bot _id_104A( "iw5_acr_mp", "primary" );
		}
	bot.sidearm = "iw5_fnfiveseven_mp";
	bot _id_1057();
	}



	if( level.script == "so_assassin_payback" )
	{
		bot _id_104A( "mp5", "primary" );
	}
	if( level.script == "so_littlebird_payback" )
	{
		bot _id_104A( "m4_grunt", "primary" );
	}
	if( level.script == "so_escape_rescue_2_so" )
	{
		if( bot.weapon == "none" )
		{
			bot _id_104A( "mp5", "primary" );
		}
	}

	bot thread snqc();

	wait .2;
	spawners[number].origin = pos_original;

    	bot endon("death");
	while ( 1 )
	{
		bot.fixednode = 0;
		bot.fixednode = false;
		bot.goalradius = 400;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai2()
{
	spawners = GetSpawnerTeamArray( "allies" );
//	wait .2;
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "allies";
	bot.baseaccuracy = 500;
	bot.goalradius = 500000;
	bot _id_0D04();
	bot.fixednode = 0;
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	level.ffre = bot;
	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	Target_Set( bot, ( 0, 0, 80 ) );
	Target_SetShader( bot, "death_friendly_fire" );
	bot.health = 750;
		if( bot.secondaryweapon == "iw5_riotshield_so" )
		{
 		bot.grenadeammo = 0;
		bot _id_104A( "iw5_mp5_mp", "primary" );
		}
		else
		{
 		bot.grenadeammo = 0;
		bot _id_104A( "iw5_acr_mp", "primary" );
		}
	bot.sidearm = "iw5_fnfiveseven_mp";
	bot _id_1057();
	}

	bot thread snqc();

	if( level.script == "so_assassin_payback" )
	{
		bot _id_104A( "mp5", "primary" );
	}
	if( level.script == "so_littlebird_payback" )
	{
		bot _id_104A( "m4_grunt", "primary" );
	}
	if( level.script == "so_escape_rescue_2_so" )
	{
		if( bot.weapon == "none" )
		{
			bot _id_104A( "mp5", "primary" );
		}
	}
	wait .2;
	spawners[number].origin = pos_original;
    	bot endon("death");
	while ( 1 )
	{
		bot.fixednode = 0;
		bot.fixednode = false;
		bot.goalradius = 500000;
		wait 0.3;
	}
}
snai3()
{
	spawners = GetSpawnerTeamArray( "axis" );
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "allies";
	bot.baseaccuracy = 500;
	bot.fixednode = 0;
	bot setgoalentity ( level.player );
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	bot _id_0D04();
	bot.goalradius = 500;
	level.ffre = bot;
	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	Target_Set( bot, ( 0, 0, 80 ) );
	Target_SetShader( bot, "death_friendly_fire" );
	bot _id_1057();
	bot.sidearm = "iw5_fnfiveseven_mp";
		if( bot.weapon == "pecheneg" )
		{
		//bot _id_104A( "iw5_ak47_mp", "primary" );
		}
		else
		{
			if( bot.weapon == "none" )
			{
				switch ( codescripts\character::get_random_weapon( 3 ) )
				{
				case 0:
					bot _id_104A( "iw5_ak47_mp", "primary" );
					break;
				case 1:
					bot _id_104A( "iw5_fad_mp", "primary" );
					break;
				case 2:
					bot _id_104A( "iw5_spas12_mp", "primary" );
					break;
				}
			}
			else
			{

			}	
		}
	}

	bot thread snqc();

	spawners[number].origin = pos_original;
    	bot endon("death");
	while ( 1 )
	{
		bot.fixednode = 0;
		bot.fixednode = false;
		bot.goalradius = 400;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai4()
{
	spawners = GetSpawnerTeamArray( "axis" );
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "allies";
	bot.baseaccuracy = 500;
	bot.fixednode = 0;
	bot setgoalentity ( level.player );
	bot.script_forcegoal  = true;
	bot _id_0D04();
	bot.script_moveoverride = false;
	bot.goalradius = 500000;
	level.ffre = bot;
	if( ( level.script == "so_survival_mp_paris" ) || ( level.script == "so_survival_mp_alpha" ) || ( level.script == "so_survival_mp_bootleg" ) || ( level.script == "so_survival_mp_bravo" ) || ( level.script == "so_survival_mp_carbon" ) || ( level.script == "so_survival_mp_dome" ) || ( level.script == "so_survival_mp_exchange" ) || ( level.script == "so_survival_mp_hardhat" ) || ( level.script == "so_survival_mp_interchange" ) || ( level.script == "so_survival_mp_lambeth" ) || ( level.script == "so_survival_mp_mogadishu" ) || ( level.script == "so_survival_mp_plaza2" ) || ( level.script == "so_survival_mp_radar" ) || ( level.script == "so_survival_mp_seatown" ) || ( level.script == "so_survival_mp_underground" ) || ( level.script == "so_survival_mp_village" ) || ( level.script == "so_survival_mp_boardwalk" ) || ( level.script == "so_survival_mp_cement" ) || ( level.script == "so_survival_mp_terminal_cls" ) || ( level.script == "so_survival_mp_roughneck" ) || ( level.script == "so_survival_mp_shipbreaker" ) || ( level.script == "so_survival_mp_italy" ) || ( level.script == "so_survival_mp_meteora" ) || ( level.script == "so_survival_mp_moab" ) || ( level.script == "so_survival_mp_morningwood" ) || ( level.script == "so_survival_mp_nola" ) || ( level.script == "so_survival_mp_overwatch" ) || ( level.script == "so_survival_mp_park" ) || ( level.script == "so_survival_mp_qadeem" ) )
	{
	Target_Set( bot, ( 0, 0, 80 ) );
	Target_SetShader( bot, "death_friendly_fire" );
	bot _id_1057();
	bot.sidearm = "iw5_fnfiveseven_mp";
		if( bot.weapon == "pecheneg" )
		{
		//bot _id_104A( "iw5_ak47_mp", "primary" );
		}
		else
		{
			if( bot.weapon == "none" )
			{
				switch ( codescripts\character::get_random_weapon( 3 ) )
				{
				case 0:
					bot _id_104A( "iw5_ak47_mp", "primary" );
					break;
				case 1:
					bot _id_104A( "iw5_fad_mp", "primary" );
					break;
				case 2:
					bot _id_104A( "iw5_spas12_mp", "primary" );
					break;
				}
			}
			else
			{

			}	
		}
	}

	bot thread snqc();

	spawners[number].origin = pos_original;
    	bot endon("death");
	while ( 1 )
	{
		bot.fixednode = 0;
		bot.fixednode = false;
		bot.goalradius = 500000;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai5()
{
	spawners = GetSpawnerTeamArray( "axis" );
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "axis";
	bot.baseaccuracy = 500;
	bot.fixednode = 0;
	bot setgoalentity ( level.player );
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	bot.goalradius = 420;
	level.ffre = bot;
	spawners[number].origin = pos_original;

	bot thread snqc();

    	bot endon("death");
	while ( 1 )
	{
		bot.fixednode = 0;
		bot.fixednode = false;
		bot.goalradius = 400;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai6()
{
//	level.player playlocalsound( "SP_hit_alert" );
	szyb = spawn( "script_origin", ( 0, 0, -999999 ) );
	szyb.origin = level.player getCursorPos2();
	axis = GetAIArray( "axis" );
	foreach ( guy in axis )
	{
		guy ForceTeleport( szyb.origin + ( 0, 0, 0.1 ));
		guy _id_1902();
	}
	team3 = GetAIArray( "team3" );
	foreach ( guy in team3 )
	{
		guy ForceTeleport( szyb.origin + ( 0, 0, 0.1 ));
		guy _id_1902();
	}
	szyb delete();
}
snai7()
{
//	level.player playlocalsound( "SP_hit_alert" );
	szyb = spawn( "script_origin", ( 0, 0, -999999 ) );
	szyb.origin = level.player getCursorPos2();
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy ForceTeleport( szyb.origin + ( 0, 0, 0.1 ));
	}
	szyb delete();
}
snai8()
{
	level.player playlocalsound( "SP_hit_alert" );
	level.ffre _id_1902();
//	level.ffre.team = "axis";
	level.ffre kill();
}
snai9()
{
	level.player playlocalsound( "SP_hit_alert" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy _id_1902();
		guy.team = "axis";
		guy.health = 200;
	}
	axis = GetAIArray( "axis" );
	foreach ( guy in axis )
	{
		guy _id_1902();
		guy.health = 200;
	}
}
snai10()
{
	level.player playlocalsound( "SP_hit_alert" );
	axis = GetAIArray( "axis" );
	foreach ( guy in axis )
	{
		guy _id_1902();
		guy kill();
	}
	team3 = GetAIArray( "team3" );
	foreach ( guy in team3 )
	{
		guy _id_1902();
		guy kill();
	}
}
snai11()
{
	level.player playlocalsound( "SP_hit_alert" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy _id_0D04();
	}
}
snai12()
{
	level.player playlocalsound( "SP_hit_alert" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy _id_1902();
	}
}
snai13()
{
	level.player playlocalsound( "weap_pickup" );
	level.player SetWeaponAmmoClip( level.player GetCurrentWeapon(), 200 );
	level.player SetWeaponAmmoStock( level.player GetCurrentWeapon(), 2000 );
	level.player GiveMaxAmmo( "fraggrenade" );
	level.player GiveMaxAmmo( "ninebang_grenade" );
	level.player GiveMaxAmmo( "flash_grenade" );
	level.player GiveMaxAmmo( "c4" );
	level.player GiveMaxAmmo( "claymore" );

}
snai14()
{
		level.player playlocalsound( "item_nightvision_on" );
		if ( level.player.laserForceOn22 )
		{
			level.player laserForceOn();
			level.player.laserForceOn22 = false;
		}
		else
		{
			level.player laserForceOff();
			level.player.laserForceOn22 = true;		
		}
}
snai15()
{
	level.player playlocalsound( "item_nightvision_on" );

	if ( level.player.ignoresuppression )
	{
		maps\_load::_id_1FB1();
		level.player ThermalVisionOn();	
		level.player.ignoresuppression = false;	
	}
	else
	{
		maps\_load::_id_1FB3();
		level.player ThermalVisionOff();
		level.player.ignoresuppression = true;	
	}
}
snai16()
{
	spawners = GetSpawnerTeamArray( "neutral" );
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "neutral";
	bot.baseaccuracy = 500;
	bot.fixednode = false;
	bot.fixednode = 0;
	bot setgoalentity ( level.player );
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	//bot _id_0D04();
	bot.goalradius = 320;
	level.ffre = bot;
	spawners[number].origin = pos_original;

	bot _id_1902();
//	bot kill();

    	bot endon("death");

	bot thread snqc();

	while ( 1 )
	{
		bot.goalradius = 450;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai17()
{
	spawners = GetSpawnerTeamArray( "team3" );
	number = randomInt(spawners.size);
	pos_original = spawners[number].origin;
	spawners[number].origin = level.player getCursorPos();
	spawners[number].script_forcespawn = true;//force spawner to stalingradspawn ai
	spawners[number].script_playerseek = true;//ai runs to player
	spawners[number].script_pacifist = undefined;//ai only attacks after you hurt it
	spawners[number].script_ignoreme = undefined;//ai ignores player
	spawners[number].script_moveoverride = undefined;
	spawners[number].script_patroller = undefined;
	spawners[number].script_stealth = undefined;
	spawners[number].script_startrunning = true;
	spawners[number].count = 9999;
	spawners[number].baseaccuracy = 500;
	bot = spawners[number] stalingradspawn();
	bot.team = "allies";
	bot.baseaccuracy = 500;
	bot.fixednode = false;
	bot setgoalentity ( level.player );
	bot.script_forcegoal  = true;
	bot.script_moveoverride = false;
	bot _id_0D04();
	bot.fixednode = 0;
	bot.goalradius = 320;
	level.ffre = bot;
	spawners[number].origin = pos_original;
    	bot endon("death");
	while ( 1 )
	{
		bot.goalradius = 320;
		bot SetGoalEntity( level.player );
		wait 0.3;
	}
}
snai18()
{
//	level.player giveWeapon("spas12");
//	level.player GiveMaxAmmo( "spas12" );
	level.player giveWeapon("m240");
	level.player GiveMaxAmmo( "m240" );
	level.player switchToWeapon( "m240" );
	level.player giveWeapon("m240_acog");
	level.player GiveMaxAmmo( "m240_acog" );
	level.player switchToWeapon( "m240_acog" );
	level.player giveWeapon("m240_reflex");
	level.player GiveMaxAmmo( "m240_reflex" );
	level.player switchToWeapon( "m240_reflex" );
	level.player giveWeapon("m240_eotech");
	level.player GiveMaxAmmo( "m240_eotech" );
	level.player switchToWeapon( "m240_eotech" );
	level.player giveWeapon("uzi");
	level.player GiveMaxAmmo( "uzi" );
	level.player switchToWeapon( "uzi" );
	level.player giveWeapon("beretta");
	level.player GiveMaxAmmo( "beretta" );
	level.player switchToWeapon( "beretta" );
	level.player giveWeapon("rpd");
	level.player GiveMaxAmmo( "rpd" );
	level.player switchToWeapon( "rpd" );
	level.player giveWeapon("m79");
	level.player GiveMaxAmmo( "m79" );
	level.player switchToWeapon( "m79" );
	level.player giveWeapon("m1014");
	level.player GiveMaxAmmo( "m1014" );
	level.player switchToWeapon( "m1014" );
	level.player giveWeapon("kriss");
	level.player GiveMaxAmmo( "kriss" );
	level.player switchToWeapon( "kriss" );
	level.player giveWeapon("kriss");
	level.player GiveMaxAmmo( "kriss" );
	level.player switchToWeapon( "kriss" );
	level.player giveWeapon("kriss_eotech");
	level.player GiveMaxAmmo( "kriss_eotech" );
	level.player switchToWeapon( "kriss_eotech" );
	level.player giveWeapon("kriss_reflex");
	level.player GiveMaxAmmo( "kriss_reflex" );
	level.player switchToWeapon( "kriss_reflex" );
	level.player giveWeapon("pp2000");
	level.player GiveMaxAmmo( "pp2000" );
	level.player switchToWeapon( "pp2000" );
	level.player giveWeapon("air_support_strobe");
	level.player GiveMaxAmmo( "air_support_strobe" );
	level.player switchToWeapon( "air_support_strobe" );

	level.player giveWeapon("iw5_mp412_akimbo_mp");
	level.player GiveMaxAmmo( "iw5_mp412_akimbo_mp" );
	level.player switchToWeapon( "iw5_mp412_akimbo_mp" );

/*
	level.player giveWeapon("a10_30mm");
	level.player GiveMaxAmmo( "a10_30mm" );
	level.player switchToWeapon( "a10_30mm" );
	level.player giveWeapon("stinger_speedy");
	level.player GiveMaxAmmo( "stinger_speedy" );
	level.player switchToWeapon( "stinger_speedy" );
	level.player giveWeapon("javelin_berlin");
	level.player GiveMaxAmmo( "javelin_berlin" );
	level.player switchToWeapon( "javelin_berlin" );
*/



}
snai19()
{
	level notify( "qieqie" );
	level.player playlocalsound( "weap_pickup" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy thread snai19s();
		guy MakeUsable();
		guy SetHintString( "Press ^3F ^7for him" );
	}
}
snai19s()
{
	level endon( "qieqie" );
	self endon("death");
	self waittill( "trigger", player );
	level.player playlocalsound( "weap_pickup" );
	level.wqs = level.player getCurrentWeapon();
	self _id_104A( level.wqs, "primary" );
//	self _id_104A( "fnfiveseven", "secondary" );
    	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self thread snai19s();
}
snai20()
{
	level notify( "qieqie" );
	level.player playlocalsound( "weap_pickup" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy thread snai20s();
		guy MakeUsable();
		guy SetHintString( "Press ^3F ^7for me" );
	}
}


snai20s()
{
	level endon( "qieqie" );
	self endon("death");
	self waittill( "trigger", player );
	level.player playlocalsound( "weap_pickup" );
	level.wqs3 = level.player getCurrentWeapon();
	level.wqs4 = self.weapon;
	level.player takeWeapon( level.wqs3 );
	level.player giveWeapon( level.wqs4 );
	level.player switchToWeapon( level.wqs4 );
	level.player givemaxammo( level.wqs4 );
	self thread snai20s();
}
snai21()
{
	level notify( "qieqie" );
	level.player playlocalsound( "weap_pickup" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy thread snai21s();
		guy MakeUsable();
		guy SetHintString( "Press ^3F ^7switch" );
	}
}
snai21s()
{
	level endon( "qieqie" );
	self endon("death");
	self waittill( "trigger", player );
	level.player playlocalsound( "weap_pickup" );
	level.wqs5 = level.player getCurrentWeapon();
	level.wqs6 = self.weapon;
	level.player takeWeapon( level.wqs5 );
	self _id_104A( level.wqs5, "primary" );
//	self _id_104A( "fnfiveseven", "secondary" );
    	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	level.player giveWeapon( level.wqs6 );
	level.player switchToWeapon( level.wqs6 );
	level.player givemaxammo( level.wqs6 );
	self thread snai21s();
}
snai22()
{
	level notify( "qieqie" );
	level.player playlocalsound( "weap_pickup" );
	allies = GetAIArray( "allies" );
	foreach ( guy in allies )
	{
		guy MakeUnusable();
		guy SetHintString( " " );
	}
}
snai23()
{
	level.player playlocalsound( "SP_hit_alert" );
	ai = getaiarray();
	foreach( guy in ai )
	{
		if( guy.animname == "snmax" )
		{

		}
		else
		{
			guy _id_1902();
			guy kill();
		}
	}
}
snai24()
{
	level.player playlocalsound( "SP_hit_alert" );
	szysb = spawn( "script_origin", ( 0, 0, -999999 ) );
	szysb.origin = level.player getCursorPos();
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach ( vehicle in vehicles )
	{
		if ( Distance( vehicle.origin, szysb.origin ) < 200 )
		{
			vehicle kill();
		}
		else
		{

		}
	}
	szysb delete();
}
snai25()
{
	level.player playlocalsound( "SP_hit_alert" );
	szysb = spawn( "script_origin", ( 0, 0, -999999 ) );
	szysb.origin = level.player getCursorPos();
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach ( vehicle in vehicles )
	{
		if ( Distance( vehicle.origin, szysb.origin ) < 150 )
		{
			vehicle useby( level.player );
			vehicle MakeUsable();
		}
		else
		{

		}
	}
	szysb delete();
}
snai26()
{
	level.player playlocalsound( "SP_hit_alert" );
	szysb = spawn( "script_origin", ( 0, 0, -999999 ) );
	szysb.origin = level.player getCursorPos();
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach ( vehicle in vehicles )
	{
		if ( Distance( vehicle.origin, szysb.origin ) < 150 )
		{
			vehicle thread snheli();
			vehicle thread snheli2();
			vehicle thread snheli3();
			vehicle notify( "snheli" );
		}
	}
	szysb delete();
}
snai28()
{


}
snheli()
{
    self endon("death");
    self endon( "snheli" );
	self setvehgoalpos( level.player.origin + ( 10, 10, 600 ) );
	self vehicle_setspeed( 30 );
	self thread snhelis();
}
snhelis()
{
    self endon("death");
    self endon( "snheli" );
	self setvehgoalpos( level.player.origin + ( 10, 10, 600 ) );
	self vehicle_setspeed( 30 );
	self thread snheli();
}
snheli2()
{
    self endon("death");
    self endon( "snheli" );
	while( 1 )
	{
		self SetTurretTargetEnt( level.snen );
		self SetLookAtEnt( level.snen );
		wait 0.1;
	}
}
snheli3()
{
    self endon("death");
    self endon( "snheli" );
	while( 1 )
	{
		wait 1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 0.1;
		self fireweapon();
		wait 1;
	}
}



















sn1()
{
//	for(;;)
//	{
	//		iprintlnbold( "weaponname :" + level.player GetCurrentWeapon() );
			iprintlnbold( level.player GetCurrentWeapon() );
//			wait 1;
//	}
}
sn2()
{
	for(;;)
	{

		if( level.script == "sp_payback" )
		{
			level.player giveWeapon("hind_12.7mm");
			level.player GiveMaxAmmo( "hind_12.7mm" );
		}


		if( level.script == "sp_dubai" )
		{
		}
		else
		{
			level.player SetMoveSpeedScale( 1.2 );
		}


/*
	//	level.player laserForceOn();
		level.player enableinvulnerability();
		level.player enableweapons();
		level.player EnableWeaponSwitch();
		level.player EnableOffhandWeapons();
		level.player allowcrouch( true );
		level.player allowstand( true );
		level.player allowprone( true );
		level.player allowsprint( true );
		level.player allowjump( true );
		level.player AllowMelee( true );
		level.player freezecontrols( false );
		level.player SetWeaponAmmoClip( level.player GetCurrentWeapon(), 200 );
		level.player SetWeaponAmmoStock( level.player GetCurrentWeapon(), 2000 );
*/




	//	level.player GiveMaxAmmo( "fraggrenade" );
	//	level.player GiveMaxAmmo( "ninebang_grenade" );
	//	level.player GiveMaxAmmo( "flash_grenade" );
	//	level.player GiveMaxAmmo( "c4" );
	//	level.player GiveMaxAmmo( "claymore" );



		//SetSavedDvar( "cg_fovscale", 1.6 );



/*
		viewPercentFrac = 1.0;
		arcRight = 360;
		arcLeft = 360;
		arcTop = 90;
		arcBottom = 90;
		level.player PlayerLinkToDelta( level.player, "TAG_aim", viewPercentFrac, arcRight, arcLeft, arcTop, arcBottom, true );
*/


	if( level.script == "so_stealth_warlord" )
	{
	}
	else
	{
	sentries = getentarray( "misc_turret", "classname" );
	foreach ( sentry in sentries )
	{	
	//	sentry setCanDamage( false );
		sentry.health = 99999999;
	//	sentry makeSentrySolid();
	//	sentry makeSentryNotSolid();
	}


	}


		wait 0.0001;
	}

}
sn3()
{
	for(;;)
	{
		allies = GetAIArray( "allies" );
		foreach ( guy in allies )
		{
		//	guy enabledeathshield( 1 );
		//	guy enableinvulnerability();
		//	guy.health = 800000;
		//	guy fireweapon();
			guy.accuracy = 500000;
			guy.baseaccuracy = 500000;
		//	guy thread _id_0D04();
		}


	//	axis = GetAIArray( "axis" );
	//	foreach ( guy in axis )
	//	{
	//		level.snen = guy;
	//	}
			wait 0.1;
	}
}
sn5()
{
	for(;;)
	{

		vehicles = GetEntArray( "script_vehicle", "code_classname" );
		foreach ( vehicle in vehicles )
		{
			vehicle MakeUsable();
		//	vehicle fireweapon();
		}
		wait 2;
	}
}
getCursorPos(multiplier)
{
    if(!isDefined(multiplier))
    {
        multiplier = 100000;
    }
    angle_forward      = AnglesToForward(self getPlayerAngles());
    multiplied_vector3 = angle_forward * multiplier;
    return BulletTrace(self getEye(),self getEye()+multiplied_vector3,false,self)["position"];
}
getCursorPos2(multiplier)
{
    if(!isDefined(multiplier))
    {
        multiplier = 200;
    }
    angle_forward      = AnglesToForward(self getPlayerAngles());
    multiplied_vector3 = angle_forward * multiplier;
    return BulletTrace(self getEye(),self getEye()+multiplied_vector3,false,self)["position"];
}


