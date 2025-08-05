// 新增函数：生成一架友军攻击直升机
spawn_friendly_attack_chopper()
{
    // 此函数现在只负责生成直升机实体

    // 寻找一条入场飞行路径
	path = _id_0618::_id_3E3D( _id_0618::_id_3E45(), "chopper_boss_path_start", "script_stopnode" );
	
    level endon( "special_op_terminated" );
    
    // 1. 获取并配置 spawner
    spawner = getent( "chopper", "targetname" );

    // 记录原始属性，避免影响后续敌方直升机
    original_origin = spawner.origin;
    original_team = spawner.team;
    original_script_team = spawner.script_team;

    // 将其移动到友军入场起点并临时设置为友军阵营
    spawner.origin = path.origin;
    spawner.script_team = "allies";
    spawner.team = "allies";

    // 2. 生成直升机
    chopper = maps\_vehicle::_id_211F( spawner );
    
    // 3. 还原 spawner 的原始属性，防止后续敌机受到影响
    spawner.origin = original_origin;
    spawner.script_team = original_script_team;
    spawner.team = original_team;
    
    // 4. 直接在此处完成友军化与能力配置（省去额外函数）
    chopper _id_0618::_id_3DCD( "friendly_support_gign" );          // 植入驾驶员 AI
    chopper._id_3D5D = _id_061C::_id_3DF4( "chopper" );
    chopper [[ level._id_3B89 ]]();                                   // 继承属性
    chopper setvehicleteam( "allies" );

    // 启用炮塔、旋转、死亡动画等
    chopper thread _id_0619::_id_3D10();
    chopper thread _id_0619::_id_3D09( "death deathspin" );

    // 巡逻与目标锁定
    chopper thread Helicopter_Patrol_Over_Player();

    // 更新炮塔/友军识别状态
    chopper._id_2942 = 1;
    chopper thread maps\_vehicle::_id_2A3E();

    // 5. 启动寿命计时器：固定时间后返航并消失
    chopper thread friendly_chopper_lifetime( path.origin );
    iprintlnbold( "^3 Friendly Chopper incoming.);
}

// =================================================================
// 新增：一个简化的直升机AI，命令其在玩家头顶盘旋
// =================================================================
Helicopter_Patrol_Over_Player()
{
    // 1. 设置线程的终结条件
    self endon("death");
    level endon("special_op_terminated");

    // 2. 定义巡逻参数
    patrol_height = 800;
    patrol_radius = 1000;

    // 3. 获取巡逻中心
    if ( !isdefined(level.players) || level.players.size == 0 )
        return;
    player = level.players[0];

    // 4. 开始无限巡逻循环
    for(;;)
    {
        // 4.1 计算下一个巡逻点坐标
        random_angle = randomfloat(360);
        horizontal_offset = ( cos(random_angle) * patrol_radius, sin(random_angle) * patrol_radius, 0 );
        patrol_point_origin = player.origin + horizontal_offset + (0, 0, patrol_height);
        
        // 4.2 构建一个临时的"伪"路径节点
        //     maps\_vehicle::_id_26A1 需要一个结构体作为参数
        path_node = spawnstruct();
        path_node.origin = patrol_point_origin;
        path_node.radius = 256; // 到达半径

        // 4.3 命令直升机飞向这个伪路径节点
        //     这是已验证的、能让直升机飞起来的核心函数
        self thread maps\_vehicle::_id_26A1( path_node );

        // 4.4 在飞行时，始终朝向玩家
        self setlookatent( player );
        
        // 4.5 等待直升机到达目标
        //     maps\_vehicle::_id_26A1 会在到达时触发 "goal"
        self waittill("goal");
        
        // 4.6 清理临时的路径节点
        path_node delete();
    }
}

// =============================================================
// 友军直升机寿命管理：300 秒后返航出生点并删除
// =============================================================
friendly_chopper_lifetime( start_origin )
{
    self endon( "death" );
    level endon( "special_op_terminated" );

    // 等待 300 秒
    wait 300;

    // 构建返航目标节点（稍高于出生点，避免碰撞）
    return_node = spawnstruct();
    return_node.origin = start_origin + ( 0, 0, 800 );
    return_node.radius = 512;

    // 飞向返航节点
    self thread maps\_vehicle::_id_26A1( return_node );
    self waittill( "goal" );

    // 删除返航节点并消失
    return_node delete();

    // 播放离场声音/特效可按需增加

    self delete();
    iprintlnbold( "^1 Friendly Chopper is Return to Base.);
}