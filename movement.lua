local Core, GUI, Logic = ...

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local settings = Core.settings

local function build()
    local tab = GUI.makeTab("Movement", 4, "motion")
    local page = GUI.makePage()

    GUI.makeSectionHeader(page, "Player", 1)

    GUI.makeToggle(page, "Noclip", "Проходить сквозь стены", settings.noclip, 2, function(v)
        Logic.enableNoclip(v)
    end, "noclip")

    GUI.makeToggle(page, "Speed", "Ускорение передвижения", settings.speed, 3, function(v)
        Logic.enableSpeed(v)
    end, "speed")

    GUI.makeSlider(page, "Walk Speed", 16, 500, settings.walkSpeed, 4, function(v)
        if settings.speed and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end, "walkSpeed")

    tab.Button.MouseButton1Click:Connect(function()
        GUI.switchTab(tab, page)
    end)

    return tab, page
end

return build
