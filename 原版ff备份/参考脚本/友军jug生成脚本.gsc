_id_3EFB 添加
_id_3EFC 添加

_id_3F24( var_0 )
{
    self endon( "death" );
    var_1 = "specops_ui_deltasupport";

    if ( var_0 == "friendly_support_delta" )
        var_1 = "specops_ui_deltasupport";

    if ( var_0 == "friendly_support_riotshield" )
        var_1 = "specops_ui_riotshieldsupport";
        
    if ( var_0 == "friendly_support_rus_jug" )
        var_1 = "specops_ui_deltasupport"; // 共用Delta部队的UI图标

    self setweaponhudiconoverride( "actionslot4", var_1 );
    notifyoncommand( "friendly_support_called", "+actionslot 4" );
    self waittill( "friendly_support_called" );
    
    // 为rus_jug使用新的生成函数
    if ( var_0 == "friendly_support_rus_jug" )
        thread spawn_rus_jug_allies( self.origin, var_0, self );
    else
        maps\_so_survival::spawn_allies( self.origin, var_0, self );
        
    self setweaponhudiconoverride( "actionslot4", "none" );
}

// 俄罗斯重装甲小队生成函数 - 增强版
spawn_rus_jug_allies( loc, type, owner )
{
    // 直接获取juggernaut类型的生成点
    spawners = GetEntArray("actor_enemy_juggernaut_so_survival", "classname");
    
    // 如果生成点不存在就退出
    if (!isdefined(spawners) || spawners.size == 0)
        return false;
    
    // 保存原位置并设置新位置
    number = randomInt(spawners.size);
    pos_original = spawners[number].origin;
    spawners[number].origin = level.player.origin + (100, 100, 0);
    
    // 生成AI
    var_ally = spawners[number] stalingradspawn();
    
    // 恢复生成点位置
    spawners[number].origin = pos_original;
    
    // 如果生成失败就退出
    if (!isdefined(var_ally))
        return false;
    
    // 设置juggernaut特性，直接参照enemy_juggernaut_so_survival.gsc
    var_ally.team = "allies"; // 设置为盟友队伍
    var_ally.owner = owner; // 归属玩家
    var_ally.type = "human";
    var_ally._id_218D = "juggernaut"; // 设置AI类型标识
    var_ally.accuracy = 0.2;
    var_ally.health = 3600; // juggernaut高生命值
    var_ally.maxhealth = 3600;
    var_ally.armor = 800; // 额外护甲
    
    // 设置视觉目标标记
    Target_Set(var_ally, (0, 0, 80));
    Target_SetShader(var_ally, "death_friendly_fire");
    
    // 提醒玩家重装兵已生成
    iprintlnbold("^3friendly actor_enemy_juggernaut_so_survival spawned!");
    
    return true;
}