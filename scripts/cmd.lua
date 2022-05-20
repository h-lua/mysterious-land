--- -gg 投降
hcmd("^-gg$", function(evtData)
    hplayer.defeat(evtData.triggerPlayer, "GG")
end)

--- -apm 查看玩家分钟操作数
hcmd("^-apm$", function(evtData)
    echo("您的apm为:" .. hplayer.getApm(evtData.triggerPlayer), evtData.triggerPlayer)
end)

--- -d [+|-][NUMBER]视距减少/增加
hcmd("^-d [-+]%d+$", function(evtData)
    local cds = string.explode(" ", string.lower(evtData.chatString))
    local first = string.sub(cds[2], 1, 1)
    if (first == "+" or first == "-") then
        --视距
        local v = string.sub(cds[2], 2, string.len(cds[2]))
        v = math.abs(tonumber(v))
        if (v > 0) then
            local val = math.abs(v)
            if (first == "+") then
                hcamera.changeDistance(evtData.triggerPlayer, val)
            elseif (first == "-") then
                hcamera.changeDistance(evtData.triggerPlayer, -val)
            end
        end
    end
end)

--- -random 随机选择英雄（必须使用hhero的选取法）
hcmd("^-random$", function(evtData)
    local p = evtData.triggerPlayer
    if (#hhero.selectorPool <= 0) then
        echo("-random 指令无效", p)
        return
    end
    local pIndex = hplayer.index(p)
    if (#hhero.player_heroes[pIndex] >= hhero.player_allow_qty[pIndex]) then
        echo("|cffffff80你已经选够了|r", p)
        return
    end
    local txt = ""
    local qty = 0
    while (true) do
        local one = table.random(hhero.selectorPool)
        table.delete(hhero.selectorPool, one)
        local u = one
        if (type(one) == "string") then
            u = hunit.create({
                whichPlayer = p,
                id = one,
                x = hhero.bornX,
                y = hhero.bornY
            })
            hcache.set(u, CONST_CACHE.HERO_SELECTOR, hhero.selectorTavern[one])
            cj.RemoveUnitFromStock(hhero.selectorTavern[one], c2i(one))
        else
            table.delete(hhero.selectorClearPool, one)
            hunit.setInvulnerable(u, false)
            cj.SetUnitOwner(u, p, true)
            hunit.portal(u, hhero.bornX, hhero.bornY)
            cj.PauseUnit(u, false)
        end
        table.insert(hhero.player_heroes[pIndex], u)
        -- 触发英雄被选择事件(全局)
        hevent.trigger("global", CONST_EVENT.pickHero, {
            triggerPlayer = p,
            triggerUnit = u
        })
        txt = txt .. " " .. cj.GetUnitName(u)
        qty = qty + 1
        if (#hhero.player_heroes[pIndex] >= hhero.player_allow_qty[pIndex]) then
            break
        end
    end
    echo("已为您 |cffffff80random|r 挑选了 " .. "|cffffff80" .. math.floor(qty) .. "|r 个：|cffffff80" .. txt .. "|r", p)
end)

--- -repick 重新选择英雄（必须使用hhero的选取法）
hcmd("^-repick$", function(evtData)
    local p = evtData.triggerPlayer
    if (#hhero.selectorPool <= 0) then
        echo("-repick 指令无效", p)
        return
    end
    local pIndex = hplayer.index(p)
    if (#hhero.player_heroes[pIndex] <= 0) then
        echo("|cffffff80你还没有选过任何单位|r", p)
        return
    end
    local qty = #hhero.player_heroes[pIndex]
    for _, u in ipairs(hhero.player_heroes[pIndex]) do
        local heroSelector = hcache.get(u, CONST_CACHE.HERO_SELECTOR)
        if (type(heroSelector) == "userdata") then
            table.insert(hhero.selectorPool, hunit.getId(u))
            cj.AddUnitToStock(heroSelector, cj.GetUnitTypeId(u), 1, 1)
        else
            local new = hunit.create({
                whichPlayer = hplayer.player_passive,
                id = cj.GetUnitTypeId(u),
                x = heroSelector[1],
                y = heroSelector[2],
                isInvulnerable = true,
                isPause = true
            })
            hcache.set(new, CONST_CACHE.HERO_SELECTOR, { heroSelector[1], heroSelector[2] })
            table.insert(hhero.selectorClearPool, new)
            table.insert(hhero.selectorPool, new)
        end
        hunit.destroy(u, 0)
    end
    hhero.player_heroes[pIndex] = {}
    echo("已为您 |cffffff80repick|r 了 " .. "|cffffff80" .. qty .. "|r 个单位", p)
end)
