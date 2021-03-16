-- 设定玩家
hplayer.qty_max = 7 -- 最大玩家数
hplayer.convert_ratio = 1000000 -- 换算比率，100金 -> 1木

-- 设定玩家支持的默认命令
hcmd.conf({ "-gg", "-apm", "-eff", "-random", "-repick", "-d" }, { 1 })

-- 设定敌军
henemy.set("怪物", PLAYER_COLOR_BLACK, { 8, 9, 10, 11 })

--- 设定获得黄金木头特效
hevent.onPlayerResourceChange(function(evtData)
    if (evtData.triggerUnit ~= nil and evtData.value > 0) then
        local u = evtData.triggerUnit
        local val = math.floor(evtData.value)
        if (evtData.type == 'gold') then
            htextTag.style(htextTag.create2Unit(u, "+" .. val .. " 万担金", 6, "ffcc00", 1, 1.70, 60.00), "toggle", 0, 0.20)
            hsound.voice2Unit(cg.gg_snd_ReceiveGold, 100, u)
        elseif (evtData.type == 'lumber') then
            htextTag.style(htextTag.create2Unit(u, "+" .. val .. " 精选木", 7, "80ff80", 1, 1.70, 60.00), "toggle", 0, 0.20)
            hsound.voice2Unit(cg.gg_snd_BundleOfLumber, 100, u)
        end
    end
end)

--- 英雄被选择
hevent.onPickHero(function(evtPickData)
    local newHero = evtPickData.triggerUnit
    local owner = hunit.getOwner(newHero)
    echo(hcolor.green(hplayer.getName(owner)) .. "的英雄灵魂成为了" .. hcolor.yellow("<" .. hunit.getName(newHero) .. ">"))
    local heroSlk = hunit.getHSlk(newHero)
    -- 镜头
    hcamera.toUnit(owner, 0, newHero)
    -- 开启硬直
    hunit.enablePunish(newHero)
    -- 初始属性
    hattr.set(newHero, 0, {
        weight = "=3",
        punish = "=1000",
        punish_current = "=1000"
    })
    -- 特性、技能、天赋
    if (heroSlk ~= nil) then
        local feature = heroSlk.feature
        if (feature ~= nil) then
            feature = "特性 - " .. feature
            hskill.add(newHero, hslk.n2i(feature))
        end
        local ability = heroSlk.ability
        if (ability ~= nil) then
            for _, a in ipairs(ability) do
                hskill.add(newHero, hslk.n2i(a))
            end
        end
        hskill.add(newHero, hslk.n2i("武 - 封印"))
        hskill.add(newHero, hslk.n2i("御 - 封印"))
        hskill.add(newHero, hslk.n2i("速 - 封印"))
        hskill.add(newHero, hslk.n2i("奇 - 封印"))
    end
    --- 升级
    hevent.onLevelUp(newHero, function(evtData)
        local primary = hhero.getPrimary(evtData.triggerUnit)
        local punish = hhero.getCurLevel(evtData.triggerUnit)
        if (primary == "STR") then
            punish = punish + 70
        elseif (primary == "AGI") then
            punish = punish + 45
        elseif (primary == "INT") then
            punish = punish + 55
        end
        hattr.set(evtData.triggerUnit, 0, {
            weight = "+0.5",
            punish = "+" .. punish
        })
    end)
    --- 经验收获
    hevent.onDamage(newHero, function(evtData)
        local exp = math.floor(evtData.damage * 0.1)
        haward.forUnitExp(evtData.triggerUnit, exp)
    end)
    --- 复活动作
    hevent.onDead(newHero, function(evtData)
        if (game.rebornQty <= 0) then
            local deadOwner = hunit.getOwner(evtData.triggerUnit)
            echo(hcolor.red(hplayer.getName(deadOwner)) .. "的英雄不幸死亡了，他离开了我们")
            hplayer.defeat(deadOwner, "冒险失败")
            return
        end
        game.rebornQty = game.rebornQty - 1
        local rebornTime = 5
        echo(hcolor.green(hplayer.getName(owner)) .. "的英雄死亡了，" .. hcolor.yellow(rebornTime) .. '秒后复活')
        -- 血幕
        htexture.mark(htexture.DEFAULT_MARKS.DREAM, rebornTime, p, 255, 0, 0)
        hhero.rebornAtXY(
            evtData.triggerUnit, rebornTime, 3,
            hunit.x(evtData.triggerUnit), hunit.y(evtData.triggerUnit),
            true
        )
        -- 中途心跳声
        htime.setTimeout(2, function(heartTimer)
            htime.delTimer(heartTimer)
            hsound.voice2Player(cg.gg_snd_voice_heart_beat, owner)
        end)
    end)
    --- 检测环境音效
    htime.setInterval(3.5, function(curTimer)
        local p = hunit.getOwner(newHero)
        if (his.deleted(newHero)) then
            htime.delTimer(curTimer)
            hsound.bgmStop(p)
            return
        end
        if (his.dead(newHero)) then
            return
        end
        local bgm = cg.gg_snd_bgm_main
        for _, obj in ipairs(islands) do
            if (his.inRect(obj.rect, hunit.x(newHero), hunit.y(newHero)) == true) then
                if (obj.bgm == "nil") then
                    bgm = nil
                elseif (obj.bgm ~= nil) then
                    bgm = obj.bgm
                end
                break
            end
        end
        if (bgm == nil) then
            hsound.bgmStop(p)
        else
            hsound.bgm(bgm, p)
        end
    end)
    -- dz奖励
    local mapLv = hdzapi.mapLv(owner)
    if (mapLv > 9) then
        hitem.create({
            itemId = hslk.n2i("初始月钥-Max"),
            charges = 1,
            whichUnit = newHero,
        })
    else
        hitem.create({
            itemId = hslk.n2i("初始月钥-Lv" .. mapLv),
            charges = 1,
            whichUnit = newHero,
        })
    end
    local prestige = hplayer.getPrestige(owner)
    hitem.create({
        itemId = hslk.n2i("诀尊阳钥[" .. prestige .. "专享]"),
        charges = 1,
        whichUnit = newHero,
    })
end)

pickCourier = function(newCourier)
    local owner = hunit.getOwner(newCourier)
    local playerIndex = hplayer.index(owner)
    if (game.playerData.courier[playerIndex] ~= nil) then
        local prevCourier = game.playerData.courier[playerIndex]
        hunit.hide(prevCourier)
        hitem.copy(prevCourier, newCourier)
        hunit.del(prevCourier)
    end
    game.playerData.courier[playerIndex] = newCourier
    echo(hcolor.green(hplayer.getName(owner)) .. "得到了宠物" .. hcolor.yellow("<" .. hunit.getName(newCourier) .. ">"))
    hevent.onDead(newCourier, function(evtData)
        local courierId = hunit.getId(evtData.triggerUnit)
        local nc = hunit.create({
            whichPlayer = hplayer.players[playerIndex],
            unitId = courierId,
            x = hunit.x(evtData.triggerUnit),
            y = hunit.y(evtData.triggerUnit),
            facing = hunit.getFacing(evtData.triggerUnit),
        })
        pickCourier(nc)
    end)
end

--设置三围基础
hattr.setThreeBuff({
    primary = 1,
    str = {
        life = 16,
        life_back = 0.03,
        aim = 0.003
    },
    agi = {
        attack_speed = 0.01,
        avoid = 0.003
    },
    int = {
        mana = 8,
        mana_back = 0.02
    }
})