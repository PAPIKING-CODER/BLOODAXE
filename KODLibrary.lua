--[[
    ██╗  ██╗ ██████╗ ██████╗     ██╗     ██╗██████╗ ██████╗  █████╗ ██████╗ ██╗   ██╗
    ██║ ██╔╝██╔═══██╗██╔══██╗    ██║     ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
    █████╔╝ ██║   ██║██║  ██║    ██║     ██║██████╔╝██████╔╝███████║██████╔╝ ╚████╔╝ 
    ██╔═██╗ ██║   ██║██║  ██║    ██║     ██║██╔══██╗██╔══██╗██╔══██║██╔══██╗  ╚██╔╝  
    ██║  ██╗╚██████╔╝██████╔╝    ███████╗██║██████╔╝██║  ██║██║  ██║██║  ██║   ██║   
    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
    
    KOD Library v2.0.0
    Premium Roblox UI Framework
    © 2025 KOD Development Team. All rights reserved.
    
    DOCUMENTATION:
    
    -- Load the library
    local KOD = loadstring(game:HttpGet("..."))()
    
    -- Create a window
    local Window = KOD:CreateWindow({
        Title = "My Script",
        SubTitle = "v1.0",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        ToggleKey = Enum.KeyCode.RightShift,
        Theme = "Dark",     -- "Dark" | "Crimson" | "Ocean" | "Custom"
        RGB = true,
    })
    
    -- Create a tab
    local Tab = Window:CreateTab("Combat", "rbxassetid://...")
    
    -- Add components
    Tab:CreateButton({ Label = "Kill All", Callback = function() end })
    Tab:CreateToggle({ Label = "Aimbot", Default = false, Callback = function(v) end })
    Tab:CreateSlider({ Label = "FOV", Min = 0, Max = 360, Default = 90, Callback = function(v) end })
    Tab:CreateDropdown({ Label = "Team", Options = {"Red","Blue"}, Callback = function(v) end })
    Tab:CreateKeybind({ Label = "Trigger Key", Default = Enum.KeyCode.E, Callback = function(v) end })
    Tab:CreateTextBox({ Label = "Player Name", Placeholder = "Enter name...", Callback = function(v) end })
    Tab:CreateColorPicker({ Label = "Color", Default = Color3.fromRGB(220,30,60), Callback = function(v) end })
    Tab:CreateLabel("This is an informational label.")
    Tab:CreateSeparator("Category Name")
    
    -- Notifications
    KOD:Notify({ Title = "KOD", Message = "Loaded!", Duration = 4, Type = "Success" })
    
    -- Config system
    KOD:SaveConfig("MyConfig")
    KOD:LoadConfig("MyConfig")
    
    -- Watermark
    KOD:SetWatermark({ Text = "KOD | My Script v1.0", Position = "TopRight" })
]]

-- ═══════════════════════════════════════════════════════
--  SERVICES
-- ═══════════════════════════════════════════════════════

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local TextService      = game:GetService("TextService")
local CoreGui          = game:GetService("CoreGui")
local HttpService      = game:GetService("HttpService")

local LocalPlayer      = Players.LocalPlayer
local Mouse            = LocalPlayer:GetMouse()
local Camera           = workspace.CurrentCamera

-- ═══════════════════════════════════════════════════════
--  UTILITY MODULE
-- ═══════════════════════════════════════════════════════

local Utility = {}

function Utility.Tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quart,
        easingDirection or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function Utility.Create(class, properties, children)
    local inst = Instance.new(class)
    for k, v in pairs(properties or {}) do
        inst[k] = v
    end
    for _, child in pairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

function Utility.Ripple(button, color)
    local ripple = Utility.Create("Frame", {
        Size = UDim2.fromOffset(0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        ZIndex = button.ZIndex + 5,
        Parent = button,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = ripple })

    local mousePos = UserInputService:GetMouseLocation()
    local buttonPos = button.AbsolutePosition
    local relX = mousePos.X - buttonPos.X
    local relY = mousePos.Y - buttonPos.Y
    ripple.Position = UDim2.fromOffset(relX, relY)

    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
    Utility.Tween(ripple, { Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1 }, 0.5, Enum.EasingStyle.Quad)
    task.delay(0.55, function() ripple:Destroy() end)
end

function Utility.Shadow(parent, radius, transparency)
    local shadow = Utility.Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = transparency or 0.55,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, radius or 20, 1, radius or 20),
        ZIndex = parent.ZIndex - 1,
        Parent = parent,
    })
    return shadow
end

function Utility.RGBColor(t)
    local r = math.abs(math.sin(t * 0.5)) * 220 + 35
    local g = math.abs(math.sin(t * 0.5 + 2.094)) * 60
    local b = math.abs(math.sin(t * 0.5 + 4.189)) * 60
    return Color3.fromRGB(r, g, b)
end

function Utility.Lerp(a, b, t) return a + (b - a) * t end

function Utility.Round(n, dec)
    local mult = 10 ^ (dec or 0)
    return math.floor(n * mult + 0.5) / mult
end

function Utility.GetTextSize(text, fontSize, font, maxWidth)
    return TextService:GetTextSize(text, fontSize, font, Vector2.new(maxWidth or 9999, 9999))
end

function Utility.HSVtoRGB(h, s, v)
    return Color3.fromHSV(h, s, v)
end

-- ═══════════════════════════════════════════════════════
--  THEME MODULE
-- ═══════════════════════════════════════════════════════

local Themes = {
    Dark = {
        Background     = Color3.fromRGB(10,  10,  12),
        Panel          = Color3.fromRGB(16,  16,  20),
        PanelAlt       = Color3.fromRGB(22,  22,  28),
        Border         = Color3.fromRGB(40,  40,  50),
        Accent         = Color3.fromRGB(200, 25,  55),
        AccentDark     = Color3.fromRGB(140, 15,  35),
        AccentGlow     = Color3.fromRGB(255, 40,  80),
        Text           = Color3.fromRGB(240, 240, 248),
        TextMuted      = Color3.fromRGB(140, 140, 160),
        TextDisabled   = Color3.fromRGB(75,  75,  90),
        Success        = Color3.fromRGB(40,  200, 100),
        Warning        = Color3.fromRGB(255, 180, 30),
        Error          = Color3.fromRGB(220, 50,  50),
        Info           = Color3.fromRGB(50,  140, 255),
        Slider         = Color3.fromRGB(28,  28,  36),
        Toggle         = Color3.fromRGB(25,  25,  32),
        Dropdown       = Color3.fromRGB(20,  20,  26),
        Scrollbar      = Color3.fromRGB(50,  50,  65),
        Separator      = Color3.fromRGB(35,  35,  45),
        SideBar        = Color3.fromRGB(13,  13,  17),
        TabActive      = Color3.fromRGB(22,  22,  30),
        TabInactive    = Color3.fromRGB(13,  13,  17),
        Ripple         = Color3.fromRGB(220, 40,  70),
    },
    Crimson = {
        Background     = Color3.fromRGB(8,   6,   8),
        Panel          = Color3.fromRGB(18,  10,  14),
        PanelAlt       = Color3.fromRGB(26,  14,  18),
        Border         = Color3.fromRGB(60,  25,  35),
        Accent         = Color3.fromRGB(220, 20,  60),
        AccentDark     = Color3.fromRGB(160, 10,  35),
        AccentGlow     = Color3.fromRGB(255, 50,  90),
        Text           = Color3.fromRGB(250, 220, 225),
        TextMuted      = Color3.fromRGB(180, 120, 130),
        TextDisabled   = Color3.fromRGB(90,  60,  70),
        Success        = Color3.fromRGB(40,  200, 100),
        Warning        = Color3.fromRGB(255, 180, 30),
        Error          = Color3.fromRGB(220, 50,  50),
        Info           = Color3.fromRGB(50,  140, 255),
        Slider         = Color3.fromRGB(30,  18,  22),
        Toggle         = Color3.fromRGB(28,  15,  20),
        Dropdown       = Color3.fromRGB(24,  13,  18),
        Scrollbar      = Color3.fromRGB(70,  35,  45),
        Separator      = Color3.fromRGB(45,  22,  30),
        SideBar        = Color3.fromRGB(12,  8,   10),
        TabActive      = Color3.fromRGB(26,  15,  20),
        TabInactive    = Color3.fromRGB(12,  8,   10),
        Ripple         = Color3.fromRGB(255, 50,  80),
    },
    Ocean = {
        Background     = Color3.fromRGB(6,   10,  18),
        Panel          = Color3.fromRGB(10,  16,  28),
        PanelAlt       = Color3.fromRGB(14,  22,  36),
        Border         = Color3.fromRGB(25,  45,  80),
        Accent         = Color3.fromRGB(30,  120, 255),
        AccentDark     = Color3.fromRGB(15,  80,  190),
        AccentGlow     = Color3.fromRGB(60,  160, 255),
        Text           = Color3.fromRGB(210, 228, 255),
        TextMuted      = Color3.fromRGB(110, 150, 210),
        TextDisabled   = Color3.fromRGB(55,  80,  120),
        Success        = Color3.fromRGB(40,  200, 100),
        Warning        = Color3.fromRGB(255, 180, 30),
        Error          = Color3.fromRGB(220, 50,  50),
        Info           = Color3.fromRGB(50,  200, 255),
        Slider         = Color3.fromRGB(14,  22,  40),
        Toggle         = Color3.fromRGB(12,  20,  36),
        Dropdown       = Color3.fromRGB(10,  18,  32),
        Scrollbar      = Color3.fromRGB(30,  60,  110),
        Separator      = Color3.fromRGB(18,  35,  65),
        SideBar        = Color3.fromRGB(7,   11,  20),
        TabActive      = Color3.fromRGB(14,  22,  38),
        TabInactive    = Color3.fromRGB(7,   11,  20),
        Ripple         = Color3.fromRGB(50,  140, 255),
    },
}

