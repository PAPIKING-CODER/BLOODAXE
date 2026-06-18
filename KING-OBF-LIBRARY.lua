-- KOD UI LIB v3.0 | Gradientes + Particulas + Animaciones
-- by KING | Para Gist
local KODUI = {}
KODUI.__index = KODUI

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function getui()
    if gethui then return gethui() end
    if get_hidden_gui then return get_hidden_gui() end
    return game:GetService("CoreGui")
end

local function Tween(obj, props, time, style, dir)
    local tween = TweenService:Create(obj, TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

local function Ripple(button)
    local mouse = game.Players.LocalPlayer:GetMouse()
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.BorderSizePixel = 0
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0, mouse.X - button.AbsolutePosition.X, 0, mouse.Y - button.AbsolutePosition.Y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Parent = button
    Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
    
    Tween(ripple, {Size = UDim2.new(0, button.AbsoluteSize.X * 1.5, 0, button.AbsoluteSize.X * 1.5), BackgroundTransparency = 1}, 0.5)
    task.delay(0.5, function() ripple:Destroy() end)
end

local function Particle(obj)
    for i = 1, 6 do
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
        p.Position = UDim2.new(0.5, math.random(-20,20), 0.5, math.random(-20,20))
        p.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
        p.BorderSizePixel = 0
        p.Parent = obj
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        
        Tween(p, {
            Position = UDim2.new(0.5, math.random(-60,60), 0.5, math.random(-60,60)),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, 0)
        }, 0.6)
        task.delay(0.6, function() p:Destroy() end)
    end
end

function KODUI:CreateWindow(config)
    config = config or {}
    local self = setmetatable({}, KODUI)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KODUI_"..math.random(1000,9999)
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = getui()
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = config.Size or UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    
    -- Gradiente de fondo animado
    local BGGradient = Instance.new("UIGradient")
    BGGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 15, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }
    BGGradient.Rotation = 45
    BGGradient.Parent = Main
    
    task.spawn(function()
        while Main.Parent do
            Tween(BGGradient, {Rotation = BGGradient.Rotation + 360}, 8, Enum.EasingStyle.Linear)
            task.wait(8)
        end
    end)
    
    -- Glow exterior
    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1, 40, 1, 40)
    Glow.Position = UDim2.new(0, -20, 0, -20)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://5028857084"
    Glow.ImageColor3 = config.Accent or Color3.fromRGB(138, 43, 226)
    Glow.ImageTransparency = 0.3
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(24, 24, 276, 276)
    Glow.ZIndex = 0
    Glow.Parent = Main
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 140, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)
    
    local SideGradient = Instance.new("UIGradient")
    SideGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 35))
    }
    SideGradient.Rotation = 90
    SideGradient.Parent = Sidebar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 50)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "KOD UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Sidebar
    
    local TabHolder = Instance.new("ScrollingFrame")
    TabHolder.Size = UDim2.new(1, -10, 1, -70)
    TabHolder.Position = UDim2.new(0, 5, 0, 65)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabHolder.Parent = Sidebar
    
    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabHolder
    
    -- Content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -150, 1, -10)
    Content.Position = UDim2.new(0, 145, 0, 5)
    Content.BackgroundTransparency = 1
    Content.Parent = Main
    
    -- Close
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Main
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    -- Drag
    local dragging, dragInput, dragStart, startPos
    Sidebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Sidebar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    self.Gui = ScreenGui
    self.Main = Main
    self.Sidebar = Sidebar
    self.TabHolder = TabHolder
    self.Content = Content
    self.Tabs = {}
    self.Accent = config.Accent or Color3.fromRGB(138, 43, 226)
    
    -- Entrada animada
    Main.Position = UDim2.new(0.5, -250, 1.5, 0)
    Tween(Main, {Position = UDim2.new(0.5, -250, 0.5, -175)}, 0.5, Enum.EasingStyle.Back)
    
    return self
end

