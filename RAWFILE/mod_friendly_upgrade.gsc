main()
{

}
//====================================================================================================
//====================================================================================================
// 判断是否还能购买友军小队升级（最多 4 次，每次 +500 血量）
function_upgrade_friendly_squad_allow( var_0 )
{
    if ( !isdefined( level.friendlySquadUpgradeCount ) )
        level.friendlySquadUpgradeCount = 0;

    if ( level.friendlySquadUpgradeCount >= 4 )
    {
        // 为了避免在菜单中悬停时反复刷屏 "buy failed"，增加一个 5 秒的冷却时间，避免消息刷屏
        if ( !isdefined( level.friendlySquadUpgradeFailedLastMessageTime ) || gettime() > ( level.friendlySquadUpgradeFailedLastMessageTime + 5000 ) )
        {
            iprintlnbold( "^​7​Purchase failed!Maximum Friendly Squad Upgrades Reached: 4/4​" );
            level.friendlySquadUpgradeFailedLastMessageTime = gettime();
        }
        return false;
    }

    return true;
}

// 执行购买：累加升级计数并为现有友军小队提升血量
function_upgrade_friendly_squad( var_0 )
{
    if ( !isdefined( level.friendlySquadUpgradeCount ) )
        level.friendlySquadUpgradeCount = 0;

    if ( level.friendlySquadUpgradeCount >= 4 )
        return;

    // 升级计数 +1
    level.friendlySquadUpgradeCount++;

    // 重新计算累计血量加成
    level.friendlySquadHealthBonus = level.friendlySquadUpgradeCount * 500;

    // 立即为当前场上 Delta / GIGN 队员提升生命值
    allies = getaiarray( "allies" );
    foreach( ent in allies )
    {
        if ( ent.aitype == "friendly_support_delta" || ent.aitype == "friendly_support_riotshield" )
        {
            ent.maxhealth = ent.maxhealth + 500;
            ent.baseMaxHP  = ent.maxhealth; // 同步给友军减伤线程使用的新上限
        }
    }
    iprintlnbold( "^2Friendly Squad Upgrade Purchased! Health Bonus: " + level.friendlySquadHealthBonus );
}

//====================================================================================================
//====================================================================================================
// 判断是否还能购买哨戒炮升级（仅可购买 1 次）
function_upgrade_sentry_gun_allow( var_0 )
{
    if ( !isdefined( level.sentryGunUpgradePurchased ) )
        level.sentryGunUpgradePurchased = false;

    if ( level.sentryGunUpgradePurchased )
    {
        // 为了避免在菜单中悬停时反复刷屏 "buy failed"，增加一个 5 秒的冷却时间，避免消息刷屏
        if ( !isdefined( level.sentryGunUpgradeFailedLastMessageTime ) || gettime() > ( level.sentryGunUpgradeFailedLastMessageTime + 5000 ) )
        {
            iprintlnbold( "^​7​Purchase failed! Sentry equipment already upgraded.​ ​" );
            level.sentryGunUpgradeFailedLastMessageTime = gettime();
        }
        return false;
    }

    return true;
}

// 执行购买：标记已升级并为场上所有哨戒炮提升生命值
function_upgrade_sentry_gun( var_0 )
{
    if ( isdefined( level.sentryGunUpgradePurchased ) && level.sentryGunUpgradePurchased )
        return;

    level.sentryGunUpgradePurchased = true;

    level.sentryGunHealthBonus = 500; // 升级后额外增加的血量

    // MW3 实际生成的炮塔实体 classname == "misc_turret"
    // 用 sentrytype 字段区分 minigun / grenade launcher
    ents = getentarray( "misc_turret", "classname" );
    upgradedCount = 0;

    foreach( ent in ents )
    {
        if ( !isdefined( ent.sentrytype ) )
            continue; // 排除非哨戒炮的 misc_turret

        if ( ent.sentrytype != "sentry_minigun" && ent.sentrytype != "sentry_gun" )
            continue;

        if ( !isdefined( ent.maxhealth ) )
            continue;

        ent.maxhealth += level.sentryGunHealthBonus;
        ent.health     = ent.maxhealth;
        upgradedCount++;
    }

    if ( upgradedCount == 0 )
    {
        iprintlnbold( "^3No active sentry guns found to upgrade. Bonus will apply to all new sentries." );
    }

    iprintlnbold( "^2Sentry Gun Upgrade Purchased! Health Bonus: " + level.sentryGunHealthBonus );
}

//====================================================================================================
//====================================================================================================
// 判断战地补给购买条件：无限制
function_call_for_resupply_allow( var_0 )
{
    // 允许任何情况下购买
    return true;
}

// 执行购买：为 Delta / GIGN 友军补充生命值
function_call_for_resupply( var_0 )
{
    allies = getaiarray( "allies" );
    healedCount = 0;

    foreach ( ent in allies )
    {
        // 只处理活着的友军实体，并确保有 maxhealth 字段
        if ( ent.team != "allies" )
            continue;

        if ( !isdefined( ent.maxhealth ) )
            continue;

        ent.health = ent.maxhealth;
        healedCount++;
    }

    if ( healedCount > 0 )
        iprintlnbold( "^2Resupply complete! Healed ^3" + healedCount + " ^2squad members." );
    else
        iprintlnbold( "^3No friendly squad members to heal." );
}