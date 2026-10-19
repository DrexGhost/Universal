local Core, GUI, Logic = ...

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local T = Core.T

local Watermark = {}

local wmScreenGui = Instance.new("ScreenGui")
wmScreenGui.Name = "NexusXWatermark"
wmScreenGui.ResetOnSpawn = false
wmScreenGui.IgnoreGuiInset = true
wmScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
wmScreenGui.DisplayOrder = 1000
wmScreenGui.Parent = PlayerGui

local wmRoot = Instance.new("Frame")
wmRoot.Name = "Root"
wmRoot.AnchorPoint = Vector2.new(0.5, 0)
wmRoot.Size = UDim2.new(0, 420, 0, 46)
wmRoot.Position = UDim2.new(0.5, 0, 0, 15)
wmRoot.BackgroundColor3 = T.bg1
wmRoot.BorderSizePixel = 0
wmRoot.ClipsDescendants = true
wmRoot.Parent = wmScreenGui

local wmScale = Instance.new("UIScale")
wmScale.Scale = 1
wmScale.Parent = wmRoot

local wmCorner = Instance.new("UICorner")
wmCorner.CornerRadius = UDim.new(0, 12)
wmCorner.Parent = wmRoot

local wmGrad = Instance.new("UIGradient")
wmGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 32, 54)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 22)),
})
wmGrad.Rotation = 0
wmGrad.Parent = wmRoot

local wmStroke = Instance.new("UIStroke")
wmStroke.Color = T.stroke
wmStroke.Thickness = 1
wmStroke.Parent = wmRoot

local wmAccentBar = Instance.new("Frame")
wmAccentBar.Size = UDim2.new(0, 3, 0.7, 0)
wmAccentBar.Position = UDim2.new(0, 0, 0.15, 0)
wmAccentBar.BackgroundColor3 = T.accent
wmAccentBar.BorderSizePixel = 0
wmAccentBar.Parent = wmRoot

local wmAccentCorner = Instance.new("UICorner")
wmAccentCorner.CornerRadius = UDim.new(1, 0)
wmAccentCorner.Parent = wmAccentBar

local wmLayout = Instance.new("UIListLayout")
wmLayout.FillDirection = Enum.FillDirection.Horizontal
wmLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
wmLayout.VerticalAlignment = Enum.VerticalAlignment.Center
wmLayout.Padding = UDim.new(0, 10)
wmLayout.SortOrder = Enum.SortOrder.LayoutOrder
wmLayout.Parent = wmRoot

local wmPad = Instance.new("UIPadding")
wmPad.PaddingLeft = UDim.new(0, 14)
wmPad.PaddingRight = UDim.new(0, 14)
wmPad.Parent = wmRoot

local wmAvatarFrame = Instance.new("Frame")
wmAvatarFrame.Size = UDim2.new(0, 32, 0, 32)
wmAvatarFrame.BackgroundColor3 = T.accent
wmAvatarFrame.BorderSizePixel = 0
wmAvatarFrame.LayoutOrder = 1
wmAvatarFrame.Parent = wmRoot

local wmAvatarCorner = Instance.new("UICorner")
wmAvatarCorner.CornerRadius = UDim.new(1, 0)
wmAvatarCorner.Parent = wmAvatarFrame

local wmAvatarGrad = Instance.new("UIGradient")
wmAvatarGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, T.accent),
    ColorSequenceKeypoint.new(1, T.accentDim),
})
wmAvatarGrad.Rotation = 135
wmAvatarGrad.Parent = wmAvatarFrame

local wmAvatarWrap = Instance.new("Frame")
wmAvatarWrap.Size = UDim2.new(1, -4, 1, -4)
wmAvatarWrap.Position = UDim2.new(0.5, -14, 0.5, -14)
wmAvatarWrap.BackgroundColor3 = T.bg1
wmAvatarWrap.BorderSizePixel = 0
wmAvatarWrap.Parent = wmAvatarFrame

