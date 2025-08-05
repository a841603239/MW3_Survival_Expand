#include maps\_hud_util;




main()
{	
	// works for player
	// ents = getentarray("player", "classname");
	
	
	// sometimes "level.player" is not available instantly so some looping is needed
	level thread wait_for_player();
	
	
	// global vars
	level._heliArr = [];
	level.callBackupWarnShown = 0;
	level.befriendWarnShown = 0;
	
}


wait_for_player()
{
	level thread get_player_loop();
	self waittill( "myPlayer_loaded", myPlayer );
	
	// player is now accessable
	if (myPlayer)
	{
		iPrintlnBold("^1 Mod Menu Ready");
	}
	
	// menu
	myPlayer thread buildMenu();
	
}
	
	

get_player_loop()
{	
	level endon("myPlayer_loaded");
	
	while(1)
	{
		ply = level.player;
		ply thread get_player();
		
		wait 0.7;
	}
}


get_player()
{
	myPlayer = self;
    level notify("myPlayer_loaded", myPlayer);
}


_giveXP_()
{
    // self setplayerdata( "experience", 9999999 );
	self setplayerdata( "experience", level._id_01DA );
	// self._id_12CE["rankxp"] = 9999999
    self maps\_rank::update_rank_into_profile();
    self thread maps\_utility::_id_12BE( "final_score_xp", 9999999 );
    UpdateGamerProfile();
}



All_armories_usable()
{
	level notify( "wave_ended", 1 );
	wait 1;
	level notify( "wave_ended", 2 );
	wait 1;
	level notify( "wave_ended", 3 );
}


give_perk_stack( perk)
{
    switch ( perk )
    {
	    case "clear":
	        self clearperks();
			break;
        case "specialty_stalker":
            self thread _id_0615::_id_3C61();
			iprintln("^1Perk Activated: ^2Stalker" );
            break;
        case "specialty_longersprint":
            self thread _id_0615::_id_3C57();
			iprintln("^1Perk Activated: ^2Extreme Conditioning" );
            break;
        case "specialty_fastreload":
            self thread _id_0615::_id_3C59();
			iprintln("^1Perk Activated: ^2Sleight of Hand" );
            break;
        case "specialty_quickdraw":
            self thread _id_0615::_id_3C5B();
			iprintln("^1Perk Activated: ^2Quickdraw" );
            break;
        case "specialty_detectexplosive":
            self thread _id_0615::_id_3C5D();
			iprintln("^1Perk Activated: ^2Detect Explosive" );
            break;
        case "specialty_bulletaccuracy":
            self thread _id_0615::_id_3C5F();
			iprintln("^1Perk Activated: ^2Steady Aim" );
            break;
		case "all":
			self thread _id_0615::_id_3C61();
            self thread _id_0615::_id_3C57();
            self thread _id_0615::_id_3C59();
            self thread _id_0615::_id_3C5B();
            self thread _id_0615::_id_3C5D();
            self thread _id_0615::_id_3C5F();
			iprintln("^2All perks activated." );
			break;
        default:
            thread _id_0615::_id_3C55();
			iprintln("^1All Perks Cleared." );
            break;
    }
}


GodMode_proper()
{
    if(!self.isGod)
    {
        self.isGod = true;
        self enableinvulnerability();
    }
    else
    {
		self disableinvulnerability();
        self.isGod   = false;
    }
}
	


give_money()
{
	self._id_3ED7 = self._id_3ED7 + 100000;
	// self._id_18D3["credits"] =  self._id_3ED7;
	iprintln("^1Gain or spend money to see the effect." );
}


give_sentry( type )
{
	self thread _id_0611::_id_3BBF(type);
}


give_armor( type )
{
	self thread _id_0626::_id_3F17(type);
}


give_laststand()
{
	maps\_laststand::_id_1ABE( 1 );
}

give_equimpemnt( type )
{
	self thread _id_0626::_id_3F10(type);
}

give_remote_missile()
{
	self thread _id_0611::_id_3BBF("remote_missile");
}

give_airstrike()
{
	self thread _id_0626::_id_3F26();
}



// 此函数用于呼叫地面盟友支援
// ally_type参数决定呼叫什么类型的部队（如Delta部队、防暴盾牌等）
_spawn_allies( ally_type )
{	
	// 显示警告信息，提醒玩家不要召唤太多支援
	showCallBackupWarn();
	
	
	// maps\_so_survival::spawn_allies( self.origin, ally_type, self );
	// 调用内部函数来实际生成盟友
	_spawn_allies_internal(self.origin, 3, ally_type, self);
}

// internal spawn_allies re-written to spawn enenmies as player teammate.
// defalt "amount" is 3 but you can pass bigger number to spawn more; risky.
// 内部函数：实际生成玩家的队友盟军
// 参数说明：
// loc - 生成位置（通常是玩家位置）
// amount - 要生成的盟友数量（默认3个，但可以更多，不过会有风险）
// type - 盟友类型（如Delta部队、重装甲士兵等）
// owner - 这些盟友的主人（通常是玩家）
_spawn_allies_internal( loc, amount, type, owner)
{
	// 创建一个路径点，用于直升机降落
	_path = _id_0618::_id_3E3D( loc, "drop_path_start", "script_unload" );
	// 发出通知，告诉游戏系统空中支援正在到来
	level notify( "so_airsupport_incoming", type );
	
	// 创建一个数组用于存储生成的NPC
	_npcArr = [];
    var_5 = _id_0618::_id_3DCA( type )[0];

    // 如果找不到指定类型，直接返回空数组
    if ( !isdefined( var_5 ) )
        return _npcArr;

    // 生成一架盟友降落直升机
    _heli = _id_0618::_id_3DCB( "ally_drop_chopper", _path.origin, _path );
    // 设置直升机行为和属性
    _heli thread _id_0619::_id_3D09( "reached_dynamic_path_end death deathspin" );
    _heli maps\_vehicle::_id_2A12();
    // 设置直升机速度（60-75之间的随机值）
    _heli vehicle_setspeed( 60 + randomint( 15 ), 30, 30 );
    _heli._id_2950 = 1;
    // 如果直升机被摧毁则终止其线程
    _heli endon( "death" );
    // 设置直升机为Delta小队类型
    _heli _id_0618::_id_3DCD( "friendly_support_delta" );

	
    // 循环生成指定数量的NPC
    for ( it = 0; it < amount; it++ )
    {
        // 在直升机上生成一个NPC
        _npc = _heli _id_0618::_id_3DCE( var_5, it + 2 );
        // 设置NPC的AI行为
        _npc maps\_utility::_id_0D72( 0 );
        _npc maps\_utility::_id_2611();
        // 让NPC准备从直升机跳出
        _npc thread _id_061C::_id_3DE7( 20, "jumpedout" );
        // 设置NPC的威胁组为"allies"（盟友）
        _npc setthreatbiasgroup( "allies" );
        // 设置NPC忽略玩家（不会把玩家当敌人）
        _npc.ignoreme = 1;
		// 这行代码非常重要！设置NPC的队伍与玩家相同，让他们成为队友
		_npc.team = owner.team; // this line was needed
        // 设置NPC的战斗行为
        _npc._id_3D5D = _id_061C::_id_3DF4( type );
        _npc [[ level._id_3B89 ]]();
        _npc thread _id_061C::_id_3DE9();
        // 设置NPC的主人为玩家
        _npc.owner = owner;
        // 将NPC添加到数组中
        _npcArr[_npcArr.size] = _npc;
        // 设置NPC的头顶图标为盟友
        _npc.headiconteam = "allies";
		
		// 设置不同类型NPC的不同头顶图标
		_npc.headicon = "headicon_gign_so"; // any npc other than delta
        if ( type == "friendly_support_delta" )
            _npc.headicon = "headicon_delta_so";
		
        // 设置NPC不在指南针上显示
        _npc.drawoncompass = 0;
        // 每生成一个NPC后稍微等待一下，避免同时生成太多导致游戏卡顿
        wait 0.05;
    }

    // 设置直升机在放下NPC后的行为
    _heli thread _id_061C::_id_3DE4( _npcArr );
    // 返回生成的NPC数组
    return _npcArr;
}

