main()
{
	// 此 main 函数必须保留 (即使是空的), 以确保该 GSC 文件能被游戏引擎加载
	// 已在 1574.gsc中的_id_3EBB()添加调用monitor_friendly_health
}

// 实时显示 Delta / GIGN 小队生命值
monitor_friendly_health()
{
    level.friendly_hud_elements = []; // 用于存储 HUD 元素的数组

    for(;;)
    {
        // 每 1.5 秒更新一次
        wait 1.5;

        // 获取所有存活的友军 AI
        allies = getaiarray( "allies" );
        
        friendly_units = [];
        if ( isdefined( allies ) )
        {
            foreach( ent in allies )
            {
                // 通过 _id_218D 字段筛选 Juggernaut (Delta) 或 Riotshield (GIGN)
                if ( isdefined( ent._id_218D ) && ( ent._id_218D == "juggernaut" || ent._id_218D == "riotshield" ) )
                {
                    friendly_units[friendly_units.size] = ent;
                }
            }
        }

        // 清理无效的 HUD 元素 (AI 阵亡或消失)
        new_hud_elements = [];
        foreach( hud_info in level.friendly_hud_elements )
        {
            is_valid = false;
            if( isdefined( hud_info.owner ) )
            {
                foreach( unit in friendly_units )
                {
                    if( hud_info.owner == unit )
                    {
                        is_valid = true;
                        break;
                    }
                }
            }

            if( is_valid )
            {
                new_hud_elements[new_hud_elements.size] = hud_info;
            }
            else
            {
                if( isdefined( hud_info.elem ) )
                    hud_info.elem destroy();
            }
        }
        level.friendly_hud_elements = new_hud_elements;

        // 为每个友军单位创建或更新 HUD
        y_offset = 80;
        squad_index = 1; // 小队序号
        foreach ( unit in friendly_units )
        {
            hud_info = undefined;
            foreach( h in level.friendly_hud_elements )
            {
                if( h.owner == unit )
                {
                    hud_info = h;
                    break;
                }
            }
            
            unit_name = "Unknown";
            if ( isdefined( unit._id_218D ) )
            {
                if ( unit._id_218D == "juggernaut" )
                    unit_name = "Delta";
                else if ( unit._id_218D == "riotshield" )
                    unit_name = "GIGN";
            }
            
            health_text = squad_index + ". " + unit_name + ": " + unit.health + " / " + unit.maxhealth;

            if ( !isdefined( hud_info ) )
            {
                // 如果 HUD 不存在，则创建新的
                hud = create_hud_element( "left", y_offset );
                hud settext( health_text );

                hud_info = spawnstruct();
                hud_info.owner = unit;
                hud_info.elem = hud;
                level.friendly_hud_elements[level.friendly_hud_elements.size] = hud_info;
            }
            else
            {
                // 如果 HUD 已存在，则更新文本和位置
                hud_info.elem settext( health_text );
                hud_info.elem.y = y_offset;
            }
            
            y_offset += 20; // 为下一个 HUD 元素增加 Y 轴偏移
            squad_index++; // 序号递增
        }
    }
}

// 创建 HUD 元素
create_hud_element( align, y )
{
    hud = newhudelem();
    hud.horzalign = "left";
    hud.vertalign = "top";
    hud.alignx = "left";
    hud.aligny = "top";
    hud.x = 20;
    hud.y = y;
    hud.font = "default";
    hud.fontscale = 1.4;
    hud.color = ( 0.8, 1, 0.8 );
    hud.glowcolor = ( 0.2, 0.8, 0.2 );
    hud.glowalpha = 0.5;
    hud.alpha = 0.9;
    hud.sort = 1;
    return hud;
} 