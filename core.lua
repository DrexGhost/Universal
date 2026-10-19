local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local Core = {}

Core.VERSION = "1.0.0"
Core.CONFIG_FOLDER = "SwillConfigs"
Core.BUTTON_DEFAULT_SIZE = 58

Core.T = {
    bg1 = Color3.fromRGB(14, 18, 32),
    bg2 = Color3.fromRGB(6, 9, 18),
    panel = Color3.fromRGB(20, 26, 44),
    panelHi = Color3.fromRGB(30, 38, 62),
    card = Color3.fromRGB(24, 30, 50),
    cardHover = Color3.fromRGB(34, 42, 68),
    row = Color3.fromRGB(26, 32, 52),
    accent = Color3.fromRGB(0, 229, 204),
    accentDim = Color3.fromRGB(0, 140, 128),
    accentSoft = Color3.fromRGB(140, 250, 235),
    text = Color3.fromRGB(232, 238, 248),
    textDim = Color3.fromRGB(150, 162, 190),
    textMuted = Color3.fromRGB(90, 102, 130),
    stroke = Color3.fromRGB(44, 54, 86),
    success = Color3.fromRGB(80, 230, 140),
    warn = Color3.fromRGB(255, 200, 80),
    danger = Color3.fromRGB(255, 90, 110),
    toggleOff = Color3.fromRGB(48, 58, 88),
    online = Color3.fromRGB(80, 230, 140),
    blue = Color3.fromRGB(70, 130, 220),
    blueHi = Color3.fromRGB(90, 150, 240),
    npc = Color3.fromRGB(255, 165, 0),
}

Core.settings = {
    menuOpen = true,
    guiScale = 85,
    floatBtnSize = 58,
    floatBtnPos = {0, 20, 0.5, 0},
    watermark = false,
    watermarkScale = 100,
    espPlayers = false,
    espPlayerHitbox = false,
    espPlayerNick = false,
    espPlayerDist = false,
    espPlayerHP = false,
    espNpc = false,
    espNpcHitbox = false,
    espNpcNick = false,
    espNpcDist = false,
    espNpcHP = false,
    noclip = false,
    speed = false,
    walkSpeed = 50,
}

Core.toggleRefs = {}
Core.sliderRefs = {}
Core.dataStore = nil

function Core.loadSettings()
    local ok, folder = pcall(function()
        if not LocalPlayer:FindFirstChild("SwillSettings") then
            local f = Instance.new("Folder")
            f.Name = "SwillSettings"
            f.Parent = LocalPlayer
        end
        return LocalPlayer.SwillSettings
    end)
    if not ok or not folder then return end
    Core.dataStore = folder
    for name, defaultValue in pairs(Core.settings) do
        local stored = folder:FindFirstChild(name)
        if stored then
            if type(defaultValue) == "table" and stored:IsA("StringValue") then
                local dok, decoded = pcall(function() return HttpService:JSONDecode(stored.Value) end)
                if dok and type(decoded) == "table" then Core.settings[name] = decoded end
            elseif type(defaultValue) ~= "table" and type(defaultValue) == type(stored.Value) then
                Core.settings[name] = stored.Value
            end
        end
    end
end

function Core.saveSetting(name, value)
    Core.settings[name] = value
    if not Core.dataStore then return end
    local stored = Core.dataStore:FindFirstChild(name)
    if type(value) == "table" then
        if not stored or not stored:IsA("StringValue") then
            if stored then stored:Destroy() end
            stored = Instance.new("StringValue")
            stored.Name = name
            stored.Parent = Core.dataStore
        end
        stored.Value = HttpService:JSONEncode(value)
    elseif type(value) == "string" then
        if not stored or not stored:IsA("StringValue") then
            if stored then stored:Destroy() end
            stored = Instance.new("StringValue")
            stored.Name = name
            stored.Parent = Core.dataStore
        end
        stored.Value = value
    elseif type(value) == "number" then
        if not stored or not stored:IsA("NumberValue") then
            if stored then stored:Destroy() end
            stored = Instance.new("NumberValue")
            stored.Name = name
            stored.Parent = Core.dataStore
        end
        stored.Value = value
    elseif type(value) == "boolean" then
        if not stored or not stored:IsA("BoolValue") then
            if stored then stored:Destroy() end
            stored = Instance.new("BoolValue")
            stored.Name = name
            stored.Parent = Core.dataStore
        end
        stored.Value = value
    end
end

function Core.ensureFolder()
    if type(isfolder) ~= "function" or type(makefolder) ~= "function" then return false end
    local ok = pcall(function()
        if not isfolder(Core.CONFIG_FOLDER) then makefolder(Core.CONFIG_FOLDER) end
    end)
    return ok
end

function Core.isValidConfigName(name)
    if type(name) ~= "string" then return false end
    if #name < 1 or #name > 30 then return false end
    if not name:match("^[%w_%-]+$") then return false end
    return true
end

function Core.listConfigs()
    if type(isfolder) ~= "function" or type(listfiles) ~= "function" then return {} end
    if not Core.ensureFolder() then return {} end
    local result = {}
    local ok, files = pcall(function() return listfiles(Core.CONFIG_FOLDER) end)
    if not ok or type(files) ~= "table" then return result end
    for _, filePath in ipairs(files) do
        local fileName = tostring(filePath):match("([^/\\]+)$") or tostring(filePath)
        local n = fileName:match("^(.+)%.json$")
        if n then table.insert(result, n) end
    end
    table.sort(result)
    return result
end

function Core.saveConfigAs(name)
    if not Core.isValidConfigName(name) then return false end
    if not Core.ensureFolder() then return false end
    if type(writefile) ~= "function" then return false end
    local data = {}
    for k, v in pairs(Core.settings) do data[k] = v end
    local ok, encoded = pcall(function() return HttpService:JSONEncode(data) end)
    if not ok then return false end
    local path = Core.CONFIG_FOLDER .. "/" .. name .. ".json"
    return pcall(function() writefile(path, encoded) end)
end

function Core.loadConfigFrom(name)
    if not Core.isValidConfigName(name) then return false end
    if type(isfile) ~= "function" or type(readfile) ~= "function" then return false end
    local path = Core.CONFIG_FOLDER .. "/" .. name .. ".json"
    if not isfile(path) then return false end
    local ok, contents = pcall(function() return readfile(path) end)
    if not ok then return false end
    local ok2, decoded = pcall(function() return HttpService:JSONDecode(contents) end)
    if not ok2 or type(decoded) ~= "table" then return false end
    for k, v in pairs(decoded) do
        if Core.settings[k] ~= nil and type(Core.settings[k]) == type(v) then
            Core.settings[k] = v
            Core.saveSetting(k, v)
        end
    end
    return true
end

function Core.deleteConfig(name)
    if not Core.isValidConfigName(name) then return false end
    if type(delfile) ~= "function" then return false end
    local path = Core.CONFIG_FOLDER .. "/" .. name .. ".json"
    return pcall(function() delfile(path) end)
end

return Core
