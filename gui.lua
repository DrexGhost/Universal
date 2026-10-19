local Core = ...

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local T = Core.T

local GUI = {}

GUI._tabs = {}
GUI._pages = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SwillUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999
screenGui.Parent = PlayerGui

GUI.screenGui = screenGui

local BASE_W, BASE_H = 660, 460

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Size = UDim2.new(0, BASE_W, 0, BASE_H)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = T.bg2
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Main.Parent = screenGui

GUI.Main = Main
GUI.BASE_W = BASE_W
GUI.BASE_H = BASE_H

local uiScale = Instance.new("UIScale")
uiScale.Scale = (Core.settings.guiScale or 85) / 100
uiScale.Parent = Main

GUI.uiScale = uiScale

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = T.panel
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local logoBox = Instance.new("Frame")
logoBox.Size = UDim2.new(0, 34, 0, 34)
logoBox.Position = UDim2.new(0, 16, 0.5, -17)
logoBox.BackgroundColor3 = T.accent
logoBox.BorderSizePixel = 0
logoBox.Parent = TopBar

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 9)
logoCorner.Parent = logoBox

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, T.accent),
    ColorSequenceKeypoint.new(1, T.accentDim),
})
logoGrad.Rotation = 135
logoGrad.Parent = logoBox

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "S"
logoText.TextColor3 = Color3.fromRGB(10, 14, 24)
logoText.TextSize = 20
logoText.Font = Enum.Font.GothamBlack
logoText.Parent = logoBox

local onlineDot = Instance.new("Frame")
onlineDot.Size = UDim2.new(0, 6, 0, 6)
onlineDot.Position = UDim2.new(0, 56, 0, 15)
onlineDot.BackgroundColor3 = T.success
onlineDot.BorderSizePixel = 0
onlineDot.Parent = TopBar
local onlineDotCorner = Instance.new("UICorner")
onlineDotCorner.CornerRadius = UDim.new(1, 0)
onlineDotCorner.Parent = onlineDot

task.spawn(function()
    while screenGui.Parent do
        TweenService:Create(onlineDot, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.7}):Play()
        task.wait(1.2)
        TweenService:Create(onlineDot, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
        task.wait(1.2)
    end
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 20)
titleLabel.Position = UDim2.new(0, 68, 0, 12)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SWILL"
titleLabel.TextColor3 = T.text
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = TopBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 200, 0, 14)
versionLabel.Position = UDim2.new(0, 68, 0, 30)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v" .. Core.VERSION
versionLabel.TextColor3 = T.textMuted
versionLabel.TextSize = 10
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = TopBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -44, 0.5, -16)
closeBtn.BackgroundColor3 = T.panelHi
closeBtn.BorderSizePixel = 0
closeBtn.Text = ""
closeBtn.AutoButtonColor = false
closeBtn.Parent = TopBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeBtn

local cX1 = Instance.new("Frame")
cX1.Size = UDim2.new(0, 12, 0, 2)
cX1.Position = UDim2.new(0.5, -6, 0.5, -1)
cX1.Rotation = 45
cX1.BackgroundColor3 = T.textDim
cX1.BorderSizePixel = 0
cX1.Parent = closeBtn
local cX1c = Instance.new("UICorner")
cX1c.CornerRadius = UDim.new(1, 0)
cX1c.Parent = cX1

local cX2 = Instance.new("Frame")
cX2.Size = UDim2.new(0, 12, 0, 2)
cX2.Position = UDim2.new(0.5, -6, 0.5, -1)
cX2.Rotation = -45
cX2.BackgroundColor3 = T.textDim
cX2.BorderSizePixel = 0
cX2.Parent = closeBtn
local cX2c = Instance.new("UICorner")
cX2c.CornerRadius = UDim.new(1, 0)
cX2c.Parent = cX2

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = T.danger}):Play()
    TweenService:Create(cX1, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(cX2, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = T.panelHi}):Play()
    TweenService:Create(cX1, TweenInfo.new(0.15), {BackgroundColor3 = T.textDim}):Play()
    TweenService:Create(cX2, TweenInfo.new(0.15), {BackgroundColor3 = T.textDim}):Play()
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 152, 1, -88)
Sidebar.Position = UDim2.new(0, 0, 0, 58)
Sidebar.BackgroundColor3 = T.bg2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 10)
sidePad.PaddingBottom = UDim.new(0, 10)
sidePad.PaddingLeft = UDim.new(0, 8)
sidePad.PaddingRight = UDim.new(0, 8)
sidePad.Parent = Sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 4)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = Sidebar

