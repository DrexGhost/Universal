local base = "https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/"

local function fetch(name)
    local ok, code = pcall(function()
        return game:HttpGet(base .. name)
    end)
    if not ok then return nil end
    return code
end

local function compile(code)
    if not code then return nil end
    local fn = loadstring(code)
    return fn
end

local function run(fn, ...)
    if not fn then return nil end
    local ok, result = pcall(fn, ...)
    if not ok then return nil end
    return result
end

local Core = run(compile(fetch("core.lua")))
if not Core then return end

pcall(function() Core.loadSettings() end)

local GUI = run(compile(fetch("gui.lua")), Core)
if not GUI then return end

local Logic = run(compile(fetch("logic.lua")), Core, GUI)
if not Logic then return end

local function loadTab(name)
    local fn = compile(fetch(name))
    if not fn then return end
    local ok, build = pcall(fn, Core, GUI, Logic)
    if not ok then return end
    if type(build) == "function" then
        pcall(build)
    end
end

loadTab("main.lua")
loadTab("esp.lua")
loadTab("movement.lua")
loadTab("settings.lua")

if Core.Watermark then
    pcall(function()
        Core.Watermark.setEnabled(Core.settings.watermark or false)
        Core.Watermark.setScale((Core.settings.watermarkScale or 100) / 100)
    end)
end

pcall(function() GUI.activateFirstTab() end)
pcall(function() GUI.setOpenState(Core.settings.menuOpen) end)
pcall(function() Logic.setupEvents() end)
pcall(function() Logic.startLoop() end)
