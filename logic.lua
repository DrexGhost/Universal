local Core, GUI = ...

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local T = Core.T

local Logic = {}

local playerESP = {}
local npcESP = {}
local playerConns = {}
local savedCollide = {}
local noclipConn = nil
local speedConn = nil

local function isPlayerCharacter(model)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character == model then return true end
    end
    return false
end

local function getHRP(entity)
    local char = entity
    if entity:IsA("Player") then char = entity.Character end
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function getHealth(entity)
    local char = entity
    if entity:IsA("Player") then
        char = entity.Character
        if not char then return 0 end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then return hum.Health end
    local h = char:GetAttribute("Health") or char:GetAttribute("HP")
    if type(h) == "number" then return h end
    if entity:IsA("Player") then
        h = entity:GetAttribute("Health") or entity:GetAttribute("HP")
        if type(h) == "number" then return h end
    end
    return 0
end

local function scanNPCs()
    local npcs = {}
    local playerChars = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then playerChars[p.Character] = true end
    end

    local function check(obj)
        if not obj:IsA("Model") then return end
        if playerChars[obj] then return end
        if obj == LocalPlayer.Character then return end
        if obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            table.insert(npcs, obj)
        end
    end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") then
            check(obj)
        elseif obj:IsA("Folder") then
            for _, child in ipairs(obj:GetChildren()) do
                check(child)
            end
        end
    end

    return npcs
end

local function destroyESPEntry(esp)
    if esp.highlight then pcall(function() esp.highlight:Destroy() end) end
    if esp.billboard then pcall(function() esp.billboard:Destroy() end) end
end

local function createESP(entity, isNPC)
    local char = entity
    if entity:IsA("Player") then char = entity.Character end
    if not char or not char.Parent then return nil end
    if not char:FindFirstChild("HumanoidRootPart") then return nil end

    local color = isNPC and T.npc or T.danger

    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0.2
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = false
    highlight.Parent = GUI.screenGui

    local adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 240, 0, 70)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = adornee
    billboard.Enabled = false

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 2)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = billboard

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = ""
    nameLabel.TextColor3 = color
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.LayoutOrder = 1
    nameLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0, 14)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeTransparency = 0.3
    distLabel.LayoutOrder = 2
    distLabel.Parent = billboard

    local hpLabel = Instance.new("TextLabel")
    hpLabel.Size = UDim2.new(1, 0, 0, 14)
    hpLabel.BackgroundTransparency = 1
    hpLabel.Text = ""
    hpLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    hpLabel.TextSize = 12
    hpLabel.Font = Enum.Font.Gotham
    hpLabel.TextStrokeTransparency = 0.3
    hpLabel.LayoutOrder = 3
    hpLabel.Parent = billboard

    return {
        highlight = highlight,
        billboard = billboard,
        nameLabel = nameLabel,
        distLabel = distLabel,
        hpLabel = hpLabel,
        isNPC = isNPC,
        character = char,
    }
end

local function updateESPFor(esp, entity, isNPC)
    local char = entity
    if entity:IsA("Player") then char = entity.Character end

    if not char or not char.Parent then
        esp.highlight.Enabled = false
        esp.billboard.Enabled = false
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        esp.highlight.Enabled = false
        esp.billboard.Enabled = false
        return
    end

    if esp.character ~= char then
        esp.highlight.Adornee = char
        local adornee = char:FindFirstChild("Head") or hrp
        if adornee then
            esp.billboard.Adornee = adornee
            esp.billboard.Parent = adornee
        end
        esp.character = char
    end

    local master, hitbox, nick, dist, hp
    if isNPC then
        master = Core.settings.espNpc
        hitbox = Core.settings.espNpcHitbox
        nick = Core.settings.espNpcNick
        dist = Core.settings.espNpcDist
        hp = Core.settings.espNpcHP
    else
        master = Core.settings.espPlayers
        hitbox = Core.settings.espPlayerHitbox
        nick = Core.settings.espPlayerNick
        dist = Core.settings.espPlayerDist
        hp = Core.settings.espPlayerHP
    end

    if not master then
        esp.highlight.Enabled = false
        esp.billboard.Enabled = false
        return
    end

    esp.highlight.Enabled = hitbox
    esp.billboard.Enabled = nick or dist or hp

    if nick then
        esp.nameLabel.Text = "Name: " .. (entity:IsA("Player") and entity.Name or char.Name)
    end
    esp.nameLabel.Visible = nick

    if dist then
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myHRP then
            local d = math.floor((myHRP.Position - hrp.Position).Magnitude + 0.5)
            esp.distLabel.Text = "Distance: " .. d .. " m"
        end
    end
    esp.distLabel.Visible = dist

    if hp then
        local h = math.floor(getHealth(entity) + 0.5)
        esp.hpLabel.Text = "Health: " .. h
    end
    esp.hpLabel.Visible = hp