local navLabel = Instance.new("TextLabel")
navLabel.Size = UDim2.new(1, 0, 0, 18)
navLabel.BackgroundTransparency = 1
navLabel.Text = "NAVIGATION"
navLabel.TextColor3 = T.textMuted
navLabel.TextSize = 9
navLabel.Font = Enum.Font.GothamBold
navLabel.TextXAlignment = Enum.TextXAlignment.Left
navLabel.LayoutOrder = 1
navLabel.Parent = Sidebar
local navPad = Instance.new("UIPadding")
navPad.PaddingLeft = UDim.new(0, 8)
navPad.Parent = navLabel

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -152, 1, -88)
Content.Position = UDim2.new(0, 152, 0, 58)
Content.BackgroundTransparency = 1
Content.Parent = Main

GUI.Content = Content

local contentPad = Instance.new("UIPadding")
contentPad.PaddingLeft = UDim.new(0, 12)
contentPad.PaddingRight = UDim.new(0, 12)
contentPad.PaddingTop = UDim.new(0, 12)
contentPad.PaddingBottom = UDim.new(0, 12)
contentPad.Parent = Content

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundColor3 = T.panel
Footer.BorderSizePixel = 0
Footer.Parent = Main

local footerTop = Instance.new("Frame")
footerTop.Size = UDim2.new(1, 0, 0, 1)
footerTop.BackgroundColor3 = T.stroke
footerTop.BorderSizePixel = 0
footerTop.Parent = Footer

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 6, 0, 6)
statusDot.Position = UDim2.new(0, 14, 0.5, -3)
statusDot.BackgroundColor3 = T.success
statusDot.BorderSizePixel = 0
statusDot.Parent = Footer
local statusDotCorner = Instance.new("UICorner")
statusDotCorner.CornerRadius = UDim.new(1, 0)
statusDotCorner.Parent = statusDot

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(0, 100, 1, 0)
statusText.Position = UDim2.new(0, 26, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "READY"
statusText.TextColor3 = T.success
statusText.TextSize = 10
statusText.Font = Enum.Font.GothamBold
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = Footer

local footerRight = Instance.new("TextLabel")
footerRight.Size = UDim2.new(0, 280, 1, 0)
footerRight.Position = UDim2.new(1, -294, 0, 0)
footerRight.BackgroundTransparency = 1
footerRight.Text = "PRESS LEFT ALT TO TOGGLE"
footerRight.TextColor3 = T.textMuted
footerRight.TextSize = 10
footerRight.Font = Enum.Font.Gotham
footerRight.TextXAlignment = Enum.TextXAlignment.Right
footerRight.Parent = Footer

local notifyContainer = Instance.new("Frame")
notifyContainer.Name = "NotifyContainer"
notifyContainer.Size = UDim2.new(0, 320, 1, -120)
notifyContainer.Position = UDim2.new(1, -340, 0, 100)
notifyContainer.BackgroundTransparency = 1
notifyContainer.Parent = screenGui

local notifyLayout = Instance.new("UIListLayout")
notifyLayout.Padding = UDim.new(0, 8)
notifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifyLayout.VerticalAlignment = Enum.VerticalAlignment.Top
notifyLayout.Parent = notifyContainer

function GUI.notify(text, color)
    color = color or T.accent
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 44)
    frame.BackgroundColor3 = T.panel
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 1
    stroke.Parent = frame

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 14, 0.5, -3)
    dot.BackgroundColor3 = color
    dot.BorderSizePixel = 0
    dot.BackgroundTransparency = 1
    dot.Parent = frame
    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(1, 0)
    dc.Parent = dot

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 1, 0)
    lbl.Position = UDim2.new(0, 28, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = T.text
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTransparency = 1
    lbl.Parent = frame

    frame.Parent = notifyContainer

    TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    TweenService:Create(dot, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(lbl, TweenInfo.new(0.2), {TextTransparency = 0}):Play()

    task.delay(2.5, function()
        TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        TweenService:Create(dot, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        task.wait(0.35)
        frame:Destroy()
    end)
end

local function buildIcon(holder, kind, color)
    for _, c in ipairs(holder:GetChildren()) do c:Destroy() end

    local base = Instance.new("Frame")
    base.Size = UDim2.new(0, 16, 0, 16)
    base.Position = UDim2.new(0, 3, 0.5, -8)
    base.BackgroundTransparency = 1
    base.Parent = holder

    local function mk(size, pos, z)
        local f = Instance.new("Frame")
        f.Size = size
        f.Position = pos
        f.BackgroundColor3 = color
        f.BorderSizePixel = 0
        f.ZIndex = z or 2
        f.Parent = base
        local fc = Instance.new("UICorner")
        fc.CornerRadius = UDim.new(1, 0)
        fc.Parent = f
        return f
    end

    if kind == "dashboard" then
        mk(UDim2.new(0, 14, 0, 5), UDim2.new(0, 1, 0, 0), 2)
        mk(UDim2.new(0, 6, 0, 7), UDim2.new(0, 1, 0, 7), 2)
        mk(UDim2.new(0, 6, 0, 7), UDim2.new(0, 9, 0, 7), 2)
    elseif kind == "crosshair" then
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 14, 0, 14)
        circle.Position = UDim2.new(0, 1, 0, 1)
        circle.BackgroundTransparency = 1
        circle.ZIndex = 6
        circle.Parent = base
        local cc = Instance.new("UICorner")
        cc.CornerRadius = UDim.new(1, 0)
        cc.Parent = circle
        local cs = Instance.new("UIStroke")
        cs.Color = color
        cs.Thickness = 1.5
        cs.Parent = circle
        mk(UDim2.new(0, 4, 0, 4), UDim2.new(0.5, -2, 0.5, -2), 2)
    elseif kind == "motion" then
        mk(UDim2.new(0, 12, 0, 2), UDim2.new(0, 1, 0, 3), 1)
        mk(UDim2.new(0, 8, 0, 2), UDim2.new(0, 1, 0, 7), 1)
        mk(UDim2.new(0, 4, 0, 2), UDim2.new(0, 1, 0, 11), 1)
    elseif kind == "settings" then
        local lines = {
            {y = 2, knobX = 9},
            {y = 7, knobX = 4},
            {y = 12, knobX = 11},
        }
        for _, l in ipairs(lines) do
            mk(UDim2.new(0, 14, 0, 2), UDim2.new(0, 1, 0, l.y), 1)
            mk(UDim2.new(0, 4, 0, 4), UDim2.new(0, l.knobX, 0, l.y - 1), 2)
        end
    end
end

function GUI.makeTab(text, order, iconKind)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 36)
    tab.BackgroundColor3 = T.card
    tab.BackgroundTransparency = 1
    tab.BorderSizePixel = 0
    tab.Text = ""
    tab.AutoButtonColor = false
    tab.LayoutOrder = order
    tab.Parent = Sidebar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 0.55, 0)
    indicator.Position = UDim2.new(0, 0, 0.225, 0)
    indicator.BackgroundColor3 = T.accent
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = tab
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = indicator

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.new(0, 22, 1, 0)
    iconHolder.Position = UDim2.new(0, 12, 0, 0)
    iconHolder.BackgroundTransparency = 1
    iconHolder.Parent = tab

    buildIcon(iconHolder, iconKind, T.textDim)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -40, 1, 0)
    textLabel.Position = UDim2.new(0, 40, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = T.textDim
    textLabel.TextSize = 12
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = tab

    local obj = { Button = tab, Indicator = indicator, IconHolder = iconHolder, Text = textLabel, Active = false, IconKind = iconKind }

    local function paintIcon(color)
        buildIcon(iconHolder, iconKind, color)
    end

    obj.SetActive = function(v)
        obj.Active = v
        if v then
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = T.card, BackgroundTransparency = 0.05}):Play()
            TweenService:Create(indicator, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.2), {TextColor3 = T.text}):Play()
            paintIcon(T.accent)
        else
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(indicator, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.2), {TextColor3 = T.textDim}):Play()
            paintIcon(T.textDim)
        end
    end

    tab.MouseEnter:Connect(function()
        if not obj.Active then
            TweenService:Create(tab, TweenInfo.new(0.12), {BackgroundColor3 = T.card, BackgroundTransparency = 0.55}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.12), {TextColor3 = T.text}):Play()
            paintIcon(T.text)
        end
    end)
    tab.MouseLeave:Connect(function()
        if not obj.Active then
            TweenService:Create(tab, TweenInfo.new(0.12), {BackgroundTransparency = 1}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.12), {TextColor3 = T.textDim}):Play()
            paintIcon(T.textDim)
        end
    end)

    table.insert(GUI._tabs, obj)

    return obj