// you can also pass your own enemyType classname
// 可以传递自定义敌人类型名称来友好化敌人
befriend_Enemies()
{
	// 显示敌人友好化的警告信息
	showBefriendWarn();
	
	// 获取所有载具并处理敌方载具
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach (veh in vehicles)
	{
		if (veh.script_team != "allies")
		{
			iprintln("^2 Veh killed: " + veh.vehicletype);
		    veh kill();
		}
	}
	
	// 获取所有轴心国AI并将其转变为盟友
	enemies = getaispeciesarray( "axis", "all" );
	for(i =0; i < enemies.size; i++)
	{
		enemy = enemies[i];			
		// did we call the juggs?
			enemy.team = "allies";
			enemy.ignoreme = 1;
			//enemy.drawoncompass = 0;
			enemy.headiconteam = "allies";
			enemy.headicon = "headicon_gign_so";
	}
}


// 显示呼叫支援的警告信息，防止玩家召唤过多支援导致游戏卡顿
showCallBackupWarn()
{
	// 检查是否已经显示过警告，避免重复显示
	if (level.callBackupWarnShown == 0)
	{
		// 设置标志位，标记已经显示过警告
		level.callBackupWarnShown = 1;
		// 在屏幕上显示警告文字
		iprintlnBold("^1Dont Call more than 4 choppers concurrently.");
		iprintlnBold("^1Having more than 12 allies is risky.");
	}
}

// 显示敌人友好化的警告信息
showBefriendWarn()
{
	if (level.befriendWarnShown == 0)
	{
		level.befriendWarnShown = 1;
		iprintlnBold("^1If Wave is Glitched, use [Kill Everyone] From Menu.");
	}
}

// 杀死所有敌人，清理地图
killAllEnemies()
{	
	// 杀死所有非盟友载具
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach (veh in vehicles)
	{
		if (veh.script_team != "allies")
		{
		    veh kill();
		}
	}
	
	// 杀死所有敌方AI
	enemies = getaispeciesarray( "axis", "all" );
	for(i =0; i < enemies.size; i++)
	{
		enemies[i] kill();
	}	
}

// use when you befriended an enemy but his death is needed for wave to end
// 当你友好化敌人后但需要他们死亡以完成波次时使用
kill_everyone()
{	
    // 杀死所有AI实体和载具
    common_scripts\utility::array_call( getaispeciesarray( "all", "all" ), ::kill ); // ::delete
	common_scripts\utility::array_call( GetEntArray( "script_vehicle", "code_classname" ), ::kill );
}

// 删除所有已召唤的直升机支援
del_spawned_helis()
{
	// 对存储在全局数组中的所有直升机执行删除操作
	common_scripts\utility::array_call( level._heliArr , ::delete ); 
}

// 生成一架友方武装直升机来支援玩家
spawn_heli_friend()
{
	// 计算直升机生成位置（玩家上方1000单位处）
	abovePly = level.player.origin + ( 1, 1, 1000 );
		
	// comes in and leaves soon
	// _path = _id_0618::_id_3E3D( plyOrg, "drop_path_start", "script_unload" );
	// _heli = _id_0618::_id_3DCB( "airdrop_littlebird", _path.origin, _path );
	
	// 生成一架"小鸟"型武装直升机
	_heli = _id_0618::_id_3DCB( "airdrop_littlebird", abovePly, abovePly + (50, 50, 50)  );
	// xxx = spawnvehicle( "vehicle_little_bird_armed", "plane", "littlebird_so", abovePly + ( 500, 500, 0 ), level.player.angles );

	// 让直升机变得"有智能"，并设置为盟友
	_heli makeentitysentient( "allies" );
    // 设置直升机生命值很高
    _heli.health = 5000;
	// 开启直升机的无敌模式
	_heli.godmode = 1;
    // 允许直升机受到伤害（虽然是无敌的，但可以接收伤害信息）
    _heli setcandamage( 1 );
    // 设置直升机可以大角度倾斜（最大90度）
    _heli setmaxpitchroll( 90, 90 );
    // 设置直升机飞行速度
    _heli vehicle_setspeed( 15, 10 );
	// 启用直升机的武器系统
	_heli turretfireenable();
    // 设置直升机为AI控制模式
    _heli setmode( "auto_ai" );
	// 设置直升机炮塔为友军阵营
	_heli setturretteam ("allies");
	// 设置直升机悬停参数
	_heli sethoverparams( 32, 10, 3 );
	// 设置直升机转向能力
	_heli setturningability( 1 );
		
	// 启动直升机的自动射击线程
	_heli thread shoot_loop();	
	
	// would also go for UAV!
	// _heli thread shoot_loop(GetEntArray( "script_vehicle", "code_classname" ));	
	
	// store spawned heli
	// 将直升机添加到全局数组中，方便后续管理
	level._heliArr[level._heliArr.size] = _heli;
}

// nasty targeting for now
// 直升机的自动射击循环，让直升机自动寻找并攻击敌人
shoot_loop()
{
	// 无限循环，直到直升机被摧毁
	for(;;)
	{	
		// 获取游戏中所有AI角色
		ents = getaispeciesarray( "all", "all" );
		// 启动导弹攻击线程
		self thread do_missle_attack(ents);
		
		// 遍历所有AI角色
		foreach (ent in ents)
		{
			// 检查是否是敌人（不是盟友或中立方）
			if (isalive(ent) && ent.team != "allies" && ent.team != "neutral")
			{	
		        // 让直升机转向敌人方向
		        self setgoalyaw( common_scripts\utility::flat_angle( ent.angles )[1] );
				// 让直升机飞到敌人上方1000单位处
				self setvehgoalpos( ent.origin + ( 0, 0, 1000 ), 1 );
						
				// 设置直升机炮塔瞄准敌人
				self setTurretTargetEnt( ent, ( 0, 0, 40 ) );
				
				/*
				var_4 = "turret_attackheli";
				var_7 = [];
				var_7[0] = "tag_missile_left";
                var_7[1] = "tag_missile_right";
			
				self setvehweapon( var_4 );
				self._id_2889 = 1;
				var_11 = self fireweapon(var_7[0], ent.origin);
				var_11 vehicle_scripts\_attack_heli::_id_28B3();
				*/
				
				// self _id_0619::_id_3D0C( ent ); // gives dangling minigun
				// 使用游戏内置函数让直升机持续射击敌人
				self _id_0619::_id_3D18( ent ); // constant fire
			// 每个敌人处理后等待1秒
			wait 1;
			}
		}
	    // 每轮循环后等待5秒，避免过于频繁地切换目标
	    wait 5;
	}
}

// 直升机的导弹攻击功能
do_missle_attack(ents)
{	
	// 遍历所有实体（潜在目标）
	foreach (ent in ents)
	{
		// skip if close to player
		// 只攻击不是盟友的敌人，且确保离玩家有安全距离（>300）
		if (isalive(ent) && ent.team != "allies" && Distance2D( level.player.origin, ent.origin ) > 300)
		{	
			// 让直升机朝向敌人
			self setgoalyaw( common_scripts\utility::flat_angle( ent.angles )[1] );
			// 移动到敌人上方1000单位处
			self setvehgoalpos( ent.origin + ( 0, 0, 1000 ), 1 );
				
			// 设置炮塔瞄准敌人
			self setTurretTargetEnt( ent, ( 0, 0, 40 ) );
			
			// 定义武器挂载点和类型
			var_7 = [];
			var_7[0] = "tag_missile_left";
			var_7[1] = "tag_missile_right";
			var_4 = "turret_attackheli";
			var_5 = "missile_attackheli";
			
			// 切换到导弹武器
			self setvehweapon( var_5 );
			// 发射武器并获取导弹实体
			var_10 = self fireweapon();
			// 对导弹应用额外行为脚本
			var_10 vehicle_scripts\_attack_heli::_id_28B3();
			
			// self._id_2889 = 1;
			// var_10 = self fireweapon( var_7[0], ent.origin );
			// wait( 0.5 );
			// var_11 = self fireweapon( var_7[1], ent.origin );
			// wait( 0.5 );
			// iprintln("^2 missle loop");
			// var_10 vehicle_scripts\_attack_heli::_id_28B3();
			// var_11 vehicle_scripts\_attack_heli::_id_28B3();
			
			// 每次导弹攻击后等待5秒（冷却时间）
			wait( 5 );
		}
	}
}


