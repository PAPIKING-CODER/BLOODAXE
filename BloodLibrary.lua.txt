-- Blood Library v1.0
-- Universal Roblox Lua UI Library
-- Load with: loadstring(game:HttpGet("RAW_URL"))()

local BloodLibrary = {}
BloodLibrary.__index = BloodLibrary

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

-- ============================================================
-- INTERNAL UTILITIES
-- ============================================================
local function tween(obj, props, dur, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir   = dir   or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(dur or 0.25, style, dir), props):Play()
end

local function ripple(btn, color)
    local rip = Instance.new("Frame")
    rip.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    rip.BackgroundTransparency = 0.6
    rip.BorderSizePixel = 0
    rip.Size = UDim2.new(0, 0, 0, 0)
    rip.Position = UDim2.new(0.5, 0, 0.5, 0)
    rip.AnchorPoint = Vector2.new(0.5, 0.5)
    rip.ZIndex = btn.ZIndex + 5
    Instance.new("UICorner", rip).CornerRadius = UDim.new(1, 0)
    rip.Parent = btn
    tween(rip, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 0.4)
    game:GetService("Debris"):AddItem(rip, 0.5)
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = parent
    return c
end

local function makeStroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(80, 0, 0)
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Parent = parent
    return s
end

local function makePadding(parent, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 8)
    p.PaddingRight  = UDim.new(0, right  or 8)
    p.PaddingBottom = UDim.new(0, bottom or 8)
    p.PaddingLeft   = UDim.new(0, left   or 8)
    p.Parent = parent
    return p
end

local function label(parent, text, size, color, weight)
    local l = Instance.new("TextLabel")
    l.Text = text or ""
    l.TextSize = size or 14
    l.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    l.Font = weight == "bold" and Enum.Font.GothamBold or (weight == "semi" and Enum.Font.GothamSemibold or Enum.Font.Gotham)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Size = UDim2.new(1, 0, 0, 18)
    l.Parent = parent
    return l
end

-- ============================================================
-- DEFAULT THEMES
-- ============================================================
BloodLibrary.Themes = {
    Blood = {
        Background      = Color3.fromRGB(15, 15, 15),
        Sidebar         = Color3.fromRGB(20, 20, 20),
        Header          = Color3.fromRGB(18, 18, 18),
        Section         = Color3.fromRGB(25, 25, 25),
        Element         = Color3.fromRGB(30, 30, 30),
        ElementHover    = Color3.fromRGB(38, 38, 38),
        Accent          = Color3.fromRGB(180, 0, 0),
        AccentDark      = Color3.fromRGB(120, 0, 0),
        AccentBright    = Color3.fromRGB(220, 30, 30),
        Text            = Color3.fromRGB(230, 230, 230),
        TextDim         = Color3.fromRGB(140, 140, 140),
        TextDark        = Color3.fromRGB(90, 90, 90),
        Border          = Color3.fromRGB(50, 10, 10),
        Toggle          = Color3.fromRGB(55, 55, 55),
        ToggleOn        = Color3.fromRGB(180, 0, 0),
        Slider          = Color3.fromRGB(50, 50, 50),
        SliderFill      = Color3.fromRGB(180, 0, 0),
        Scrollbar       = Color3.fromRGB(60, 0, 0),
        Notification    = Color3.fromRGB(22, 22, 22),
        Success         = Color3.fromRGB(0, 160, 60),
        Warning         = Color3.fromRGB(200, 130, 0),
        Error           = Color3.fromRGB(200, 20, 20),
        Info            = Color3.fromRGB(0, 100, 200),
    },
    Dark = {
        Background      = Color3.fromRGB(18, 18, 22),
        Sidebar         = Color3.fromRGB(24, 24, 30),
        Header          = Color3.fromRGB(20, 20, 26),
        Section         = Color3.fromRGB(28, 28, 36),
        Element         = Color3.fromRGB(34, 34, 44),
        ElementHover    = Color3.fromRGB(44, 44, 56),
        Accent          = Color3.fromRGB(100, 70, 220),
        AccentDark      = Color3.fromRGB(70, 50, 160),
        AccentBright    = Color3.fromRGB(130, 100, 255),
        Text            = Color3.fromRGB(230, 230, 240),
        TextDim         = Color3.fromRGB(140, 140, 160),
        TextDark        = Color3.fromRGB(80, 80, 100),
        Border          = Color3.fromRGB(50, 40, 80),
        Toggle          = Color3.fromRGB(55, 55, 70),
        ToggleOn        = Color3.fromRGB(100, 70, 220),
        Slider          = Color3.fromRGB(50, 50, 65),
        SliderFill      = Color3.fromRGB(100, 70, 220),
        Scrollbar       = Color3.fromRGB(70, 55, 120),
        Notification    = Color3.fromRGB(26, 26, 34),
        Success         = Color3.fromRGB(0, 160, 60),
        Warning         = Color3.fromRGB(200, 130, 0),
        Error           = Color3.fromRGB(200, 20, 20),
        Info            = Color3.fromRGB(0, 100, 200),
    },
}

BloodLibrary.CurrentTheme = BloodLibrary.Themes.Blood

-- ============================================================
-- CONFIG SYSTEM
-- ============================================================
BloodLibrary.ConfigFolder = "BloodLibraryConfigs"
BloodLibrary.Configs = {}

function BloodLibrary:SaveConfig(name)
    if not isfolder(self.ConfigFolder) then
        makefolder(self.ConfigFolder)
    end
    local data = HttpService:JSONEncode(self.Configs)
    writefile(self.ConfigFolder .. "/" .. (name or "default") .. ".json", data)
end

function BloodLibrary:LoadConfig(name)
    if not isfolder(self.ConfigFolder) then return end
    local path = self.ConfigFolder .. "/" .. (name or "default") .. ".json"
    if isfile(path) then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        if ok and data then
            for k, v in pairs(data) do
                self.Configs[k] = v
            end
            return data
        end
    end
    return nil
end

function BloodLibrary:ListConfigs()
    if not isfolder(self.ConfigFolder) then return {} end
    local list = {}
    for _, f in ipairs(listfiles(self.ConfigFolder)) do
        local name = f:match("([^/\\]+)%.json$")
        if name then table.insert(list, name) end
    end
    return list
end

-- ============================================================
-- NOTIFICATION SYSTEM (standalone, created once)
-- ============================================================
local NotifHolder do
    NotifHolder = Instance.new("ScreenGui")
    NotifHolder.Name = "BloodNotifications"
    NotifHolder.ResetOnSpawn = false
    NotifHolder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifHolder.DisplayOrder = 999
    pcall(function() NotifHolder.Parent = CoreGui end)
    if not NotifHolder.Parent then NotifHolder.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local list = Instance.new("Frame")
    list.Name = "List"
    list.BackgroundTransparency = 1
    list.Size = UDim2.new(0, 300, 1, 0)
    list.Position = UDim2.new(1, -310, 0, 0)
    list.AnchorPoint = Vector2.new(0, 0)
    list.Parent = NotifHolder

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.Padding = UDim.new(0, 8)
    layout.Parent = list

    makePadding(list, 10, 10, 10, 10)
end

