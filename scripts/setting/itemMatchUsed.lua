hmatcher.item({
    {
        "秘笈：.+",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            local triggerItem = evtData.triggerItem
            local playerIndex = hplayer.index(hunit.getOwner(triggerUnit))
            local hero = hhero.player_heroes[playerIndex][1] -- 兼容信使
            if (hero == nil or his.deleted(hero)) then
                return
            end
            local itemName = hitem.getName(triggerItem)
            local abName = string.gsub(itemName, "秘笈：", "")
            local abSlk = hskill.getHSlk(abName)
            local abid = abSlk._id
            local gt = abSlk.gift_type
            if (gt == "gift_weapon" and hskill.has(hero, hskill.n2i("武 - 封印"))) then
                hskill.del(hero, hskill.n2i("武 - 封印"))
            elseif (gt == "gift_defend" and hskill.n2i("御 - 封印")) then
                hskill.del(hero, hskill.n2i("御 - 封印"))
            elseif (gt == "gift_speed" and hskill.n2i("速 - 封印")) then
                hskill.del(hero, hskill.n2i("速 - 封印"))
            elseif (gt == "gift_tao" and hskill.n2i("奇 - 封印")) then
                hskill.del(hero, hskill.n2i("奇 - 封印"))
            end
            if (game.playerData.gift[playerIndex][gt] ~= nil) then
                hskill.del(hero, game.playerData.gift[playerIndex][gt])
            end
            hskill.add(hero, abid)
            game.playerData.gift[playerIndex][gt] = abid
            heffect.toUnit("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", hero)
            echo("学会了[" .. hcolor.green(abName) .. "]")
        end
    },
    {
        "医疗石",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl",
                triggerUnit, "origin", 10
            )
            hattr.set(triggerUnit, 10, {
                life_back = "+20",
            })
        end
    },
    {
        "医疗剂",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",
                triggerUnit, "origin", 6
            )
            hattr.set(triggerUnit, 6, {
                life_back = "+83.34",
            })
        end
    },
    {
        "魔法石",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl",
                triggerUnit, "origin", 10
            )
            hattr.set(triggerUnit, 10, {
                mana_back = "+15",
            })
        end
    },
    {
        "魔法剂",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl",
                triggerUnit, "origin", 6
            )
            hattr.set(triggerUnit, 6, {
                mana_back = "+50",
            })
        end
    },
    {
        "吸血药水",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            hattr.set(triggerUnit, 35, {
                hemophagia = "+20",
            })
        end
    },
    {
        "完美药水",
        function(evtData)
            heffect.toUnit("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", evtData.triggerUnit)
            hunit.setCurLifePercent(evtData.triggerUnit, 100)
            hunit.setCurManaPercent(evtData.triggerUnit, 100)
        end
    },
    {
        "恢复卷轴",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            local g = hgroup.createByUnit(evtData.triggerUnit, 600, function(filterUnit)
                return his.alive(filterUnit) and his.ally(triggerUnit, filterUnit)
            end)
            hgroup.forEach(g, function(enumUnit)
                heffect.toUnit("Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", enumUnit)
                hunit.addCurLife(enumUnit, 300)
            end, true)
        end
    },
    {
        "加速卷轴",
        function(evtData)
            local triggerUnit = evtData.triggerUnit
            local g = hgroup.createByUnit(evtData.triggerUnit, 600, function(filterUnit)
                return his.alive(filterUnit) and his.ally(triggerUnit, filterUnit)
            end)
            hgroup.forEach(g, function(enumUnit)
                heffect.bindUnit(
                    "Abilities\\Spells\\Items\\AIsp\\SpeedTarget.mdl",
                    enumUnit, "overhead", 30
                )
                hattr.set(enumUnit, 30, {
                    move = "+100",
                    attack_speed = "+15",
                })
            end, true)
        end
    },
})