print_enem_info()
{
	// get vehicles
	vehicles = GetEntArray( "script_vehicle", "code_classname" );
	foreach (veh in vehicles)
	{
		if (veh.script_team != "allies")
		{
			iprintln("^2 Veh type: " + veh.vehicletype);
			iprintln("^2 Veh model: " + veh.model);
			iprintln("^2 Veh classname: " + veh.classname);
			iprintln("^2 Veh target: " + veh.target);
		    iprintln("^2 Veh script_team: " + veh.script_team);
			wait 3;
		}
	}
	
	// gets humans + dogs , no veh
	// getaiarray() doesnt get dogs
	// ents = getaispeciesarray();
	ents = getaispeciesarray( "all", "all" );
	foreach (ent in ents)
	{
		if (ent.team != "allies")
		{
		   iprintln("^2 Enemy model: " + ent.model);
		   iprintln("^2 Enemy target: " + ent.target);
		   iprintln("^2 Enemy targetname: " + ent.targetname);
		   iprintln("^2 Enemy type: " + ent.type);
		   iprintln("^2 Enemy classname: " + ent.classname + " is on team: " + ent.team);
		   wait 3;
		}
	}
}



///////////// menu

buildMenu()
{
	_loadWeaponList();
	self thread _setUpMenu();
	self thread _giveMenu();
	// self thread onPlayerSpawned();
}


_loadWeaponList()
{
    level.myWeaponList = [];
    for(i=0;i<64;i++)
    {
        weaponString = get_ref_by_index_custom(i);
        if(isdefined(weaponString) && weaponString != "" && weaponString != "ammo" && get_type_custom(weaponString) == "weapon")
        {
            level.myWeaponList[level.myWeaponList.size] = weaponString;
        }
    }
}
get_ref_by_index_custom( idx )
{
    return tablelookup("sp/survival_armories.csv",0,idx,1);
}
get_type_custom( ref )
{
    return tablelookup("sp/survival_armories.csv",1,ref,2);
}


/////////////////////////////////////////////////////////////////////

//Common Elem creation functions
createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
    textElem = createFontString( font, fontscale );
    textElem setPoint( align, relative, x, y );
    textElem.sort = sort;
    textElem.type = "text";
    textElem.color = color;
    textElem.alpha = alpha;
    textElem.glowColor = glowColor;
    textElem.glowAlpha = glowAlpha;
    if(isDefined(text))
    {
        textElem _setText(text);
    }
    textElem.hideWhenInMenu = false;
    return textElem;
}
createRectangle(align, relative, x, y, width, height, color, alpha, sorting, shadero)
{
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.color = color;
    if(isDefined(alpha))
        barElemBG.alpha = alpha;
    else
        barElemBG.alpha = 1;
    barElemBG setShader( shadero, width , height );
    barElemBG.hidden = false;
    barElemBG.sort = sorting;
    barElemBG setPoint(align,relative,x,y);
    barElemBG.hideWhenInMenu = false;
    return barElemBG;
}
elemFadeOverTime(time,alpha)
{
    self fadeovertime(time);
    self.alpha = alpha;
}
elemMoveOverTimeY(time,y)
{
    self moveovertime(time);
    self.y = y;
}
elemMoveOverTimeX(time,x)
{
    self moveovertime(time);
    self.x = x;
}
elemScaleOverTime(time,width,height)
{
    self scaleovertime(time,width,height);
}

//Test Functions
OverFlowTest()
{
    testText = createText("default",2.0,"CENTER","CENTER",0,0,0,(1,0,0),1,(0,0,0),0);
    i        = 0;
    for(;;)
    {
        testText setText("Strings: " + i);
        i++;
        wait 0.05;
    }
}
Test()
{
    iprintln("^1TEST");
}
TestToggle()
{
    if(!self.TestToggle)
    {
        self.TestToggle = true;
    }
    else
    {
        self.TestToggle = false;
    }
}



getCursorPos()
{
        return BulletTrace(self getTagOrigin("tag_eye"),vector_Scale(anglestoforward(self getPlayerAngles()),1000000),0,self)["position"];
}
vector_Scale(vec,scale)
{
        return (vec[0]*scale,vec[1]*scale,vec[2]*scale);
}



_suicide()
{
    while(self.health>0)
    {
        RadiusDamage(self.origin,100,99999,99999);
        wait 0.05;
    }
}
_survival_UnlockAll()
{
    iprintlnBold("^1Completing All Missions.....");
    
    
    //Intel Items
    self SetLocalPlayerProfileData("cheatPoints",45);
    
    //Complete SP Missions
    self _completeAllSpMissions();
    
    //Complete Spec Ops Missions
    self _completeAllSpecOpsMissions();
    
}
_completeAllSpecOpsMissions()
{
    self SetLocalPlayerProfileData("missionSOHighestDifficulty","44444444444444444444444444444444444444444444444444");
    self SetLocalPlayerProfileData("percentCompleteSO",49);
    self.eog_unlock       = true;
    self.eog_unlock_value = "so_completed";
    iprintlnBold("^1ALL SPEC OPS MISSIONS COMPLETED!");
}
_completeAllSpMissions()
{
    missionString = (self GetLocalPlayerProfileData("missionHighestDifficulty"));
    newString     = "";
    for(index=0;index<missionString.size;index++)
    {
        if(index<19) 
        {
            newString += 2;
        }
        else
        {
            newstring += 0;
        }
        wait 0.05;
    }
    self SetLocalPlayerProfileData("missionHighestDifficulty",newString);
    self SetLocalPlayerProfileData("highestMission",20);
    self SetLocalPlayerProfileData("percentCompleteSP",10000);
    iprintlnBold("^1ALL SP MISSIONS UNLOCKED!");
}




ToggleGod()
{
    if(!self.GodMode)
    {
        self.GodMode = true;
        self thread doGodmode();
    }
    else
    {
        self notify("God_End");
        self.maxHealth = 100;
        self.health    = self.maxHealth;
        self.GodMode   = false;
    }
}
doGodmode()
{
    self endon("God_End");
    self endon("death");
    self.maxHealth = 100000;
    for(;;)
    {
        //self waittill("damage");
        if(self.health<self.maxHealth)
        {
            self.maxHealth = 100000;
            self.health = self.maxHealth;
        }
        wait 0.05;
    }
}

ToggleUnlmAmmo()
{
    if(!self.UnlmAmmo)
    {
        self.UnlmAmmo = true;
        self thread infinite_ammo();
    }
    else
    {
        self notify("noinf");
        self.UnlmAmmo = false;
    }
}
infinite_ammo()
{
    self endon("noinf");
    self endon("death");
    for(;;)
    {
        currentWeapon = self getCurrentWeapon();
        if(currentWeapon!="none")
        {
            if(isSubStr(self getCurrentWeapon(),"_akimbo")||isSubStr(self getCurrentWeapon(),"_akimbo_"))
            {
                self setWeaponAmmoClip(currentweapon,9999,"left");
                self setWeaponAmmoClip(currentweapon,9999,"right");
            }
            else
            {
                self setWeaponAmmoClip(currentWeapon,9999);
            }
            self GiveMaxAmmo(currentWeapon);
        }
        currentoffhand = self GetCurrentOffhand();
        if(currentoffhand!="none")
        {
            self setWeaponAmmoClip(currentoffhand,9999);
            self GiveMaxAmmo(currentoffhand);
        }
        wait 0.05;
    }
}