-- ═══════════════════════════════════════════════════════
--  ANIMATION MODULE
-- ═══════════════════════════════════════════════════════

local Animations = {}

function Animations.SlideIn(frame, direction, duration)
    direction = direction or "Left"
    duration = duration or 0.3
    local originalPos = frame.Position
    local startPos
    if direction == "Left" then
        startPos = UDim2.new(originalPos.X.Scale - 0.05, originalPos.X.Offset - 20, originalPos.Y.Scale, originalPos.Y.Offset)
    elseif direction == "Right" then
        startPos = UDim2.new(originalPos.X.Scale + 0.05, originalPos.X.Offset + 20, originalPos.Y.Scale, originalPos.Y.Offset)
    elseif direction == "Up" then
        startPos = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale - 0.05, originalPos.Y.Offset - 20)
    elseif direction == "Down" then
        startPos = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale + 0.05, originalPos.Y.Offset + 20)
    end
    frame.Position = startPos
    frame.BackgroundTransparency = 1
    Utility.Tween(frame, { Position = originalPos, BackgroundTransparency = frame.BackgroundTransparency > 0 and frame.BackgroundTransparency or 0 }, duration, Enum.EasingStyle.Quart)
end

function Animations.FadeIn(object, targetTransparency, duration)
    object.BackgroundTransparency = 1
    Utility.Tween(object, { BackgroundTransparency = targetTransparency or 0 }, duration or 0.25)
end

function Animations.Scale(object, targetSize, duration)
    Utility.Tween(object, { Size = targetSize }, duration or 0.2, Enum.EasingStyle.Back)
end

function Animations.Bounce(object)
    local origSize = object.Size
    Utility.Tween(object, { Size = UDim2.new(origSize.X.Scale * 0.95, origSize.X.Offset * 0.95, origSize.Y.Scale * 0.95, origSize.Y.Offset * 0.95) }, 0.08)
    task.delay(0.09, function()
        Utility.Tween(object, { Size = origSize }, 0.15, Enum.EasingStyle.Back)
    end)
end

-- ═══════════════════════════════════════════════════════
--  CONFIG SYSTEM
-- ═══════════════════════════════════════════════════════

local ConfigSystem = {}
ConfigSystem._data = {}
ConfigSystem._callbacks = {}

function ConfigSystem:Register(key, callback)
    self._callbacks[key] = callback
end

function ConfigSystem:Set(key, value)
    self._data[key] = value
end

function ConfigSystem:Get(key)
    return self._data[key]
end

function ConfigSystem:Save(name)
    local success, encoded = pcall(HttpService.JSONEncode, HttpService, self._data)
    if not success then return false end
    if writefile then
        pcall(writefile, "KOD_" .. name .. ".json", encoded)
        return true
    end
    return false
end

function ConfigSystem:Load(name)
    if not readfile then return false end
    local success, data = pcall(readfile, "KOD_" .. name .. ".json")
    if not success then return false end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, data)
    if not ok then return false end
    self._data = decoded
    for key, value in pairs(decoded) do
        if self._callbacks[key] then
            pcall(self._callbacks[key], value)
        end
    end
    return true
end

function ConfigSystem:ListConfigs()
    if not listfiles then return {} end
    local configs = {}
    local ok, files = pcall(listfiles, "")
    if not ok then return configs end
    for _, file in ipairs(files) do
        local name = file:match("KOD_(.+)%.json$")
        if name then
            table.insert(configs, name)
        end
    end
    return configs
end

-- ═══════════════════════════════════════════════════════
--  MAIN LIBRARY
-- ═══════════════════════════════════════════════════════

local KOD = {}
KOD.__index = KOD

KOD._version    = "2.0.0"
KOD._windows    = {}
KOD._notifQueue = {}
KOD._rgbTime    = 0
KOD._watermark  = nil
KOD._config     = ConfigSystem
KOD._connections = {}

-- ┌─────────────────────────────────────────┐
-- │  LIBRARY INIT                           │
-- └─────────────────────────────────────────┘

function KOD:Init()
    -- Clean up old GUI
    local existing = CoreGui:FindFirstChild("KODLibrary")
    if existing then existing:Destroy() end

    -- Root ScreenGui
    self._gui = Utility.Create("ScreenGui", {
        Name = "KODLibrary",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
        IgnoreGuiInset = true,
        Parent = (syn and syn.protect_gui) and syn.protect_gui(Instance.new("ScreenGui")) or CoreGui,
    })
    if syn and syn.protect_gui then
        syn.protect_gui(self._gui)
        self._gui.Parent = CoreGui
    end

    -- Notification container
    self._notifContainer = Utility.Create("Frame", {
        Name = "NotifContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20, 1, -20),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.fromOffset(320, 0),
        ZIndex = 9999,
        Parent = self._gui,
    })
    Utility.Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self._notifContainer,
    })

    -- Global RGB loop
    table.insert(self._connections, RunService.Heartbeat:Connect(function(dt)
        self._rgbTime = self._rgbTime + dt
        for _, w in pairs(self._windows) do
            if w._rgbEnabled and w._rgbLine then
                w._rgbLine.BackgroundColor3 = Utility.RGBColor(self._rgbTime)
            end
        end
    end))
end

-- ┌─────────────────────────────────────────┐
-- │  WINDOW                                 │
-- └─────────────────────────────────────────┘

