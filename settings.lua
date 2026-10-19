local Core, GUI, Logic = ...

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local T = Core.T
local settings = Core.settings

local function refreshAllUI()
    local function refreshToggle(name, val)
        local ref = Core.toggleRefs[name]
        if ref and ref.setEnabled then
            ref.setEnabled(val, true)
        end
    end

    refreshToggle("espPlayers", settings.espPlayers)
    refreshToggle("espPlayerHitbox", settings.espPlayerHitbox)
    refreshToggle("espPlayerNick", settings.espPlayerNick)
    refreshToggle("espPlayerDist", settings.espPlayerDist)
    refreshToggle("espPlayerHP", settings.espPlayerHP)
    refreshToggle("espNpc", settings.espNpc)
    refreshToggle("espNpcHitbox", settings.espNpcHitbox)
    refreshToggle("espNpcNick", settings.espNpcNick)
    refreshToggle("espNpcDist", settings.espNpcDist)
    refreshToggle("espNpcHP", settings.espNpcHP)
    refreshToggle("noclip", settings.noclip)
    refreshToggle("speed", settings.speed)
    refreshToggle("watermark", settings.watermark)

    if Core.sliderRefs["walkSpeed"] then Core.sliderRefs["walkSpeed"].setValue(settings.walkSpeed, true) end
    if Core.sliderRefs["guiScale"] then Core.sliderRefs["guiScale"].setValue(settings.guiScale, true) end
    if Core.sliderRefs["floatBtnSize"] then Core.sliderRefs["floatBtnSize"].setValue(settings.floatBtnSize, true) end
    if Core.sliderRefs["watermarkScale"] then Core.sliderRefs["watermarkScale"].setValue(settings.watermarkScale, true) end

    GUI.setScale((settings.guiScale or 85) / 100)
    GUI.setButtonSize(settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE)

    if settings.floatBtnPos then
        GUI.setButtonPos(settings.floatBtnPos)
    end

    if Core.Watermark then
        Core.Watermark.setEnabled(settings.watermark or false)
        Core.Watermark.setScale((settings.watermarkScale or 100) / 100)
    end

    Logic.refreshESP()
    Logic.enableNoclip(settings.noclip)
    Logic.enableSpeed(settings.speed)

    GUI.setOpenState(settings.menuOpen)
end

