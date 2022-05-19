--- 记录demo所有UI的变量
local demoCache = {}

--- 框架自带的demo
--- !仅供参考，切勿乱用!
--- 玩家、选择单位的属性显示
--- 需要在main函数前 hideInterface()
--[[
    options = {
        target_hp_unit = 5000, --目标单位单条血量
    }
]]
return {
    data = demoCache,
    run = function(options)
        options = options or {}
        options.target_hp_unit = options.target_hp_unit or 5000
        options.hp_y = options.hp_y or 0.0038
        options.mp_y = options.mp_y or 0.0038
        --
        cj.FogMaskEnable(false)
        local width = 3200
        local height = 640
        local size_x = 0.8
        local size_y = height / width * size_x
        local _x = function(num)
            return num / width * size_x
        end
        local _y = function(num)
            return -(num - (1024 - height)) / height * size_y
        end
        local pxIt = 125
        local pxItx = 10.5
        local pxIty = 8.5
        local pxSk = 150
        local pxSkx = 14
        local pxSky = 10
        local px = {
            minMap = { w = _x(388), h = _x(388), x = _x(376.1892), y = _y(618.6245) },
            minMapBtn = {
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(624.8737) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(687.1362) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(748.2268) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(809.3958) },
                { w = _x(51.9997), h = _x(48.2053), x = _x(299.3033), y = _y(888) },
            },
            portrait = { w = _x(371.2194), h = _x(372.1813), x = _x(786.1427), y = _y(577.6204) },
            hp = { w = _x(238.11), h = _x(35.6226000000), x = _x(873.17), y = _y(925.0998) },
            mp = { w = _x(238.11), h = _x(35.6226000000), x = _x(873.17), y = _y(976.0349) },
            info = { w = _x(757.7399), h = _x(469.1952), x = _x(1183.6135), y = _y(553.8748) },
            sell = { w = _x(264.8083), h = _x(48.071), x = _x(1987.4771), y = _y(559.8199) },
            resource = { w = _x(640.4091), h = _x(47.9624), x = _x(2282.46), y = _y(487.3246) },
            item = {
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617 + (pxIt + pxIty) * 2) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617 + (pxIt + pxIty) * 2) },
            },
            skill = {
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540 + (pxSk + pxSky) * 2) },
            },
        }
        --
        demoCache.game = hjapi.DzGetGameUI()
        demoCache.tips = {}
        -- 设置
        local txt = {
            { "F8", "F8  空闲信使" },
            { "F9", "F9  帮助" },
            { "F10", "F10 菜单" },
            { "F11", "F11 盟友" },
            { "F12", "F12 消息" },
        }
        for i, t in ipairs(txt) do
            demoCache[t[1]] = hjapi.FrameTag("TEXT", "txt_10l", demoCache.game)
            hjapi.FrameRelation(demoCache[t[1]], FRAME_ALIGN_LEFT_BOTTOM, demoCache.game, FRAME_ALIGN_RIGHT_BOTTOM, -0.052, 0.088 - (i - 1) * 0.016)
            hjapi.DzFrameSetSize(demoCache[t[1]], 0.06, 0.016)
            hjapi.DzFrameSetText(demoCache[t[1]], t[2])
        end
        -- 底部命令区
        demoCache.main = hjapi.FrameTag("BACKDROP", "bg", demoCache.game)
        hjapi.FrameRelation(demoCache.main, FRAME_ALIGN_BOTTOM, demoCache.game, FRAME_ALIGN_BOTTOM, 0, 0)
        hjapi.DzFrameSetTexture(demoCache.main, "hLua\\ui\\main_orc.tga", false)
        hjapi.DzFrameSetAlpha(demoCache.main, 240)
        hjapi.DzFrameSetSize(demoCache.main, size_x, size_x * (height / width))
        --- 系统消息框
        demoCache.unitMessage = hjapi.DzFrameGetUnitMessage()
        hjapi.FrameRelation(demoCache.unitMessage, FRAME_ALIGN_LEFT_BOTTOM, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.minMapBtn[1].x - 0.01, -0.018)
        hjapi.DzFrameSetSize(demoCache.unitMessage, 0.2, 0.1)
        hjapi.DzFrameShow(demoCache.unitMessage, true)
        --- 上方消息框
        demoCache.topMessage = hjapi.DzFrameGetTopMessage()
        hjapi.FrameRelation(demoCache.topMessage, FRAME_ALIGN_TOP, demoCache.game, FRAME_ALIGN_TOP, 0, -0.04)
        hjapi.DzFrameShow(demoCache.topMessage, true)
        -- 小地图
        demoCache.minMap = hjapi.DzFrameGetMinimap()
        hjapi.FrameRelation(demoCache.minMap, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.minMap.x, px.minMap.y)
        hjapi.DzFrameSetSize(demoCache.minMap, px.minMap.w, px.minMap.h)
        -- 小地图按钮
        for i = 1, 5 do
            local f = hjapi.DzFrameGetMinimapButton(i - 1)
            hjapi.FrameRelation(f, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.minMapBtn[i].x, px.minMapBtn[i].y)
            hjapi.DzFrameShow(f, true)
            hjapi.DzFrameSetSize(f, px.minMapBtn[i].w, px.minMapBtn[i].h)
        end
        --- 单位大头像
        demoCache.portrait = hjapi.DzFrameGetPortrait()
        hjapi.FrameRelation(demoCache.portrait, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.portrait.x, px.portrait.y)
        hjapi.DzFrameShow(demoCache.portrait, true)
        hjapi.DzFrameSetSize(demoCache.portrait, px.portrait.w, px.portrait.h)
        --- 聊天消息
        demoCache.chatMessage = hjapi.DzFrameGetChatMessage()
        hjapi.FrameRelation(demoCache.chatMessage, FRAME_ALIGN_BOTTOM, demoCache.main, FRAME_ALIGN_TOP, 0, 0.014)
        hjapi.DzFrameSetSize(demoCache.chatMessage, 0.21, 0.2)
        hjapi.DzFrameShow(demoCache.chatMessage, true)
        --- 物品栏
        demoCache.itemSlot = {}
        for i = 0, 5 do
            table.insert(demoCache.itemSlot, hjapi.DzFrameGetItemBarButton(i))
        end
        demoCache.itemSlotBlock = {}
        for i, f in ipairs(demoCache.itemSlot) do
            hjapi.FrameRelation(f, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.item[i].x, px.item[i].y)
            hjapi.DzFrameSetSize(f, px.item[i].w, px.item[i].w)
            hjapi.DzFrameShow(f, true)
            local block = hjapi.FrameTag("BACKDROP", "bg", demoCache.main)
            hjapi.FrameRelation(block, FRAME_ALIGN_CENTER, f, FRAME_ALIGN_CENTER, 0, 0)
            hjapi.DzFrameSetTexture(block, "hLua\\ui\\block_orc.tga", false)
            hjapi.DzFrameSetSize(block, px.item[i].w, px.item[i].w)
            hjapi.DzFrameSetAlpha(block, 127)
            table.insert(demoCache.itemSlotBlock, block)
        end
        --- 鼠标提示
        demoCache.tooltip = hjapi.DzFrameGetTooltip()
        hjapi.FrameRelation(demoCache.tooltip, FRAME_ALIGN_LEFT_BOTTOM, demoCache.itemSlot[1], FRAME_ALIGN_LEFT_TOP, -0.002, 0.06)
        hjapi.DzFrameShow(demoCache.tooltip, true)
        --- 技能栏
        demoCache.skillSlot = {
            hjapi.DzFrameGetCommandBarButton(0, 0), -- (0,0)
            hjapi.DzFrameGetCommandBarButton(0, 1), -- (1,0)
            hjapi.DzFrameGetCommandBarButton(0, 2), -- (2,0)
            hjapi.DzFrameGetCommandBarButton(0, 3), -- (3,0)
            hjapi.DzFrameGetCommandBarButton(1, 0), -- (0,1)
            hjapi.DzFrameGetCommandBarButton(1, 1), -- (1,1)
            hjapi.DzFrameGetCommandBarButton(1, 2), -- (2,1)
            hjapi.DzFrameGetCommandBarButton(1, 3), -- (3,1)
            hjapi.DzFrameGetCommandBarButton(2, 0), -- (0,2)
            hjapi.DzFrameGetCommandBarButton(2, 1), -- (1,2)
            hjapi.DzFrameGetCommandBarButton(2, 2), -- (2,2)
            hjapi.DzFrameGetCommandBarButton(2, 3), -- (3,2)
        }
        demoCache.skillSlotBlock = {}
        for i, sk in ipairs(demoCache.skillSlot) do
            hjapi.FrameRelation(sk, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.skill[i].x, px.skill[i].y)
            hjapi.DzFrameSetSize(sk, px.skill[i].w, px.skill[i].w)
            hjapi.DzFrameShow(sk, true)
            local block = hjapi.FrameTag("BACKDROP", "bg", demoCache.main)
            hjapi.FrameRelation(block, FRAME_ALIGN_CENTER, sk, FRAME_ALIGN_CENTER, 0, 0)
            hjapi.DzFrameSetTexture(block, "hLua\\ui\\block_orc.tga", false)
            hjapi.DzFrameSetSize(block, px.skill[i].w, px.skill[i].w)
            hjapi.DzFrameSetAlpha(block, 127)
            table.insert(demoCache.skillSlotBlock, block)
        end
        --- 英雄栏
        demoCache.hero = {}
        for i = 0, 6 do
            table.insert(demoCache.hero, {
                avatar = hjapi.DzFrameGetHeroBarButton(i),
                hp = hjapi.DzFrameGetHeroHPBar(i),
                mp = hjapi.DzFrameGetHeroManaBar(i),
            })
        end
        local hx = px.info.x - 0.002
        local d = 0.024
        for _, h in ipairs(demoCache.hero) do
            hjapi.FrameRelation(h.avatar, FRAME_ALIGN_LEFT_BOTTOM, demoCache.main, FRAME_ALIGN_LEFT_TOP, hx, -0.016)
            hjapi.DzFrameSetSize(h.avatar, d, d)
            hjapi.FrameRelation(h.hp, FRAME_ALIGN_LEFT_TOP, h.avatar, FRAME_ALIGN_LEFT_BOTTOM, 0.001, 0)
            hjapi.DzFrameSetSize(h.hp, d - 0.002, d * 0.06)
            hjapi.FrameRelation(h.mp, FRAME_ALIGN_LEFT_TOP, h.hp, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
            hjapi.DzFrameSetSize(h.mp, d - 0.002, d * 0.06)
            hx = hx + d + 0.002
        end
        -- 预留多余单位按钮2个

        -- 条:长度
        local bar_len = 0.074
        -- 之后下面是自定义UI
        -- 每个周期都更新UI
        demoCache.lastTarget = {}
        demoCache.update = function()
            hplayer.forEach(function(enumPlayer, idx)
                if (hplayer.loc() == enumPlayer) then
                    hjapi.DzFrameSetText(demoCache.gold, hcolor.mixed(hplayer.getGold(enumPlayer), "E7B730"))
                    hjapi.DzFrameSetText(demoCache.lumber, hcolor.mixed(hplayer.getLumber(enumPlayer), "C47A3A"))
                    hjapi.DzFrameSetText(demoCache.gold_ratio, hcolor.grey(hplayer.getGoldRatio(enumPlayer) .. "%"))
                    hjapi.DzFrameSetText(demoCache.lumber_ratio, hcolor.grey(hplayer.getLumberRatio(enumPlayer) .. "%"))
                    hjapi.DzFrameSetText(demoCache.sell_ratio, "售卖率:" .. hplayer.getSellRatio(enumPlayer) .. "%")
                    hjapi.DzFrameSetText(demoCache.exp_ratio, hcolor.mixed("经验率:" .. hplayer.getExpRatio(enumPlayer) .. "%", "78B5E4"))
                end
                local show = false
                local isHero = false
                local isPeriod = false
                local isBarE1 = false
                local isBarE2 = false
                local isBarExp = false
                local isBarPeriod = false
                local isBarPunish = false
                local primary
                local isStr = false
                local isAgi = false
                local isInt = false
                local selection
                local data = {}
                if (his.playing(enumPlayer)) then
                    selection = hplayer.getSelection(enumPlayer)
                    local ldt = hevent.getPlayerLastDamageTarget(enumPlayer)
                    if (demoCache.lastTarget[idx] ~= ldt) then
                        demoCache.lastTarget[idx] = ldt
                        demoCache.target_val_prev = nil
                    end
                    if (selection ~= nil) then
                        local attr = hattribute.get(selection)
                        if (attr ~= nil and his.alive(selection) and false == his.unitDestroyed(selection)) then
                            show = true
                            isHero = his.hero(selection)
                            primary = hhero.getPrimary(selection)
                            isStr = (primary == "STR")
                            isAgi = (primary == "AGI")
                            isInt = (primary == "INT")
                            isPeriod = hunit.getPeriod(selection) > 0
                            isBarE1 = isPeriod or isHero
                            isBarExp = isHero
                            isBarPeriod = isPeriod
                            -- sign
                            if (primary == "STR") then
                                data.sign = "hLua\\ui\\sign_str.tga"
                            elseif (primary == "AGI") then
                                data.sign = "hLua\\ui\\sign_agi.tga"
                            elseif (primary == "INT") then
                                data.sign = "hLua\\ui\\sign_int.tga"
                            else
                                data.sign = "hLua\\ui\\sign_nor.tga"
                            end
                            -- 生命
                            local hpc = math.floor(hunit.getCurLife(selection))
                            local hpm = math.floor(hunit.getMaxLife(selection))
                            if (hpm == 0 or hpc > hpm * 0.85) then
                                data.hp = hcolor.mixed(hpc, "32CD32") .. "/" .. hpm
                            elseif (hpc > hpm * 0.60) then
                                data.hp = hcolor.mixed(hpc, "7FFF00") .. "/" .. hpm
                            elseif (hpc > hpm * 0.45) then
                                data.hp = hcolor.mixed(hpc, "ADFF2F") .. "/" .. hpm
                            elseif (hpc > hpm * 0.25) then
                                data.hp = hcolor.mixed(hpc, "FFFF00") .. "/" .. hpm
                            else
                                data.hp = hcolor.red(hpc) .. "/" .. hpm
                            end
                            -- 魔法
                            local mpc = math.floor(hunit.getCurMana(selection))
                            local mpm = math.floor(hunit.getMaxMana(selection))
                            if (mpm == 0 or mpc > mpm * 0.6) then
                                data.mp = hcolor.mixed(mpc, "1E90FF") .. "/" .. mpm
                            elseif (mpc > mpm * 0.3) then
                                data.mp = hcolor.mixed(mpc, "87CEFA") .. "/" .. mpm
                            else
                                data.mp = hcolor.red(mpc) .. "/" .. mpm
                            end
                            -- 生命恢复
                            local life_back = math.round(attr.life_back, 1)
                            if (life_back > hattr.CURE_FLOOR) then
                                data.life_back = hcolor.mixed("+" .. math.numberFormat(life_back, 1), "32CD32")
                            elseif (life_back < -hattr.CURE_FLOOR) then
                                data.life_back = hcolor.red(math.numberFormat(life_back, 1))
                            else
                                data.life_back = "+0.00"
                            end
                            -- 魔法恢复
                            local mana_back = math.round(attr.mana_back, 1)
                            if (mana_back > hattr.CURE_FLOOR) then
                                data.mana_back = hcolor.mixed("+" .. math.numberFormat(mana_back, 1), "1E90FF")
                            elseif (mana_back < -hattr.CURE_FLOOR) then
                                data.mana_back = hcolor.red(math.numberFormat(mana_back, 1))
                            else
                                data.mana_back = "+0.00"
                            end
                            -- 名称
                            data.unit_name = hunit.getName(selection)
                            data.hero_name = hhero.getProperName(selection)
                            if (data.hero_name ~= "") then
                                data.hero_name = "·" .. data.hero_name
                            end
                            local attrBuilder = function(label, def, defCheck, val, unit)
                                if (defCheck == true) then
                                    return hcolor.grey(label .. ":" .. def)
                                end
                                return label .. ":" .. val .. unit
                            end
                            data.reborn = attrBuilder("复活", "不能", attr.reborn < 0, math.round(attr.reborn, 1), "秒")
                            local weapsOn = hslk.i2v(hunit.getId(selection), "slk", "weapsOn") or "0"
                            local can_attack = ("0" ~= weapsOn)
                            data.attack = attrBuilder("攻击", "无", not can_attack, math.integerFormat(attr.attack + attr.attack_sides[1]) .. "~" .. math.integerFormat(attr.attack + attr.attack_sides[2]), "")
                            data.attack_speed = attrBuilder("攻速", "无", not can_attack, math.round(attr.attack_space, 1), "秒")
                            if (attr.attack_speed > 0) then
                                data.attack_speed = data.attack_speed .. hcolor.grey("(+" .. math.floor(attr.attack_speed) .. "%)")
                            elseif (attr.attack_speed < 0) then
                                data.attack_speed = data.attack_speed .. hcolor.redLight("(" .. math.floor(attr.attack_speed) .. "%)")
                            end
                            data.attack_range = attrBuilder("攻击范围", "无", not can_attack, math.floor(attr.attack_range), "")
                            data.knocking_extent = attrBuilder("暴击加成", "无", not can_attack, 0, "%")
                            data.knocking_odds = attrBuilder("暴击几率", "无", not can_attack, 0, "%")
                            data.hemophagia = attrBuilder("攻击吸血", "无", not can_attack, 0, "%")
                            data.hemophagia_skill = attrBuilder("技能吸血", "无", false, 0, "%")
                            data.weight = attrBuilder("负重", "无", false == his.hasSlot(selection), 0, "Kg")
                            data.move = attrBuilder("移动", "无", false, math.floor(attr.move), "")
                            if (his.invincible(selection)) then
                                data.defend = "护甲:" .. hcolor.gold("无敌")
                            else
                                data.defend = attrBuilder("护甲", "无", false, math.floor(attr.defend), "")
                                if (his.immune(selection)) then
                                    data.defend = data.defend .. hcolor.grey("[魔免]")
                                elseif (his.ethereal(selection)) then
                                    data.defend = data.defend .. hcolor.grey("[虚无]")
                                end
                            end
                            data.damage_reduce = attrBuilder("减伤", "无", false, 0, "")
                            data.cure = attrBuilder("治疗加成", "无", false, 0, "%")
                            data.avoid = attrBuilder("回避几率", "无", false, 0, "%")
                            data.aim = attrBuilder("命中加成", "无", false, 0, "%")
                            data.damage_extent = attrBuilder("伤害增幅", "无", false, 0, "%")
                            data.damage_rebound = attrBuilder("反弹伤害", "无", false, 0, "%")
                            data.sight_day = attrBuilder("白天视野", "无", false, math.floor(hunit.getSight(selection)), "")
                            data.sight_night = attrBuilder("黑夜视野", "无", false, math.floor(hunit.getNSight(selection)), "")
                            if (isHero) then
                                data.str = attrBuilder(hcolor.mixed("力量", "FFA99F"), "无", false, math.floor(attr.str), "")
                                data.agi = attrBuilder(hcolor.mixed("敏捷", "CBFF9E"), "无", false, math.floor(attr.agi), "")
                                data.int = attrBuilder(hcolor.mixed("智力", "A0E1FF"), "无", false, math.floor(attr.int), "")
                                data.str_plus = attrBuilder(hcolor.mixed("成长", "FFA99F"), "无", false, "+" .. hhero.getStrPlus(selection), "")
                                data.agi_plus = attrBuilder(hcolor.mixed("成长", "CBFF9E"), "无", false, "+" .. hhero.getAgiPlus(selection), "")
                                data.int_plus = attrBuilder(hcolor.mixed("成长", "A0E1FF"), "无", false, "+" .. hhero.getIntPlus(selection), "")
                            end
                            if (isPeriod) then
                                local pr = hunit.getPeriodRemain(selection)
                                local p = hunit.getPeriod(selection)
                                data.period_bar = bar_len * pr / p
                                data.period_val = pr .. "秒"
                            elseif (isHero) then
                                local lv = hhero.getCurLevel(selection)
                                local e = hhero.getExp(selection)
                                local en = hhero.getExpNeed(lv + 1)
                                data.exp_bar = bar_len * e / en
                                data.exp_val = "Lv" .. lv .. "   " .. math.min(e, en) .. "/" .. en
                            end
                        end
                    end
                    -- 目标数据
                    if (demoCache.lastTarget[idx]) then
                        if (his.dead(demoCache.lastTarget[idx]) or his.unitDestroyed(demoCache.lastTarget[idx])) then
                            demoCache.lastTarget[idx] = nil
                            if (selection) then
                                hevent.setLastDamage(selection, nil)
                            end
                        end
                        if (demoCache.lastTarget[idx] ~= nil) then
                            local ml = math.floor(hunit.getMaxLife(demoCache.lastTarget[idx])) or 0
                            local cl = math.floor(hunit.getCurLife(demoCache.lastTarget[idx])) or 0
                            if (ml > 0 and cl > 0) then
                                local HPUnit = math.min(options.target_hp_unit, ml)
                                data.target_ava = hunit.getAvatar(demoCache.lastTarget[idx])
                                local tr = math.ceil(cl / HPUnit)
                                if (tr > 0) then
                                    data.target_tl = "等级" .. cj.GetUnitLevel(demoCache.lastTarget[idx]) .. " " .. hunit.getName(demoCache.lastTarget[idx]) .. "      " .. cl .. "/" .. ml
                                    data.target_tr = ""
                                    data.target_val1 = nil
                                    data.target_val2 = (tr - 1) % 10
                                    if (demoCache.target_val2_prev ~= data.target_val2) then
                                        demoCache.target_val_prev = nil
                                    end
                                    demoCache.target_val2_prev = data.target_val2
                                    if (tr > 1) then
                                        data.target_tr = "X " .. tr
                                        if (data.target_val2 == 0) then
                                            data.target_val1 = 9
                                        else
                                            data.target_val1 = data.target_val2 - 1
                                        end
                                    end
                                end
                                data.target_val = (cl % HPUnit) / HPUnit
                            else
                                demoCache.lastTarget[idx] = nil
                            end
                        end
                    end
                    if (show == false) then
                        hcache.set(enumPlayer, CONST_CACHE.PLAYER_SELECTION, nil)
                    end
                end
                if (hplayer.loc() == enumPlayer) then
                    if (show == true) then
                        hjapi.DzFrameSetText(demoCache.hp, data.hp)
                        hjapi.DzFrameSetText(demoCache.mp, data.mp)
                        hjapi.DzFrameSetText(demoCache.life_back, data.life_back)
                        hjapi.DzFrameSetText(demoCache.mana_back, data.mana_back)
                        if (isHero) then
                            hjapi.DzFrameSetTexture(demoCache.info_attr, "hLua\\ui\\info_attr_hero.tga", false)
                        else
                            hjapi.DzFrameSetTexture(demoCache.info_attr, "hLua\\ui\\info_attr.tga", false)
                        end
                        hjapi.DzFrameSetTexture(demoCache.sign, data.sign, false)
                        hjapi.DzFrameSetText(demoCache.unit_name, data.unit_name)
                        hjapi.DzFrameSetText(demoCache.hero_name, data.hero_name)
                        hjapi.DzFrameSetText(demoCache.reborn, data.reborn)
                        hjapi.DzFrameSetText(demoCache.attack, data.attack)
                        hjapi.DzFrameSetText(demoCache.attack_speed, data.attack_speed)
                        hjapi.DzFrameSetText(demoCache.attack_range, data.attack_range)
                        hjapi.DzFrameSetText(demoCache.knocking_extent, data.knocking_extent)
                        hjapi.DzFrameSetText(demoCache.knocking_odds, data.knocking_odds)
                        hjapi.DzFrameSetText(demoCache.hemophagia, data.hemophagia)
                        hjapi.DzFrameSetText(demoCache.hemophagia_skill, data.hemophagia_skill)
                        hjapi.DzFrameSetText(demoCache.weight, data.weight)
                        hjapi.DzFrameSetText(demoCache.move, data.move)
                        hjapi.DzFrameSetText(demoCache.defend, data.defend)
                        hjapi.DzFrameSetText(demoCache.damage_reduce, data.damage_reduce)
                        hjapi.DzFrameSetText(demoCache.cure, data.cure)
                        hjapi.DzFrameSetText(demoCache.avoid, data.avoid)
                        hjapi.DzFrameSetText(demoCache.aim, data.aim)
                        hjapi.DzFrameSetText(demoCache.damage_extent, data.damage_extent)
                        hjapi.DzFrameSetText(demoCache.damage_rebound, data.damage_rebound)
                        hjapi.DzFrameSetText(demoCache.sight_day, data.sight_day)
                        hjapi.DzFrameSetText(demoCache.sight_night, data.sight_night)
                        if (isHero) then
                            hjapi.DzFrameSetText(demoCache.str, data.str)
                            hjapi.DzFrameSetText(demoCache.str_plus, data.str_plus)
                            hjapi.DzFrameSetText(demoCache.agi, data.agi)
                            hjapi.DzFrameSetText(demoCache.agi_plus, data.agi_plus)
                            hjapi.DzFrameSetText(demoCache.int, data.int)
                            hjapi.DzFrameSetText(demoCache.int_plus, data.int_plus)
                        end
                        hjapi.DzFrameSetText(demoCache.e_attack, data.e_attack)
                        hjapi.DzFrameSetText(demoCache.e_append, data.e_append)
                        hjapi.DzFrameSetText(demoCache.e_oppose, data.e_oppose)
                        if (isPeriod) then
                            hjapi.DzFrameSetText(demoCache.period_val, hcolor.mixed(data.period_val, "26BD08"))
                            if (data.period_bar > 0) then
                                hjapi.DzFrameSetSize(demoCache.bar_period, data.period_bar, 0.002)
                            else
                                isBarPeriod = false
                            end
                        elseif (isHero) then
                            hjapi.DzFrameSetText(demoCache.exp_val, hcolor.mixed(data.exp_val, "78B5E4"))
                            if (data.exp_bar > 0) then
                                hjapi.DzFrameSetSize(demoCache.bar_exp, data.exp_bar, 0.002)
                            else
                                isBarExp = false
                            end
                        end
                    end
                    for i, f in ipairs(demoCache.itemSlotBlock) do
                        hjapi.DzFrameShow(f, not (show and (cj.UnitItemInSlot(selection, i - 1) ~= nil)))
                    end
                    for _, f in ipairs(demoCache.skillSlotBlock) do
                        hjapi.DzFrameShow(f, not show)
                    end
                    hjapi.DzFrameShow(demoCache.hp, show)
                    hjapi.DzFrameShow(demoCache.mp, show)
                    hjapi.DzFrameShow(demoCache.life_back, show)
                    hjapi.DzFrameShow(demoCache.mana_back, show)
                    hjapi.DzFrameShow(demoCache.info_attr, show)
                    hjapi.DzFrameShow(demoCache.sign, show)
                    hjapi.DzFrameShow(demoCache.unit_name, show)
                    hjapi.DzFrameShow(demoCache.hero_name, show)
                    hjapi.DzFrameShow(demoCache.reborn, show)
                    hjapi.DzFrameShow(demoCache.attack, show)
                    hjapi.DzFrameShow(demoCache.attack_speed, show)
                    hjapi.DzFrameShow(demoCache.attack_range, show)
                    hjapi.DzFrameShow(demoCache.knocking_extent, show)
                    hjapi.DzFrameShow(demoCache.knocking_odds, show)
                    hjapi.DzFrameShow(demoCache.hemophagia, show)
                    hjapi.DzFrameShow(demoCache.hemophagia_skill, show)
                    hjapi.DzFrameShow(demoCache.weight, show)
                    hjapi.DzFrameShow(demoCache.move, show)
                    hjapi.DzFrameShow(demoCache.defend, show)
                    hjapi.DzFrameShow(demoCache.damage_reduce, show)
                    hjapi.DzFrameShow(demoCache.cure, show)
                    hjapi.DzFrameShow(demoCache.avoid, show)
                    hjapi.DzFrameShow(demoCache.aim, show)
                    hjapi.DzFrameShow(demoCache.damage_extent, show)
                    hjapi.DzFrameShow(demoCache.damage_rebound, show)
                    hjapi.DzFrameShow(demoCache.sight_day, show)
                    hjapi.DzFrameShow(demoCache.sight_night, show)
                    hjapi.DzFrameShow(demoCache.str, show and isHero)
                    hjapi.DzFrameShow(demoCache.str_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.int, show and isHero)
                    hjapi.DzFrameShow(demoCache.int_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.e_attack, show)
                    hjapi.DzFrameShow(demoCache.e_append, show)
                    hjapi.DzFrameShow(demoCache.e_oppose, show)
                    hjapi.DzFrameShow(demoCache.period, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.period_val, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.exp, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_val, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_ratio, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.punish, isBarPunish)
                    hjapi.DzFrameShow(demoCache.punish_val, isBarPunish)
                    hjapi.DzFrameShow(demoCache.bar_e1, show and isBarE1)
                    hjapi.DzFrameShow(demoCache.bar_e2, show and isBarE2)
                    hjapi.DzFrameShow(demoCache.bar_period, show and isBarPeriod)
                    hjapi.DzFrameShow(demoCache.bar_exp, show and (not isPeriod) and isBarExp)
                    hjapi.DzFrameShow(demoCache.bar_punish, show and isBarPunish)
                    if (demoCache.lastTarget[idx] ~= nil and data.target_val ~= nil) then
                        hjapi.DzFrameSetTexture(demoCache.target_ava, data.target_ava)
                        hjapi.DzFrameSetText(demoCache.target_tl, data.target_tl)
                        hjapi.DzFrameSetText(demoCache.target_tr, data.target_tr)
                        local cur = data.target_val * 0.2126
                        local next = cur
                        local step = 0.2126 / 10
                        if (demoCache.target_val_prev ~= nil) then
                            if (cur < demoCache.target_val_prev and (demoCache.target_val_prev - cur) > step) then
                                next = demoCache.target_val_prev - step
                            elseif (cur > demoCache.target_val_prev and (cur - demoCache.target_val_prev) > step) then
                                next = demoCache.target_val_prev + step
                            end
                        end
                        demoCache.target_val_prev = next
                        hjapi.DzFrameSetSize(demoCache.target_val2, next, 0.022)
                        hjapi.DzFrameSetAlpha(demoCache.target_val2, 255)
                        if (data.target_val1 ~= nil) then
                            hjapi.DzFrameSetTexture(demoCache.target_val1, "ReplaceableTextures\\TeamColor\\TeamColor0" .. data.target_val1 .. ".blp")
                        end
                        hjapi.DzFrameSetTexture(demoCache.target_val2, "ReplaceableTextures\\TeamColor\\TeamColor0" .. data.target_val2 .. ".blp")
                        hjapi.DzFrameShow(demoCache.target, true)
                        hjapi.DzFrameShow(demoCache.target_ava, true)
                        hjapi.DzFrameShow(demoCache.target_tl, true)
                        hjapi.DzFrameShow(demoCache.target_tr, true)
                        hjapi.DzFrameShow(demoCache.target_val1, data.target_val1 ~= nil)
                        hjapi.DzFrameShow(demoCache.target_val2, true)
                    else
                        hjapi.DzFrameShow(demoCache.target, false)
                        hjapi.DzFrameShow(demoCache.target_ava, false)
                        hjapi.DzFrameShow(demoCache.target_tl, false)
                        hjapi.DzFrameShow(demoCache.target_tr, false)
                        hjapi.DzFrameShow(demoCache.target_val1, false)
                        hjapi.DzFrameShow(demoCache.target_val2, false)
                    end
                    local btns = { "btn_more_x_tras", "btn_more_x_oppose", "btn_more_e_attack", "btn_more_e_append", "btn_more_e_oppose" }
                    for _, bk in ipairs(btns) do
                        hjapi.DzFrameShow(demoCache[bk], show)
                    end
                end
            end)
        end
        -- 黄金
        demoCache.gold = hjapi.FrameTag("TEXT", "txt_10l", demoCache.main)
        hjapi.FrameRelation(demoCache.gold, FRAME_ALIGN_LEFT, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.014, px.resource.y - 0.0055)
        hjapi.DzFrameSetSize(demoCache.gold, 0.05, 0.02)
        -- 黄金率
        demoCache.gold_ratio = hjapi.FrameTag("TEXT", "txt_8l", demoCache.main)
        hjapi.FrameRelation(demoCache.gold_ratio, FRAME_ALIGN_LEFT, demoCache.gold, FRAME_ALIGN_RIGHT, 0, 0)
        hjapi.DzFrameSetSize(demoCache.gold_ratio, 0.08, 0.02)
        -- 木头
        demoCache.lumber = hjapi.FrameTag("TEXT", "txt_10l", demoCache.main)
        hjapi.FrameRelation(demoCache.lumber, FRAME_ALIGN_LEFT, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.096, px.resource.y - 0.0055)
        hjapi.DzFrameSetSize(demoCache.lumber, 0.05, 0.02)
        -- 木头率
        demoCache.lumber_ratio = hjapi.FrameTag("TEXT", "txt_8l", demoCache.main)
        hjapi.FrameRelation(demoCache.lumber_ratio, FRAME_ALIGN_LEFT, demoCache.lumber, FRAME_ALIGN_RIGHT, 0, 0)
        -- 售卖率
        demoCache.sell_ratio = hjapi.FrameTag("TEXT", "txt_8l", demoCache.main)
        hjapi.FrameRelation(demoCache.sell_ratio, FRAME_ALIGN_CENTER, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.sell.x + 0.033, px.sell.y - 0.006)
        -- 生命
        demoCache.hp = hjapi.FrameTag("TEXT", "txt_8l", demoCache.main)
        hjapi.FrameRelation(demoCache.hp, FRAME_ALIGN_LEFT, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.hp.x, px.hp.y - options.hp_y)
        hjapi.DzFrameSetSize(demoCache.hp, px.hp.w * 0.7, px.hp.h)
        -- 魔法
        demoCache.mp = hjapi.FrameTag("TEXT", "txt_8l", demoCache.main)
        hjapi.FrameRelation(demoCache.mp, FRAME_ALIGN_LEFT, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.mp.x, px.mp.y - options.mp_y)
        hjapi.DzFrameSetSize(demoCache.mp, px.hp.w * 0.7, px.hp.h)
        -- 生命恢复
        demoCache.life_back = hjapi.FrameTag("TEXT", "txt_8r", demoCache.main)
        hjapi.FrameRelation(demoCache.life_back, FRAME_ALIGN_CENTER, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.hp.x + 0.055, px.hp.y - options.hp_y)
        hjapi.DzFrameSetSize(demoCache.life_back, px.hp.w * 0.3, px.hp.h)
        -- 魔法恢复
        demoCache.mana_back = hjapi.FrameTag("TEXT", "txt_8r", demoCache.main)
        hjapi.FrameRelation(demoCache.mana_back, FRAME_ALIGN_CENTER, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.mp.x + 0.055, px.mp.y - options.mp_y)
        hjapi.DzFrameSetSize(demoCache.mana_back, px.hp.w * 0.3, px.hp.h)
        -- 信息面板
        demoCache.info_attr = hjapi.FrameTag("BACKDROP", "bg", demoCache.main)
        hjapi.DzFrameSetSize(demoCache.info_attr, px.info.w, px.info.h)
        hjapi.FrameRelation(demoCache.info_attr, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.info.x, px.info.y)
        -- 单位标志
        demoCache.sign = hjapi.FrameTag("BACKDROP", "bg", demoCache.main)
        hjapi.FrameRelation(demoCache.sign, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.0035, px.info.y - 0.006)
        hjapi.DzFrameSetSize(demoCache.sign, 0.014, 0.018)
        -- 单位名称
        demoCache.unit_name = hjapi.FrameTag("TEXT", "txt_10l", demoCache.main)
        hjapi.FrameRelation(demoCache.unit_name, FRAME_ALIGN_LEFT, demoCache.main, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.018, px.info.y - 0.01)
        -- 英雄名称
        demoCache.hero_name = hjapi.FrameTag("TEXT", "txt_10l", demoCache.main)
        hjapi.FrameRelation(demoCache.hero_name, FRAME_ALIGN_LEFT_TOP, demoCache.unit_name, FRAME_ALIGN_RIGHT_TOP, 0, 0)
        -- 条:存在周期[字]
        demoCache.period = hjapi.FrameTag("TEXT", "txt_76r", demoCache.main)
        hjapi.DzFrameSetText(demoCache.period, hcolor.mixed("存在", "26BD08"))
        hjapi.FrameRelation(demoCache.period, FRAME_ALIGN_LEFT_TOP, demoCache.main, FRAME_ALIGN_TOP, -0.024, -0.048)
        -- 条:存在周期[值]
        demoCache.period_val = hjapi.FrameTag("TEXT", "txt_6l", demoCache.main)
        hjapi.FrameRelation(demoCache.period_val, FRAME_ALIGN_LEFT_TOP, demoCache.period, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:经验[字]
        demoCache.exp = hjapi.FrameTag("TEXT", "txt_76r", demoCache.main)
        hjapi.DzFrameSetText(demoCache.exp, hcolor.mixed("经验", "78B5E4"))
        hjapi.FrameRelation(demoCache.exp, FRAME_ALIGN_LEFT_TOP, demoCache.period, FRAME_ALIGN_LEFT_TOP, 0, 0)
        -- 条:经验[值]
        demoCache.exp_val = hjapi.FrameTag("TEXT", "txt_6l", demoCache.main)
        hjapi.FrameRelation(demoCache.exp_val, FRAME_ALIGN_LEFT_TOP, demoCache.exp, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:硬直[字]
        demoCache.punish = hjapi.FrameTag("TEXT", "txt_76r", demoCache.main)
        hjapi.DzFrameSetText(demoCache.punish, hcolor.mixed("硬直", "FFFF00"))
        hjapi.FrameRelation(demoCache.punish, FRAME_ALIGN_LEFT_TOP, demoCache.exp, FRAME_ALIGN_LEFT_TOP, 0, -0.012)
        -- 条:硬直[值]
        demoCache.punish_val = hjapi.FrameTag("TEXT", "txt_6l", demoCache.main)
        hjapi.FrameRelation(demoCache.punish_val, FRAME_ALIGN_LEFT_TOP, demoCache.punish, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:空1
        demoCache.bar_e1 = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.main)
        hjapi.FrameRelation(demoCache.bar_e1, FRAME_ALIGN_LEFT_BOTTOM, demoCache.period, FRAME_ALIGN_RIGHT_BOTTOM, 0.002, 0)
        hjapi.DzFrameSetTexture(demoCache.bar_e1, "ReplaceableTextures\\TeamColor\\TeamColor08.blp", false)
        hjapi.DzFrameSetSize(demoCache.bar_e1, bar_len, 0.002)
        -- 条:空2
        demoCache.bar_e2 = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.main)
        hjapi.FrameRelation(demoCache.bar_e2, FRAME_ALIGN_LEFT_BOTTOM, demoCache.punish, FRAME_ALIGN_RIGHT_BOTTOM, 0.002, 0)
        hjapi.DzFrameSetTexture(demoCache.bar_e2, "ReplaceableTextures\\TeamColor\\TeamColor08.blp", false)
        hjapi.DzFrameSetSize(demoCache.bar_e2, bar_len, 0.002)
        -- 条:存在周期
        demoCache.bar_period = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.main)
        hjapi.FrameRelation(demoCache.bar_period, FRAME_ALIGN_LEFT, demoCache.bar_e1, FRAME_ALIGN_LEFT, 0, 0)
        hjapi.DzFrameSetTexture(demoCache.bar_period, "ReplaceableTextures\\TeamColor\\TeamColor06.blp", false)
        hjapi.DzFrameSetSize(demoCache.bar_period, bar_len, 0.002)
        -- 条:经验
        demoCache.bar_exp = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.main)
        hjapi.FrameRelation(demoCache.bar_exp, FRAME_ALIGN_LEFT, demoCache.bar_e1, FRAME_ALIGN_LEFT, 0, 0)
        hjapi.DzFrameSetTexture(demoCache.bar_exp, "ReplaceableTextures\\TeamColor\\TeamColor09.blp", false)
        hjapi.DzFrameSetSize(demoCache.bar_exp, bar_len, 0.002)
        -- 条:经验率
        demoCache.exp_ratio = hjapi.FrameTag("TEXT", "txt_6l", demoCache.main)
        hjapi.FrameRelation(demoCache.exp_ratio, FRAME_ALIGN_RIGHT_BOTTOM, demoCache.bar_e1, FRAME_ALIGN_RIGHT_TOP, 0, 0.002)
        -- 条:硬直
        demoCache.bar_punish = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.main)
        hjapi.FrameRelation(demoCache.bar_punish, FRAME_ALIGN_LEFT, demoCache.bar_e2, FRAME_ALIGN_LEFT, 0, 0)
        hjapi.DzFrameSetTexture(demoCache.bar_punish, "ReplaceableTextures\\TeamColor\\TeamColor04.blp", false)
        hjapi.DzFrameSetSize(demoCache.bar_punish, bar_len, 0.002)
        -- 属性:复活
        demoCache.reborn = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.reborn, FRAME_ALIGN_LEFT_TOP, demoCache.unit_name, FRAME_ALIGN_LEFT_BOTTOM, 0, -0.004)
        local attr_y = -0.005
        -- 属性:攻击
        demoCache.attack = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.attack, FRAME_ALIGN_LEFT_TOP, demoCache.reborn, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:攻击速度
        demoCache.attack_speed = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.attack_speed, FRAME_ALIGN_LEFT_TOP, demoCache.attack, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:攻击范围
        demoCache.attack_range = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.attack_range, FRAME_ALIGN_LEFT_TOP, demoCache.attack_speed, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:暴击加成
        demoCache.knocking_extent = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.knocking_extent, FRAME_ALIGN_LEFT_TOP, demoCache.attack_range, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:暴击几率
        demoCache.knocking_odds = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.knocking_odds, FRAME_ALIGN_LEFT_TOP, demoCache.knocking_extent, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:攻击吸血
        demoCache.hemophagia = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.hemophagia, FRAME_ALIGN_LEFT_TOP, demoCache.knocking_odds, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:技能吸血
        demoCache.hemophagia_skill = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.hemophagia_skill, FRAME_ALIGN_LEFT_TOP, demoCache.hemophagia, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:负重
        demoCache.weight = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.weight, FRAME_ALIGN_LEFT_TOP, demoCache.hemophagia_skill, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:移动
        demoCache.move = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.move, FRAME_ALIGN_LEFT_TOP, demoCache.weight, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:护甲
        demoCache.defend = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.defend, FRAME_ALIGN_LEFT_TOP, demoCache.reborn, FRAME_ALIGN_LEFT_BOTTOM, 0.062, attr_y)
        -- 属性:减伤
        demoCache.damage_reduce = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.damage_reduce, FRAME_ALIGN_LEFT_TOP, demoCache.defend, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:治疗
        demoCache.cure = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.cure, FRAME_ALIGN_LEFT_TOP, demoCache.damage_reduce, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:回避
        demoCache.avoid = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.avoid, FRAME_ALIGN_LEFT_TOP, demoCache.cure, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:命中
        demoCache.aim = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.aim, FRAME_ALIGN_LEFT_TOP, demoCache.avoid, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:增伤
        demoCache.damage_extent = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.damage_extent, FRAME_ALIGN_LEFT_TOP, demoCache.aim, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:反伤
        demoCache.damage_rebound = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.damage_rebound, FRAME_ALIGN_LEFT_TOP, demoCache.damage_extent, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:白天视野
        demoCache.sight_day = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.sight_day, FRAME_ALIGN_LEFT_TOP, demoCache.damage_rebound, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:夜晚视野
        demoCache.sight_night = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.sight_night, FRAME_ALIGN_LEFT_TOP, demoCache.sight_day, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:力量
        demoCache.str = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.str, FRAME_ALIGN_LEFT_TOP, demoCache.reborn, FRAME_ALIGN_LEFT_BOTTOM, 0.120, attr_y)
        -- 属性:力量成长
        demoCache.str_plus = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.str_plus, FRAME_ALIGN_LEFT_TOP, demoCache.str, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:敏捷
        demoCache.agi = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.agi, FRAME_ALIGN_LEFT_TOP, demoCache.str_plus, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:敏捷成长
        demoCache.agi_plus = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.agi_plus, FRAME_ALIGN_LEFT_TOP, demoCache.agi, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:智力
        demoCache.int = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.int, FRAME_ALIGN_LEFT_TOP, demoCache.agi_plus, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:智力成长
        demoCache.int_plus = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.int_plus, FRAME_ALIGN_LEFT_TOP, demoCache.int, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:附魔攻击
        demoCache.e_attack = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.e_attack, FRAME_ALIGN_LEFT_TOP, demoCache.reborn, FRAME_ALIGN_LEFT_BOTTOM, 0.120, -0.064)
        -- 属性:附魔附着
        demoCache.e_append = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.e_append, FRAME_ALIGN_LEFT_TOP, demoCache.e_attack, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:附魔抗性
        demoCache.e_oppose = hjapi.FrameTag("TEXT", "txt_76l", demoCache.main)
        hjapi.FrameRelation(demoCache.e_oppose, FRAME_ALIGN_LEFT_TOP, demoCache.e_append, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 上方目标血条
        demoCache.target = hjapi.FrameTag("BACKDROP", "bg_bar_target", demoCache.game)
        hjapi.FrameRelation(demoCache.target, FRAME_ALIGN_CENTER, demoCache.game, FRAME_ALIGN_TOP, 0, -0.04)
        hjapi.DzFrameSetSize(demoCache.target, 0.24, 0.03)
        demoCache.target_ava = hjapi.FrameTag("BACKDROP", "bg", demoCache.game)
        hjapi.FrameRelation(demoCache.target_ava, FRAME_ALIGN_LEFT, demoCache.target, FRAME_ALIGN_LEFT, 0.002, 0)
        hjapi.DzFrameSetSize(demoCache.target_ava, 0.02, 0.023)
        demoCache.target_val1 = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.target)
        hjapi.FrameRelation(demoCache.target_val1, FRAME_ALIGN_LEFT, demoCache.target, FRAME_ALIGN_LEFT, 0.0236, 0)
        hjapi.DzFrameSetSize(demoCache.target_val1, 0.2126, 0.022)
        demoCache.target_val2 = hjapi.FrameTag("BACKDROP", "bg_tile", demoCache.target)
        hjapi.FrameRelation(demoCache.target_val2, FRAME_ALIGN_LEFT, demoCache.target, FRAME_ALIGN_LEFT, 0.0236, 0)
        hjapi.DzFrameSetSize(demoCache.target_val2, 0.2126, 0.022)
        demoCache.target_tl = hjapi.FrameTag("TEXT", "txt_12l", demoCache.game)
        hjapi.FrameRelation(demoCache.target_tl, FRAME_ALIGN_LEFT, demoCache.target, FRAME_ALIGN_LEFT, 0.025, 0)
        demoCache.target_tr = hjapi.FrameTag("TEXT", "txt_12r", demoCache.game)
        hjapi.FrameRelation(demoCache.target_tr, FRAME_ALIGN_RIGHT, demoCache.target, FRAME_ALIGN_RIGHT, -0.006, 0)
        -- 右侧展开属性
        demoCache.more_tip = hjapi.FrameTag("BACKDROP", "bg_tooltip", demoCache.game)
        hjapi.FrameRelation(demoCache.more_tip, FRAME_ALIGN_LEFT_BOTTOM, demoCache.game, FRAME_ALIGN_BOTTOM, 0.088, 0.002)
        hjapi.DzFrameSetSize(demoCache.more_tip, 0.1, 0.1)
        hjapi.DzFrameShow(demoCache.more_tip, false)
        demoCache.more_txt = hjapi.FrameTag("TEXT", "txt_10l", demoCache.game)
        hjapi.FrameRelation(demoCache.more_txt, FRAME_ALIGN_CENTER, demoCache.more_tip, FRAME_ALIGN_CENTER, 0, 0)
        hjapi.DzFrameShow(demoCache.more_txt, false)
        -- UI展示
        demoCache.update()
        demoCache.updateTimer = htime.setInterval(0.05, function(_)
            demoCache.update()
        end)
    end
}