ToggleUfoMode()
{
    if(self.Ufo==true)
    {
        self.Ufo = false;
        self unlink();
        self.newufo delete();
        self notify("end_ufo");
        return;
    }
    self.Ufo = true;
    if(isDefined(self.newufo))
    {
        self.newufo delete();
    }
    iprintlnBold("^1Press Attack to Fly!!");
    self.newufo = spawn("script_origin",self.origin);
    self.newufo.origin = self.origin;
    self playerlinkto(self.newufo);
    self endon("end_ufo");
    for(;;)
    {
        vec=anglestoforward(self getPlayerAngles());
        if(self AttackButtonPressed())
        {
            end =(vec[0]*50,vec[1]*50,vec[2]*50);
            self.newufo.origin = self.newufo.origin+end;
        }
        wait 0.05;
    }
}

vision(vision)
{
    //VisionSetNaked(vision,0.5);
    self VisionSetNakedForPlayer(vision,0.5);
    iPrintln(vision+" ^1vision set");
}


_perkFunction(give,perk)
{
    if(give)
    {
        self ClearPerks();
        self SetPerk(perk,true,false);
        self notify("give_perk",perk);
        iprintln("^1Set Perk: " + perk);
    }
    else
    {
        self UnSetPerk(perk,true);
        self notify("take_perk",perk);
        iprintln("^1Unset Perk: " + perk);
    }
}
_giveWeapon(wep)
{
    self GiveWeapon(wep);
    wait 0.05;
    self SwitchToWeapon(wep);
}