function KOD:CreateWindow(options)
    options = options or {}
    local theme   = Themes[options.Theme] or Themes.Dark
    local size    = options.Size or UDim2.fromOffset(600, 480)
    local title   = options.Title or "KOD Library"
    local subTitle = options.SubTitle or "v2.0"
    local tabWidth = options.TabWidth or 155
    local toggleKey = options.ToggleKey or Enum.KeyCode.RightShift
    local rgbEnabled = options.RGB ~= false

    local Window = {}
    Window._theme = theme
    Window._tabs  = {}
    Window._rgbEnabled = rgbEnabled
    Window._visible = true
    Window._connections = {}
    Window._configKeys = {}

    -- Override theme with custom colors
    if options.CustomTheme then
        for k, v in pairs(options.CustomTheme) do
            theme[k] = v
        end
    end

    -- ── Main Frame ──────────────────────────────────
    local mainFrame = Utility.Create("Frame", {
        Name = "KODWindow",
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = 0.04,
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10,
        Parent = self._gui,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = mainFrame })
    Utility.Create("UIStroke", {
        Color = theme.Border,
        Thickness = 1.2,
        Transparency = 0.4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = mainFrame,
    })
    Utility.Shadow(mainFrame, 40, 0.3)

    -- ── Top Bar ─────────────────────────────────────
    local topBar = Utility.Create("Frame", {
        Name = "TopBar",
        BackgroundColor3 = theme.Panel,
        BackgroundTransparency = 0.08,
        Size = UDim2.new(1, 0, 0, 44),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = mainFrame,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = topBar })

    -- Fix bottom corners of topbar
    Utility.Create("Frame", {
        BackgroundColor3 = theme.Panel,
        BackgroundTransparency = 0.08,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0.5, 0),
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = topBar,
    })

    -- Logo area
    local logoArea = Utility.Create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(0, 44, 1, 0),
        ZIndex = 13,
        Parent = topBar,
    })

    -- KOD Logo icon (stylized K)
    local logoBox = Utility.Create("Frame", {
        BackgroundColor3 = theme.Accent,
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.fromScale(0, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = logoArea,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = logoBox })
    Utility.Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, theme.Accent),
            ColorSequenceKeypoint.new(1, theme.AccentDark),
        }),
        Rotation = 135,
        Parent = logoBox,
    })
    Utility.Create("TextLabel", {
        Text = "K",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 15,
        Parent = logoBox,
    })

    -- Title labels
    local titleLabel = Utility.Create("TextLabel", {
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = theme.Text,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 7),
        Size = UDim2.new(0.5, 0, 0, 16),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = topBar,
    })

    local subLabel = Utility.Create("TextLabel", {
        Text = subTitle,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = theme.TextMuted,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 24),
        Size = UDim2.new(0.5, 0, 0, 13),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = topBar,
    })

    -- Status badge
    local statusBadge = Utility.Create("Frame", {
        BackgroundColor3 = theme.Success,
        Size = UDim2.fromOffset(6, 6),
        Position = UDim2.new(1, -70, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = topBar,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = statusBadge })

    Utility.Create("TextLabel", {
        Text = "ACTIVE",
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = theme.Success,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -60, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(55, 14),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = topBar,
    })

    -- Close / Minimize buttons
    local closeBtn = Utility.Create("TextButton", {
        Text = "✕",
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = theme.TextMuted,
        BackgroundColor3 = Color3.fromRGB(200, 30, 55),
        BackgroundTransparency = 0.6,
        Size = UDim2.fromOffset(22, 22),
        Position = UDim2.new(1, -12, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = topBar,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = closeBtn })

    local minBtn = Utility.Create("TextButton", {
        Text = "−",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = theme.TextMuted,
        BackgroundColor3 = theme.Border,
        BackgroundTransparency = 0.4,
        Size = UDim2.fromOffset(22, 22),
        Position = UDim2.new(1, -38, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = topBar,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = minBtn })

    -- RGB accent line under topbar
    local rgbLine = Utility.Create("Frame", {
        Name = "RGBLine",
        BackgroundColor3 = theme.Accent,
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BorderSizePixel = 0,
        ZIndex = 15,
        Parent = topBar,
    })
    Utility.Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(220, 20, 60)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 60, 100)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(180, 10, 40)),
        }),
        Parent = rgbLine,
    })
    Window._rgbLine = rgbLine

    -- ── Body ────────────────────────────────────────
    local body = Utility.Create("Frame", {
        Name = "Body",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 44),
        Size = UDim2.new(1, 0, 1, -44),
        ZIndex = 10,
        Parent = mainFrame,
    })

    -- ── Left Sidebar ────────────────────────────────
    local sidebar = Utility.Create("Frame", {
        Name = "Sidebar",
        BackgroundColor3 = theme.SideBar,
        BackgroundTransparency = 0.1,
        Size = UDim2.new(0, tabWidth, 1, 0),
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = body,
    })

    -- Sidebar right border
    Utility.Create("Frame", {
        BackgroundColor3 = theme.Border,
        BackgroundTransparency = 0.3,
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = sidebar,
    })

    -- Sidebar user card
    local userCard = Utility.Create("Frame", {
        BackgroundColor3 = theme.Panel,
        BackgroundTransparency = 0.3,
        Size = UDim2.new(1, -12, 0, 52),
        Position = UDim2.fromOffset(6, 8),
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = sidebar,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = userCard })

    -- Avatar placeholder
    local avatar = Utility.Create("ImageLabel", {
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.5,
        Size = UDim2.fromOffset(34, 34),
        Position = UDim2.fromOffset(8, 9),
        BorderSizePixel = 0,
        ZIndex = 13,
        Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png",
        Parent = userCard,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = avatar })
    Utility.Create("UIStroke", { Color = theme.Accent, Thickness = 1.5, Parent = avatar })

    Utility.Create("TextLabel", {
        Text = LocalPlayer.Name,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = theme.Text,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(50, 11),
        Size = UDim2.new(1, -54, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 13,
        Parent = userCard,
    })

    Utility.Create("TextLabel", {
        Text = "KOD Framework",
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextColor3 = theme.Accent,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(50, 26),
        Size = UDim2.new(1, -54, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
        Parent = userCard,
    })

    -- Tab buttons container
    local tabList = Utility.Create("ScrollingFrame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 68),
        Size = UDim2.new(1, 0, 1, -68),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = theme.Scrollbar,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = sidebar,
    })
    Utility.Create("UIListLayout", {
        Padding = UDim.new(0, 3),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabList,
    })
    Utility.Create("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), Parent = tabList })

    -- ── Content area ────────────────────────────────
    local contentArea = Utility.Create("Frame", {
        Name = "ContentArea",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(tabWidth, 0),
        Size = UDim2.new(1, -tabWidth, 1, 0),
        ClipsDescendants = true,
        ZIndex = 10,
        Parent = body,
    })

    -- ── Drag System ─────────────────────────────────
    do
        local dragging, dragInput, dragStart, startPos
        topBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end)
        topBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                             input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                Utility.Tween(mainFrame, {
                    Position = UDim2.new(
                        startPos.X.Scale,
                        startPos.X.Offset + delta.X,
                        startPos.Y.Scale,
                        startPos.Y.Offset + delta.Y
                    )
                }, 0.05, Enum.EasingStyle.Linear)
            end
        end)
    end

    -- ── Button interactions ──────────────────────────
    closeBtn.MouseButton1Click:Connect(function()
        Utility.Tween(mainFrame, { Size = UDim2.fromOffset(size.X.Offset, 0), BackgroundTransparency = 1 }, 0.3, Enum.EasingStyle.Quart)
        task.delay(0.35, function() mainFrame:Destroy() end)
    end)

    closeBtn.MouseEnter:Connect(function()
        Utility.Tween(closeBtn, { BackgroundTransparency = 0.1 }, 0.15)
    end)
    closeBtn.MouseLeave:Connect(function()
        Utility.Tween(closeBtn, { BackgroundTransparency = 0.6 }, 0.15)
    end)

    local minimized = false
    local fullSize = size

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Utility.Tween(mainFrame, { Size = UDim2.fromOffset(fullSize.X.Offset, 44) }, 0.3, Enum.EasingStyle.Quart)
        else
            Utility.Tween(mainFrame, { Size = fullSize }, 0.3, Enum.EasingStyle.Back)
        end
    end)

    -- ── Toggle key ──────────────────────────────────
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == toggleKey then
            Window._visible = not Window._visible
            if Window._visible then
                mainFrame.Visible = true
                Utility.Tween(mainFrame, { BackgroundTransparency = 0.04 }, 0.25)
            else
                Utility.Tween(mainFrame, { BackgroundTransparency = 1 }, 0.25)
                task.delay(0.26, function() mainFrame.Visible = false end)
            end
        end
    end)

    -- ── Opening animation ───────────────────────────
    mainFrame.Size = UDim2.fromOffset(size.X.Offset, 0)
    mainFrame.BackgroundTransparency = 1
    Utility.Tween(mainFrame, { Size = size, BackgroundTransparency = 0.04 }, 0.4, Enum.EasingStyle.Back)

    -- ══════════════════════════════════════════════
    --  CREATE TAB
    -- ══════════════════════════════════════════════

    function Window:CreateTab(label, icon)
        local Tab = {}
        Tab._sections = {}
        Tab._elements = {}
        Tab._active = false

        -- Tab button
        local tabBtn = Utility.Create("TextButton", {
            Text = "",
            BackgroundColor3 = theme.TabInactive,
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, -12, 0, 36),
            BorderSizePixel = 0,
            AutoButtonColor = false,
            ZIndex = 12,
            Parent = tabList,
        })
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = tabBtn })

        -- Accent left bar (active indicator)
        local tabAccent = Utility.Create("Frame", {
            BackgroundColor3 = theme.Accent,
            Size = UDim2.fromOffset(3, 18),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 13,
            Parent = tabBtn,
        })
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = tabAccent })

        -- Icon (optional)
        local iconOffset = 10
        if icon and icon ~= "" then
            local iconLabel = Utility.Create("ImageLabel", {
                BackgroundTransparency = 1,
                Image = icon,
                Size = UDim2.fromOffset(16, 16),
                Position = UDim2.new(0, 10, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                ZIndex = 13,
                Parent = tabBtn,
            })
            iconOffset = 32
        end

        local tabLabel = Utility.Create("TextLabel", {
            Text = label,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextColor3 = theme.TextMuted,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(iconOffset, 0),
            Size = UDim2.new(1, -iconOffset - 6, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 13,
            Parent = tabBtn,
        })

        -- Tab page
        local tabPage = Utility.Create("ScrollingFrame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            CanvasSize = UDim2.fromScale(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = theme.Scrollbar,
            ScrollBarImageTransparency = 0.4,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 10,
            Parent = contentArea,
        })
        Utility.Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = tabPage,
        })
        Utility.Create("UIPadding", {
            PaddingTop    = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft   = UDim.new(0, 12),
            PaddingRight  = UDim.new(0, 12),
            Parent = tabPage,
        })
        Tab._page = tabPage

        local function Activate()
            -- Deactivate all tabs
            for _, t in pairs(Window._tabs) do
                t._active = false
                if t._btn then
                    Utility.Tween(t._btn, { BackgroundColor3 = theme.TabInactive, BackgroundTransparency = 0.2 }, 0.2)
                    Utility.Tween(t._btnLabel, { TextColor3 = theme.TextMuted }, 0.2)
                    t._btnAccent.Visible = false
                end
                if t._page then t._page.Visible = false end
            end
            -- Activate this tab
            Tab._active = true
            Utility.Tween(tabBtn, { BackgroundColor3 = theme.TabActive, BackgroundTransparency = 0.05 }, 0.2)
            Utility.Tween(tabLabel, { TextColor3 = theme.Text }, 0.2)
            tabAccent.Visible = true
            tabPage.Visible = true
            Animations.SlideIn(tabPage, "Left", 0.2)
        end

        Tab._btn = tabBtn
        Tab._btnLabel = tabLabel
        Tab._btnAccent = tabAccent

        tabBtn.MouseButton1Click:Connect(Activate)
        tabBtn.MouseEnter:Connect(function()
            if not Tab._active then
                Utility.Tween(tabBtn, { BackgroundTransparency = 0.08 }, 0.15)
                Utility.Tween(tabLabel, { TextColor3 = theme.Text }, 0.15)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if not Tab._active then
                Utility.Tween(tabBtn, { BackgroundTransparency = 0.2 }, 0.15)
                Utility.Tween(tabLabel, { TextColor3 = theme.TextMuted }, 0.15)
            end
        end)

        -- Auto-activate first tab
        if #Window._tabs == 0 then
            task.defer(Activate)
        end

        table.insert(Window._tabs, Tab)

        -- ════════════════════════════════════════
        --  SECTION
        -- ════════════════════════════════════════

        function Tab:CreateSection(sectionTitle)
            local Section = {}
            Section._elements = {}

            local sectionFrame = Utility.Create("Frame", {
                BackgroundColor3 = theme.Panel,
                BackgroundTransparency = 0.15,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
                ZIndex = 11,
                Parent = tabPage,
            })
            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = sectionFrame })
            Utility.Create("UIStroke", {
                Color = theme.Border,
                Thickness = 1,
                Transparency = 0.5,
                Parent = sectionFrame,
            })

            local sectionLayout = Utility.Create("UIListLayout", {
                Padding = UDim.new(0, 6),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = sectionFrame,
            })
            Utility.Create("UIPadding", {
                PaddingTop    = UDim.new(0, 36),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft   = UDim.new(0, 8),
                PaddingRight  = UDim.new(0, 8),
                Parent = sectionFrame,
            })

            -- Section header
            local headerFrame = Utility.Create("Frame", {
                BackgroundColor3 = theme.Accent,
                BackgroundTransparency = 0.85,
                Size = UDim2.new(1, 0, 0, 28),
                Position = UDim2.fromOffset(0, 0),
                BorderSizePixel = 0,
                ZIndex = 12,
                Parent = sectionFrame,
            })
            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = headerFrame })

            -- Fix bottom corners of header
            Utility.Create("Frame", {
                BackgroundColor3 = theme.Accent,
                BackgroundTransparency = 0.85,
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(1, 0, 0.5, 0),
                BorderSizePixel = 0,
                ZIndex = 11,
                Parent = headerFrame,
            })

            -- Left accent bar
            Utility.Create("Frame", {
                BackgroundColor3 = theme.Accent,
                Size = UDim2.fromOffset(3, 14),
                Position = UDim2.new(0, 10, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BorderSizePixel = 0,
                ZIndex = 13,
                Parent = headerFrame,
            })

            Utility.Create("TextLabel", {
                Text = sectionTitle or "Section",
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = theme.Text,
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(20, 0),
                Size = UDim2.new(1, -20, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 13,
                Parent = headerFrame,
            })

            Section._frame = sectionFrame
            Section._parent = tabPage

            -- ════════════════════════════════════════
            --  COMPONENTS
            -- ════════════════════════════════════════

            local function MakeElement(height)
                local el = Utility.Create("Frame", {
                    BackgroundColor3 = theme.PanelAlt,
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(1, 0, 0, height or 40),
                    BorderSizePixel = 0,
                    ZIndex = 12,
                    Parent = sectionFrame,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = el })
                return el
            end

            -- ── BUTTON ───────────────────────────────
            function Section:CreateButton(opts)
                opts = opts or {}
                local el = MakeElement(38)

                local btn = Utility.Create("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 13,
                    Parent = el,
                })

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Button",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -80, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 14,
                    Parent = el,
                })

                -- Execute button
                local execBtn = Utility.Create("TextButton", {
                    Text = opts.ButtonLabel or "Execute",
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = theme.Accent,
                    Size = UDim2.fromOffset(70, 24),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 14,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = execBtn })
                Utility.Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, theme.Accent),
                        ColorSequenceKeypoint.new(1, theme.AccentDark),
                    }),
                    Rotation = 90,
                    Parent = execBtn,
                })

                execBtn.MouseEnter:Connect(function()
                    Utility.Tween(execBtn, { BackgroundColor3 = theme.AccentGlow }, 0.15)
                end)
                execBtn.MouseLeave:Connect(function()
                    Utility.Tween(execBtn, { BackgroundColor3 = theme.Accent }, 0.15)
                end)
                execBtn.MouseButton1Click:Connect(function()
                    Utility.Ripple(execBtn, theme.Ripple)
                    Animations.Bounce(execBtn)
                    if opts.Callback then pcall(opts.Callback) end
                end)

                -- Tooltip
                if opts.Tooltip then
                    el.MouseEnter:Connect(function()
                        KOD:_ShowTooltip(opts.Tooltip, el)
                    end)
                    el.MouseLeave:Connect(function()
                        KOD:_HideTooltip()
                    end)
                end

                return {
                    SetLabel = function(_, text)
                        el:FindFirstChildOfClass("TextLabel").Text = text
                    end,
                }
            end

            -- ── TOGGLE ───────────────────────────────
            function Section:CreateToggle(opts)
                opts = opts or {}
                local el = MakeElement(38)
                local value = opts.Default or false

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Toggle",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -60, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local trackBg = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Slider,
                    Size = UDim2.fromOffset(40, 22),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    ZIndex = 13,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = trackBg })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Parent = trackBg })

                local knob = Utility.Create("Frame", {
                    BackgroundColor3 = theme.TextMuted,
                    Size = UDim2.fromOffset(16, 16),
                    Position = UDim2.fromOffset(3, 3),
                    BorderSizePixel = 0,
                    ZIndex = 14,
                    Parent = trackBg,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

                local function UpdateVisual(val, instant)
                    local dur = instant and 0 or 0.2
                    if val then
                        Utility.Tween(trackBg, { BackgroundColor3 = theme.Accent }, dur)
                        Utility.Tween(knob, { Position = UDim2.fromOffset(21, 3), BackgroundColor3 = Color3.fromRGB(255, 255, 255) }, dur)
                    else
                        Utility.Tween(trackBg, { BackgroundColor3 = theme.Slider }, dur)
                        Utility.Tween(knob, { Position = UDim2.fromOffset(3, 3), BackgroundColor3 = theme.TextMuted }, dur)
                    end
                end

                UpdateVisual(value, true)

                local clickBtn = Utility.Create("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 15,
                    Parent = el,
                })
                clickBtn.MouseButton1Click:Connect(function()
                    value = not value
                    UpdateVisual(value)
                    if opts.Callback then pcall(opts.Callback, value) end
                    if opts.ConfigKey then
                        KOD._config:Set(opts.ConfigKey, value)
                    end
                end)

                if opts.ConfigKey then
                    KOD._config:Register(opts.ConfigKey, function(v)
                        value = v
                        UpdateVisual(v, true)
                    end)
                end

                return {
                    Set = function(_, val)
                        value = val
                        UpdateVisual(val)
                        if opts.Callback then pcall(opts.Callback, val) end
                    end,
                    Get = function() return value end,
                }
            end

            -- ── SLIDER ───────────────────────────────
            function Section:CreateSlider(opts)
                opts = opts or {}
                local el = MakeElement(52)
                local min     = opts.Min     or 0
                local max     = opts.Max     or 100
                local default = opts.Default or min
                local step    = opts.Step    or 1
                local value   = math.clamp(default, min, max)

                local topRow = Utility.Create("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 22),
                    Position = UDim2.fromOffset(0, 4),
                    ZIndex = 13,
                    Parent = el,
                })

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Slider",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 14,
                    Parent = topRow,
                })

                local valueLabel = Utility.Create("TextLabel", {
                    Text = tostring(value) .. (opts.Suffix or ""),
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    TextColor3 = theme.Accent,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -12, 0, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    Size = UDim2.new(0.3, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex = 14,
                    Parent = topRow,
                })

                -- Track
                local track = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Slider,
                    Size = UDim2.new(1, -24, 0, 6),
                    Position = UDim2.new(0, 12, 1, -14),
                    BorderSizePixel = 0,
                    ZIndex = 13,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

                local fill = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Accent,
                    Size = UDim2.fromScale(0, 1),
                    BorderSizePixel = 0,
                    ZIndex = 14,
                    Parent = track,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })
                Utility.Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, theme.Accent),
                        ColorSequenceKeypoint.new(1, theme.AccentDark),
                    }),
                    Parent = fill,
                })

                local knob = Utility.Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.fromOffset(14, 14),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    ZIndex = 15,
                    Parent = track,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })
                Utility.Create("UIStroke", { Color = theme.Accent, Thickness = 2, Parent = knob })

                local function UpdateSlider(val, instant)
                    val = math.clamp(val, min, max)
                    if step > 0 then
                        val = Utility.Round(math.floor((val - min) / step + 0.5) * step + min, 10)
                    end
                    value = val
                    local pct = (value - min) / (max - min)
                    local dur = instant and 0 or 0.08
                    Utility.Tween(fill, { Size = UDim2.fromScale(pct, 1) }, dur, Enum.EasingStyle.Linear)
                    Utility.Tween(knob, { Position = UDim2.fromScale(pct, 0.5) }, dur, Enum.EasingStyle.Linear)
                    valueLabel.Text = tostring(value) .. (opts.Suffix or "")
                end

                UpdateSlider(value, true)

                local dragging = false
                knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or
                       input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or
                       input.UserInputType == Enum.UserInputType.Touch then
                        if dragging then
                            dragging = false
                            if opts.Callback then pcall(opts.Callback, value) end
                            if opts.ConfigKey then KOD._config:Set(opts.ConfigKey, value) end
                        end
                    end
                end)
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                        UpdateSlider(min + rel * (max - min))
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                        UpdateSlider(min + rel * (max - min))
                    end
                end)

                if opts.ConfigKey then
                    KOD._config:Register(opts.ConfigKey, function(v)
                        UpdateSlider(v, true)
                    end)
                end

                return {
                    Set = function(_, val)
                        UpdateSlider(val, false)
                        if opts.Callback then pcall(opts.Callback, val) end
                    end,
                    Get = function() return value end,
                }
            end

            -- ── DROPDOWN ─────────────────────────────
            function Section:CreateDropdown(opts)
                opts = opts or {}
                local el = MakeElement(38)
                local selected = opts.Default or nil
                local isOpen = false

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Dropdown",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.5, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local dropBtn = Utility.Create("TextButton", {
                    Text = "",
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0.48, 0, 0, 26),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 14,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = dropBtn })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.4, Parent = dropBtn })

                local selectedLabel = Utility.Create("TextLabel", {
                    Text = selected or "Select...",
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextColor3 = selected and theme.Text or theme.TextMuted,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(8, 0),
                    Size = UDim2.new(1, -26, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 15,
                    Parent = dropBtn,
                })

                -- Arrow
                local arrow = Utility.Create("TextLabel", {
                    Text = "▾",
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextColor3 = theme.TextMuted,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -4, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Size = UDim2.fromOffset(20, 20),
                    ZIndex = 15,
                    Parent = dropBtn,
                })

                -- Dropdown list (absolute positioned)
                local dropList = Utility.Create("ScrollingFrame", {
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.02,
                    Size = UDim2.new(0.48, 0, 0, 0),
                    Position = UDim2.new(1, -10, 1, 4),
                    AnchorPoint = Vector2.new(1, 0),
                    BorderSizePixel = 0,
                    ZIndex = 50,
                    Visible = false,
                    CanvasSize = UDim2.fromScale(0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = theme.Scrollbar,
                    ClipsDescendants = true,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = dropList })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.3, Parent = dropList })
                Utility.Create("UIListLayout", {
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = dropList,
                })
                Utility.Create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), Parent = dropList })

                local function Populate(options)
                    for _, child in pairs(dropList:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    for _, opt in ipairs(options or opts.Options or {}) do
                        local optBtn = Utility.Create("TextButton", {
                            Text = tostring(opt),
                            Font = Enum.Font.Gotham,
                            TextSize = 11,
                            TextColor3 = tostring(opt) == tostring(selected) and theme.Accent or theme.Text,
                            BackgroundColor3 = theme.PanelAlt,
                            BackgroundTransparency = tostring(opt) == tostring(selected) and 0.5 or 0.85,
                            Size = UDim2.new(1, 0, 0, 28),
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                            ZIndex = 51,
                            Parent = dropList,
                        })
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = optBtn })

                        optBtn.MouseEnter:Connect(function()
                            Utility.Tween(optBtn, { BackgroundTransparency = 0.4, TextColor3 = theme.Text }, 0.1)
                        end)
                        optBtn.MouseLeave:Connect(function()
                            Utility.Tween(optBtn, { BackgroundTransparency = tostring(opt) == tostring(selected) and 0.5 or 0.85 }, 0.1)
                        end)
                        optBtn.MouseButton1Click:Connect(function()
                            selected = opt
                            selectedLabel.Text = tostring(opt)
                            selectedLabel.TextColor3 = theme.Text
                            isOpen = false
                            Utility.Tween(dropList, { Size = UDim2.new(0.48, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
                            task.delay(0.22, function() dropList.Visible = false end)
                            Utility.Tween(arrow, { Rotation = 0 }, 0.2)
                            if opts.Callback then pcall(opts.Callback, opt) end
                            if opts.ConfigKey then KOD._config:Set(opts.ConfigKey, opt) end
                            Populate()
                        end)
                    end
                end

                Populate()

                local maxH = math.min(#(opts.Options or {}) * 32 + 12, 180)
                dropBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    if isOpen then
                        dropList.Visible = true
                        dropList.Size = UDim2.new(0.48, 0, 0, 0)
                        Utility.Tween(dropList, { Size = UDim2.new(0.48, 0, 0, maxH) }, 0.25, Enum.EasingStyle.Back)
                        Utility.Tween(arrow, { Rotation = 180 }, 0.2)
                    else
                        Utility.Tween(dropList, { Size = UDim2.new(0.48, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
                        task.delay(0.22, function() dropList.Visible = false end)
                        Utility.Tween(arrow, { Rotation = 0 }, 0.2)
                    end
                end)

                if opts.ConfigKey then
                    KOD._config:Register(opts.ConfigKey, function(v)
                        selected = v
                        selectedLabel.Text = tostring(v)
                        selectedLabel.TextColor3 = theme.Text
                        Populate()
                    end)
                end

                return {
                    Set = function(_, val)
                        selected = val
                        selectedLabel.Text = tostring(val)
                        selectedLabel.TextColor3 = theme.Text
                        Populate()
                        if opts.Callback then pcall(opts.Callback, val) end
                    end,
                    Get = function() return selected end,
                    Refresh = function(_, newOptions)
                        opts.Options = newOptions
                        Populate(newOptions)
                    end,
                }
            end

            -- ── KEYBIND ──────────────────────────────
            function Section:CreateKeybind(opts)
                opts = opts or {}
                local el = MakeElement(38)
                local bound = opts.Default or Enum.KeyCode.Unknown
                local listening = false

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Keybind",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.6, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local keyBtn = Utility.Create("TextButton", {
                    Text = bound.Name,
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    TextColor3 = theme.Accent,
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0, 80, 0, 24),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 14,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = keyBtn })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.3, Parent = keyBtn })

                keyBtn.MouseButton1Click:Connect(function()
                    listening = true
                    keyBtn.Text = "..."
                    keyBtn.TextColor3 = theme.TextMuted
                    Utility.Tween(keyBtn, { BackgroundColor3 = theme.Accent, BackgroundTransparency = 0.6 }, 0.15)
                end)

                UserInputService.InputBegan:Connect(function(input, processed)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        listening = false
                        bound = input.KeyCode
                        keyBtn.Text = bound.Name
                        keyBtn.TextColor3 = theme.Accent
                        Utility.Tween(keyBtn, { BackgroundColor3 = theme.Dropdown, BackgroundTransparency = 0.1 }, 0.15)
                        if opts.Callback then pcall(opts.Callback, bound) end
                        if opts.ConfigKey then KOD._config:Set(opts.ConfigKey, bound.Name) end
                    elseif not processed and input.KeyCode == bound and not listening then
                        if opts.OnPressed then pcall(opts.OnPressed) end
                    end
                end)

                return {
                    Get = function() return bound end,
                    Set = function(_, key)
                        bound = key
                        keyBtn.Text = key.Name
                    end,
                }
            end

            -- ── TEXTBOX ──────────────────────────────
            function Section:CreateTextBox(opts)
                opts = opts or {}
                local el = MakeElement(38)

                Utility.Create("TextLabel", {
                    Text = opts.Label or "TextBox",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.4, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local boxBg = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0.55, 0, 0, 26),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    ZIndex = 13,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = boxBg })
                local stroke = Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.4, Parent = boxBg })

                local box = Utility.Create("TextBox", {
                    Text = opts.Default or "",
                    PlaceholderText = opts.Placeholder or "Type here...",
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextColor3 = theme.Text,
                    PlaceholderColor3 = theme.TextDisabled,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -12, 1, 0),
                    Position = UDim2.fromOffset(6, 0),
                    ClearTextOnFocus = opts.ClearOnFocus or false,
                    ZIndex = 14,
                    Parent = boxBg,
                })

                box.Focused:Connect(function()
                    Utility.Tween(stroke, { Color = theme.Accent, Transparency = 0 }, 0.2)
                end)
                box.FocusLost:Connect(function(entered)
                    Utility.Tween(stroke, { Color = theme.Border, Transparency = 0.4 }, 0.2)
                    if opts.Callback then pcall(opts.Callback, box.Text) end
                    if opts.ConfigKey then KOD._config:Set(opts.ConfigKey, box.Text) end
                end)

                return {
                    Get = function() return box.Text end,
                    Set = function(_, text) box.Text = text end,
                }
            end

            -- ── COLOR PICKER ─────────────────────────
            function Section:CreateColorPicker(opts)
                opts = opts or {}
                local el = MakeElement(38)
                local currentColor = opts.Default or Color3.fromRGB(220, 30, 60)
                local pickerOpen = false

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Color",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local preview = Utility.Create("TextButton", {
                    Text = "",
                    BackgroundColor3 = currentColor,
                    Size = UDim2.fromOffset(32, 22),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 14,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = preview })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1.5, Parent = preview })

                -- Color picker popup
                local picker = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Panel,
                    BackgroundTransparency = 0.05,
                    Size = UDim2.fromOffset(200, 180),
                    Position = UDim2.new(1, -10, 1, 8),
                    AnchorPoint = Vector2.new(1, 0),
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 60,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = picker })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.3, Parent = picker })

                -- Hue/Saturation canvas
                local hsvCanvas = Utility.Create("ImageLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                    Image = "rbxassetid://698052951",
                    Size = UDim2.new(1, -16, 0, 100),
                    Position = UDim2.fromOffset(8, 8),
                    BorderSizePixel = 0,
                    ZIndex = 61,
                    Parent = picker,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = hsvCanvas })

                local h, s, v = Color3.toHSV(currentColor)

                -- Hue bar
                local hueBar = Utility.Create("ImageLabel", {
                    Image = "rbxassetid://698053051",
                    Size = UDim2.new(1, -16, 0, 14),
                    Position = UDim2.fromOffset(8, 116),
                    BorderSizePixel = 0,
                    ZIndex = 61,
                    Parent = picker,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = hueBar })

                local hueKnob = Utility.Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Size = UDim2.fromOffset(10, 18),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(h, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    ZIndex = 62,
                    Parent = hueBar,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = hueKnob })
                Utility.Create("UIStroke", { Color = Color3.fromRGB(0,0,0), Thickness = 1.5, Parent = hueKnob })

                local svKnob = Utility.Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Size = UDim2.fromOffset(12, 12),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(s, 0, 1 - v, 0),
                    BorderSizePixel = 0,
                    ZIndex = 62,
                    Parent = hsvCanvas,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = svKnob })
                Utility.Create("UIStroke", { Color = Color3.fromRGB(0,0,0), Thickness = 1.5, Parent = svKnob })

                local hexBox = Utility.Create("TextBox", {
                    Text = string.format("#%02X%02X%02X", currentColor.R*255, currentColor.G*255, currentColor.B*255),
                    Font = Enum.Font.GothamMono,
                    TextSize = 11,
                    TextColor3 = theme.Text,
                    BackgroundColor3 = theme.PanelAlt,
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(1, -16, 0, 26),
                    Position = UDim2.fromOffset(8, 138),
                    BorderSizePixel = 0,
                    ZIndex = 61,
                    Parent = picker,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = hexBox })

                local function UpdateColor()
                    currentColor = Color3.fromHSV(h, s, v)
                    preview.BackgroundColor3 = currentColor
                    hsvCanvas.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    hexBox.Text = string.format("#%02X%02X%02X", math.floor(currentColor.R*255), math.floor(currentColor.G*255), math.floor(currentColor.B*255))
                    if opts.Callback then pcall(opts.Callback, currentColor) end
                end

                local draggingHSV, draggingHue = false, false
                hsvCanvas.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingHSV = true end
                end)
                hueBar.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = true end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingHSV = false; draggingHue = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseMovement then
                        if draggingHSV then
                            s = math.clamp((inp.Position.X - hsvCanvas.AbsolutePosition.X) / hsvCanvas.AbsoluteSize.X, 0, 1)
                            v = 1 - math.clamp((inp.Position.Y - hsvCanvas.AbsolutePosition.Y) / hsvCanvas.AbsoluteSize.Y, 0, 1)
                            svKnob.Position = UDim2.new(s, 0, 1 - v, 0)
                            UpdateColor()
                        elseif draggingHue then
                            h = math.clamp((inp.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                            hueKnob.Position = UDim2.new(h, 0, 0.5, 0)
                            UpdateColor()
                        end
                    end
                end)

                preview.MouseButton1Click:Connect(function()
                    pickerOpen = not pickerOpen
                    picker.Visible = pickerOpen
                    if pickerOpen then
                        Animations.FadeIn(picker, 0.05, 0.2)
                    end
                end)

                return {
                    Get = function() return currentColor end,
                    Set = function(_, col)
                        currentColor = col
                        preview.BackgroundColor3 = col
                        h, s, v = Color3.toHSV(col)
                    end,
                }
            end

            -- ── LABEL ────────────────────────────────
            function Section:CreateLabel(text, color)
                local el = MakeElement(28)
                el.BackgroundTransparency = 1

                Utility.Create("TextLabel", {
                    Text = text or "",
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextColor3 = color or theme.TextMuted,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -24, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 13,
                    Parent = el,
                })

                return {
                    Set = function(_, t) el:FindFirstChildOfClass("TextLabel").Text = t end,
                }
            end

            -- ── SEPARATOR ────────────────────────────
            function Section:CreateSeparator(label)
                local el = MakeElement(24)
                el.BackgroundTransparency = 1

                local line = Utility.Create("Frame", {
                    BackgroundColor3 = theme.Separator,
                    Size = UDim2.new(1, -24, 0, 1),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BorderSizePixel = 0,
                    ZIndex = 13,
                    Parent = el,
                })

                if label then
                    local textSize = Utility.GetTextSize(label, 10, Enum.Font.GothamBold)
                    local gap = textSize.X + 16

                    local labelBg = Utility.Create("Frame", {
                        BackgroundColor3 = theme.Panel,
                        BackgroundTransparency = 0.1,
                        Size = UDim2.fromOffset(gap, 18),
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BorderSizePixel = 0,
                        ZIndex = 14,
                        Parent = el,
                    })
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = labelBg })
                    Utility.Create("TextLabel", {
                        Text = label,
                        Font = Enum.Font.GothamBold,
                        TextSize = 10,
                        TextColor3 = theme.TextMuted,
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 15,
                        Parent = labelBg,
                    })
                end

                return {}
            end

            -- ── MULTI DROPDOWN ───────────────────────
            function Section:CreateMultiDropdown(opts)
                opts = opts or {}
                local el = MakeElement(38)
                local selected = {}
                for _, v in ipairs(opts.Default or {}) do selected[v] = true end
                local isOpen = false

                Utility.Create("TextLabel", {
                    Text = opts.Label or "Multi Select",
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.45, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 13,
                    Parent = el,
                })

                local dropBtn = Utility.Create("TextButton", {
                    Text = "",
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0.52, 0, 0, 26),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 14,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = dropBtn })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.4, Parent = dropBtn })

                local function GetSelectedText()
                    local t = {}
                    for k, v in pairs(selected) do if v then table.insert(t, k) end end
                    return #t == 0 and "Select..." or table.concat(t, ", ")
                end

                local selLabel = Utility.Create("TextLabel", {
                    Text = GetSelectedText(),
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    TextColor3 = theme.Text,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(6, 0),
                    Size = UDim2.new(1, -24, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 15,
                    Parent = dropBtn,
                })
                Utility.Create("TextLabel", {
                    Text = "▾",
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextColor3 = theme.TextMuted,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -4, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Size = UDim2.fromOffset(20, 20),
                    ZIndex = 15,
                    Parent = dropBtn,
                })

                local dropList = Utility.Create("ScrollingFrame", {
                    BackgroundColor3 = theme.Dropdown,
                    BackgroundTransparency = 0.02,
                    Size = UDim2.new(0.52, 0, 0, 0),
                    Position = UDim2.new(1, -10, 1, 4),
                    AnchorPoint = Vector2.new(1, 0),
                    BorderSizePixel = 0,
                    ZIndex = 50,
                    Visible = false,
                    CanvasSize = UDim2.fromScale(0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    ClipsDescendants = true,
                    Parent = el,
                })
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = dropList })
                Utility.Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.3, Parent = dropList })
                Utility.Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = dropList })
                Utility.Create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), Parent = dropList })

                for _, opt in ipairs(opts.Options or {}) do
                    local optBtn = Utility.Create("TextButton", {
                        Text = "",
                        BackgroundColor3 = theme.PanelAlt,
                        BackgroundTransparency = selected[opt] and 0.4 or 0.85,
                        Size = UDim2.new(1, 0, 0, 26),
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        ZIndex = 51,
                        Parent = dropList,
                    })
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = optBtn })

                    local checkmark = Utility.Create("Frame", {
                        BackgroundColor3 = selected[opt] and theme.Accent or theme.Border,
                        Size = UDim2.fromOffset(14, 14),
                        Position = UDim2.fromOffset(6, 6),
                        BorderSizePixel = 0,
                        ZIndex = 52,
                        Parent = optBtn,
                    })
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = checkmark })
                    if selected[opt] then
                        Utility.Create("TextLabel", {
                            Text = "✓",
                            Font = Enum.Font.GothamBold,
                            TextSize = 10,
                            TextColor3 = Color3.fromRGB(255,255,255),
                            BackgroundTransparency = 1,
                            Size = UDim2.fromScale(1,1),
                            ZIndex = 53,
                            Parent = checkmark,
                        })
                    end

                    Utility.Create("TextLabel", {
                        Text = tostring(opt),
                        Font = Enum.Font.Gotham,
                        TextSize = 11,
                        TextColor3 = theme.Text,
                        BackgroundTransparency = 1,
                        Position = UDim2.fromOffset(26, 0),
                        Size = UDim2.new(1, -26, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 52,
                        Parent = optBtn,
                    })

                    optBtn.MouseButton1Click:Connect(function()
                        selected[opt] = not selected[opt]
                        Utility.Tween(checkmark, { BackgroundColor3 = selected[opt] and theme.Accent or theme.Border }, 0.15)
                        Utility.Tween(optBtn, { BackgroundTransparency = selected[opt] and 0.4 or 0.85 }, 0.15)
                        selLabel.Text = GetSelectedText()

                        local selList = {}
                        for k, v in pairs(selected) do if v then table.insert(selList, k) end end
                        if opts.Callback then pcall(opts.Callback, selList) end
                    end)
                end

                local maxH = math.min(#(opts.Options or {}) * 30 + 12, 180)
                dropBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    if isOpen then
                        dropList.Visible = true
                        Utility.Tween(dropList, { Size = UDim2.new(0.52, 0, 0, maxH) }, 0.25, Enum.EasingStyle.Back)
                    else
                        Utility.Tween(dropList, { Size = UDim2.new(0.52, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
                        task.delay(0.22, function() dropList.Visible = false end)
                    end
                end)

                return {
                    Get = function()
                        local t = {}
                        for k, v in pairs(selected) do if v then table.insert(t, k) end end
                        return t
                    end,
                }
            end

            return Section
        end

        -- ── Shorthand component creators on Tab ─────
        -- These create a transparent auto-section per call
        local function AutoSection()
            local s = Tab:CreateSection("")
            s._frame:FindFirstChild("UIStroke").Transparency = 1
            s._frame.BackgroundTransparency = 1
            -- Remove header
            for _, c in pairs(s._frame:GetChildren()) do
                if c:IsA("Frame") and c:FindFirstChildOfClass("TextLabel") then
                    c.Visible = false
                end
            end
            s._frame:FindFirstChildOfClass("UIPadding").PaddingTop = UDim.new(0, 4)
            return s
        end

        function Tab:CreateButton(opts)   return AutoSection():CreateButton(opts) end
        function Tab:CreateToggle(opts)   return AutoSection():CreateToggle(opts) end
        function Tab:CreateSlider(opts)   return AutoSection():CreateSlider(opts) end
        function Tab:CreateDropdown(opts) return AutoSection():CreateDropdown(opts) end
        function Tab:CreateKeybind(opts)  return AutoSection():CreateKeybind(opts) end
        function Tab:CreateTextBox(opts)  return AutoSection():CreateTextBox(opts) end
        function Tab:CreateColorPicker(opts) return AutoSection():CreateColorPicker(opts) end
        function Tab:CreateLabel(text, color) return AutoSection():CreateLabel(text, color) end
        function Tab:CreateSeparator(label) return AutoSection():CreateSeparator(label) end
        function Tab:CreateMultiDropdown(opts) return AutoSection():CreateMultiDropdown(opts) end

        return Tab
    end -- end CreateTab

    -- Store window reference
    table.insert(KOD._windows, Window)
    return Window
end -- end CreateWindow

-- ══════════════════════════════════════════════
--  NOTIFICATIONS
-- ══════════════════════════════════════════════

KOD._tooltip = nil

function KOD:_ShowTooltip(text, anchor)
    if self._tooltip then self._tooltip:Destroy() end
    local tip = Utility.Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(20, 20, 26),
        BackgroundTransparency = 0.1,
        Size = UDim2.fromOffset(0, 28),
        AutomaticSize = Enum.AutomaticSize.X,
        Position = UDim2.new(0.5, 0, 1, 6),
        AnchorPoint = Vector2.new(0.5, 0),
        BorderSizePixel = 0,
        ZIndex = 9000,
        Parent = anchor,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = tip })
    Utility.Create("UIStroke", { Color = Color3.fromRGB(220, 30, 60), Thickness = 1, Transparency = 0.5, Parent = tip })
    Utility.Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), Parent = tip })
    Utility.Create("TextLabel", {
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(220, 220, 230),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        ZIndex = 9001,
        Parent = tip,
    })
    self._tooltip = tip
