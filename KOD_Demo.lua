--[[
    KOD Library — Demo Script
    Showcases all components and features
    
    Load this AFTER loading KODLibrary.lua
    Usage: paste KODLibrary.lua first, then run this demo
]]

-- ── Load Library ─────────────────────────────────────────
-- In a real script you would do:
-- local KOD = loadstring(game:HttpGet("YOUR_RAW_URL"))()
-- For demo purposes, assume KOD is already in scope.

local KOD = require(script.Parent.KODLibrary) -- adjust path as needed

-- ── Create Window ─────────────────────────────────────────
local Window = KOD:CreateWindow({
    Title      = "KOD Library",
    SubTitle   = "v2.0 — Demo",
    Size       = UDim2.fromOffset(600, 480),
    ToggleKey  = Enum.KeyCode.RightShift,
    Theme      = "Dark",       -- "Dark" | "Crimson" | "Ocean"
    RGB        = true,
    TabWidth   = 158,
})

-- ── Watermark ──────────────────────────────────────────────
local Wm = KOD:SetWatermark({
    Text     = "KOD Library v2.0  |  Demo",
    Position = "TopRight",
})

-- ══════════════════════════════════════════════════════════
--  TAB: Combat
-- ══════════════════════════════════════════════════════════
local CombatTab = Window:CreateTab("⚔  Combat")

-- Section: Aimbot
local AimSection = CombatTab:CreateSection("Aimbot Settings")

local AimbotToggle = AimSection:CreateToggle({
    Label     = "Enable Aimbot",
    Default   = false,
    ConfigKey = "aimbot_enabled",
    Callback  = function(value)
        print("[KOD] Aimbot:", value)
    end,
})

local FOVSlider = AimSection:CreateSlider({
    Label     = "FOV Radius",
    Min       = 10,
    Max       = 360,
    Default   = 90,
    Step      = 5,
    Suffix    = "°",
    ConfigKey = "aimbot_fov",
    Callback  = function(value)
        print("[KOD] FOV:", value)
    end,
})

local SmoothSlider = AimSection:CreateSlider({
    Label     = "Smoothness",
    Min       = 1,
    Max       = 100,
    Default   = 30,
    Suffix    = "%",
    ConfigKey = "aimbot_smooth",
    Callback  = function(value)
        print("[KOD] Smooth:", value)
    end,
})

local BoneDrop = AimSection:CreateDropdown({
    Label     = "Target Bone",
    Options   = { "Head", "HumanoidRootPart", "UpperTorso", "LeftArm", "RightArm" },
    Default   = "Head",
    ConfigKey = "aimbot_bone",
    Callback  = function(value)
        print("[KOD] Bone:", value)
    end,
})

local AimKey = AimSection:CreateKeybind({
    Label     = "Aim Key",
    Default   = Enum.KeyCode.Q,
    ConfigKey = "aimbot_key",
    Callback  = function(key)
        print("[KOD] Aim key set to:", key.Name)
    end,
    OnPressed = function()
        print("[KOD] Aim key held")
    end,
})

-- Section: Triggerbot
local TriggerSection = CombatTab:CreateSection("Triggerbot")

TriggerSection:CreateToggle({
    Label     = "Enable Triggerbot",
    Default   = false,
    ConfigKey = "trigger_enabled",
    Callback  = function(v) print("[KOD] Trigger:", v) end,
})

TriggerSection:CreateSlider({
    Label    = "Reaction Delay",
    Min      = 0,
    Max      = 500,
    Default  = 80,
    Step     = 10,
    Suffix   = "ms",
    Callback = function(v) print("[KOD] Delay:", v) end,
})

TriggerSection:CreateSeparator("Team Check")

TriggerSection:CreateToggle({
    Label    = "Team Check",
    Default  = true,
    Callback = function(v) end,
})

-- ══════════════════════════════════════════════════════════
--  TAB: Visuals
-- ══════════════════════════════════════════════════════════
local VisualsTab = Window:CreateTab("👁  Visuals")

local ESPSection = VisualsTab:CreateSection("ESP Settings")

ESPSection:CreateToggle({
    Label     = "Player ESP",
    Default   = false,
    ConfigKey = "esp_enabled",
    Callback  = function(v) print("[KOD] ESP:", v) end,
})