end

function GUI.makePage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.CanvasSize = UDim2.new(0, 0, 0, 800)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = T.accent
    page.ScrollBarImageTransparency = 0.5
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = page

    table.insert(GUI._pages, page)

    return page
end

function GUI.switchTab(targetTab, targetPage)
    for _, tab in ipairs(GUI._tabs) do
        if tab == targetTab then
            tab.SetActive(true)
        else
            tab.SetActive(false)
        end
    end
    for _, page in ipairs(GUI._pages) do
        page.Visible = (page == targetPage)
    end
end

function GUI.makeSectionHeader(parent, text, order)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 24)
    holder.BackgroundTransparency = 1
    holder.LayoutOrder = order
    holder.Parent = parent

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 4, 0.5, -3)
    dot.BackgroundColor3 = T.accent
    dot.BorderSizePixel = 0
    dot.Parent = holder
    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(1, 0)
    dc.Parent = dot

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 1, 0)
    lbl.Position = UDim2.new(0, 18, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = T.text
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder
end

function GUI.makeToggle(parent, name, desc, default, order, callback, settingName)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 48)
    row.BackgroundColor3 = T.card
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = order
    row.Parent = parent

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 10)
    rowCorner.Parent = row

    local rowStroke = Instance.new("UIStroke")
    rowStroke.Color = T.stroke
    rowStroke.Thickness = 1
    rowStroke.Transparency = 0.4
    rowStroke.Parent = row

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -80, 0, 16)
    nameLbl.Position = UDim2.new(0, 14, 0, 9)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextColor3 = T.text
    nameLbl.TextSize = 13
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = row

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -80, 0, 14)
    descLbl.Position = UDim2.new(0, 14, 0, 26)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = desc or ""
    descLbl.TextColor3 = T.textMuted
    descLbl.TextSize = 10
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = row

    local pill = Instance.new("Frame")
    pill.Size = UDim2.new(0, 40, 0, 22)
    pill.Position = UDim2.new(1, -54, 0.5, -11)
    pill.BackgroundColor3 = default and T.accent or T.toggleOff
    pill.BorderSizePixel = 0
    pill.Parent = row
    local pc = Instance.new("UICorner")
    pc.CornerRadius = UDim.new(1, 0)
    pc.Parent = pill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = pill
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local state = default

    local function render()
        TweenService:Create(pill, TweenInfo.new(0.2), {BackgroundColor3 = state and T.accent or T.toggleOff}):Play()
        TweenService:Create(knob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
    end

    local function setState(v, silent)
        state = v
        render()
        if not silent then
            if settingName then Core.saveSetting(settingName, state) end
            if callback then callback(state) end
        end
    end

    row.MouseButton1Click:Connect(function()
        setState(not state, false)
    end)

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = T.cardHover}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = T.accent, Transparency = 0.5}):Play()
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = T.card}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = T.stroke, Transparency = 0.4}):Play()
    end)

    if settingName then
        Core.toggleRefs[settingName] = {
            setEnabled = setState,
            isEnabled = function() return state end,
            updateVisual = render,
        }
    end

    return { Set = setState, Get = function() return state end }