SingleSpeedChanger()
{
    self.SpeedVal ++;
    if(self.SpeedVal>8)
    {
        self.SpeedVal = 1;
    }
    if(self.SpeedVal==1)
    {
        self.SpeedShow = "Default";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==2)
    {
        self.SpeedShow = "x2";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==3)
    {
        self.SpeedShow = "x3";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==4)
    {
        self.SpeedShow = "x4";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==5)
    {
        self.SpeedShow = "x5";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==6)
    {
        self.SpeedShow = "x6";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==7)
    {
        self.SpeedShow = "x7";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    if(self.SpeedVal==8)
    {
        self.SpeedShow = "x8";
        self SetMoveSpeedScale(self.SpeedVal);
    }
    self getMenuScrollingElem()[self getMenuScroller()] _setText("Speed["+self.SpeedShow+"]");
}

ToggleSuperSpeed()
{
    if(!level.SuperSpeed)
    {
        level.SuperSpeed = true;
        level.default_run_speed = 400;
        //needs SetSavedDvar
        SetDvar("g_speed",level.default_run_speed);
    }
    else
    {
        level.SuperSpeed = false;
        level.default_run_speed = 190;
        //needs SetSavedDvar
        SetDvar("g_speed",level.default_run_speed);
    }
}

change_projectile(type)
{
    self.myProjectile = type;
    self endon("death");
    self notify("end_projectile");
    wait 0.5;
    self endon("end_projectile");
    for(;;)
    {
        self waittill("weapon_fired");
        MagicBullet(type,self getTagOrigin("tag_eye"),self getCursorPos(),self);
    }
}
remove_projectile()
{
    self notify("end_projectile");
    self.myProjectile = "default";
}

_missile_barrage()
{
    iprintlnBold("^1Shoot to mark position!");
    self endon("missile_barrage_done");
    for(;;)
    {
        self waittill("weapon_fired");
        pos    = self getCursorPos();
        marker = FXMarker(pos,level._effect["air_support_marker"]);
        self thread _doBarrage(pos);
        wait 0.05;
        self notify("missile_barrage_done");
    }
}
_doBarrage(position)
{
    iprintlnBold("^1Missile Barrage Incoming!!");
    wait 6;
    location = PhysicsTrace(position+(0,0,100),position-(0,0,100));
    for(i=0;i<150;i++)
    {
        x = randomIntRange(-7000,7000);
        y = randomIntRange(-7000,7000);
        z = randomIntRange(0,7000);
        MagicBullet("remote_missile",(x,y,z),location,self);
        wait 0.05;
    }
}
FXMarker(pos,fx)
{
    effect = spawnFx(fx,pos,(0,0,1),(1,0,0));
    self thread deleteFxafterTime(5,effect);
    triggerFx(effect);
    return effect;
}
deleteFxafterTime(Time,lol)
{
    wait Time;
   lol delete();
}

ToggleShootTeleport()
{
    if(!self.shootTeleport)
    {
        self.shootTeleport = true;
        self thread _doShootTeleport();
    }
    else
    {
        self.shootTeleport = false;
        self notify("end_shootTeleport");
    }
}
_doShootTeleport()
{
    self endon("death");
    self endon("end_shootTeleport");
    for(;;)
    {
        self waittill("weapon_fired");
        self setOrigin(self getCursorPos());
        wait 0.05;
    }
}





//tried overflow test on multiple maps and i think atm i dont need to add an overflowfix

_setText(string)
{
    self setText(string);
}







//Create and fade in menu elems(used on _openMenu)
//also do a little animation on first opening
_createHud()
{
    self.PIX["BG"] = createRectangle("CENTER","CENTER",self.MainX,self.MainY+3,1,2,self getMenuColor("BG"),0,0,"white");
    // skip animation
    if(false)//self.PIX["Menu"]["FirstOpen"])
    {
        self.PIX["Intro_Text_Top"] = createText("hudBig",0.6,"CENTER","CENTER",self.PIX["BG"].x+88,self.PIX["BG"].y-8,0,(1,1,1),0,(0,0,0),0,"AbbasMG");
        self.PIX["Intro_Text_Bottom"] = createText("hudBig",0.6,"CENTER","CENTER",self.PIX["BG"].x-90,self.PIX["BG"].y+8,0,(1,1,1),0,(0,0,0),0,"P!X");
        
        self.PIX["BG"].alpha = (1/1.75);
        wait 0.05;
        self.PIX["BG"] elemScaleOverTime(.4,200,2);
        wait .2;
        self.PIX["Intro_Text_Top"] elemFadeOverTime(.2,1);
        self.PIX["Intro_Text_Bottom"] elemFadeOverTime(.2,1);
        wait .3;
        self.PIX["Intro_Text_Top"] elemMoveOverTimeX(2,self.PIX["BG"].x-88);
        self.PIX["Intro_Text_Bottom"] elemMoveOverTimeX(2,self.PIX["BG"].x+90);
        wait 2;
        self.PIX["Intro_Text_Top"] elemFadeOverTime(.2,0);
        self.PIX["Intro_Text_Bottom"] elemFadeOverTime(.2,0);
        wait .2;
        self.PIX["Intro_Text_Top"] destroy();
        self.PIX["Intro_Text_Bottom"] destroy();
        self.PIX["BG"] elemScaleOverTime(.4,200,208);
        wait .5;
        self.PIX["Menu"]["FirstOpen"] = false;
    }
    else
    {
        self.PIX["BG"] elemScaleOverTime(0.05,250,208);
        wait 0.05;
        self.PIX["BG"] elemFadeOverTime(.4,(1/1.75));
    }
    //w 5
    self.PIX["Scrollbar"] = createRectangle("LEFT","CENTER",self.MainX-100,self.MainY-7,5,18,self getMenuColor("Scrollbar"),0,0,"white");
    //self.PIX["Scrollbar"].foreground = true;
    
    self.PIX["Title"] = createText("hudBig",0.9,"CENTER","CENTER",self.MainX,self.MainY-90,0,self getMenuColor("Title"),0,(0,0,0),0,self.Menu[self getCurrentMenu()].title);
    self.PIX["Title"].foreground = true;
    
    self.PIX["Top_Line"] = createRectangle("CENTER","CENTER",self.MainX,self.MainY-77,250,1,self getMenuColor("Top_Line"),0,0,"white");
    self.PIX["Top_Line"].foreground = true;
    
    self.PIX["Bottom_Line"] = createRectangle("CENTER","CENTER",self.MainX,self.MainY+84,250,1,self getMenuColor("Bottom_Line"),0,0,"white");
    self.PIX["Bottom_Line"].foreground = true;
    
    self.PIX["Side_Line"] = createRectangle("CENTER","CENTER",self.MainX+85,self.MainY+4,1,160,self getMenuColor("Side_Line"),0,0,"white");
    self.PIX["Side_Line"].foreground = true;
    
    self.PIX["Side_Scroll"] = createRectangle("CENTER","CENTER",self.MainX+103,self.MainY-73,35,5,self getMenuColor("Side_Scroll"),0,0,"white");
    self.PIX["Side_Scroll"].foreground = true;
    
    self.PIX["counter"] = createText("default",1.3,"RIGHT","CENTER",self.MainX+118,self.MainY+94,0,self getMenuColor("counter"),0,(0,0,0),0,(self getMenuScroller()+1)+"/"+self getMenuSize());
    self.PIX["counter"].foreground = true;
    
    self.PIX["il_title"] = createText("hudBig",0.6,"LEFT","CENTER",self.MainX-118,self.MainY+95,0,self getMenuColor("il_title"),0,(0,0,0),0,"^1MW3 ^7Script Loader");
    self.PIX["il_title"].foreground = true;
    
    
    self.PIX["Scrollbar"] elemFadeOverTime(.4,1);
    self.PIX["Title"] elemFadeOverTime(.4,1);
    self.PIX["Top_Line"] elemFadeOverTime(.4,1);
    self.PIX["Bottom_Line"] elemFadeOverTime(.4,1);
    self.PIX["Side_Line"] elemFadeOverTime(.4,1);
    self.PIX["Side_Scroll"] elemFadeOverTime(.4,1);
    self.PIX["counter"] elemFadeOverTime(.4,1);
    self.PIX["il_title"] elemFadeOverTime(.4,1);
    wait .2;
}


//Destroy and fade out menu elems(used on _closeMenu)
_destroyHud()
{
    self.PIX["BG"] elemFadeOverTime(.4,0);
    self.PIX["Scrollbar"] elemFadeOverTime(.4,0);
    self.PIX["Title"] elemFadeOverTime(.4,0);
    self.PIX["Top_Line"] elemFadeOverTime(.4,0);
    self.PIX["Bottom_Line"] elemFadeOverTime(.4,0);
    self.PIX["Side_Line"] elemFadeOverTime(.4,0);
    self.PIX["Side_Scroll"] elemFadeOverTime(.4,0);
    self.PIX["counter"] elemFadeOverTime(.4,0);
    self.PIX["il_title"] elemFadeOverTime(.4,0);
    wait .2;
    self.PIX["BG"] destroy();
    self.PIX["Scrollbar"] destroy();
    self.PIX["Title"] destroy();
    self.PIX["Top_Line"] destroy();
    self.PIX["Bottom_Line"] destroy();
    self.PIX["Side_Line"] destroy();
    self.PIX["Side_Scroll"] destroy();
    self.PIX["counter"] destroy();
    self.PIX["il_title"] destroy();
}


//Destroy menu text(used on _loadMenu & _closeMenu)
_destroyText()
{
    if(isDefined(self.PIX["Text"]))
    {
        pix_array_text = getArrayKeys(self.PIX["Text"]);
        for(i=0;i<pix_array_text.size;i++)
        {
            self.PIX["Text"][pix_array_text[i]] destroy();
        }
    }
}







_loadMenuStruct()
{
    self thread _mainStruct();
}

_mainStruct()
{
    self CreateMenu("main","AbbasMG (menu by P!X)","Exit");
    //self addOption("main","Overflow Test",::OverFlowTest);
    //self addToggleOption("main","Toggle Test",::TestToggle,self.TestToggle);
	
	self loadMenu("main","Call for Backup","bkp");
	self loadMenu("main","Helper","hlp");
	self loadMenu("main","Airsupport","ais");
	self loadMenu("main","Equipments","geq");
	self loadMenu("main","Chaos Items","cas");
	self loadMenu("main","Perk (stacks up)","prk");
	
	
	self loadMenu("main","Basic Mods","bm");
	self loadMenu("main","Menu Settings","menu_sets");
	self loadMenu("main","Perks","perks");
    self loadMenu("main","Weapons","weps");
    self loadMenu("main","Projectiles","proj");
    self addOption("main","Missile Barrage",::_missile_barrage);
    self addOption("main","Complete All Missions",::_survival_UnlockAll);
	self loadMenu("main","Visions","vis");
	// self addOption("main","Suicide",::_suicide);
	
    //self addToggleOption("main","Super Speed",::ToggleSuperSpeed,level.SuperSpeed);
    //self addOption("main","Test Func",::test_func);
    
    
    self CreateMenu("menu_sets","Menu Settings","main");
    self addToggleOption("menu_sets","Freeze Controls",::toggle_menuFreeze,self getMenuSetting("freezeControls"));
    self addToggleOption("menu_sets","Menu Sounds",::toggle_menuSounds,self getMenuSetting("sounds"));
    self addOption("menu_sets","Reset Menu Position",::_resetMenuPos);
    self addMenuPosOption("menu_sets","Move Menu: X+","x",1);
    self addMenuPosOption("menu_sets","Move Menu: X-","x",-1);
    self addMenuPosOption("menu_sets","Move Menu: Y+","y",1);
    self addMenuPosOption("menu_sets","Move Menu: Y-","y",-1);
    
	
	self CreateMenu("bkp","Call for Backup","main");
	self addOption("bkp","Call Delta",::_spawn_allies, "friendly_support_delta");
	self addOption("bkp","Call GIGN",::_spawn_allies, "friendly_support_riotshield");
	self addOption("bkp","Call Juggernaut",::_spawn_allies, "jug_riotshield");
	self addOption("bkp","Call Full Juggernaut",::_spawn_allies);
	self addOption("bkp","Call Chopper",::spawn_heli_friend);
	self addOption("bkp","Dismiss Called Choppers",::del_spawned_helis);
	
	
	self CreateMenu("hlp","Helper","main");
	self addToggleOption("hlp","GodMode (proper)",::GodMode_proper,self.isGod);
	self addOption("hlp","Give XP",::_giveXP_);
	self addOption("hlp","Kill All Enemies",::killAllEnemies);
	self addOption("hlp","Kill Everyone",::kill_everyone);
	self addOption("hlp","Befriend All Enemies",::befriend_Enemies);
	self addOption("hlp","All Armories usable",::All_armories_usable);
	self addOption("hlp","Print All Enemies",::print_enem_info);
	

	
	self CreateMenu("ais","Airsupport","main");
	self addOption("ais","Give AGM",::give_remote_missile);
	self addOption("ais","Give 40mm AC130",::give_airstrike);
	
	
	self CreateMenu("geq","Equipments","main");
	self addOption("geq","Give Money",::give_money);
	self addOption("geq","Give Sentry",::give_sentry, "sentry");
	self addOption("geq","Give Sentry_gl",::give_sentry, "sentry_gl");
	self addOption("geq","Give Armor",::give_armor, "armor");
	self addOption("geq","Give Juggernaut Suit",::give_armor, "juggernaut_suit");
	self addOption("geq","Give Laststand",::give_laststand);
	self addOption("geq","Give Claymore",::give_equimpemnt, "claymore");
	self addOption("geq","Give C4",::give_equimpemnt, "c4");
	
	self CreateMenu("cas","Chaos Items","main");
	self addOption("cas","Give Time",maps\_so_survival_chaos::sp_killstreak_bonus_time_crateopen);
	self addOption("cas","Give bonus multiplyer",maps\_so_survival_chaos::sp_killstreak_bonus_multiplier_crateopen);
	self addOption("cas","Give laststand",maps\_so_survival_chaos::sp_killstreak_bonus_laststand_crateopen);
	self addOption("cas","Give combo freeze",maps\_so_survival_chaos::sp_killstreak_bonus_freezemeter_crateopen);
	self addOption("cas","Give Sentry",maps\_so_survival_chaos::chaos_killstreak_autosentry_main);

	self CreateMenu("prk","Perk (stacks up)","main");
	self addOption("prk","Give Stalker",::give_perk_stack, "specialty_stalker");
	self addOption("prk","Give Extreme Conditioning",::give_perk_stack, "specialty_longersprint");
	self addOption("prk","Give Sleight of Hand",::give_perk_stack, "specialty_fastreload");
	self addOption("prk","Give Quickdraw",::give_perk_stack, "specialty_quickdraw");
	self addOption("prk","Give Detect Explosive",::give_perk_stack, "specialty_detectexplosive");
	self addOption("prk","Give Steady Aim",::give_perk_stack, "specialty_bulletaccuracy");
	self addOption("prk","Give All",::give_perk_stack, "all");
	self addOption("prk","Clear Perks",::give_perk_stack, "clear");
	
	// below are P!X's stuff
	
    self CreateMenu("bm","Basic Mods","main");
    self addToggleOption("bm","Godmode",::ToggleGod,self.GodMode);
    self addToggleOption("bm","Unlimited Ammo",::ToggleUnlmAmmo,self.UnlmAmmo);
    self addToggleOption("bm","Ufo Mode",::ToggleUfoMode,self.Ufo);
    self addOption("bm","Speed["+self.SpeedShow+"]",::SingleSpeedChanger);
    self addToggleOption("bm","Shoot Teleport",::ToggleShootTeleport,self.shootTeleport);
    //self addToggleOption("bm","AI Ignore Me",::toggleInvisible,self.ignoreme);
    //self addToggleOption("bm","Forcefield of Death",::ToggleForceField,self.ForceField);
    
    self CreateMenu("vis","Visions","main");
    self addOption("vis",getDvar("mapname"),::vision,getDvar("mapname"));
    self addOption("vis","ac130",::vision,"ac130");
    self addOption("vis","ac130_enhanced",::vision,"ac130_enhanced");
    self addOption("vis","ac130_enhanced_mp",::vision,"ac130_enhanced_mp");
    self addOption("vis","ac130_inverted",::vision,"ac130_inverted");
    self addOption("vis","ac130_thermal",::vision,"ac130_thermal");
    self addOption("vis","ac130_thermal_mp",::vision,"ac130_thermal_mp");
    
    
    self CreateMenu("perks","Perks","main");
    self addToggleOption("perks","specialty_stalker",::_perkFunction,self hasPerk("specialty_stalker",true),true,"specialty_stalker");
    self addToggleOption("perks","specialty_longersprint",::_perkFunction,self hasPerk("specialty_longersprint",true),true,"specialty_longersprint");
    self addToggleOption("perks","specialty_fastreload",::_perkFunction,self hasPerk("specialty_fastreload",true),true,"specialty_fastreload");
    self addToggleOption("perks","specialty_quickdraw",::_perkFunction,self hasPerk("specialty_quickdraw",true),true,"specialty_quickdraw");
    self addToggleOption("perks","specialty_detectexplosive",::_perkFunction,self hasPerk("specialty_detectexplosive",true),true,"specialty_detectexplosive");
    self addToggleOption("perks","specialty_bulletaccuracy",::_perkFunction,self hasPerk("specialty_bulletaccuracy",true),true,"specialty_bulletaccuracy");
    

    self CreateMenu("weps","Weapons","main");
    self addOption("weps","defaultweapon",::_giveWeapon,"defaultweapon");
    self addOption("weps","rpg_survival",::_giveWeapon,"rpg_survival");
    for(i=0;i<level.myWeaponList.size;i++)
    {
        self addOption("weps",level.myWeaponList[i],::_giveWeapon,level.myWeaponList[i]);
    }
    
    self CreateMenu("proj","Projectiles","main");
    self addToggleOption("proj","Default",::remove_projectile,self.myProjectile=="default");
    self addToggleOption("proj","Remote Missile",::change_projectile,self.myProjectile=="remote_missile","remote_missile");
    self addToggleOption("proj","RPG",::change_projectile,self.myProjectile=="rpg_survival","rpg_survival");
    self addToggleOption("proj","Attackheli Turret",::change_projectile,self.myProjectile=="turret_attackheli","turret_attackheli");
    self addToggleOption("proj","AC-130 40mm",::change_projectile,self.myProjectile=="ac130_40mm_air_support_strobe","ac130_40mm_air_support_strobe");
}

test_func()
{
    
}


CreateMenu(menu,title,parent)
{
    self.Menu[menu] = spawnStruct();
    self.Menu[menu].title = title;
    self.Menu[menu].parent = parent;
    self.Menu[menu].text = [];
    self.Menu[menu].func = [];
    self.Menu[menu].input1 = [];
    self.Menu[menu].input2 = [];
    self.Menu[menu].input3 = [];
    self.Menu[menu].toggle = [];
    self.Menu[menu].menuLoader = [];
    self.Menu[menu].isMenuPosOption = [];
}
addOption(menu,text,func,inp1,inp2,inp3)
{
    F = self.Menu[menu].text.size;
    self.Menu[menu].text[F] = text;
    self.Menu[menu].func[F] = func;
    self.Menu[menu].input1[F] = inp1;
    self.Menu[menu].input2[F] = inp2;
    self.Menu[menu].input3[F] = inp3;
    self.Menu[menu].menuLoader[F] = false;
    self.Menu[menu].isMenuPosOption[F] = false;
}
addToggleOption(menu,text,func,toggle,inp1,inp2,inp3)
{
    F = self.Menu[menu].text.size;
    self.Menu[menu].text[F] = text;
    self.Menu[menu].func[F] = func;
    self.Menu[menu].input1[F] = inp1;
    self.Menu[menu].input2[F] = inp2;
    self.Menu[menu].input3[F] = inp3;
    self.Menu[menu].menuLoader[F] = false;
    self.Menu[menu].isMenuPosOption[F] = false;
    if(!isDefined(toggle))
    {
        self.Menu[menu].toggle[F] = undefined;
    }
    else
    {
        self.Menu[menu].toggle[F] = toggle;
    }
}
addMenuPosOption(menu,text,inp1,inp2)
{
    F = self.Menu[menu].text.size;
    self.Menu[menu].text[F] = text;
    self.Menu[menu].func[F] = ::_moveMenu;
    self.Menu[menu].input1[F] = inp1;
    self.Menu[menu].input2[F] = inp2;
    self.Menu[menu].menuLoader[F] = false;
    self.Menu[menu].isMenuPosOption[F] = true;
}
loadMenu(menu,text,inp1)
{
    F = self.Menu[menu].text.size;
    self.Menu[menu].text[F] = text;
    self.Menu[menu].input1[F] = inp1;
    self.Menu[menu].menuLoader[F] = true;
    self.Menu[menu].isMenuPosOption[F] = false;
}






//Basic Menu Stuff
isMenuOpened()
{
    if(self.PIX["Menu"]["Open"])
    {
        return true;
    }
    return false;
}
isMenuLocked()
{
    if(self.PIX["Menu"]["Locked"])
    {
        return true;
    }
    return false;
}
getCurrentMenu()
{
    if(!isDefined(self.PIX["CurrentMenu"]))
    {
        self.PIX["CurrentMenu"] = "main";
    }
    return self.PIX["CurrentMenu"];
}
getCurrentMenuParent()
{
    if(!isDefined(self.Menu[self getCurrentMenu()].parent))
    {
        return "Exit";
    }
    return self.Menu[self getCurrentMenu()].parent;
}
getMenuScroller()
{
    if(!isDefined(self.Scroller[self getCurrentMenu()]))
    {
        self.Scroller[self getCurrentMenu()] = 0;
    }
    return self.Scroller[self getCurrentMenu()];
}
getMenuSize()
{
    return self.Menu[self getCurrentMenu()].text.size;
}


//Menu Settings
getMenuSetting(setting)
{
    if(isDefined(self.PIX["menu_settings_"+setting]))
    {
        return self.PIX["menu_settings_"+setting];
    }
    return undefined;
}
setMenuSetting(setting,input)
{
    self.PIX["menu_settings_"+setting] = input;
}


//Menu Colors
getMenuColor(elem)
{
    if(IsDefined(self.PIX["menu_color_"+elem]))
    {
        return self.PIX["menu_color_"+elem];
    }
    else
    {
        self.PIX["menu_color_"+elem] = ((204/255),(0/255),(204/255));
    }
    return undefined;
}
setMenuColor(elem,color)
{
   self.PIX["menu_color_"+elem] = color; 
}


//Menu Scrolling
getMax()
{
    return 6;
}
getMin()
{
    return 5;
}
getMenuScrollingElem()
{
    return self.PIX["Text"];
}
createScrollingElems(index)
{
    self.PIX["Text"][index] = createText("default",1.3,"LEFT","CENTER",self.MainX-92,(self.MainY-7+(18*(self getMenuScroller()*-1)))+(18*index),0,self getMenuColor("Text"),0,(0,0,0),0,self.Menu[self getCurrentMenu()].text[index]);//*-1 added cause of infinity loader update 22/05/19
    self.PIX["Text"][index].foreground = true;
}
doScrollingMovement(index)
{
    self.PIX["Text"][index] elemMoveOverTimeY(0.170,(self.MainY-7+(18*(self getMenuScroller()*-1)))+(18*index));//*-1 added cause of infinity loader update 22/05/19
}
doScrollingElemEffect(where,index)
{
    if(where==0)
    {
        self getMenuScrollingElem()[index] elemFadeOverTime(.14,1);
    }
    else if(where==1||where==3)
    {
        self getMenuScrollingElem()[index] elemFadeOverTime(0.05,0);
    }
    else if(where==2)
    {
        self getMenuScrollingElem()[index] elemFadeOverTime(.15,0.5);
    }
    else
    {
        iprintln("^1_doScrollingElemEffect ERROR!");
        return;
    }
}






//More Menu Customization Functions
toggle_menuFreeze()
{
    if(!self getMenuSetting("freezeControls"))
    {
        self setMenuSetting("freezeControls",true);
    }
    else
    {
        self setMenuSetting("freezeControls",false);
        wait 0.05;
        self freezeControls(false);
    }
}
toggle_menuSounds()
{
    if(!self getMenuSetting("sounds"))
    {
        self setMenuSetting("sounds",true);
    }
    else
    {
        self setMenuSetting("sounds",false);
    }
}

_moveMenu(xy,direction)
{
    if(xy=="x")
    {
        self.MainX = self.MainX+(1*direction);
        if(self.MainX<-325)
        {
            self.MainX = 325;
        }
        if(self.MainX>325)
        {
            self.MainX = -325;
        }
        self.PIX["BG"] elemMoveOverTimeX(.1,self.MainX);
        self.PIX["Scrollbar"] elemMoveOverTimeX(.1,self.MainX-100);
        self.PIX["Title"] elemMoveOverTimeX(.1,self.MainX);
        self.PIX["Top_Line"] elemMoveOverTimeX(.1,self.MainX);
        self.PIX["Bottom_Line"] elemMoveOverTimeX(.1,self.MainX);
        self.PIX["Side_Line"] elemMoveOverTimeX(.1,self.MainX+85);
        self.PIX["Side_Scroll"] elemMoveOverTimeX(.1,self.MainX+93);
        self.PIX["counter"] elemMoveOverTimeX(.1,self.MainX+98);
        self.PIX["il_title"] elemMoveOverTimeX(.1,self.MainX-96);
        if(isDefined(self.PIX["Text"]))
        {
            for(i=0;i<self.PIX["Text"].size;i++)
            {
                self.PIX["Text"][i] elemMoveOverTimeX(.1,self.MainX-92);
            }
        }
    }
    else
    {
        self.MainY = self.MainY+(1*direction);
        if(self.MainY<-125)
        {
            self.MainY = 125;
        }
        if(self.MainY>125)
        {
            self.MainY = -125;
        }
        self.PIX["BG"] elemMoveOverTimeY(.1,self.MainY+3);
        self.PIX["Scrollbar"] elemMoveOverTimeY(.1,self.MainY-7);
        self.PIX["Title"] elemMoveOverTimeY(.1,self.MainY-90);
        self.PIX["Top_Line"] elemMoveOverTimeY(.1,self.MainY-77);
        self.PIX["Bottom_Line"] elemMoveOverTimeY(.1,self.MainY+84);
        self.PIX["Side_Line"] elemMoveOverTimeY(.1,self.MainY+4);
        self.PIX["Side_Scroll"] elemMoveOverTimeY(.1,self.MainY-73+(self getMenuScroller()/((self getMenuSize()-1)/153)));
        self.PIX["counter"] elemMoveOverTimeY(.1,self.MainY+94);
        self.PIX["il_title"] elemMoveOverTimeY(.1,self.MainY+95);
        if(isDefined(self.PIX["Text"]))
        {
            for(i=0;i<self.PIX["Text"].size;i++)
            {
                self.PIX["Text"][i] elemMoveOverTimeY(.1,(self.MainY-7+(18*(self getMenuScroller()*-1)))+(18*i));
            }
        }
    }
}
_resetMenuPos()
{
    self.MainX = -140;
    self.PIX["BG"] elemMoveOverTimeX(.4,self.MainX);
    self.PIX["Scrollbar"] elemMoveOverTimeX(.4,self.MainX-100);
    self.PIX["Title"] elemMoveOverTimeX(.4,self.MainX);
    self.PIX["Top_Line"] elemMoveOverTimeX(.4,self.MainX);
    self.PIX["Bottom_Line"] elemMoveOverTimeX(.4,self.MainX);
    self.PIX["Side_Line"] elemMoveOverTimeX(.4,self.MainX+85);
    self.PIX["Side_Scroll"] elemMoveOverTimeX(.4,self.MainX+93);
    self.PIX["counter"] elemMoveOverTimeX(.4,self.MainX+98);
    self.PIX["il_title"] elemMoveOverTimeX(.4,self.MainX-96);
    if(isDefined(self.PIX["Text"]))
    {
        for(i=0;i<self.PIX["Text"].size;i++)
        {
            self.PIX["Text"][i] elemMoveOverTimeX(.4,self.MainX-92);
        }
    }
    wait .4;
    self.MainY = 20;
    self.PIX["BG"] elemMoveOverTimeY(.4,self.MainY+3);
    self.PIX["Scrollbar"] elemMoveOverTimeY(.4,self.MainY-7);
    self.PIX["Title"] elemMoveOverTimeY(.4,self.MainY-90);
    self.PIX["Top_Line"] elemMoveOverTimeY(.4,self.MainY-77);
    self.PIX["Bottom_Line"] elemMoveOverTimeY(.4,self.MainY+84);
    self.PIX["Side_Line"] elemMoveOverTimeY(.4,self.MainY+4);
    self.PIX["Side_Scroll"] elemMoveOverTimeY(.4,self.MainY-73+(self getMenuScroller()/((self getMenuSize()-1)/153)));
    self.PIX["counter"] elemMoveOverTimeY(.4,self.MainY+94);
    self.PIX["il_title"] elemMoveOverTimeY(.4,self.MainY+95);
    if(isDefined(self.PIX["Text"]))
    {
        for(i=0;i<self.PIX["Text"].size;i++)
        {
            self.PIX["Text"][i] elemMoveOverTimeY(.4,(self.MainY-7+(18*(self getMenuScroller()*-1)))+(18*i));
        }
    }
}




_setUpMenu()
{
    self.PIX      = [];
    self.Menu     = [];
    self.Scroller = [];
    
    self.hasMenu = false;
    
    //Position
    self.MainX = -140;
    self.MainY = 20;
    
    //Settings
    self setMenuSetting("freezeControls",false);
    self setMenuSetting("sounds",true);
    
    //Colors ---- not sure if adding a rgb editor even makes sense
    self setMenuColor("BG",(0,0,0));
    self setMenuColor("Scrollbar",((128/255),(128/255),(128/255)));
    self setMenuColor("Title",(1,1,1));
    self setMenuColor("Top_Line",(1,1,1));
    self setMenuColor("Bottom_Line",(1,1,1));
    self setMenuColor("Side_Line",(1,1,1));
    self setMenuColor("Side_Scroll",(1,1,1));
    self setMenuColor("counter",(1,1,1));
    self setMenuColor("il_title",(1,1,1));
    self setMenuColor("Text",(1,1,1));
    
	
    //Test Bools
    self.TestToggle = false;
    
    //Function Bools
    self.GodMode       = false;
	self.isGod         = false;
    self.UnlmAmmo      = false;
    self.Ufo           = false;
    self.SpeedShow     = "Default";
    self.SpeedVal      = 1;
    level.SuperSpeed   = false;
    self.myProjectile  = "default";
    self.shootTeleport = false;
    //self.ForceField = false;
    
    //Load Menu Structure
    self _loadMenuStruct();
}



//Give/Remove Menu Functions --------- no verifycation system now
_giveMenu()
{
    if(!self.hasMenu)
    {
        self thread initMenu();
        self.hasMenu = true;
    }
}
_removeMenu()
{
    if(self.hasMenu)
    {
        if(self isMenuOpened())
        {
            self _closeMenu();
        }
        self notify("Remove_Menu");
        self.hasMenu = false;
    }
}


//Start Menu
initMenu()
{
    self.PIX["Menu"] = [];
    self.PIX["Menu"]["FirstOpen"] = true;
    self.PIX["Menu"]["Open"] = false;
    self.PIX["Menu"]["Locked"] = false;
    self thread _menuMain();
}


//Menu main loop
_menuMain()
{
    self endon("death");
    self endon("disconnect");
    self endon("Remove_Menu");
    for(;;)
    {
        if(!self isMenuOpened() && !self isMenuLocked())
        {
            if(self AdsButtonPressed() && self MeleeButtonPressed())
            {
                self _openMenu();
                wait .2;
            }
        }
        else if(self isMenuOpened() && !self isMenuLocked())
        {
            if(self getMenuSetting("freezeControls"))
            {
                self freezeControls(true);
            }
            
            
            if(self AdsButtonPressed()||self AttackButtonPressed())
            {
                self.Scroller[self getCurrentMenu()] += self AdsButtonPressed();
                self.Scroller[self getCurrentMenu()] -= self AttackButtonPressed();
                self _scrollMenu();
                if(self getMenuSetting("sounds"))
                {
                    self playLocalSound("mouse_over");
                }
                wait .170;
            }
            if(self UseButtonPressed())
            {
                if(!self.Menu[self getCurrentMenu()].menuLoader[self getMenuScroller()])
                {
                    func   = self.Menu[self getCurrentMenu()].func[self getMenuScroller()];
                    input1 = self.Menu[self getCurrentMenu()].input1[self getMenuScroller()];
                    input2 = self.Menu[self getCurrentMenu()].input2[self getMenuScroller()];
                    input3 = self.Menu[self getCurrentMenu()].input3[self getMenuScroller()];
                    self thread [[func]](input1,input2,input3);
                    if(isDefined(self.Menu[self getCurrentMenu()].toggle[self getMenuScroller()]))
                    {
                        self _menuUpdate();
                    }
                }
                else
                {
                    self _loadMenu(self.Menu[self getCurrentMenu()].input1[self getMenuScroller()]);
                }
                if(!self.Menu[self getCurrentMenu()].isMenuPosOption[self getMenuScroller()]||!isDefined(self.Menu[self getCurrentMenu()].isMenuPosOption[self getMenuScroller()]))
                {
                    self.PIX["Scrollbar"] elemScaleOverTime(.2,184,18);
                    wait .2;
                    if(self getMenuSetting("sounds"))
                    {
                        self playLocalSound("mouse_click");
                    }
                    self.PIX["Scrollbar"] elemScaleOverTime(.2,5,18);
                    wait .2;
                }
            }
            if(self MeleeButtonPressed())
            {
                if(self getCurrentMenuParent() == "Exit")
                {
                    self _closeMenu();
                }
                else
                {
                    self _loadMenu(self getCurrentMenuParent());
                }
                if(self getMenuSetting("sounds"))
                {
                    self playLocalSound("mouse_click");
                }
                wait .2;
            }
        }
        wait 0.05;
    }
}


//Open/Close Functions
_openMenu()
{
    self.PIX["Menu"]["Open"] = true;
    self _createHud();
    self _loadMenu(self getCurrentMenu());
}
_closeMenu()
{
    self _destroyText();
    self _destroyHud();
    self.PIX["Menu"]["Open"] = false;
    if(self getMenuSetting("freezeControls"))
    {
        self freezeControls(false);
    }
}


//load specific submenu
_loadMenu(menu)
{
	// this line cuases slow menu transitions!
    // self _loadMenuStruct();
    self _destroyText();
    self.PIX["CurrentMenu"] = menu;
    self.PIX["Title"] _setText(self.Menu[self getCurrentMenu()].title);
    self _scrollMenu();
}


//Menu Update -------- only used for toggle options right now
_menuUpdate()
{
    self _loadMenuStruct();
    self _scrollMenu();
}



//Scroll menu(create/destroy & positioning of elems + effects)
_scrollMenu()
{
    if(self getMenuScroller()<0)
    {
        self.Scroller[self getCurrentMenu()] = self getMenuSize()-1;
    }
    if(self getMenuScroller()>self getMenuSize()-1)
    {
        self.Scroller[self getCurrentMenu()] = 0;
    }
    
    for(i=0;i<self getMenuSize();i++)
    {
        //creating/destoying elems
        if(i>=self getMenuScroller()-self getMin() && i<=self getMenuScroller()+self getMax())
        {
            if(!isDefined(self getMenuScrollingElem()[i]))
            {
                self createScrollingElems(i);
            }
        }
        else
        {
            if(isDefined(self getMenuScrollingElem()[i]))
            {
                self getMenuScrollingElem()[i] destroy();
            }
        }
        
        //elem position
        if(isDefined(self getMenuScrollingElem()[i]))
        {
            self doScrollingMovement(i);
        }
        
        //elem effects
        if(i==self getMenuScroller())
        {
            if(isDefined(self getMenuScrollingElem()[i]))
            {
                self doScrollingElemEffect(0,i);
            }
        }
        else if(i<self getMenuScroller()-(self getMin()-2) && i>self getMenuScroller()-self getMin()||i>self getMenuScroller()+(self getMax()-2) && i<self getMenuScroller()+self getMax())
        {
            if(isDefined(self getMenuScrollingElem()[i]))
            {
                self doScrollingElemEffect(1,i);
            }
        }
        else if(i<self getMenuScroller() && i>self getMenuScroller()-(self getMin()-1)||i>self getMenuScroller() && i<self getMenuScroller()+(self getMax()-1))
        {
            if(isDefined(self getMenuScrollingElem()[i]))
            {
                self doScrollingElemEffect(2,i);
            }
        }
        else
        {
            if(isDefined(self getMenuScrollingElem()[i]))
            {
                self doScrollingElemEffect(3,i);
            }
        }
     
        
        //toggle effect for default text elems
        if(isDefined(self getMenuScrollingElem()[i]))
        {
            if(isDefined(self.Menu[self getCurrentMenu()].toggle[i]))
            {
                self getMenuScrollingElem()[i].glowAlpha = 1;
                if(self.Menu[self getCurrentMenu()].toggle[i]==true)
                {
                    self getMenuScrollingElem()[i].glowColor = (0.3,0.9,0.5);
                }
                else
                {
                    self getMenuScrollingElem()[i].glowColor = (1,0,0);
                }
            }
            else
            {
                self getMenuScrollingElem()[i].glowAlpha = 0;
            }
        }
    }
    //Update side scroller & option counter
    self.PIX["counter"] _setText((self getMenuScroller()+1)+"/"+self getMenuSize());
    self.PIX["Side_Scroll"] elemMoveOverTimeY(0.170,self.MainY-73+(self getMenuScroller()/((self getMenuSize()-1)/153)));//*-1 removed cause of infinity loader update 22/05/19}
}