ESPSection:CreateColorPicker({
    Label    = "ESP Color",
    Default  = Color3.fromRGB(220, 30, 60),
    ConfigKey = "esp_color",
    Callback = function(color)
        print("[KOD] ESP Color:", color)
    end,
})

ESPSection:CreateMultiDropdown({
    Label    = "Show Info",
    Options  = { "Name", "Health", "Distance", "Weapon", "Skeleton" },
    Default  = { "Name", "Health" },
    Callback = function(selected)
        print("[KOD] ESP info:", table.concat(selected, ", "))
    end,
})

ESPSection:CreateSlider({
    Label    = "Max Distance",
    Min      = 50,
    Max      = 2000,
    Default  = 500,
    Step     = 50,
    Suffix   = " studs",
    Callback = function(v) print("[KOD] ESP Distance:", v) end,
})

local ChamsSection = VisualsTab:CreateSection("Chams")

ChamsSection:CreateToggle({
    Label    = "Enable Chams",
    Default  = false,
    Callback = function(v) end,
})

ChamsSection:CreateDropdown({
    Label    = "Chams Style",
    Options  = { "Flat", "Shiny", "Glass", "Neon" },
    Default  = "Flat",
    Callback = function(v) end,
})

ChamsSection:CreateColorPicker({
    Label    = "Visible Color",
    Default  = Color3.fromRGB(30, 200, 100),
    Callback = function(c) end,
})

ChamsSection:CreateColorPicker({
    Label    = "Hidden Color",
    Default  = Color3.fromRGB(200, 30, 60),
    Callback = function(c) end,
})

-- ══════════════════════════════════════════════════════════
--  TAB: Movement
-- ══════════════════════════════════════════════════════════
local MovTab = Window:CreateTab("🏃  Movement")

local SpeedSection = MovTab:CreateSection("Speed")

SpeedSection:CreateToggle({
    Label    = "Speed Hack",
    Default  = false,
    Callback = function(v) end,
})

SpeedSection:CreateSlider({
    Label    = "Walk Speed",
    Min      = 16,
    Max      = 500,
    Default  = 16,
    Step     = 4,
    Callback = function(v)
        if game.Players.LocalPlayer.Character then
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end,
})

SpeedSection:CreateSlider({
    Label    = "Jump Power",
    Min      = 50,
    Max      = 1000,
    Default  = 50,
    Step     = 10,
    Callback = function(v)
        if game.Players.LocalPlayer.Character then
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = v end
        end
    end,
})

local FlySection = MovTab:CreateSection("Fly")

FlySection:CreateToggle({
    Label    = "Fly",
    Default  = false,
    Callback = function(v) print("[KOD] Fly:", v) end,
})

FlySection:CreateSlider({
    Label    = "Fly Speed",
    Min      = 10,
    Max      = 300,
    Default  = 60,
    Callback = function(v) end,
})

FlySection:CreateKeybind({
    Label    = "Fly Toggle Key",
    Default  = Enum.KeyCode.F,
    Callback = function(k) end,
})

-- ══════════════════════════════════════════════════════════
--  TAB: Player
-- ══════════════════════════════════════════════════════════
local PlayerTab = Window:CreateTab("👤  Player")

local GodSection = PlayerTab:CreateSection("God Mode")

GodSection:CreateToggle({
    Label    = "God Mode",
    Default  = false,
    Tooltip  = "Makes you invincible.",
    Callback = function(v) print("[KOD] God:", v) end,
})

GodSection:CreateButton({
    Label       = "Reset Character",
    ButtonLabel = "Reset",
    Callback    = function()
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:BreakJoints()
        end
    end,
})

GodSection:CreateButton({
    Label       = "Respawn",
    ButtonLabel = "Respawn",
    Callback    = function()
        game.Players.LocalPlayer:LoadCharacter()
    end,
})

local PlayerInfoSection = PlayerTab:CreateSection("Info")