local wmAvatarWrapCorner = Instance.new("UICorner")
wmAvatarWrapCorner.CornerRadius = UDim.new(1, 0)
wmAvatarWrapCorner.Parent = wmAvatarWrap

local wmAvatar = Instance.new("ImageLabel")
wmAvatar.Size = UDim2.new(1, 0, 1, 0)
wmAvatar.BackgroundTransparency = 1
wmAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
wmAvatar.Parent = wmAvatarWrap

local wmAvatarImgCorner = Instance.new("UICorner")
wmAvatarImgCorner.CornerRadius = UDim.new(1, 0)
wmAvatarImgCorner.Parent = wmAvatar

local function wmMakeSeparator(order)
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(0, 1, 0.5, 0)
    sep.BackgroundColor3 = T.stroke
    sep.BorderSizePixel = 0
    sep.LayoutOrder = order
    sep.Parent = wmRoot
    return sep
end

local function wmMakeStat(label, order, iconColor)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, 80, 1, 0)
    holder.BackgroundTransparency = 1
    holder.LayoutOrder = order
    holder.Parent = wmRoot

    local icon = Instance.new("Frame")
    icon.Size = UDim2.new(0, 6, 0, 6)
    icon.Position = UDim2.new(0, 0, 0.5, -3)
    icon.BackgroundColor3 = iconColor
    icon.BorderSizePixel = 0
    icon.Parent = holder

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = icon

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 12)
    lbl.Position = UDim2.new(0, 12, 0, 12)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = T.textMuted
    lbl.TextSize = 9
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(1, -12, 0, 16)
    val.Position = UDim2.new(0, 12, 0, 23)
    val.BackgroundTransparency = 1
    val.Text = "0"
    val.TextColor3 = T.text
    val.TextSize = 12
    val.Font = Enum.Font.GothamBold
    val.TextXAlignment = Enum.TextXAlignment.Left
    val.Parent = holder

    return val
end

local wmFpsValue = wmMakeStat("FPS", 2, T.accent)
wmMakeSeparator(3)
local wmPingValue = wmMakeStat("PING", 4, T.success)
wmMakeSeparator(5)
local wmOnlineValue = wmMakeStat("ONLINE", 6, T.warn)

local wmFpsFrames = 0
local wmFpsAccum = 0

RunService.RenderStepped:Connect(function(dt)
    if not wmRoot.Visible then return end
    wmFpsFrames = wmFpsFrames + 1
    wmFpsAccum = wmFpsAccum + dt
    if wmFpsAccum >= 0.5 then
        local fps = math.floor(wmFpsFrames / wmFpsAccum + 0.5)
        wmFpsFrames = 0
        wmFpsAccum = 0
        local fpsColor
        if fps >= 60 then fpsColor = T.success
        elseif fps >= 30 then fpsColor = T.warn
        else fpsColor = T.danger end
        wmFpsValue.Text = tostring(fps)
        wmFpsValue.TextColor3 = fpsColor
    end
end)

task.spawn(function()
    while wmScreenGui.Parent do
        task.wait(1)
        if wmRoot.Visible then
            local ping = 0
            pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5) end)
            local pingColor
            if ping < 60 then pingColor = T.success
            elseif ping < 120 then pingColor = T.warn
            else pingColor = T.danger end
            wmPingValue.Text = ping .. " ms"
            wmPingValue.TextColor3 = pingColor
            wmOnlineValue.Text = tostring(#Players:GetPlayers())
        end
    end
end)