end

local function refreshESP()
    for plr, esp in pairs(playerESP) do
        destroyESPEntry(esp)
        playerESP[plr] = nil
    end
    for npc, esp in pairs(npcESP) do
        destroyESPEntry(esp)
        npcESP[npc] = nil
    end

    if Core.settings.espPlayers then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local esp = createESP(plr, false)
                if esp then playerESP[plr] = esp end
            end
        end
    end

    if Core.settings.espNpc then
        for _, npc in ipairs(scanNPCs()) do
            local esp = createESP(npc, true)
            if esp then npcESP[npc] = esp end
        end
    end
end

local function setupPlayer(plr)
    if playerConns[plr] then return end
    local conn = plr.CharacterAdded:Connect(function()
        task.wait(0.1)
        if playerESP[plr] then
            destroyESPEntry(playerESP[plr])
            playerESP[plr] = nil
        end
        if Core.settings.espPlayers and plr.Character then
            local esp = createESP(plr, false)
            if esp then playerESP[plr] = esp end
        end
    end)
    playerConns[plr] = conn

    if Core.settings.espPlayers and plr.Character then
        local esp = createESP(plr, false)
        if esp then playerESP[plr] = esp end
    end
end

local function cleanupPlayer(plr)
    if playerESP[plr] then
        destroyESPEntry(playerESP[plr])
        playerESP[plr] = nil
    end
    if playerConns[plr] then
        playerConns[plr]:Disconnect()
        playerConns[plr] = nil
    end
end

local function applyNoclip()
    if not LocalPlayer.Character then return end
    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            if savedCollide[part] == nil then savedCollide[part] = part.CanCollide end
            part.CanCollide = false
        end
    end
end

local function removeNoclip()
    for part, state in pairs(savedCollide) do
        if part and part.Parent then part.CanCollide = state end
    end
    savedCollide = {}
end

function Logic.enableNoclip(v)
    if v then
        if noclipConn then noclipConn:Disconnect() end
        applyNoclip()
        noclipConn = RunService.Stepped:Connect(function()
            if Core.settings.noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if savedCollide[part] == nil then savedCollide[part] = part.CanCollide end
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        noclipConn = nil
        removeNoclip()
    end
end

function Logic.enableSpeed(v)
    if v then
        if speedConn then speedConn:Disconnect() end
        speedConn = RunService.Heartbeat:Connect(function()
            if Core.settings.speed and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = Core.settings.walkSpeed end
            end
        end)
    else
        if speedConn then speedConn:Disconnect() end
        speedConn = nil
        if LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end

function Logic.setupEvents()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then setupPlayer(plr) end
    end

    Players.PlayerAdded:Connect(function(plr)
        if plr ~= LocalPlayer then setupPlayer(plr) end
    end)

    Players.PlayerRemoving:Connect(function(plr)
        cleanupPlayer(plr)
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        savedCollide = {}
        task.wait(0.5)
        if Core.settings.noclip then applyNoclip() end
    end)
end

function Logic.startLoop()
    local npcTimer = 0

    RunService.RenderStepped:Connect(function(dt)
        if Core.settings.espPlayers then
            for plr, esp in pairs(playerESP) do
                if not plr.Character or not plr.Character.Parent then
                    esp.highlight.Enabled = false
                    esp.billboard.Enabled = false
                else
                    updateESPFor(esp, plr, false)
                end
            end
        end

        if Core.settings.espNpc then
            npcTimer = npcTimer + dt
            if npcTimer >= 0.5 then
                npcTimer = 0
                local current = scanNPCs()
                local currentSet = {}
                for _, npc in ipairs(current) do currentSet[npc] = true end

                local toRemove = {}
                for npc, esp in pairs(npcESP) do
                    if not currentSet[npc] or not npc.Parent then
                        table.insert(toRemove, npc)
                    end
                end
                for _, npc in ipairs(toRemove) do
                    destroyESPEntry(npcESP[npc])
                    npcESP[npc] = nil
                end

                for _, npc in ipairs(current) do
                    if not npcESP[npc] then
                        local esp = createESP(npc, true)
                        if esp then npcESP[npc] = esp end
                    end
                end
            end

            for npc, esp in pairs(npcESP) do
                if not npc.Parent then
                    destroyESPEntry(esp)
                    npcESP[npc] = nil
                else
                    updateESPFor(esp, npc, true)
                end
            end
        end
    end)
end

Logic.refreshESP = refreshESP
Logic.getHealth = getHealth
Logic.getHRP = getHRP
Logic.scanNPCs = scanNPCs

return Logic
