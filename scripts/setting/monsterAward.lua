-- 怪物奖励

onNormalAwardFleeting = function(fleetingData)
    if (his.deleted(fleetingData.centerUnit) == true) then
        return
    end
    local p = hunit.getOwner(fleetingData.enterUnit)
    if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
        local buffId = cj.GetUnitTypeId(fleetingData.centerUnit)
        hunit.del(fleetingData.centerUnit)
        if (buffId == hitem.FLEETING_IDS.GOLD) then
            haward.forUnitGold(fleetingData.enterUnit, math.random(10, 20))
            hsound.voice2Player(cg.gg_snd_ReceiveGold, p)
        elseif (buffId == hitem.FLEETING_IDS.LUMBER) then
            haward.forUnitLumber(fleetingData.enterUnit, 1)
            hsound.voice2Player(cg.gg_snd_BundleOfLumber, p)
        elseif (buffId == hitem.FLEETING_IDS.BOOK_YELLOW) then
            heffect.toUnit("Abilities\\Spells\\Items\\AIsm\\AIsmTarget.mdl", fleetingData.enterUnit, 1)
            hattr.set(fleetingData.enterUnit, 0, { str_green = "+1" })
        elseif (buffId == hitem.FLEETING_IDS.BOOK_RED) then
            heffect.toUnit("Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl", fleetingData.enterUnit, 1)
            hattr.set(fleetingData.enterUnit, 0, { agi_green = "+1" })
        elseif (buffId == hitem.FLEETING_IDS.BOOK_PURPLE) then
            heffect.toUnit("Abilities\\Spells\\Items\\AIim\\AIimTarget.mdl", fleetingData.enterUnit, 1)
            hattr.set(fleetingData.enterUnit, 0, { int_green = "+1" })
        elseif (buffId == hitem.FLEETING_IDS.DOTA2_CURE) then
            hattr.set(fleetingData.enterUnit, 3, {
                life_back = "+150",
                life_mana = "+100",
            })
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl",
                fleetingData.enterUnit, "origin", 3
            )
        elseif (buffId == hitem.FLEETING_IDS.DOTA2_DAMAGE) then
            hattr.set(fleetingData.enterUnit, 15, {
                damage_extent = "+10",
            })
            heffect.bindUnit(
                "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl",
                fleetingData.enterUnit, "origin", 15
            )
        elseif (buffId == hitem.FLEETING_IDS.DOTA2_GOLD) then
            hplayer.addGoldRatio(p, 10, 40)
        elseif (buffId == hitem.FLEETING_IDS.DOTA2_SPEED) then
            hattr.set(fleetingData.enterUnit, 7, {
                attack_speed = "+25",
                move = "+120",
            })
            heffect.bindUnit(
                "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl",
                fleetingData.enterUnit, "origin", 7
            )
        elseif (buffId == hitem.FLEETING_IDS.DOTA2_INVISIBLE) then
            hskill.visible(fleetingData.enterUnit, 10, 0.3, nil)
        end
    end
end
onNormalAward = function(evtData)
    local triggerUnit = evtData.triggerUnit
    local killer = evtData.killer
    local mi = hunit.getUserData(triggerUnit)
    local level = monsterNormal[mi].level
    local gold = level * 5 + game.diff
    local exp = level * 6 + game.diff
    if (killer ~= nil) then
        haward.forUnitGold(killer, gold)
        haward.forGroupExp(killer, exp)
        local p = hunit.getOwner(killer)
        if (his.playing(p) and his.computer(p) == false) then
            local pIndex = hplayer.index(p)
            game.playerDZData.info[pIndex][2] = game.playerDZData.info[pIndex][2] + 1
        end
    end
    if (math.random(1, 50) == 26) then
        local buffs = {
            hitem.FLEETING_IDS.GOLD,
            hitem.FLEETING_IDS.LUMBER,
            hitem.FLEETING_IDS.BOOK_RED,
            hitem.FLEETING_IDS.BOOK_YELLOW,
            hitem.FLEETING_IDS.BOOK_PURPLE,
            hitem.FLEETING_IDS.DOTA2_CURE,
            hitem.FLEETING_IDS.DOTA2_DAMAGE,
            hitem.FLEETING_IDS.DOTA2_GOLD,
            hitem.FLEETING_IDS.DOTA2_SPEED,
            hitem.FLEETING_IDS.DOTA2_INVISIBLE,
        }
        local buff = table.random(buffs)
        hitem.fleeting(buff, hunit.x(triggerUnit), hunit.y(triggerUnit), 30, onNormalAwardFleeting)
    end
end

onEliteAward = function(evtData)
    local triggerUnit = evtData.triggerUnit
    local killer = evtData.killer
    local mi = math.floor(hunit.getUserData(triggerUnit) / 1000)
    local level = monsterElite[mi].level
    local killerGold = level * 30 + game.diff * 10
    local gold = level * 15 + game.diff * 3
    local exp = level * (99 + game.diff)
    monsterElite[mi].creating = false
    if (killer ~= nil) then
        haward.forUnit(killer, 0, killerGold, 1)
        haward.forGroupExp(killer, exp)
        local p = hunit.getOwner(killer)
        if (his.playing(p) and his.computer(p) == false) then
            local pIndex = hplayer.index(p)
            game.playerDZData.info[pIndex][2] = game.playerDZData.info[pIndex][2] + 3
        end
    end
    for _ = 1, (4 + level) do
        hitem.fleeting(
            hitem.FLEETING_IDS.GOLD,
            hunit.x(triggerUnit) + math.random(0, 200),
            hunit.y(triggerUnit) + math.random(0, 200),
            30,
            function(fleetingData)
                if (his.deleted(fleetingData.centerUnit) == true) then
                    return
                end
                local p = hunit.getOwner(fleetingData.enterUnit)
                if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                    hunit.del(fleetingData.centerUnit)
                    haward.forUnitGold(fleetingData.enterUnit, gold)
                    hsound.voice2Player(cg.gg_snd_ReceiveGold, p)
                end
            end
        )
    end
end