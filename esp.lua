local Core, GUI, Logic = ...

local T = Core.T
local settings = Core.settings

local function build()
    local tab = GUI.makeTab("ESP", 3, "crosshair")
    local page = GUI.makePage()

    GUI.makeSectionHeader(page, "Players", 1)

    GUI.makeToggle(page, "ESP Players", "Полный ESP игроков", settings.espPlayers, 2, function(v)
        Logic.refreshESP()
    end, "espPlayers")

    GUI.makeToggle(page, "Hitbox", "Хитбокс игрока", settings.espPlayerHitbox, 3, nil, "espPlayerHitbox")

    GUI.makeToggle(page, "Name", "Ник игрока", settings.espPlayerNick, 4, nil, "espPlayerNick")

    GUI.makeToggle(page, "Distance", "Дистанция до игрока", settings.espPlayerDist, 5, nil, "espPlayerDist")

    GUI.makeToggle(page, "Health", "Здоровье игрока", settings.espPlayerHP, 6, nil, "espPlayerHP")

    GUI.makeSectionHeader(page, "NPC", 7)

    GUI.makeToggle(page, "ESP NPC", "Полный ESP NPC", settings.espNpc, 8, function(v)
        Logic.refreshESP()
    end, "espNpc")

    GUI.makeToggle(page, "NPC Hitbox", "Хитбокс NPC", settings.espNpcHitbox, 9, nil, "espNpcHitbox")

    GUI.makeToggle(page, "NPC Name", "Имя NPC", settings.espNpcNick, 10, nil, "espNpcNick")

    GUI.makeToggle(page, "NPC Distance", "Дистанция до NPC", settings.espNpcDist, 11, nil, "espNpcDist")

    GUI.makeToggle(page, "NPC Health", "Здоровье NPC", settings.espNpcHP, 12, nil, "espNpcHP")

    tab.Button.MouseButton1Click:Connect(function()
        GUI.switchTab(tab, page)
    end)

    return tab, page
end

return build