function KODUI:CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TabBtn.Text = "  "..(icon or "📁").."  "..name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = self.TabHolder
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = self.Accent
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabContent.Visible = false
    TabContent.Parent = self.Content
    
    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 8)
    List.Parent = TabContent
    
    local Pad = Instance.new("UIPadding")
    Pad.PaddingLeft = UDim.new(0, 10)
    Pad.PaddingRight = UDim.new(0, 10)
    Pad.PaddingTop = UDim.new(0, 10)
    Pad.Parent = TabContent
    
    local tab = {Button = TabBtn, Content = TabContent}
    table.insert(self.Tabs, tab)
    
    if #self.Tabs == 1 then
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = self.Accent
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Content.Visible = false
            Tween(t.Button, {BackgroundColor3 = Color3.fromRGB(20, 20, 30), TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.2)
        end
        TabContent.Visible = true
        Tween(TabBtn, {BackgroundColor3 = self.Accent, TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
        Ripple(TabBtn)
    end)
    
    local api = {}
    
    function api:AddButton(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 38)
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.TextSize = 14
        Btn.Font = Enum.Font.GothamSemibold
        Btn.AutoButtonColor = false
        Btn.Parent = TabContent
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
        
        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
        }
        Gradient.Rotation = 90
        Gradient.Parent = Btn
        
        Btn.MouseEnter:Connect(function()
            Tween(Btn, {BackgroundColor3 = self.Accent}, 0.2)
        end)
        Btn.MouseLeave:Connect(function()
            Tween(Btn, {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}, 0.2)
        end)
        Btn.MouseButton1Click:Connect(function()
            Ripple(Btn)
            Particle(Btn)
            if callback then callback() end
        end)
        return Btn
    end
    
    function api:AddToggle(text, default, callback)
        local state = default or false
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 38)
        Container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Container.Parent = TabContent
        Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 14
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container
        
        local Toggle = Instance.new("Frame")
        Toggle.Size = UDim2.new(0, 45, 0, 22)
        Toggle.Position = UDim2.new(1, -50, 0.5, -11)
        Toggle.BackgroundColor3 = state and self.Accent or Color3.fromRGB(50, 50, 60)
        Toggle.Parent = Container
        Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
        
        local Circle = Instance.new("Frame")
        Circle.Size = UDim2.new(0, 18, 0, 18)
        Circle.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Circle.Parent = Toggle
        Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
        
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.BackgroundTransparency = 1
        Btn.Text = ""
        Btn.Parent = Container
        
        Btn.MouseButton1Click:Connect(function()
            state = not state
            Tween(Toggle, {BackgroundColor3 = state and self.Accent or Color3.fromRGB(50, 50, 60)}, 0.2)
            Tween(Circle, {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.2, Enum.EasingStyle.Back)
            Particle(Circle)
            if callback then callback(state) end
        end)
        return {Set = function(v) state = v end, Get = function() return state end}
    end
    
    function api:AddDropdown(text, options, callback)
        local open = false
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 38)
        Container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Container.ClipsDescendants = true
        Container.Parent = TabContent
        Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
        
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 38)
        Btn.BackgroundTransparency = 1
        Btn.Text = text.."  ▼"
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.TextSize = 14
        Btn.Font = Enum.Font.GothamSemibold
        Btn.Parent = Container
        
        local List = Instance.new("Frame")
        List.Size = UDim2.new(1, 0, 0, #options * 30)
        List.Position = UDim2.new(0, 0, 0, 38)
        List.BackgroundTransparency = 1
        List.Parent = Container
        
        local ListLayout = Instance.new("UIListLayout")
        ListLayout.Padding = UDim.new(0, 2)
        ListLayout.Parent = List
        
        for _, opt in ipairs(options) do
            local OptBtn = Instance.new("TextButton")
            OptBtn.Size = UDim2.new(1, 0, 0, 28)
            OptBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            OptBtn.Text = opt
            OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            OptBtn.TextSize = 13
            OptBtn.Font = Enum.Font.Gotham
            OptBtn.Parent = List
            Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)
            
            OptBtn.MouseButton1Click:Connect(function()
                Btn.Text = text..": "..opt
                open = false
                Tween(Container, {Size = UDim2.new(1, 0, 0, 38)}, 0.2)
                if callback then callback(opt) end
            end)
        end
        
        Btn.MouseButton1Click:Connect(function()
            open = not open
            if open then
                Tween(Container, {Size = UDim2.new(1, 0, 0, 38 + #options * 32)}, 0.3, Enum.EasingStyle.Quart)
            else
                Tween(Container, {Size = UDim2.new(1, 0, 0, 38)}, 0.3, Enum.EasingStyle.Quart)
            end
        end)
        return Container
    end
    
    function api:AddSlider(text, min, max, default, callback)
        local value = default or min
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 50)
        Container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Container.Parent = TabContent
        Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 20)
        Label.Position = UDim2.new(0, 10, 0, 5)
        Label.BackgroundTransparency = 1
        Label.Text = text..": "..value
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 14
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container
        
        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(1, -20, 0, 6)
        SliderBg.Position = UDim2.new(0, 10, 0, 30)
        SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        SliderBg.Parent = Container
        Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        SliderFill.BackgroundColor3 = self.Accent
        SliderFill.Parent = SliderBg
        Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
        
        local dragging = false
        SliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local percent = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * percent)
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                Label.Text = text..": "..value
                if callback then callback(value) end
            end
        end)
        return {Set = function(v) value = v end, Get = function() return value end}
    end
    
    return api
end

return KODUI