end

function KOD:_HideTooltip()
    if self._tooltip then
        self._tooltip:Destroy()
        self._tooltip = nil
    end
end

function KOD:Notify(opts)
    opts = opts or {}
    local title    = opts.Title or "KOD"
    local message  = opts.Message or ""
    local duration = opts.Duration or 4
    local ntype    = opts.Type or "Info" -- "Success" | "Error" | "Warning" | "Info"

    local typeColors = {
        Success = Themes.Dark.Success,
        Error   = Themes.Dark.Error,
        Warning = Themes.Dark.Warning,
        Info    = Themes.Dark.Info,
    }
    local typeIcons = {
        Success = "✓",
        Error   = "✕",
        Warning = "⚠",
        Info    = "ℹ",
    }
    local accentColor = typeColors[ntype] or Themes.Dark.Info
    local icon = typeIcons[ntype] or "ℹ"

    local notif = Utility.Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(16, 16, 20),
        BackgroundTransparency = 0.08,
        Size = UDim2.fromOffset(310, 70),
        BorderSizePixel = 0,
        ZIndex = 9999,
        Parent = self._notifContainer,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = notif })
    Utility.Create("UIStroke", { Color = accentColor, Thickness = 1, Transparency = 0.5, Parent = notif })
    Utility.Shadow(notif, 20, 0.4)

    -- Left accent bar
    local accentBar = Utility.Create("Frame", {
        BackgroundColor3 = accentColor,
        Size = UDim2.fromOffset(3, 40),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        ZIndex = 10000,
        Parent = notif,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = accentBar })

    -- Icon
    local iconBg = Utility.Create("Frame", {
        BackgroundColor3 = accentColor,
        BackgroundTransparency = 0.75,
        Size = UDim2.fromOffset(32, 32),
        Position = UDim2.new(0, 14, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        ZIndex = 10000,
        Parent = notif,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = iconBg })
    Utility.Create("TextLabel", {
        Text = icon,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = accentColor,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 10001,
        Parent = iconBg,
    })

    -- Title
    Utility.Create("TextLabel", {
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(240, 240, 248),
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(56, 12),
        Size = UDim2.new(1, -70, 0, 16),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10000,
        Parent = notif,
    })

    -- Message
    Utility.Create("TextLabel", {
        Text = message,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(160, 160, 180),
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(56, 30),
        Size = UDim2.new(1, -70, 0, 30),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        ZIndex = 10000,
        Parent = notif,
    })

    -- Progress bar
    local progBg = Utility.Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(30, 30, 38),
        Size = UDim2.new(1, -12, 0, 3),
        Position = UDim2.new(0, 6, 1, -5),
        AnchorPoint = Vector2.new(0, 1),
        BorderSizePixel = 0,
        ZIndex = 10000,
        Parent = notif,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = progBg })

    local prog = Utility.Create("Frame", {
        BackgroundColor3 = accentColor,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        ZIndex = 10001,
        Parent = progBg,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = prog })

    -- Slide in
    notif.Position = UDim2.fromOffset(340, 0)
    Utility.Tween(notif, { Position = UDim2.fromOffset(0, 0) }, 0.4, Enum.EasingStyle.Back)

    -- Progress bar countdown
    Utility.Tween(prog, { Size = UDim2.fromScale(0, 1) }, duration, Enum.EasingStyle.Linear)

    -- Dismiss
    task.delay(duration, function()
        Utility.Tween(notif, { Position = UDim2.fromOffset(340, 0), BackgroundTransparency = 1 }, 0.35, Enum.EasingStyle.Quart)
        task.delay(0.4, function() notif:Destroy() end)
    end)

    -- Click to dismiss
    local dismissBtn = Utility.Create("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 10002,
        Parent = notif,
    })
    dismissBtn.MouseButton1Click:Connect(function()
        Utility.Tween(notif, { Position = UDim2.fromOffset(340, 0), BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Quart)
        task.delay(0.3, function() notif:Destroy() end)
    end)

    return notif
end

-- ══════════════════════════════════════════════
--  WATERMARK
-- ══════════════════════════════════════════════

function KOD:SetWatermark(opts)
    opts = opts or {}
    if self._watermark then self._watermark:Destroy() end

    local posMap = {
        TopLeft    = { anchor = Vector2.new(0,0), pos = UDim2.fromOffset(12, 12) },
        TopRight   = { anchor = Vector2.new(1,0), pos = UDim2.new(1,-12,0,12) },
        BottomLeft  = { anchor = Vector2.new(0,1), pos = UDim2.new(0,12,1,-12) },
        BottomRight = { anchor = Vector2.new(1,1), pos = UDim2.new(1,-12,1,-12) },
    }
    local p = posMap[opts.Position or "TopRight"]

    local wm = Utility.Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 10, 14),
        BackgroundTransparency = 0.15,
        Size = UDim2.fromOffset(0, 30),
        AutomaticSize = Enum.AutomaticSize.X,
        Position = p.pos,
        AnchorPoint = p.anchor,
        BorderSizePixel = 0,
        ZIndex = 8000,
        Parent = self._gui,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = wm })
    Utility.Create("UIStroke", { Color = Themes.Dark.Accent, Thickness = 1, Transparency = 0.4, Parent = wm })
    Utility.Create("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = wm })

    -- KOD badge
    local badge = Utility.Create("Frame", {
        BackgroundColor3 = Themes.Dark.Accent,
        Size = UDim2.fromOffset(22, 18),
        Position = UDim2.fromOffset(0, 6),
        BorderSizePixel = 0,
        ZIndex = 8001,
        Parent = wm,
    })
    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = badge })
    Utility.Create("TextLabel", {
        Text = "K",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255,255,255),
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1,1),
        ZIndex = 8002,
        Parent = badge,
    })

    Utility.Create("TextLabel", {
        Text = "  " .. (opts.Text or "KOD Library"),
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(200, 200, 215),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        ZIndex = 8001,
        Parent = wm,
    })

    self._watermark = wm

    -- Optional: update watermark dynamically
    if opts.Dynamic then
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not wm.Parent then conn:Disconnect() return end
            -- fps
            local fps = math.floor(1 / RunService.Heartbeat:Wait())
            local label = wm:FindFirstChildOfClass("TextLabel")
            if label and opts.FPS then
                label.Text = "  " .. (opts.Text or "KOD Library") .. " | " .. fps .. " FPS"
            end
        end)
    end

    return {
        SetText = function(_, t)
            local label = wm:FindFirstChildOfClass("TextLabel")
            if label then label.Text = "  " .. t end
        end,
        Destroy = function()
            wm:Destroy()
            KOD._watermark = nil
        end,
    }