Players.PlayerAdded:Connect(function()
    wmOnlineValue.Text = tostring(#Players:GetPlayers())
end)

Players.PlayerRemoving:Connect(function()
    task.wait(0.1)
    wmOnlineValue.Text = tostring(#Players:GetPlayers())
end)

task.spawn(function()
    while wmScreenGui.Parent do
        TweenService:Create(wmAccentBar, TweenInfo.new(1.8, Enum.EasingStyle.Sine), {BackgroundColor3 = T.accent:Lerp(Color3.fromRGB(255, 255, 255), 0.3)}):Play()
        task.wait(1.8)
        TweenService:Create(wmAccentBar, TweenInfo.new(1.8, Enum.EasingStyle.Sine), {BackgroundColor3 = T.accent}):Play()
        task.wait(1.8)
    end
end)

function Watermark.setEnabled(v)
    wmRoot.Visible = v
end

function Watermark.setScale(s)
    wmScale.Scale = s
end

Core.Watermark = Watermark

local function build()
    local tab = GUI.makeTab("Main", 2, "dashboard")
    local page = GUI.makePage()

    local profileCard = Instance.new("Frame")
    profileCard.Size = UDim2.new(1, 0, 0, 92)
    profileCard.BackgroundColor3 = T.card
    profileCard.BorderSizePixel = 0
    profileCard.LayoutOrder = 1
    profileCard.Parent = page

    local pcCorner = Instance.new("UICorner")
    pcCorner.CornerRadius = UDim.new(0, 12)
    pcCorner.Parent = profileCard

    local pcStroke = Instance.new("UIStroke")
    pcStroke.Color = T.stroke
    pcStroke.Thickness = 1
    pcStroke.Transparency = 0.3
    pcStroke.Parent = profileCard

    local pcGradient = Instance.new("UIGradient")
    pcGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 34, 62)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 32)),
    })
    pcGradient.Rotation = 115
    pcGradient.Parent = profileCard

    local avatarRing = Instance.new("Frame")
    avatarRing.Size = UDim2.new(0, 64, 0, 64)
    avatarRing.Position = UDim2.new(0, 14, 0.5, -32)
    avatarRing.BackgroundColor3 = T.accent
    avatarRing.BorderSizePixel = 0
    avatarRing.ZIndex = 2
    avatarRing.Parent = profileCard

    local avatarRingCorner = Instance.new("UICorner")
    avatarRingCorner.CornerRadius = UDim.new(1, 0)
    avatarRingCorner.Parent = avatarRing

    local avatarRingGradient = Instance.new("UIGradient")
    avatarRingGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 65, 220)),
    })
    avatarRingGradient.Rotation = 135
    avatarRingGradient.Parent = avatarRing

    local avatarWrap = Instance.new("Frame")
    avatarWrap.Size = UDim2.new(0, 58, 0, 58)
    avatarWrap.Position = UDim2.new(0.5, -29, 0.5, -29)
    avatarWrap.BackgroundColor3 = T.bg1
    avatarWrap.BorderSizePixel = 0
    avatarWrap.ZIndex = 3
    avatarWrap.Parent = avatarRing

    local avatarWrapCorner = Instance.new("UICorner")
    avatarWrapCorner.CornerRadius = UDim.new(1, 0)
    avatarWrapCorner.Parent = avatarWrap

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(1, 0, 1, 0)
    avatar.BackgroundTransparency = 1
    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
    avatar.ZIndex = 4
    avatar.Parent = avatarWrap

    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = avatar

    local onlineDot = Instance.new("Frame")
    onlineDot.Size = UDim2.new(0, 12, 0, 12)
    onlineDot.Position = UDim2.new(1, -14, 1, -14)
    onlineDot.BackgroundColor3 = T.online
    onlineDot.BorderSizePixel = 0
    onlineDot.ZIndex = 5
    onlineDot.Parent = avatarRing

    local onlineDotCorner = Instance.new("UICorner")
    onlineDotCorner.CornerRadius = UDim.new(1, 0)
    onlineDotCorner.Parent = onlineDot

    local onlineDotStroke = Instance.new("UIStroke")
    onlineDotStroke.Color = T.card
    onlineDotStroke.Thickness = 2
    onlineDotStroke.Parent = onlineDot

    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(1, -100, 0, 20)
    nameText.Position = UDim2.new(0, 92, 0, 22)
    nameText.BackgroundTransparency = 1
    nameText.Text = LocalPlayer.DisplayName
    nameText.TextColor3 = T.text
    nameText.TextSize = 15
    nameText.Font = Enum.Font.GothamBold
    nameText.TextXAlignment = Enum.TextXAlignment.Left
    nameText.ZIndex = 4
    nameText.Parent = profileCard

    local userText = Instance.new("TextLabel")
    userText.Size = UDim2.new(1, -100, 0, 14)
    userText.Position = UDim2.new(0, 92, 0, 42)
    userText.BackgroundTransparency = 1
    userText.Text = "@" .. LocalPlayer.Name
    userText.TextColor3 = T.textDim
    userText.TextSize = 11
    userText.Font = Enum.Font.Gotham
    userText.TextXAlignment = Enum.TextXAlignment.Left
    userText.ZIndex = 4
    userText.Parent = profileCard

    local idText = Instance.new("TextLabel")
    idText.Size = UDim2.new(1, -100, 0, 12)
    idText.Position = UDim2.new(0, 92, 0, 58)
    idText.BackgroundTransparency = 1
    idText.Text = "ID: " .. tostring(LocalPlayer.UserId)
    idText.TextColor3 = T.textMuted
    idText.TextSize = 10
    idText.Font = Enum.Font.Gotham
    idText.TextXAlignment = Enum.TextXAlignment.Left
    idText.ZIndex = 4
    idText.Parent = profileCard

    GUI.makeSectionHeader(page, "Server", 2)

    local statsRow = Instance.new("Frame")
    statsRow.Size = UDim2.new(1, 0, 0, 56)
    statsRow.BackgroundTransparency = 1
    statsRow.LayoutOrder = 3
    statsRow.Parent = page

    local statsLayout = Instance.new("UIListLayout")
    statsLayout.FillDirection = Enum.FillDirection.Horizontal
    statsLayout.Padding = UDim.new(0, 8)
    statsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    statsLayout.Parent = statsRow

    local function makeStat(order, title)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(0.5, -4, 1, 0)
        card.BackgroundColor3 = T.row
        card.BorderSizePixel = 0
        card.LayoutOrder = order
        card.Parent = statsRow

        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 10)
        c.Parent = card

        local s = Instance.new("UIStroke")
        s.Color = T.stroke
        s.Thickness = 1
        s.Transparency = 0.4
        s.Parent = card

        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1, -20, 0, 12)
        t.Position = UDim2.new(0, 12, 0, 10)
        t.BackgroundTransparency = 1
        t.Text = title:upper()
        t.TextColor3 = T.textMuted
        t.TextSize = 9
        t.Font = Enum.Font.GothamBold
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.Parent = card

        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(1, -20, 0, 20)
        v.Position = UDim2.new(0, 12, 0, 26)
        v.BackgroundTransparency = 1
        v.Text = "0"
        v.TextColor3 = T.text
        v.TextSize = 16
        v.Font = Enum.Font.GothamBold
        v.TextXAlignment = Enum.TextXAlignment.Left
        v.Parent = card

        return v
    end

    local playersValue = makeStat(1, "Players")
    local pingValue = makeStat(2, "Ping")

    playersValue.Text = tostring(#Players:GetPlayers())
    pcall(function()
        pingValue.Text = tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) .. " ms"
    end)

    task.spawn(function()
        while GUI.screenGui.Parent do
            task.wait(1)
            playersValue.Text = tostring(#Players:GetPlayers())
            pcall(function()
                pingValue.Text = tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) .. " ms"
            end)
        end
    end)

    GUI.makeSectionHeader(page, "Watermark", 4)

    GUI.makeToggle(page, "Watermark", "Показать watermark на экране", Core.settings.watermark, 5, function(v)
        Watermark.setEnabled(v)
    end, "watermark")

    tab.Button.MouseButton1Click:Connect(function()
        GUI.switchTab(tab, page)
    end)

    return tab, page
end

return build