local function build()
    local tab = GUI.makeTab("Settings", 5, "settings")
    local page = GUI.makePage()

    GUI.makeSectionHeader(page, "Configs", 1)

    local inputRow = Instance.new("Frame")
    inputRow.Size = UDim2.new(1, 0, 0, 42)
    inputRow.BackgroundColor3 = T.card
    inputRow.BorderSizePixel = 0
    inputRow.LayoutOrder = 2
    inputRow.Parent = page

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 10)
    inputCorner.Parent = inputRow

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = T.stroke
    inputStroke.Thickness = 1
    inputStroke.Parent = inputRow

    local nameInput = Instance.new("TextBox")
    nameInput.Size = UDim2.new(1, -100, 1, 0)
    nameInput.Position = UDim2.new(0, 12, 0, 0)
    nameInput.BackgroundTransparency = 1
    nameInput.Text = ""
    nameInput.PlaceholderText = "Config name..."
    nameInput.TextColor3 = T.text
    nameInput.PlaceholderColor3 = T.textMuted
    nameInput.TextSize = 12
    nameInput.Font = Enum.Font.Gotham
    nameInput.TextXAlignment = Enum.TextXAlignment.Left
    nameInput.ClearTextOnFocus = false
    nameInput.Parent = inputRow

    local saveAsBtn = Instance.new("TextButton")
    saveAsBtn.Size = UDim2.new(0, 80, 0, 28)
    saveAsBtn.Position = UDim2.new(1, -92, 0.5, -14)
    saveAsBtn.BackgroundColor3 = T.accent
    saveAsBtn.BorderSizePixel = 0
    saveAsBtn.Text = "SAVE AS"
    saveAsBtn.TextColor3 = Color3.fromRGB(10, 14, 24)
    saveAsBtn.TextSize = 11
    saveAsBtn.Font = Enum.Font.GothamBold
    saveAsBtn.AutoButtonColor = false
    saveAsBtn.Parent = inputRow

    local saveAsCorner = Instance.new("UICorner")
    saveAsCorner.CornerRadius = UDim.new(0, 8)
    saveAsCorner.Parent = saveAsBtn

    local configListFrame = Instance.new("Frame")
    configListFrame.Size = UDim2.new(1, 0, 0, 0)
    configListFrame.AutomaticSize = Enum.AutomaticSize.Y
    configListFrame.BackgroundTransparency = 1
    configListFrame.LayoutOrder = 3
    configListFrame.Parent = page

    local configListLayout = Instance.new("UIListLayout")
    configListLayout.Padding = UDim.new(0, 6)
    configListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    configListLayout.Parent = configListFrame

    local function refreshConfigList()
        for _, c in ipairs(configListFrame:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end

        local configs = Core.listConfigs()
        if #configs == 0 then
            local emptyLbl = Instance.new("TextLabel")
            emptyLbl.Size = UDim2.new(1, 0, 0, 30)
            emptyLbl.BackgroundTransparency = 1
            emptyLbl.Text = "No configs yet"
            emptyLbl.TextColor3 = T.textMuted
            emptyLbl.TextSize = 11
            emptyLbl.Font = Enum.Font.Gotham
            emptyLbl.Parent = configListFrame
            return
        end

        for _, name in ipairs(configs) do
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 38)
            row.BackgroundColor3 = T.card
            row.BorderSizePixel = 0
            row.Parent = configListFrame

            local rowCorner = Instance.new("UICorner")
            rowCorner.CornerRadius = UDim.new(0, 10)
            rowCorner.Parent = row

            local rowStroke = Instance.new("UIStroke")
            rowStroke.Color = T.stroke
            rowStroke.Thickness = 1
            rowStroke.Transparency = 0.4
            rowStroke.Parent = row

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Size = UDim2.new(1, -170, 1, 0)
            nameLbl.Position = UDim2.new(0, 14, 0, 0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.Text = name
            nameLbl.TextColor3 = T.text
            nameLbl.TextSize = 12
            nameLbl.Font = Enum.Font.GothamBold
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent = row

            local loadBtn = Instance.new("TextButton")
            loadBtn.Size = UDim2.new(0, 70, 0, 26)
            loadBtn.Position = UDim2.new(1, -152, 0.5, -13)
            loadBtn.BackgroundColor3 = T.blue
            loadBtn.BorderSizePixel = 0
            loadBtn.Text = "LOAD"
            loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadBtn.TextSize = 10
            loadBtn.Font = Enum.Font.GothamBold
            loadBtn.AutoButtonColor = false
            loadBtn.Parent = row

            local lc = Instance.new("UICorner")
            lc.CornerRadius = UDim.new(0, 7)
            lc.Parent = loadBtn

            local delBtn = Instance.new("TextButton")
            delBtn.Size = UDim2.new(0, 70, 0, 26)
            delBtn.Position = UDim2.new(1, -74, 0.5, -13)
            delBtn.BackgroundColor3 = T.danger
            delBtn.BorderSizePixel = 0
            delBtn.Text = "DELETE"
            delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            delBtn.TextSize = 10
            delBtn.Font = Enum.Font.GothamBold
            delBtn.AutoButtonColor = false
            delBtn.Parent = row

            local dc = Instance.new("UICorner")
            dc.CornerRadius = UDim.new(0, 7)
            dc.Parent = delBtn

            loadBtn.MouseButton1Click:Connect(function()
                local ok = Core.loadConfigFrom(name)
                if ok then
                    GUI.notify("Loaded: " .. name, T.success)
                    refreshAllUI()
                else
                    GUI.notify("Load failed: " .. name, T.danger)
                end
            end)

            delBtn.MouseButton1Click:Connect(function()
                Core.deleteConfig(name)
                GUI.notify("Deleted: " .. name, T.textMuted)
                refreshConfigList()
            end)
        end
    end

    saveAsBtn.MouseButton1Click:Connect(function()
        local name = (nameInput.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if not Core.isValidConfigName(name) then
            GUI.notify("Invalid name (a-z, 0-9, _, -)", T.danger)
            return
        end
        local ok = Core.saveConfigAs(name)
        if ok then
            GUI.notify("Saved: " .. name, T.success)
            nameInput.Text = ""
            refreshConfigList()
        else
            GUI.notify("Save failed", T.danger)
        end
    end)

    refreshConfigList()

    GUI.makeSectionHeader(page, "Appearance", 4)

    GUI.makeSlider(page, "GUI Scale (%)", 70, 95, settings.guiScale or 85, 5, function(v)
        GUI.setScale(v / 100)
    end, "guiScale")

    GUI.makeSlider(page, "Button Size", 40, 80, settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE, 6, function(v)
        GUI.setButtonSize(v)
    end, "floatBtnSize")

    GUI.makeSlider(page, "Watermark Scale (%)", 60, 150, settings.watermarkScale or 100, 7, function(v)
        if Core.Watermark then
            Core.Watermark.setScale(v / 100)
        end
    end, "watermarkScale")

    tab.Button.MouseButton1Click:Connect(function()
        GUI.switchTab(tab, page)
    end)

    return tab, page
end

return build