end

function GUI.makeSlider(parent, name, min, max, default, order, callback, settingName)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 62)
    row.BackgroundColor3 = T.card
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = parent

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 10)
    rowCorner.Parent = row

    local rowStroke = Instance.new("UIStroke")
    rowStroke.Color = T.stroke
    rowStroke.Thickness = 1
    rowStroke.Transparency = 0.4
    rowStroke.Parent = row

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -80, 0, 16)
    nameLbl.Position = UDim2.new(0, 14, 0, 8)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextColor3 = T.text
    nameLbl.TextSize = 13
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 60, 0, 16)
    valLbl.Position = UDim2.new(1, -74, 0, 8)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = T.accent
    valLbl.TextSize = 13
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -28, 0, 4)
    track.Position = UDim2.new(0, 14, 0, 42)
    track.BackgroundColor3 = T.toggleOff
    track.BorderSizePixel = 0
    track.Parent = row
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = track

    local fill = Instance.new("Frame")
    local initPct = (default - min) / (max - min)
    fill.Size = UDim2.new(initPct, 0, 1, 0)
    fill.BackgroundColor3 = T.accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0)
    fc.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(initPct, 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local ks = Instance.new("UIStroke")
    ks.Color = T.accent
    ks.Thickness = 2
    ks.Parent = knob

    local value = default
    local activeDrag = false

    local function apply(v, silent)
        v = math.clamp(v, min, max)
        v = math.floor(v + 0.5)
        value = v
        local pct = (v - min) / (max - min)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, 0, 0.5, 0)
        valLbl.Text = tostring(v)
        if not silent then
            if settingName then Core.saveSetting(settingName, v) end
            if callback then callback(v) end
        end
    end

    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 0, 30)
    clickArea.Position = UDim2.new(0, 0, 0, 26)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = row

    clickArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            activeDrag = true
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            apply(min + rel * (max - min), false)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not activeDrag then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            apply(min + rel * (max - min), false)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            activeDrag = false
        end
    end)

    if settingName then
        Core.sliderRefs[settingName] = {
            setValue = function(v, silent) apply(v, silent ~= false) end,
            getValue = function() return value end,
        }
    end

    return { Set = apply, Get = function() return value end }
