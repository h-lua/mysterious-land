onMapDestructableDestroy = function()
    -- 整理书籍
    local randomGifts = {
        gift_weapon = { "大剑修炼", "回音剑技" },
        gift_defend = { "蛮力抵抗", "反射盾牌" },
        gift_speed = { "虚幻之刀", "断臂之勇" },
        gift_tao = { "无我", "醍醐点化" },
    }
    --
    hevent.onMapDestructableDestroy(function(evtData)
        if (math.random(1, 3) ~= 2) then
            return
        end
        local dest = evtData.triggerDestructable
        local destId = string.id2char(cj.GetDestructableTypeId(dest))
        if (destId == 'LTba') then
            -- 路障，给10木材
            hitem.fleeting(
                hitem.FLEETING_IDS.LUMBER,
                cj.GetDestructableX(dest),
                cj.GetDestructableY(dest),
                20,
                function(fleetingData)
                    if (his.deleted(fleetingData.centerUnit) == true) then
                        return
                    end
                    local p = hunit.getOwner(fleetingData.enterUnit)
                    if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                        hunit.del(fleetingData.centerUnit)
                        haward.forUnitLumber(fleetingData.enterUnit, math.random(5, 15))
                    end
                end
            )
        elseif (destId == 'LTcr') then
            -- 木箱，给黄金
            hitem.fleeting(
                hitem.FLEETING_IDS.GOLD,
                cj.GetDestructableX(dest),
                cj.GetDestructableY(dest),
                20,
                function(fleetingData)
                    if (his.deleted(fleetingData.centerUnit) == true) then
                        return
                    end
                    local p = hunit.getOwner(fleetingData.enterUnit)
                    if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                        hunit.del(fleetingData.centerUnit)
                        haward.forUnitGold(fleetingData.enterUnit, math.random(20, 90))
                    end
                end
            )
        elseif (destId == 'LTbs' or destId == 'LTbr' or destId == 'LTbx') then
            -- 木桶，给天赋书
            local types = { "gift_weapon", "gift_defend", "gift_speed", "gift_tao" }
            local t = table.random(types)
            local rgn = table.random(randomGifts[t])
            if (t == 'gift_weapon') then
                rgn = '武 - ' .. rgn
            elseif (t == 'gift_defend') then
                rgn = '御 - ' .. rgn
            elseif (t == 'gift_speed') then
                rgn = '速 - ' .. rgn
            elseif (t == 'gift_tao') then
                rgn = '奇 - ' .. rgn
            end
            rgn = '秘笈：' .. rgn
            hitem.create({
                itemId = hslk.n2i(rgn),
                charges = 1,
                x = cj.GetDestructableX(dest),
                y = cj.GetDestructableY(dest),
                during = 60,
            })
        end
    end)
end