end

-- ══════════════════════════════════════════════
--  CONFIG HELPERS
-- ══════════════════════════════════════════════

function KOD:SaveConfig(name)
    return self._config:Save(name)
end

function KOD:LoadConfig(name)
    return self._config:Load(name)
end

function KOD:ListConfigs()
    return self._config:ListConfigs()
end

-- ══════════════════════════════════════════════
--  THEME MANAGER
-- ══════════════════════════════════════════════

function KOD:GetTheme(name)
    return Themes[name]
end

function KOD:RegisterTheme(name, themeTable)
    Themes[name] = themeTable
end

-- ══════════════════════════════════════════════
--  DESTROY
-- ══════════════════════════════════════════════

function KOD:Destroy()
    for _, conn in pairs(self._connections) do
        conn:Disconnect()
    end
    if self._gui then self._gui:Destroy() end
end

-- ══════════════════════════════════════════════
--  INITIALIZE AND RETURN
-- ══════════════════════════════════════════════

KOD:Init()

return KOD

--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  KOD LIBRARY — FULL API REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  KOD:CreateWindow(opts) → Window
    opts.Title         string
    opts.SubTitle      string
    opts.Size          UDim2
    opts.TabWidth      number
    opts.ToggleKey     Enum.KeyCode
    opts.Theme         "Dark"|"Crimson"|"Ocean"
    opts.RGB           boolean
    opts.CustomTheme   table  (overrides)

  Window:CreateTab(label, icon?) → Tab
  Tab:CreateSection(title) → Section

  Section / Tab (shorthand):
    :CreateButton({ Label, ButtonLabel?, Callback, Tooltip?, ConfigKey? })
    :CreateToggle({ Label, Default?, Callback, ConfigKey? })
    :CreateSlider({ Label, Min, Max, Default?, Step?, Suffix?, Callback, ConfigKey? })
    :CreateDropdown({ Label, Options, Default?, Callback, ConfigKey? })
    :CreateMultiDropdown({ Label, Options, Default?, Callback })
    :CreateKeybind({ Label, Default?, Callback, OnPressed?, ConfigKey? })
    :CreateTextBox({ Label, Default?, Placeholder?, ClearOnFocus?, Callback, ConfigKey? })
    :CreateColorPicker({ Label, Default?, Callback })
    :CreateLabel(text, color?)
    :CreateSeparator(label?)

  KOD:Notify({ Title, Message, Duration?, Type? })
    Type: "Success"|"Error"|"Warning"|"Info"

  KOD:SetWatermark({ Text, Position?, Dynamic?, FPS? })
    Position: "TopLeft"|"TopRight"|"BottomLeft"|"BottomRight"
    Returns { SetText(text), Destroy() }

  KOD:SaveConfig(name)   → boolean
  KOD:LoadConfig(name)   → boolean
  KOD:ListConfigs()      → { string }
  KOD:RegisterTheme(name, themeTable)
  KOD:Destroy()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]
