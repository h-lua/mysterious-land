local gift = {
    {
        Name = "封印",
        Art = "war3mapImported\\icon_pas_Slow_Grey.blp",
        _remarks = "[御]字技，在于巩固英雄的防御|n当前正处于封印状态",
        _attr = nil,
    },
    {
        Name = "蛮力抵抗",
        Art = "war3mapImported\\icon_pas_Ability_Warrior_ShieldGuard.blp",
        _attr = {
            defend_green = "+15",
        },
    },
    {
        Name = "反射盾牌",
        Art = "war3mapImported\\icon_pas_Ability_Warrior_ShieldReflection.blp",
        _attr = {
            damage_rebound = "+10",
            damage_rebound_oppose = "+10",
        },
    },
    {
        Name = "苦难之炼",
        Art = "war3mapImported\\icon_pas_Mage_MoltenArmor.blp",
        _attr = {
            defend_green = "-25",
            damage_rebound = "+30",
        },
    },
    {
        Name = "胜者之盾",
        Art = "war3mapImported\\icon_pas_Invulnerable.blp",
        _attr = {
            defend_green = "+20",
            invincible = "+10",
        },
    },
    {
        Name = "铁布衫",
        Art = "war3mapImported\\icon_pas_Spell_Holy_SpellWarding.blp",
        _attr = {
            damage_reduction = "+150",
        },
    },
}

for _, v in ipairs(gift) do
    hslk_ability_empty({
        Art = v.Art,
        Name = "御 - " .. v.Name,
        Buttonpos_1 = 1,
        Buttonpos_2 = 1,
        race = "human",
        _remarks = v._remarks,
        _attr = v._attr,
        _gift_type = "gift_defend",
    })
end

for _, v in ipairs(gift) do
    if (v._attr ~= nil) then
        v._attr.disabled = true
        hslk_item({
            Art = v.Art,
            Name = "秘笈：御 - " .. v.Name,
            Ubertip = "使用习得[御技]：" .. v.Name,
            file = "Objects\\InventoryItems\\tomeBlue\\tomeBlue.mdl",
            race = "human",
            perishable = 1,
            _cooldown = 0,
            _attr = v._attr,
        })
    end
end
