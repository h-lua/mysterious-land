stage1 = function()
    gameQuestEvent.state1()
    -- 小神木商店
    FIRST_SHOP = hunit.create({
        whichPlayer = hplayer.player_passive,
        id = hslk.n2i("小神木商店"),
        x = -7040,
        y = -8317,
        facing = 270,
    })
    -- 土匪
    henemy.create({
        id = hslk.n2i("土匪"),
        x = -6057,
        y = -8706,
        facing = 180,
        qty = 10,
        attr = {
            attack_white = "=" .. 9 + game.diff * 1,
            attack_speed = "-20",
            life = "=" .. 65 + game.diff * 5,
            move = "=150",
        }
    })
    -- boss
    local boss = henemy.create({
        id = hslk.n2i("秘地傀儡"),
        x = -5036,
        y = -8908,
        facing = 180,
        attr = {
            attack_white = "=" .. 125 + game.diff * 5,
            life = "=" .. 1900 + game.diff * 100,
            life_back = "=10",
            move = "=" .. (50 + game.diff),
            avoid = "=" .. (game.diff - 20),
        }
    })
    -- 区域陷阱
    local trap1 = hrect.create(-5183, -8893, 384, 700, "trap1")
    --
    hevent.onAttack(boss, function(evtData)
        stage_ttg(evtData.triggerUnit, "越战越强")
        heffect.attach("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl", evtData.triggerUnit, "weapon", 3)
        hattr.set(evtData.triggerUnit, 3, {
            attack_white = "+" .. math.floor(hattr.get(evtData.triggerUnit, "attack_white") * 0.2),
            move = "+5",
        })
        henemy.create({
            id = hslk.n2i("秘地小傀儡"),
            x = hunit.x(evtData.triggerUnit),
            y = hunit.y(evtData.triggerUnit),
            facing = hunit.getFacing(evtData.triggerUnit),
            attr = {
                attack_white = "=" .. 10 + game.diff,
                life = "=50",
                move = "=110",
            }
        })
    end)
    hevent.onBeDamage(boss, function(evtData)
        local u = evtData.triggerUnit
        stage_ttg(u, "继续打我呀")
        hattr.set(u, 5, {
            move = "+70",
        })
        if (math.random(1, 2) == 1) then
            cj.IssueTargetOrder(u, "attack", evtData.sourceUnit)
        end
    end)
    hevent.onDead(boss, function(evtData)
        hrect.destroy(trap1)
        stage2()
        stage_ttg(evtData.triggerUnit, "竟然...!")
        local deadUnit = evtData.triggerUnit
        local killer = evtData.killer
        local exp = 4000 + 1000 * game.diff
        if (killer ~= nil) then
            haward.forGroupExp(killer, exp)
        end
    end)
    hevent.onEnterRect(trap1, function(evtData)
        if (hunit.isAlive(boss) and hunit.isAllyPlayer(evtData.triggerUnit, game.ALLY_PLAYER)) then
            hattr.set(boss, 10, {
                attack_white = "+1000",
                move = "+522",
            })
            cj.IssueTargetOrder(boss, "attack", evtData.triggerUnit)
            stage_ttg(boss, "敢硬闯?!")
        end
    end)
    hevent.onDestructableDestroy(JassGlobals.gg_dest_DTg7_0109, function(evtData)
        cj.RemoveDestructable(evtData.triggerDestructable)
        if (hunit.isAlive(boss)) then
            hunit.kill(boss, 0)
        end
    end)
end