local function spawnNotif(options)
    local T        = BloodLibrary.CurrentTheme
    local title    = options.Title   or "Notification"
    local text     = options.Text    or ""
    local duration = options.Duration or 4
    local ntype    = options.Type    or "info"

    local accentColor = (ntype == "success" and T.Success)
        or (ntype == "warning" and T.Warning)
        or (ntype == "error"   and T.Error)
        or T.Accent

    local card = Instance.new("Frame")
    card.Name = "Notif"
    card.BackgroundColor3 = T.Notification
    card.BorderSizePixel = 0
    card.Size = UDim2.new(1, 0, 0, 0)
    card.ClipsDescendants = true
    card.LayoutOrder = tick()
    makeCorner(card, 8)
    makeStroke(card, accentColor, 1, 0.3)

    local bar = Instance.new("Frame")
    bar.BackgroundColor3 = accentColor
    bar.BorderSizePixel = 0
    bar.Size = UDim2.new(0, 4, 1, 0)
    bar.Position = UDim2.new(0, 0, 0, 0)
    bar.Parent = card
    makeCorner(bar, 4)

    local inner = Instance.new("Frame")
    inner.BackgroundTransparency = 1
    inner.Size = UDim2.new(1, -16, 1, 0)
    inner.Position = UDim2.new(0, 12, 0, 0)
    inner.Parent = card

    local tl = label(inner, title, 13, T.Text, "bold")
    tl.Size = UDim2.new(1, 0, 0, 16)
    tl.Position = UDim2.new(0, 0, 0, 8)

    local tx = label(inner, text, 12, T.TextDim)
    tx.Size = UDim2.new(1, 0, 0, 14)
    tx.Position = UDim2.new(0, 0, 0, 26)
    tx.TextWrapped = true

    local prog = Instance.new("Frame")
    prog.BackgroundColor3 = accentColor
    prog.BackgroundTransparency = 0.3
    prog.BorderSizePixel = 0
    prog.Size = UDim2.new(1, 0, 0, 2)
    prog.Position = UDim2.new(0, 0, 1, -2)
    prog.Parent = card

    card.Parent = NotifHolder:FindFirstChild("List")
    tween(card, {Size = UDim2.new(1, 0, 0, 58)}, 0.3)
    tween(prog, {Size = UDim2.new(0, 0, 0, 2)}, duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In)

    task.delay(duration, function()
        tween(card, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}, 0.25)
        task.wait(0.3)
        card:Destroy()
    end)
end

function BloodLibrary:Notify(options)   spawnNotif(options) end
function BloodLibrary:Warning(title, text, dur)  spawnNotif({Title=title, Text=text, Duration=dur, Type="warning"}) end
function BloodLibrary:Error(title, text, dur)    spawnNotif({Title=title, Text=text, Duration=dur, Type="error"}) end
function BloodLibrary:Success(title, text, dur)  spawnNotif({Title=title, Text=text, Duration=dur, Type="success"}) end