PlayerInfoSection:CreateLabel("Player: " .. game.Players.LocalPlayer.Name, Color3.fromRGB(200, 200, 220))
PlayerInfoSection:CreateLabel("User ID: " .. tostring(game.Players.LocalPlayer.UserId), Color3.fromRGB(160, 160, 185))
PlayerInfoSection:CreateLabel("Account Age: " .. tostring(game.Players.LocalPlayer.AccountAge) .. " days", Color3.fromRGB(160, 160, 185))
PlayerInfoSection:CreateSeparator()
PlayerInfoSection:CreateLabel("Game: " .. tostring(game.PlaceId), Color3.fromRGB(140, 140, 165))

-- ══════════════════════════════════════════════════════════
--  TAB: Misc
-- ══════════════════════════════════════════════════════════
local MiscTab = Window:CreateTab("⚙  Misc")

local UISection = MiscTab:CreateSection("Interface")

UISection:CreateDropdown({
    Label    = "Theme",
    Options  = { "Dark", "Crimson", "Ocean" },
    Default  = "Dark",
    Callback = function(v)
        KOD:Notify({ Title = "Theme", Message = "Theme changed to " .. v, Type = "Info", Duration = 3 })
    end,
})

UISection:CreateToggle({
    Label    = "RGB Mode",
    Default  = true,
    Callback = function(v)
        for _, w in pairs(KOD._windows) do
            w._rgbEnabled = v
        end
    end,
})

UISection:CreateSeparator("Watermark")

UISection:CreateTextBox({
    Label       = "Watermark Text",
    Placeholder = "Enter watermark text...",
    Default     = "KOD Library v2.0  |  Demo",
    Callback    = function(text)
        Wm:SetText(text)
    end,
})

local ConfigSection = MiscTab:CreateSection("Configuration")

ConfigSection:CreateTextBox({
    Label       = "Config Name",
    Placeholder = "my_config",
    Default     = "default",
    ConfigKey   = "_config_name",
})

ConfigSection:CreateButton({
    Label       = "Save Config",
    ButtonLabel = "Save",
    Callback    = function()
        local name = KOD._config:Get("_config_name") or "default"
        local ok = KOD:SaveConfig(name)
        if ok then
            KOD:Notify({ Title = "Config", Message = "Saved as: " .. name, Type = "Success" })
        else
            KOD:Notify({ Title = "Config", Message = "Save failed (executor may not support writefile)", Type = "Warning" })
        end
    end,
})

ConfigSection:CreateButton({
    Label       = "Load Config",
    ButtonLabel = "Load",
    Callback    = function()
        local name = KOD._config:Get("_config_name") or "default"
        local ok = KOD:LoadConfig(name)
        if ok then
            KOD:Notify({ Title = "Config", Message = "Loaded: " .. name, Type = "Success" })
        else
            KOD:Notify({ Title = "Config", Message = "Config not found: " .. name, Type = "Error" })
        end
    end,
})

local NotifSection = MiscTab:CreateSection("Notification Test")

NotifSection:CreateButton({
    Label       = "Test Success",
    ButtonLabel = "Fire",
    Callback    = function()
        KOD:Notify({ Title = "Success", Message = "Operation completed successfully.", Type = "Success", Duration = 4 })
    end,
})
NotifSection:CreateButton({
    Label       = "Test Warning",
    ButtonLabel = "Fire",
    Callback    = function()
        KOD:Notify({ Title = "Warning", Message = "Something may not be working correctly.", Type = "Warning", Duration = 4 })
    end,
})
NotifSection:CreateButton({
    Label       = "Test Error",
    ButtonLabel = "Fire",
    Callback    = function()
        KOD:Notify({ Title = "Error", Message = "Something went wrong. Please try again.", Type = "Error", Duration = 4 })
    end,
})
NotifSection:CreateButton({
    Label       = "Test Info",
    ButtonLabel = "Fire",
    Callback    = function()
        KOD:Notify({ Title = "KOD Library", Message = "Premium UI Framework v2.0 loaded.", Type = "Info", Duration = 4 })
    end,
})

-- ── Welcome Notification ───────────────────────────────────
task.delay(0.8, function()
    KOD:Notify({
        Title    = "KOD Library",
        Message  = "Loaded successfully! Press RightShift to toggle.",
        Type     = "Success",
        Duration = 5,
    })
end)

print("[KOD] Demo script loaded.")