end

function GUI.makeActionButton(parent, text, variant, order, onClick)
    local color, textColor, strokeColor
    if variant == "primary" then
        color = T.accent
        textColor = Color3.fromRGB(10, 14, 24)
        strokeColor = T.accent
    elseif variant == "blue" then
        color = T.blue
        textColor = Color3.fromRGB(255, 255, 255)
        strokeColor = T.blueHi
    elseif variant == "danger" then
        color = T.danger
        textColor = Color3.fromRGB(255, 255, 255)
        strokeColor = T.danger
    else
        color = T.card
        textColor = Color3.fromRGB(255, 255, 255)
        strokeColor = T.stroke
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = textColor
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.LayoutOrder = order
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = strokeColor
    stroke.Thickness = 1
    stroke.Parent = btn

    btn.MouseEnter:Connect(function()
        if variant == "primary" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)}):Play()
        elseif variant == "blue" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.blue:Lerp(Color3.fromRGB(255, 255, 255), 0.15)}):Play()
        elseif variant == "danger" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.danger:Lerp(Color3.fromRGB(255, 255, 255), 0.15)}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.cardHover}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.15), {Color = T.accent, Transparency = 0.4}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if variant == "primary" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.accent}):Play()
        elseif variant == "blue" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.blue}):Play()
        elseif variant == "danger" then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.danger}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = T.card}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.15), {Color = T.stroke, Transparency = 0}):Play()
        end
    end)

    if onClick then
        btn.MouseButton1Click:Connect(onClick)
    end

    return btn
end

local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE, 0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE)
floatBtn.AnchorPoint = Vector2.new(0, 0.5)
floatBtn.Position = UDim2.new(
    Core.settings.floatBtnPos[1] or 0,
    Core.settings.floatBtnPos[2] or 20,
    Core.settings.floatBtnPos[3] or 0.5,
    Core.settings.floatBtnPos[4] or 0
)
floatBtn.BackgroundColor3 = T.bg1
floatBtn.BorderSizePixel = 0
floatBtn.Text = ""
floatBtn.AutoButtonColor = false
floatBtn.ClipsDescendants = true
floatBtn.Parent = screenGui

GUI.floatBtn = floatBtn

local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(0, 14)
fbCorner.Parent = floatBtn

local fbGrad = Instance.new("UIGradient")
fbGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 34, 54)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 14, 26)),
})
fbGrad.Rotation = 135
fbGrad.Parent = floatBtn

local fbStroke = Instance.new("UIStroke")
fbStroke.Color = T.accent
fbStroke.Thickness = 1.5
fbStroke.Transparency = 0.3
fbStroke.Parent = floatBtn

local barContainer = Instance.new("Frame")
barContainer.Size = UDim2.new(0, 32, 1, -18)
barContainer.Position = UDim2.new(0.5, -16, 0.5, 0)
barContainer.AnchorPoint = Vector2.new(0, 0.5)
barContainer.BackgroundTransparency = 1
barContainer.Parent = floatBtn

local barLayout = Instance.new("UIListLayout", barContainer)
barLayout.FillDirection = Enum.FillDirection.Horizontal
barLayout.Padding = UDim.new(0, 3)
barLayout.SortOrder = Enum.SortOrder.LayoutOrder
barLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local bars = {}
for i = 1, 5 do
    local bar = Instance.new("Frame")
    bar.AnchorPoint = Vector2.new(0, 0.5)
    bar.Size = UDim2.new(0, 4, 0.3, 0)
    bar.Position = UDim2.new(0, 0, 0.5, 0)
    bar.BackgroundColor3 = T.accent
    bar.BorderSizePixel = 0
    bar.ZIndex = 4
    bar.Parent = barContainer
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    table.insert(bars, {frame = bar, phase = i * 0.8})
end