-- ============================================================
-- WINDOW
-- ============================================================
function BloodLibrary:CreateWindow(options)
    options = options or {}
    local T   = self.CurrentTheme
    local win = {}
    win._tabs = {}
    win._activeTab = nil
    win._destroyed = false
    win._toggleKey = options.ToggleKey or Enum.KeyCode.RightShift
    win._visible = true

    -- Root ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = options.Name or "BloodLibrary"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 100
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    win._gui = gui

    -- Main window frame
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.BackgroundColor3 = T.Background
    main.BorderSizePixel = 0
    main.Size = options.Size or UDim2.new(0, 620, 0, 420)
    main.Position = options.Position or UDim2.new(0.5, -310, 0.5, -210)
    main.ClipsDescendants = false
    makeCorner(main, 10)
    makeStroke(main, T.Border, 1)
    main.Parent = gui

    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.ZIndex = 0
    shadow.Parent = main

    -- ── HEADER ──────────────────────────────────────────────
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = T.Header
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 46)
    header.Position = UDim2.new(0, 0, 0, 0)
    makeCorner(header, 10)
    header.Parent = main

    -- Bottom cover to square-off lower corners of header
    local hCover = Instance.new("Frame")
    hCover.BackgroundColor3 = T.Header
    hCover.BorderSizePixel = 0
    hCover.Size = UDim2.new(1, 0, 0, 8)
    hCover.Position = UDim2.new(0, 0, 1, -8)
    hCover.Parent = header

    -- Accent bar on header left
    local accentLine = Instance.new("Frame")
    accentLine.BackgroundColor3 = T.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Size = UDim2.new(0, 3, 1, -12)
    accentLine.Position = UDim2.new(0, 0, 0, 6)
    accentLine.Parent = header
    makeCorner(accentLine, 2)

    -- Icon
    local iconFrame = Instance.new("Frame")
    iconFrame.BackgroundColor3 = T.Accent
    iconFrame.BorderSizePixel = 0
    iconFrame.Size = UDim2.new(0, 30, 0, 30)
    iconFrame.Position = UDim2.new(0, 10, 0.5, -15)
    makeCorner(iconFrame, 6)
    iconFrame.Parent = header

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Text = options.Icon or ""
    iconLabel.TextScaled = true
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.Parent = iconFrame

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = options.Title or "Blood Library"
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = T.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0, 200, 0, 20)
    titleLabel.Position = UDim2.new(0, 48, 0, 8)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Text = options.Subtitle or "Blood Library"
    subtitleLabel.TextSize = 11
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextColor3 = T.TextDim
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Size = UDim2.new(0, 200, 0, 14)
    subtitleLabel.Position = UDim2.new(0, 48, 0, 26)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = header

    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "✕"
    closeBtn.TextSize = 13
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    closeBtn.BorderSizePixel = 0
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
    makeCorner(closeBtn, 6)
    closeBtn.Parent = header

    -- Minimize button
    local minBtn = Instance.new("TextButton")
    minBtn.Text = "─"
    minBtn.TextSize = 13
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    minBtn.BackgroundColor3 = T.Element
    minBtn.BorderSizePixel = 0
    minBtn.Size = UDim2.new(0, 26, 0, 26)
    minBtn.Position = UDim2.new(1, -64, 0.5, -13)
    makeCorner(minBtn, 6)
    minBtn.Parent = header

    -- Search bar
    local searchBox = Instance.new("TextBox")
    searchBox.PlaceholderText = "Search..."
    searchBox.Text = ""
    searchBox.TextSize = 13
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextColor3 = T.Text
    searchBox.PlaceholderColor3 = T.TextDark
    searchBox.BackgroundColor3 = T.Element
    searchBox.BorderSizePixel = 0
    searchBox.Size = UDim2.new(0, 140, 0, 26)
    searchBox.Position = UDim2.new(1, -218, 0.5, -13)
    searchBox.ClearTextOnFocus = false
    makeCorner(searchBox, 6)
    makePadding(searchBox, 4, 8, 4, 8)
    searchBox.Parent = header
    win._searchBox = searchBox

    -- ── BODY ────────────────────────────────────────────────
    local body = Instance.new("Frame")
    body.Name = "Body"
    body.BackgroundTransparency = 1
    body.Size = UDim2.new(1, 0, 1, -46)
    body.Position = UDim2.new(0, 0, 0, 46)
    body.Parent = main
    win._body = body

    -- ── SIDEBAR ─────────────────────────────────────────────
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.BackgroundColor3 = T.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Size = UDim2.new(0, 150, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    makeCorner(sidebar, 8)
    sidebar.Parent = body

    local sidebarCover = Instance.new("Frame")
    sidebarCover.BackgroundColor3 = T.Sidebar
    sidebarCover.BorderSizePixel = 0
    sidebarCover.Size = UDim2.new(0, 10, 1, 0)
    sidebarCover.Position = UDim2.new(1, -10, 0, 0)
    sidebarCover.Parent = sidebar

    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.BackgroundTransparency = 1
    tabList.BorderSizePixel = 0
    tabList.Size = UDim2.new(1, 0, 1, -10)
    tabList.Position = UDim2.new(0, 0, 0, 8)
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.ScrollBarThickness = 3
    tabList.ScrollBarImageColor3 = T.Scrollbar
    tabList.Parent = sidebar
    win._tabList = tabList

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabList
    makePadding(tabList, 4, 8, 4, 8)

    -- ── CONTENT AREA ────────────────────────────────────────
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, -160, 1, -8)
    content.Position = UDim2.new(0, 158, 0, 4)
    content.Parent = body
    win._content = content

    -- ── DRAG LOGIC ──────────────────────────────────────────
    do
        local dragging, dragStart, startPos
        local function onInputBegan(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                dragging  = true
                dragStart = inp.Position
                startPos  = main.Position
            end
        end
        local function onInputChanged(inp)
            if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement
            or inp.UserInputType == Enum.UserInputType.Touch) then
                local delta = inp.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end
        local function onInputEnded(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end
        header.InputBegan:Connect(onInputBegan)
        header.InputChanged:Connect(onInputChanged)
        UserInputService.InputChanged:Connect(onInputChanged)
        UserInputService.InputEnded:Connect(onInputEnded)
    end

    -- ── TOGGLE KEY ──────────────────────────────────────────
    UserInputService.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == win._toggleKey then
            win._visible = not win._visible
            tween(main, {Size = win._visible
                and (options.Size or UDim2.new(0, 620, 0, 420))
                or UDim2.new(0, 620, 0, 0)}, 0.3)
            tween(main, {BackgroundTransparency = win._visible and 0 or 1}, 0.3)
            body.Visible = win._visible
        end
    end)

    -- ── MINIMIZE ────────────────────────────────────────────
    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        tween(main, {Size = minimized
            and UDim2.new(0, 620, 0, 46)
            or (options.Size or UDim2.new(0, 620, 0, 420))}, 0.3)
        body.Visible = not minimized
    end)

    closeBtn.MouseButton1Click:Connect(function()
        win:Destroy()
    end)

    -- ── HOVER BUTTONS ───────────────────────────────────────
    closeBtn.MouseEnter:Connect(function()
        tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(220, 30, 30)}, 0.15)
    end)
    closeBtn.MouseLeave:Connect(function()
        tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(180, 0, 0)}, 0.15)
    end)
    minBtn.MouseEnter:Connect(function()
        tween(minBtn, {BackgroundColor3 = T.ElementHover}, 0.15)
    end)
    minBtn.MouseLeave:Connect(function()
        tween(minBtn, {BackgroundColor3 = T.Element}, 0.15)
    end)

    -- Animate in
    main.Size = UDim2.new(0, 620, 0, 0)
    main.BackgroundTransparency = 1
    task.defer(function()
        tween(main, {Size = options.Size or UDim2.new(0, 620, 0, 420), BackgroundTransparency = 0}, 0.4)
    end)

    -- ============================================================
    -- WINDOW METHODS
    -- ============================================================
    function win:SetTitle(text)
        titleLabel.Text = text
    end
    function win:SetIcon(icon)
        iconLabel.Text = icon
    end
    function win:SetSize(x, y)
        main.Size = UDim2.new(0, x, 0, y)
    end
    function win:SetPosition(x, y)
        main.Position = UDim2.new(0, x, 0, y)
    end
    function win:ToggleKey(key)
        win._toggleKey = key
    end
    function win:Destroy()
        tween(main, {Size = UDim2.new(0, 620, 0, 0), BackgroundTransparency = 1}, 0.3)
        task.wait(0.35)
        gui:Destroy()
        win._destroyed = true
    end

    -- ============================================================
    -- TAB SYSTEM
    -- ============================================================
    function win:AddTab(options2)
        return self:CreateTab(options2)
    end

    function win:CreateTab(options2)
        options2 = options2 or {}
        local tab = {}
        tab._sections = {}
        tab._order = #win._tabs + 1

        -- Tab button in sidebar
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab_" .. (options2.Title or "Tab")
        tabBtn.Text = ""
        tabBtn.BackgroundColor3 = T.Element
        tabBtn.BackgroundTransparency = 1
        tabBtn.BorderSizePixel = 0
        tabBtn.Size = UDim2.new(1, 0, 0, 34)
        tabBtn.LayoutOrder = tab._order
        makeCorner(tabBtn, 6)
        tabBtn.Parent = tabList

        -- Accent indicator
        local tabAccent = Instance.new("Frame")
        tabAccent.BackgroundColor3 = T.Accent
        tabAccent.BorderSizePixel = 0
        tabAccent.Size = UDim2.new(0, 3, 0.6, 0)
        tabAccent.Position = UDim2.new(0, 0, 0.2, 0)
        tabAccent.BackgroundTransparency = 1
        makeCorner(tabAccent, 2)
        tabAccent.Parent = tabBtn

        local tabIconL = Instance.new("TextLabel")
        tabIconL.Text = options2.Icon or ""
        tabIconL.TextSize = 14
        tabIconL.Font = Enum.Font.Gotham
        tabIconL.TextColor3 = T.TextDim
        tabIconL.BackgroundTransparency = 1
        tabIconL.Size = UDim2.new(0, 20, 1, 0)
        tabIconL.Position = UDim2.new(0, 8, 0, 0)
        tabIconL.Parent = tabBtn

        local tabTitleL = Instance.new("TextLabel")
        tabTitleL.Text = options2.Title or "Tab"
        tabTitleL.TextSize = 13
        tabTitleL.Font = Enum.Font.Gotham
        tabTitleL.TextColor3 = T.TextDim
        tabTitleL.BackgroundTransparency = 1
        tabTitleL.Size = UDim2.new(1, -32, 1, 0)
        tabTitleL.Position = UDim2.new(0, 30, 0, 0)
        tabTitleL.TextXAlignment = Enum.TextXAlignment.Left
        tabTitleL.Parent = tabBtn

        -- Content frame for this tab
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "TabContent_" .. (options2.Title or "Tab")
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.ScrollBarThickness = 3
        tabContent.ScrollBarImageColor3 = T.Scrollbar
        tabContent.Visible = false
        tabContent.Parent = content

        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 8)
        contentLayout.Parent = tabContent
        makePadding(tabContent, 4, 4, 8, 4)

        tab._btn     = tabBtn
        tab._content = tabContent
        tab._accent  = tabAccent
        tab._titleL  = tabTitleL
        tab._iconL   = tabIconL

        -- Activate tab function
        local function activateTab()
            -- Deactivate all
            for _, t in ipairs(win._tabs) do
                tween(t._btn,    {BackgroundTransparency = 1}, 0.15)
                tween(t._accent, {BackgroundTransparency = 1}, 0.15)
                tween(t._titleL, {TextColor3 = T.TextDim}, 0.15)
                tween(t._iconL,  {TextColor3 = T.TextDim}, 0.15)
                t._content.Visible = false
                t._btn.Font = Enum.Font.Gotham
            end
            -- Activate this
            tween(tabBtn,    {BackgroundTransparency = 0.85}, 0.15)
            tween(tabAccent, {BackgroundTransparency = 0}, 0.15)
            tween(tabTitleL, {TextColor3 = T.Accent}, 0.15)
            tween(tabIconL,  {TextColor3 = T.Accent}, 0.15)
            tabTitleL.Font = Enum.Font.GothamSemibold
            tabContent.Visible = true
            win._activeTab = tab
        end

        tabBtn.MouseButton1Click:Connect(function()
            ripple(tabBtn, T.Accent)
            activateTab()
        end)
        tabBtn.MouseEnter:Connect(function()
            if win._activeTab ~= tab then
                tween(tabBtn, {BackgroundTransparency = 0.92}, 0.15)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if win._activeTab ~= tab then
                tween(tabBtn, {BackgroundTransparency = 1}, 0.15)
            end
        end)

        table.insert(win._tabs, tab)

        -- Auto-select first tab
        if #win._tabs == 1 then
            activateTab()
        end

        -- ======================================================
        -- TAB METHODS
        -- ======================================================
        function tab:SetTabTitle(text) tabTitleL.Text = text end
        function tab:SetTabIcon(icon)  tabIconL.Text  = icon  end
        function tab:SelectTab()       activateTab()           end

        -- Search filtering
        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local q = searchBox.Text:lower()
            for _, section in ipairs(tab._sections) do
                for _, el in ipairs(section._elements or {}) do
                    if el._frame then
                        local show = q == "" or (el._name or ""):lower():find(q, 1, true)
                        el._frame.Visible = show ~= nil
                    end
                end
            end
        end)

        -- ======================================================
        -- SECTION SYSTEM
        -- ======================================================
        function tab:AddSection(options3)
            return self:CreateSection(options3)
        end

        function tab:CreateSection(options3)
            options3 = options3 or {}
            local section = {}
            section._elements = {}
            section._order = #tab._sections + 1

            local sFrame = Instance.new("Frame")
            sFrame.Name = "Section"
            sFrame.BackgroundColor3 = T.Section
            sFrame.BorderSizePixel = 0
            sFrame.Size = UDim2.new(1, 0, 0, 0)
            sFrame.AutomaticSize = Enum.AutomaticSize.Y
            sFrame.LayoutOrder = section._order
            makeCorner(sFrame, 8)
            makeStroke(sFrame, T.Border, 1, 0.5)
            sFrame.Parent = tabContent

            -- Section header
            local sHeader = Instance.new("Frame")
            sHeader.BackgroundTransparency = 1
            sHeader.Size = UDim2.new(1, 0, 0, 28)
            sHeader.Parent = sFrame

            local sAccent = Instance.new("Frame")
            sAccent.BackgroundColor3 = T.Accent
            sAccent.BorderSizePixel = 0
            sAccent.Size = UDim2.new(0, 3, 0.55, 0)
            sAccent.Position = UDim2.new(0, 10, 0.225, 0)
            makeCorner(sAccent, 2)
            sAccent.Parent = sHeader

            local sTitle = Instance.new("TextLabel")
            sTitle.Text = options3.Title or "Section"
            sTitle.TextSize = 12
            sTitle.Font = Enum.Font.GothamSemibold
            sTitle.TextColor3 = T.Accent
            sTitle.BackgroundTransparency = 1
            sTitle.Size = UDim2.new(1, -20, 1, 0)
            sTitle.Position = UDim2.new(0, 18, 0, 0)
            sTitle.TextXAlignment = Enum.TextXAlignment.Left
            sTitle.Parent = sHeader

            -- Divider line
            local sDivider = Instance.new("Frame")
            sDivider.BackgroundColor3 = T.Border
            sDivider.BorderSizePixel = 0
            sDivider.Size = UDim2.new(1, -20, 0, 1)
            sDivider.Position = UDim2.new(0, 10, 0, 28)
            sDivider.Parent = sFrame

            -- Element container
            local sContent = Instance.new("Frame")
            sContent.BackgroundTransparency = 1
            sContent.Size = UDim2.new(1, 0, 0, 0)
            sContent.AutomaticSize = Enum.AutomaticSize.Y
            sContent.Position = UDim2.new(0, 0, 0, 30)
            sContent.Parent = sFrame

            local elLayout = Instance.new("UIListLayout")
            elLayout.SortOrder = Enum.SortOrder.LayoutOrder
            elLayout.Padding = UDim.new(0, 0)
            elLayout.Parent = sContent

            section._frame   = sFrame
            section._content = sContent

            table.insert(tab._sections, section)

            -- ==================================================
            -- ELEMENT HELPERS
            -- ==================================================
            local elOrder = 0
            local function nextOrder()
                elOrder = elOrder + 1
                return elOrder
            end

            local function makeElementRow(name, hasRight)
                local row = Instance.new("Frame")
                row.BackgroundColor3 = T.Element
                row.BackgroundTransparency = 1
                row.BorderSizePixel = 0
                row.Size = UDim2.new(1, 0, 0, 38)
                row.LayoutOrder = nextOrder()
                row.Parent = sContent

                local divLine = Instance.new("Frame")
                divLine.BackgroundColor3 = T.Border
                divLine.BackgroundTransparency = 0.5
                divLine.BorderSizePixel = 0
                divLine.Size = UDim2.new(1, -20, 0, 1)
                divLine.Position = UDim2.new(0, 10, 1, -1)
                divLine.Parent = row

                row.MouseEnter:Connect(function()
                    tween(row, {BackgroundTransparency = 0.95}, 0.12)
                end)
                row.MouseLeave:Connect(function()
                    tween(row, {BackgroundTransparency = 1}, 0.12)
                end)

                local nameL = Instance.new("TextLabel")
                nameL.Text = name or ""
                nameL.TextSize = 13
                nameL.Font = Enum.Font.Gotham
                nameL.TextColor3 = T.Text
                nameL.BackgroundTransparency = 1
                nameL.Size = UDim2.new(0.55, -10, 0, 38)
                nameL.Position = UDim2.new(0, 12, 0, 0)
                nameL.TextXAlignment = Enum.TextXAlignment.Left
                nameL.Parent = row

                return row, nameL
            end

            -- ==================================================
            -- BUTTON
            -- ==================================================
            function section:AddButton(options4)
                return self:CreateButton(options4)
            end

            function section:CreateButton(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}

                local row = Instance.new("Frame")
                row.BackgroundTransparency = 1
                row.BorderSizePixel = 0
                row.Size = UDim2.new(1, 0, 0, 42)
                row.LayoutOrder = nextOrder()
                row.Parent = sContent
                el._frame = row

                local divLine = Instance.new("Frame")
                divLine.BackgroundColor3 = T.Border
                divLine.BackgroundTransparency = 0.5
                divLine.BorderSizePixel = 0
                divLine.Size = UDim2.new(1, -20, 0, 1)
                divLine.Position = UDim2.new(0, 10, 1, -1)
                divLine.Parent = row

                local nameL = Instance.new("TextLabel")
                nameL.Text = options4.Name or ""
                nameL.TextSize = 13
                nameL.Font = Enum.Font.Gotham
                nameL.TextColor3 = T.Text
                nameL.BackgroundTransparency = 1
                nameL.Size = UDim2.new(0.5, -10, 1, 0)
                nameL.Position = UDim2.new(0, 12, 0, 0)
                nameL.TextXAlignment = Enum.TextXAlignment.Left
                nameL.Parent = row

                local btn = Instance.new("TextButton")
                btn.Text = options4.ButtonText or "Execute"
                btn.TextSize = 12
                btn.Font = Enum.Font.GothamSemibold
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundColor3 = T.Accent
                btn.BorderSizePixel = 0
                btn.Size = UDim2.new(0, 80, 0, 26)
                btn.Position = UDim2.new(1, -92, 0.5, -13)
                makeCorner(btn, 6)
                btn.Parent = row

                btn.MouseEnter:Connect(function()
                    tween(btn, {BackgroundColor3 = T.AccentBright}, 0.15)
                end)
                btn.MouseLeave:Connect(function()
                    tween(btn, {BackgroundColor3 = T.Accent}, 0.15)
                end)

                local cb = options4.Callback or function() end
                btn.MouseButton1Click:Connect(function()
                    ripple(btn)
                    tween(btn, {BackgroundColor3 = T.AccentDark}, 0.1)
                    task.wait(0.1)
                    tween(btn, {BackgroundColor3 = T.Accent}, 0.15)
                    pcall(cb)
                end)

                row.MouseEnter:Connect(function()
                    tween(row, {BackgroundColor3 = T.ElementHover}, 0.12)
                    row.BackgroundTransparency = 0.95
                end)
                row.MouseLeave:Connect(function()
                    tween(row, {BackgroundTransparency = 1}, 0.12)
                end)

                table.insert(section._elements, el)

                function el:SetButtonText(text) btn.Text = text end
                function el:ButtonCallback(fn)   cb = fn         end
                return el
            end

            -- ==================================================
            -- TOGGLE
            -- ==================================================
            function section:AddToggle(options4)
                return self:CreateToggle(options4)
            end

            function section:CreateToggle(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local value = options4.Default or false
                local cb = options4.Callback or function() end

                local row, nameL = makeElementRow(options4.Name)
                el._frame = row

                -- Save to config
                if options4.Flag then
                    BloodLibrary.Configs[options4.Flag] = value
                end

                -- Track UI
                local trackBg = Instance.new("Frame")
                trackBg.BackgroundColor3 = value and T.ToggleOn or T.Toggle
                trackBg.BorderSizePixel = 0
                trackBg.Size = UDim2.new(0, 40, 0, 22)
                trackBg.Position = UDim2.new(1, -52, 0.5, -11)
                makeCorner(trackBg, 11)
                trackBg.Parent = row

                local knob = Instance.new("Frame")
                knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                knob.BorderSizePixel = 0
                knob.Size = UDim2.new(0, 16, 0, 16)
                knob.Position = value and UDim2.new(0, 21, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                makeCorner(knob, 8)
                knob.Parent = trackBg

                local function setVal(v, silent)
                    value = v
                    tween(trackBg, {BackgroundColor3 = v and T.ToggleOn or T.Toggle}, 0.2)
                    tween(knob, {Position = v and UDim2.new(0, 21, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.2)
                    if options4.Flag then BloodLibrary.Configs[options4.Flag] = v end
                    if not silent then pcall(cb, v) end
                end

                local hitbox = Instance.new("TextButton")
                hitbox.Text = ""
                hitbox.BackgroundTransparency = 1
                hitbox.Size = UDim2.new(1, 0, 1, 0)
                hitbox.Parent = row
                hitbox.MouseButton1Click:Connect(function()
                    setVal(not value)
                end)

                -- Load config if flag exists
                if options4.Flag and BloodLibrary.Configs[options4.Flag] ~= nil then
                    setVal(BloodLibrary.Configs[options4.Flag], true)
                end

                table.insert(section._elements, el)
                function el:SetValue(v)     setVal(v)   end
                function el:GetValue()      return value end
                function el:ToggleCallback(fn) cb = fn  end
                return el
            end

            -- ==================================================
            -- SLIDER
            -- ==================================================
            function section:AddSlider(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local min     = options4.Min     or 0
                local max     = options4.Max     or 100
                local default = options4.Default or min
                local value   = default
                local cb = options4.Callback or function() end

                local row = Instance.new("Frame")
                row.BackgroundTransparency = 1
                row.BorderSizePixel = 0
                row.Size = UDim2.new(1, 0, 0, 50)
                row.LayoutOrder = nextOrder()
                row.Parent = sContent
                el._frame = row

                local divLine = Instance.new("Frame")
                divLine.BackgroundColor3 = T.Border
                divLine.BackgroundTransparency = 0.5
                divLine.BorderSizePixel = 0
                divLine.Size = UDim2.new(1, -20, 0, 1)
                divLine.Position = UDim2.new(0, 10, 1, -1)
                divLine.Parent = row

                local nameL = Instance.new("TextLabel")
                nameL.Text = options4.Name or ""
                nameL.TextSize = 13
                nameL.Font = Enum.Font.Gotham
                nameL.TextColor3 = T.Text
                nameL.BackgroundTransparency = 1
                nameL.Size = UDim2.new(0.75, 0, 0, 22)
                nameL.Position = UDim2.new(0, 12, 0, 4)
                nameL.TextXAlignment = Enum.TextXAlignment.Left
                nameL.Parent = row

                local valLabel = Instance.new("TextLabel")
                valLabel.Text = tostring(value)
                valLabel.TextSize = 12
                valLabel.Font = Enum.Font.GothamSemibold
                valLabel.TextColor3 = T.Accent
                valLabel.BackgroundTransparency = 1
                valLabel.Size = UDim2.new(0.25, -12, 0, 22)
                valLabel.Position = UDim2.new(0.75, 0, 0, 4)
                valLabel.TextXAlignment = Enum.TextXAlignment.Right
                valLabel.Parent = row

                local track = Instance.new("Frame")
                track.BackgroundColor3 = T.Slider
                track.BorderSizePixel = 0
                track.Size = UDim2.new(1, -24, 0, 4)
                track.Position = UDim2.new(0, 12, 0, 32)
                makeCorner(track, 2)
                track.Parent = row

                local fill = Instance.new("Frame")
                fill.BackgroundColor3 = T.SliderFill
                fill.BorderSizePixel = 0
                fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                fill.Position = UDim2.new(0, 0, 0, 0)
                makeCorner(fill, 2)
                fill.Parent = track

                local knob = Instance.new("Frame")
                knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                knob.BorderSizePixel = 0
                knob.Size = UDim2.new(0, 12, 0, 12)
                knob.AnchorPoint = Vector2.new(0.5, 0.5)
                knob.Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0)
                makeCorner(knob, 6)
                makeStroke(knob, T.Accent, 1, 0.2)
                knob.Parent = track

                local draggingSlider = false
                local function updateSlider(inputPos)
                    local trackAbs = track.AbsolutePosition
                    local trackSz  = track.AbsoluteSize
                    local pct = math.clamp((inputPos.X - trackAbs.X) / trackSz.X, 0, 1)
                    value = math.floor(min + pct * (max - min) + 0.5)
                    pct = (value - min) / (max - min)
                    fill.Size = UDim2.new(pct, 0, 1, 0)
                    knob.Position = UDim2.new(pct, 0, 0.5, 0)
                    valLabel.Text = tostring(value)
                    if options4.Flag then BloodLibrary.Configs[options4.Flag] = value end
                    pcall(cb, value)
                end

                track.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = true
                        updateSlider(inp.Position)
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if draggingSlider and (inp.UserInputType == Enum.UserInputType.MouseMovement
                    or inp.UserInputType == Enum.UserInputType.Touch) then
                        updateSlider(inp.Position)
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = false
                    end
                end)

                table.insert(section._elements, el)
                function el:SetMin(v)         min = v              end
                function el:SetMax(v)         max = v              end
                function el:SetDefault(v)     updateSlider({X = track.AbsolutePosition.X + (v - min)/(max - min) * track.AbsoluteSize.X}) end
                function el:SliderCallback(fn) cb = fn             end
                function el:GetValue()        return value         end
                return el
            end

            -- ==================================================
            -- DROPDOWN
            -- ==================================================
            function section:AddDropdown(options4)
                return self:CreateDropdown(options4)
            end

            function section:CreateDropdown(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local options5 = options4.Options or {}
                local selected = options4.Default or (options5[1] or "")
                local open = false
                local cb = options4.Callback or function() end

                local wrapper = Instance.new("Frame")
                wrapper.BackgroundTransparency = 1
                wrapper.BorderSizePixel = 0
                wrapper.Size = UDim2.new(1, 0, 0, 38)
                wrapper.AutomaticSize = Enum.AutomaticSize.Y
                wrapper.LayoutOrder = nextOrder()
                wrapper.ClipsDescendants = false
                wrapper.Parent = sContent
                el._frame = wrapper

                local divLine = Instance.new("Frame")
                divLine.BackgroundColor3 = T.Border
                divLine.BackgroundTransparency = 0.5
                divLine.BorderSizePixel = 0
                divLine.Size = UDim2.new(1, -20, 0, 1)
                divLine.Position = UDim2.new(0, 10, 0, 37)
                divLine.Parent = wrapper

                local nameL = Instance.new("TextLabel")
                nameL.Text = options4.Name or ""
                nameL.TextSize = 13
                nameL.Font = Enum.Font.Gotham
                nameL.TextColor3 = T.Text
                nameL.BackgroundTransparency = 1
                nameL.Size = UDim2.new(0.5, 0, 0, 38)
                nameL.Position = UDim2.new(0, 12, 0, 0)
                nameL.TextXAlignment = Enum.TextXAlignment.Left
                nameL.Parent = wrapper

                local dropBtn = Instance.new("TextButton")
                dropBtn.Text = ""
                dropBtn.BackgroundColor3 = T.Element
                dropBtn.BorderSizePixel = 0
                dropBtn.Size = UDim2.new(0.45, -12, 0, 26)
                dropBtn.Position = UDim2.new(0.55, 0, 0.5, -13)
                makeCorner(dropBtn, 6)
                dropBtn.Parent = wrapper

                local selLabel = Instance.new("TextLabel")
                selLabel.Text = selected
                selLabel.TextSize = 12
                selLabel.Font = Enum.Font.Gotham
                selLabel.TextColor3 = T.Accent
                selLabel.BackgroundTransparency = 1
                selLabel.Size = UDim2.new(1, -22, 1, 0)
                selLabel.Position = UDim2.new(0, 8, 0, 0)
                selLabel.TextXAlignment = Enum.TextXAlignment.Left
                selLabel.Parent = dropBtn

                local arrow = Instance.new("TextLabel")
                arrow.Text = "▾"
                arrow.TextSize = 12
                arrow.Font = Enum.Font.GothamBold
                arrow.TextColor3 = T.TextDim
                arrow.BackgroundTransparency = 1
                arrow.Size = UDim2.new(0, 18, 1, 0)
                arrow.Position = UDim2.new(1, -20, 0, 0)
                arrow.Parent = dropBtn

                local dropMenu = Instance.new("Frame")
                dropMenu.BackgroundColor3 = T.Element
                dropMenu.BorderSizePixel = 0
                dropMenu.Size = UDim2.new(0.45, -12, 0, 0)
                dropMenu.Position = UDim2.new(0.55, 0, 0, 40)
                dropMenu.ZIndex = 10
                dropMenu.ClipsDescendants = true
                makeCorner(dropMenu, 6)
                makeStroke(dropMenu, T.Border, 1, 0.3)
                dropMenu.Parent = wrapper

                local menuLayout = Instance.new("UIListLayout")
                menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                menuLayout.Parent = dropMenu

                local optionFrames = {}
                local function rebuildOptions()
                    for _, f in ipairs(optionFrames) do f:Destroy() end
                    optionFrames = {}
                    for i, opt in ipairs(options5) do
                        local oBtn = Instance.new("TextButton")
                        oBtn.Text = opt
                        oBtn.TextSize = 12
                        oBtn.Font = Enum.Font.Gotham
                        oBtn.TextColor3 = T.Text
                        oBtn.BackgroundColor3 = T.Element
                        oBtn.BackgroundTransparency = 1
                        oBtn.BorderSizePixel = 0
                        oBtn.Size = UDim2.new(1, 0, 0, 28)
                        oBtn.TextXAlignment = Enum.TextXAlignment.Left
                        oBtn.LayoutOrder = i
                        oBtn.ZIndex = 11
                        makePadding(oBtn, 4, 8, 4, 8)
                        oBtn.Parent = dropMenu
                        table.insert(optionFrames, oBtn)

                        oBtn.MouseEnter:Connect(function()
                            tween(oBtn, {BackgroundTransparency = 0.85, TextColor3 = T.Accent}, 0.1)
                        end)
                        oBtn.MouseLeave:Connect(function()
                            tween(oBtn, {BackgroundTransparency = 1, TextColor3 = T.Text}, 0.1)
                        end)
                        oBtn.MouseButton1Click:Connect(function()
                            selected = opt
                            selLabel.Text = opt
                            open = false
                            tween(dropMenu, {Size = UDim2.new(0.45, -12, 0, 0)}, 0.2)
                            tween(arrow, {Rotation = 0}, 0.2)
                            if options4.Flag then BloodLibrary.Configs[options4.Flag] = opt end
                            pcall(cb, opt)
                        end)
                    end
                end
                rebuildOptions()

                dropBtn.MouseButton1Click:Connect(function()
                    open = not open
                    local h = #options5 * 28
                    tween(dropMenu, {Size = UDim2.new(0.45, -12, 0, open and math.min(h, 140) or 0)}, 0.2)
                    tween(arrow, {Rotation = open and 180 or 0}, 0.2)
                end)

                table.insert(section._elements, el)

                function el:AddOption(opt)
                    table.insert(options5, opt)
                    rebuildOptions()
                end
                function el:RemoveOption(opt)
                    for i, o in ipairs(options5) do
                        if o == opt then table.remove(options5, i) break end
                    end
                    rebuildOptions()
                end
                function el:DropdownCallback(fn) cb = fn           end
                function el:GetValue()          return selected    end
                function el:SetValue(v)         selected = v; selLabel.Text = v end
                return el
            end

            -- ==================================================
            -- TEXTBOX
            -- ==================================================
            function section:AddTextbox(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local cb = options4.Callback or function() end

                local row, nameL = makeElementRow(options4.Name)
                el._frame = row

                local box = Instance.new("TextBox")
                box.PlaceholderText = options4.Placeholder or "Enter text..."
                box.Text = options4.Default or ""
                box.TextSize = 12
                box.Font = Enum.Font.Gotham
                box.TextColor3 = T.Text
                box.PlaceholderColor3 = T.TextDark
                box.BackgroundColor3 = T.Background
                box.BorderSizePixel = 0
                box.Size = UDim2.new(0.45, -12, 0, 26)
                box.Position = UDim2.new(0.55, 0, 0.5, -13)
                box.ClearTextOnFocus = false
                makeCorner(box, 6)
                makePadding(box, 4, 8, 4, 8)
                makeStroke(box, T.Border, 1, 0)
                box.Parent = row

                box.Focused:Connect(function()
                    tween(box, {BackgroundColor3 = T.Element}, 0.15)
                end)
                box.FocusLost:Connect(function(enter)
                    tween(box, {BackgroundColor3 = T.Background}, 0.15)
                    pcall(cb, box.Text, enter)
                end)

                table.insert(section._elements, el)
                function el:SetPlaceholder(text) box.PlaceholderText = text end
                function el:TextboxCallback(fn)  cb = fn                    end
                function el:GetValue()           return box.Text            end
                function el:SetValue(v)          box.Text = v               end
                return el
            end

            -- ==================================================
            -- LABEL
            -- ==================================================
            function section:AddLabel(options4)
                options4 = options4 or {}
                local el = {_name = options4.Text}

                local row = Instance.new("Frame")
                row.BackgroundTransparency = 1
                row.BorderSizePixel = 0
                row.Size = UDim2.new(1, 0, 0, 30)
                row.LayoutOrder = nextOrder()
                row.Parent = sContent
                el._frame = row

                local l = Instance.new("TextLabel")
                l.Text = options4.Text or ""
                l.TextSize = 13
                l.Font = Enum.Font.Gotham
                l.TextColor3 = options4.Color or T.TextDim
                l.BackgroundTransparency = 1
                l.Size = UDim2.new(1, -24, 1, 0)
                l.Position = UDim2.new(0, 12, 0, 0)
                l.TextXAlignment = Enum.TextXAlignment.Left
                l.TextWrapped = true
                l.Parent = row

                table.insert(section._elements, el)
                function el:SetText(text) l.Text = text end
                function el:GetText()     return l.Text end
                return el
            end

            -- ==================================================
            -- PARAGRAPH
            -- ==================================================
            function section:AddParagraph(options4)
                options4 = options4 or {}
                local el = {_name = options4.Title}

                local wrapper2 = Instance.new("Frame")
                wrapper2.BackgroundTransparency = 1
                wrapper2.BorderSizePixel = 0
                wrapper2.Size = UDim2.new(1, 0, 0, 0)
                wrapper2.AutomaticSize = Enum.AutomaticSize.Y
                wrapper2.LayoutOrder = nextOrder()
                wrapper2.Parent = sContent
                el._frame = wrapper2

                local tl2 = Instance.new("TextLabel")
                tl2.Text = options4.Title or ""
                tl2.TextSize = 13
                tl2.Font = Enum.Font.GothamSemibold
                tl2.TextColor3 = T.Text
                tl2.BackgroundTransparency = 1
                tl2.Size = UDim2.new(1, -24, 0, 20)
                tl2.Position = UDim2.new(0, 12, 0, 6)
                tl2.TextXAlignment = Enum.TextXAlignment.Left
                tl2.Parent = wrapper2

                local tx2 = Instance.new("TextLabel")
                tx2.Text = options4.Content or ""
                tx2.TextSize = 12
                tx2.Font = Enum.Font.Gotham
                tx2.TextColor3 = T.TextDim
                tx2.BackgroundTransparency = 1
                tx2.Size = UDim2.new(1, -24, 0, 0)
                tx2.AutomaticSize = Enum.AutomaticSize.Y
                tx2.Position = UDim2.new(0, 12, 0, 28)
                tx2.TextXAlignment = Enum.TextXAlignment.Left
                tx2.TextWrapped = true
                tx2.Parent = wrapper2

                table.insert(section._elements, el)
                return el
            end

            -- ==================================================
            -- DIVIDER
            -- ==================================================
            function section:AddDivider()
                local el = {_name = "Divider"}

                local div = Instance.new("Frame")
                div.BackgroundColor3 = T.Border
                div.BorderSizePixel = 0
                div.Size = UDim2.new(1, -24, 0, 1)
                div.Position = UDim2.new(0, 12, 0, 0)
                div.LayoutOrder = nextOrder()
                local wrapper3 = Instance.new("Frame")
                wrapper3.BackgroundTransparency = 1
                wrapper3.Size = UDim2.new(1, 0, 0, 10)
                wrapper3.LayoutOrder = nextOrder()
                wrapper3.Parent = sContent
                div.Parent = wrapper3
                div.Position = UDim2.new(0, 12, 0.5, 0)
                el._frame = wrapper3

                table.insert(section._elements, el)
                return el
            end

            -- ==================================================
            -- KEYBIND
            -- ==================================================
            function section:AddKeybind(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local currentKey = options4.Default or Enum.KeyCode.Unknown
                local listening = false
                local cb = options4.Callback or function() end

                local row, nameL = makeElementRow(options4.Name)
                el._frame = row

                local keyBtn = Instance.new("TextButton")
                keyBtn.TextSize = 12
                keyBtn.Font = Enum.Font.Gotham
                keyBtn.TextColor3 = T.Accent
                keyBtn.BackgroundColor3 = T.Element
                keyBtn.BorderSizePixel = 0
                keyBtn.Size = UDim2.new(0, 90, 0, 26)
                keyBtn.Position = UDim2.new(1, -102, 0.5, -13)
                keyBtn.Text = currentKey.Name
                makeCorner(keyBtn, 6)
                makeStroke(keyBtn, T.Border, 1, 0.3)
                keyBtn.Parent = row

                keyBtn.MouseButton1Click:Connect(function()
                    if listening then return end
                    listening = true
                    keyBtn.Text = "..."
                    keyBtn.TextColor3 = T.Warning
                    local conn
                    conn = UserInputService.InputBegan:Connect(function(inp, gp)
                        if gp then return end
                        if inp.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = inp.KeyCode
                            keyBtn.Text = inp.KeyCode.Name
                            keyBtn.TextColor3 = T.Accent
                            listening = false
                            conn:Disconnect()
                        end
                    end)
                end)

                UserInputService.InputBegan:Connect(function(inp, gp)
                    if gp then return end
                    if inp.KeyCode == currentKey then
                        pcall(cb, currentKey)
                    end
                end)

                table.insert(section._elements, el)
                function el:GetValue()         return currentKey           end
                function el:SetValue(key)      currentKey = key; keyBtn.Text = key.Name end
                function el:KeybindCallback(fn) cb = fn                    end
                return el
            end

            -- ==================================================
            -- COLOR PICKER
            -- ==================================================
            function section:AddColorPicker(options4)
                options4 = options4 or {}
                local el = {_name = options4.Name}
                local color = options4.Default or Color3.fromRGB(255, 0, 0)
                local cb = options4.Callback or function() end
                local open2 = false

                local wrapper4 = Instance.new("Frame")
                wrapper4.BackgroundTransparency = 1
                wrapper4.BorderSizePixel = 0
                wrapper4.Size = UDim2.new(1, 0, 0, 38)
                wrapper4.LayoutOrder = nextOrder()
                wrapper4.ClipsDescendants = false
                wrapper4.Parent = sContent
                el._frame = wrapper4

                local divLine = Instance.new("Frame")
                divLine.BackgroundColor3 = T.Border
                divLine.BackgroundTransparency = 0.5
                divLine.BorderSizePixel = 0
                divLine.Size = UDim2.new(1, -20, 0, 1)
                divLine.Position = UDim2.new(0, 10, 0, 37)
                divLine.Parent = wrapper4

                local nameL = Instance.new("TextLabel")
                nameL.Text = options4.Name or ""
                nameL.TextSize = 13
                nameL.Font = Enum.Font.Gotham
                nameL.TextColor3 = T.Text
                nameL.BackgroundTransparency = 1
                nameL.Size = UDim2.new(0.6, 0, 0, 38)
                nameL.Position = UDim2.new(0, 12, 0, 0)
                nameL.TextXAlignment = Enum.TextXAlignment.Left
                nameL.Parent = wrapper4

                local colorPreview = Instance.new("TextButton")
                colorPreview.Text = ""
                colorPreview.BackgroundColor3 = color
                colorPreview.BorderSizePixel = 0
                colorPreview.Size = UDim2.new(0, 36, 0, 22)
                colorPreview.Position = UDim2.new(1, -48, 0.5, -11)
                makeCorner(colorPreview, 6)
                makeStroke(colorPreview, T.Border, 1, 0.2)
                colorPreview.Parent = wrapper4

                -- Simple RGB picker popup
                local picker = Instance.new("Frame")
                picker.BackgroundColor3 = T.Element
                picker.BorderSizePixel = 0
                picker.Size = UDim2.new(1, -24, 0, 0)
                picker.Position = UDim2.new(0, 12, 0, 40)
                picker.ZIndex = 10
                picker.ClipsDescendants = true
                makeCorner(picker, 8)
                makeStroke(picker, T.Border, 1, 0.3)
                picker.Parent = wrapper4

                local function makeChannel(label2, idx, startV)
                    local ch = Instance.new("Frame")
                    ch.BackgroundTransparency = 1
                    ch.Size = UDim2.new(1, 0, 0, 28)
                    ch.Position = UDim2.new(0, 0, 0, (idx - 1) * 32 + 8)
                    ch.Parent = picker

                    local lbl = Instance.new("TextLabel")
                    lbl.Text = label2
                    lbl.TextSize = 11
                    lbl.Font = Enum.Font.GothamSemibold
                    lbl.TextColor3 = T.TextDim
                    lbl.BackgroundTransparency = 1
                    lbl.Size = UDim2.new(0, 20, 1, 0)
                    lbl.Position = UDim2.new(0, 8, 0, 0)
                    lbl.Parent = ch

                    local track2 = Instance.new("Frame")
                    track2.BackgroundColor3 = T.Slider
                    track2.BorderSizePixel = 0
                    track2.Size = UDim2.new(1, -90, 0, 4)
                    track2.Position = UDim2.new(0, 30, 0.5, -2)
                    makeCorner(track2, 2)
                    track2.Parent = ch

                    local fill2 = Instance.new("Frame")
                    fill2.BackgroundColor3 = T.Accent
                    fill2.BorderSizePixel = 0
                    fill2.Size = UDim2.new(startV / 255, 0, 1, 0)
                    makeCorner(fill2, 2)
                    fill2.Parent = track2

                    local knob2 = Instance.new("Frame")
                    knob2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    knob2.BorderSizePixel = 0
                    knob2.Size = UDim2.new(0, 10, 0, 10)
                    knob2.AnchorPoint = Vector2.new(0.5, 0.5)
                    knob2.Position = UDim2.new(startV / 255, 0, 0.5, 0)
                    makeCorner(knob2, 5)
                    knob2.Parent = track2

                    local numBox = Instance.new("TextBox")
                    numBox.Text = tostring(math.floor(startV))
                    numBox.TextSize = 11
                    numBox.Font = Enum.Font.Gotham
                    numBox.TextColor3 = T.Text
                    numBox.BackgroundColor3 = T.Background
                    numBox.BorderSizePixel = 0
                    numBox.Size = UDim2.new(0, 44, 0, 22)
                    numBox.Position = UDim2.new(1, -52, 0.5, -11)
                    numBox.ZIndex = 11
                    makeCorner(numBox, 4)
                    numBox.Parent = ch

                    return fill2, knob2, numBox, track2
                end

                local r2, g2, b2 = color.R * 255, color.G * 255, color.B * 255
                local rFill, rKnob, rBox, rTrack = makeChannel("R", 1, r2)
                local gFill, gKnob, gBox, gTrack = makeChannel("G", 2, g2)
                local bFill, bKnob, bBox, bTrack = makeChannel("B", 3, b2)

                local function applyColor()
                    color = Color3.fromRGB(r2, g2, b2)
                    colorPreview.BackgroundColor3 = color
                    pcall(cb, color)
                end

                local function setupDrag(fill3, knob3, track3, ref)
                    local drag = false
                    track3.InputBegan:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1
                        or inp.UserInputType == Enum.UserInputType.Touch then
                            drag = true
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(inp)
                        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement
                        or inp.UserInputType == Enum.UserInputType.Touch) then
                            local pct = math.clamp((inp.Position.X - track3.AbsolutePosition.X) / track3.AbsoluteSize.X, 0, 1)
                            fill3.Size = UDim2.new(pct, 0, 1, 0)
                            knob3.Position = UDim2.new(pct, 0, 0.5, 0)
                            ref[1] = math.floor(pct * 255)
                            applyColor()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1
                        or inp.UserInputType == Enum.UserInputType.Touch then
                            drag = false
                        end
                    end)
                end

                local rv, gv, bv = {r2}, {g2}, {b2}
                setupDrag(rFill, rKnob, rTrack, rv)
                setupDrag(gFill, gKnob, gTrack, gv)
                setupDrag(bFill, bKnob, bTrack, bv)

                colorPreview.MouseButton1Click:Connect(function()
                    open2 = not open2
                    tween(picker, {Size = UDim2.new(1, -24, 0, open2 and 108 or 0)}, 0.2)
                end)

                table.insert(section._elements, el)
                function el:GetValue()            return color           end
                function el:SetValue(c)           color = c; colorPreview.BackgroundColor3 = c end
                function el:ColorCallback(fn)     cb = fn               end
                return el
            end

            table.insert(tab._sections, section)
            return section
        end -- CreateSection

        return tab
    end -- CreateTab

    return win
end -- CreateWindow

-- ============================================================
-- THEME API
-- ============================================================
function BloodLibrary:SetTheme(name)
    if self.Themes[name] then
        self.CurrentTheme = self.Themes[name]
    end
end

function BloodLibrary:AddTheme(name, themeTable)
    self.Themes[name] = themeTable
end

-- ============================================================
-- EXTERNAL SCRIPT SUPPORT
-- ============================================================
-- Usage from another script:
--   local Lib = loadstring(game:HttpGet("RAW_URL"))()
--   local win = Lib:CreateWindow({Title = "My Script"})
--   local tab = win:AddTab({Title = "Main"})
--   local sec = tab:AddSection({Title = "Player"})
--   sec:AddToggle({Name = "God Mode", Callback = function(v) ... end})

return BloodLibrary