local eqHovered = false

RunService.Heartbeat:Connect(function()
    if not floatBtn.Parent then return end
    local t = tick()
    local speed = eqHovered and 6 or 3
    for _, b in ipairs(bars) do
        local v = (math.sin(t * speed + b.phase) + 1) / 2
        local h = 0.2 + v * 0.75
        b.frame.Size = UDim2.new(0, 4, h, 0)
    end
end)

floatBtn.MouseEnter:Connect(function()
    eqHovered = true
    TweenService:Create(fbStroke, TweenInfo.new(0.15), {Color = T.accentSoft, Transparency = 0}):Play()
end)
floatBtn.MouseLeave:Connect(function()
    eqHovered = false
    TweenService:Create(fbStroke, TweenInfo.new(0.15), {Color = T.accent, Transparency = 0.3}):Play()
end)

local isOpen = false
local animating = false

function GUI.open()
    if isOpen or animating then return end
    animating = true
    isOpen = true

    Main.Visible = true
    Main.Size = UDim2.new(0, BASE_W * 0.85, 0, BASE_H * 0.85)
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, BASE_W, 0, BASE_H)
    }):Play()
    TweenService:Create(floatBtn, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()

    Core.settings.menuOpen = true
    Core.saveSetting("menuOpen", true)

    task.delay(0.32, function() animating = false end)
end

function GUI.close()
    if not isOpen or animating then return end
    animating = true
    isOpen = false

    TweenService:Create(Main, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.new(0, BASE_W * 0.85, 0, BASE_H * 0.85)
    }):Play()
    TweenService:Create(floatBtn, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE, 0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE)
    }):Play()

    Core.settings.menuOpen = false
    Core.saveSetting("menuOpen", false)

    task.delay(0.25, function()
        Main.Visible = false
        animating = false
    end)
end

function GUI.isOpen()
    return isOpen
end

function GUI.setOpenState(open)
    if open then
        if not isOpen then
            isOpen = true
            Main.Visible = true
            Main.Size = UDim2.new(0, BASE_W, 0, BASE_H)
            floatBtn.Size = UDim2.new(0, 0, 0, 0)
        end
    else
        if isOpen then
            isOpen = false
            Main.Visible = false
        end
        floatBtn.Size = UDim2.new(0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE, 0, Core.settings.floatBtnSize or Core.BUTTON_DEFAULT_SIZE)
    end
end

function GUI.setScale(scale)
    uiScale.Scale = scale
end

function GUI.setButtonSize(size)
    Core.settings.floatBtnSize = size
    if not isOpen and not animating then
        TweenService:Create(floatBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, size, 0, size)
        }):Play()
    end
end

function GUI.setButtonPos(pos)
    floatBtn.Position = UDim2.new(pos[1] or 0, pos[2] or 20, pos[3] or 0.5, pos[4] or 0)
end

function GUI.activateFirstTab()
    if #GUI._tabs > 0 and #GUI._pages > 0 then
        GUI.switchTab(GUI._tabs[1], GUI._pages[1])
    end
end

local fbDragging = false
local fbDragStart = nil
local fbStartPos = nil
local fbHasMoved = false

floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        fbDragging = true
        fbHasMoved = false
        fbDragStart = input.Position
        fbStartPos = floatBtn.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if not fbDragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = input.Position - fbDragStart
    if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
        fbHasMoved = true
    end
    floatBtn.Position = UDim2.new(
        fbStartPos.X.Scale, fbStartPos.X.Offset + delta.X,
        fbStartPos.Y.Scale, fbStartPos.Y.Offset + delta.Y
    )
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        if fbDragging then
            fbDragging = false
            if fbHasMoved then
                Core.saveSetting("floatBtnPos", {
                    floatBtn.Position.X.Scale, floatBtn.Position.X.Offset,
                    floatBtn.Position.Y.Scale, floatBtn.Position.Y.Offset
                })
            else
                if isOpen then GUI.close() else GUI.open() end
            end
        end
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    GUI.close()
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        if isOpen then GUI.close() else GUI.open() end
    end
end)

return GUI
