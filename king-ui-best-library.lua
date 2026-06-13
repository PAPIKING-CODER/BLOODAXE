local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KODBloodUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Themes = {
    Blood = {
        Background = Color3.fromRGB(10, 10, 10),
        Panel = Color3.fromRGB(18, 18, 18),
        Secondary = Color3.fromRGB(25, 25, 25),
        Stroke = Color3.fromRGB(120, 0, 0),
        Accent = Color3.fromRGB(200, 0, 0),
        Text = Color3.fromRGB(255, 255, 255),
        DarkText = Color3.fromRGB(170, 170, 170),
        ToggleOff = Color3.fromRGB(40, 40, 40),
        ToggleOn = Color3.fromRGB(200, 0, 0),
        SliderTrack = Color3.fromRGB(30, 30, 30),
        SliderFill = Color3.fromRGB(200, 0, 0),
        Dropdown = Color3.fromRGB(20, 20, 20),
        TabSelected = Color3.fromRGB(180, 0, 0),
        TabHover = Color3.fromRGB(100, 0, 0)
    },
    Dark = {
        Background = Color3.fromRGB(15, 15, 15),
        Panel = Color3.fromRGB(25, 25, 25),
        Secondary = Color3.fromRGB(35, 35, 35),
        Stroke = Color3.fromRGB(80, 80, 80),
        Accent = Color3.fromRGB(50, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        DarkText = Color3.fromRGB(180, 180, 180),
        ToggleOff = Color3.fromRGB(40, 40, 40),
        ToggleOn = Color3.fromRGB(70, 70, 70),
        SliderTrack = Color3.fromRGB(30, 30, 30),
        SliderFill = Color3.fromRGB(80, 80, 80),
        Dropdown = Color3.fromRGB(20, 20, 20),
        TabSelected = Color3.fromRGB(60, 60, 60),
        TabHover = Color3.fromRGB(40, 40, 40)
    }
}

local CurrentTheme = "Blood"
local WindowInstances = {}

local function GetThemeColor(key)
    return Themes[CurrentTheme] and Themes[CurrentTheme][key] or Themes["Blood"][key]
end

local function CreateCorner(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = frame
    return corner
end

local function CreateStroke(frame, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or GetThemeColor("Stroke")
    stroke.Thickness = thickness or 1.5
    stroke.Transparency = transparency or 0.3
    stroke.Parent = frame
    return stroke
end

local function CreateRipple(button, color)
    local ripple = Instance.new("ImageLabel")
    ripple.Name = "Ripple"
    ripple.BackgroundTransparency = 1
    ripple.Image = "rbxassetid://7733813662"
    ripple.ImageColor3 = color or GetThemeColor("Accent")
    ripple.ImageTransparency = 0.6
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.ZIndex = 10
    ripple.Parent = button
    local tween = TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(3, 0, 3, 0), ImageTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

function Library.SetTheme(themeName)
    if Themes[themeName] then
        CurrentTheme = themeName
        for _, win in pairs(WindowInstances) do
            if win.UpdateTheme then win:UpdateTheme() end
        end
        return true
    end
    return false
end

function Library.Notify(data)
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 300, 0, 70)
    notifyFrame.Position = UDim2.new(1.1, 0, 0.9, 0)
    notifyFrame.BackgroundColor3 = GetThemeColor("Panel")
    notifyFrame.BackgroundTransparency = 0.1
    notifyFrame.BorderSizePixel = 0
    notifyFrame.Parent = ScreenGui
    CreateCorner(notifyFrame, 8)
    CreateStroke(notifyFrame, GetThemeColor("Stroke"), 1, 0.2)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0.35, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = data.Title or "KOD"
    titleLabel.TextColor3 = GetThemeColor("Accent")
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notifyFrame
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -20, 0.65, -5)
    contentLabel.Position = UDim2.new(0, 10, 0.35, 0)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = data.Content or ""
    contentLabel.TextColor3 = GetThemeColor("Text")
    contentLabel.TextSize = 13
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.Parent = notifyFrame
    local tweenIn = TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.85, -320, 0.9, 0)})
    tweenIn:Play()
    tweenIn.Completed:Connect(function()
        task.delay(data.Duration or 4, function()
            local tweenOut = TweenService:Create(notifyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1.1, 0, 0.9, 0), BackgroundTransparency = 1})
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                notifyFrame:Destroy()
            end)
        end)
    end)
    return notifyFrame
end

local function CreateWindow(data)
    local self = {}
    local windowSize = data.Size or Vector2.new(700, 500)
    local minSize = data.MinSize or Vector2.new(400, 300)
    local maxSize = data.MaxSize or Vector2.new(1200, 800)
    local windowTitle = data.Name or "KOD Blood Hub"
    local toggleKey = data.ToggleKey or Enum.KeyCode.RightShift
    if data.Theme then CurrentTheme = data.Theme end

    local windowFrame = Instance.new("Frame")
    windowFrame.Size = UDim2.new(0, windowSize.X, 0, windowSize.Y)
    windowFrame.Position = UDim2.new(0.5, -windowSize.X/2, 0.5, -windowSize.Y/2)
    windowFrame.BackgroundColor3 = GetThemeColor("Background")
    windowFrame.BackgroundTransparency = 0.05
    windowFrame.BorderSizePixel = 0
    windowFrame.Parent = ScreenGui
    windowFrame.Visible = true
    CreateCorner(windowFrame, 12)
    CreateStroke(windowFrame, GetThemeColor("Stroke"), 1.5, 0.2)

    local headerFrame = Instance.new("Frame")
    headerFrame.Size = UDim2.new(1, 0, 0, 50)
    headerFrame.Position = UDim2.new(0, 0, 0, 0)
    headerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    headerFrame.BackgroundTransparency = 0.3
    headerFrame.BorderSizePixel = 0
    headerFrame.Parent = windowFrame
    CreateCorner(headerFrame, 12)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 0, 30)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = windowTitle
    titleLabel.TextColor3 = GetThemeColor("Text")
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = headerFrame

    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0, 150, 0, 20)
    subtitleLabel.Position = UDim2.new(0, 15, 0, 30)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "Premium UI Library"
    subtitleLabel.TextColor3 = GetThemeColor("DarkText")
    subtitleLabel.TextSize = 12
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = headerFrame

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -90, 0, 10)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    minimizeBtn.TextSize = 18
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Parent = headerFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -50, 0, 10)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = headerFrame

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 160, 1, -50)
    sidebar.Position = UDim2.new(0, 0, 0, 50)
    sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sidebar.BackgroundTransparency = 0.4
    sidebar.BorderSizePixel = 0
    sidebar.Parent = windowFrame
    CreateCorner(sidebar, 12)

    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -170, 1, -60)
    contentContainer.Position = UDim2.new(0, 160, 0, 55)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = windowFrame

    local resizeHandle = Instance.new("Frame")
    resizeHandle.Size = UDim2.new(0, 12, 0, 12)
    resizeHandle.Position = UDim2.new(1, -12, 1, -12)
    resizeHandle.BackgroundColor3 = GetThemeColor("Accent")
    resizeHandle.BackgroundTransparency = 0.3
    resizeHandle.Parent = windowFrame
    CreateCorner(resizeHandle, 3)

    local tabButtons = {}
    local tabContents = {}
    local currentTab = nil

    local function AddTab(tabName, tabIcon)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, -10, 0, 40)
        tabBtn.Position = UDim2.new(0, 5, 0, #tabButtons * 45 + 5)
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabBtn.BackgroundTransparency = 0.8
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = "  " .. tabName
        tabBtn.TextColor3 = GetThemeColor("DarkText")
        tabBtn.TextSize = 14
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextXAlignment = Enum.TextXAlignment.Left
        tabBtn.Parent = sidebar
        CreateCorner(tabBtn, 6)

        if tabIcon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 18, 0, 18)
            icon.Position = UDim2.new(0, 8, 0.5, -9)
            icon.BackgroundTransparency = 1
            icon.Image = tabIcon
            icon.ImageColor3 = GetThemeColor("DarkText")
            icon.Parent = tabBtn
        end

        local tabIndicator = Instance.new("Frame")
        tabIndicator.Size = UDim2.new(0, 3, 0.6, 0)
        tabIndicator.Position = UDim2.new(0, 0, 0.2, 0)
        tabIndicator.BackgroundColor3 = GetThemeColor("Accent")
        tabIndicator.BackgroundTransparency = 1
        tabIndicator.Parent = tabBtn
        CreateCorner(tabIndicator, 2)

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollBarImageColor3 = GetThemeColor("Accent")
        tabContent.ScrollBarImageTransparency = 0.5
        tabContent.Visible = false
        tabContent.Parent = contentContainer

        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.Parent = tabContent
        local contentPadding = Instance.new("UIPadding")
        contentPadding.PaddingLeft = UDim.new(0, 10)
        contentPadding.PaddingRight = UDim.new(0, 10)
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingBottom = UDim.new(0, 10)
        contentPadding.Parent = tabContent

        local function SelectTab()
            if currentTab then
                local oldBtn = tabButtons[currentTab]
                if oldBtn then
                    oldBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    oldBtn.BackgroundTransparency = 0.8
                    oldBtn.TextColor3 = GetThemeColor("DarkText")
                    local oldInd = oldBtn:FindFirstChild("Indicator")
                    if oldInd then
                        TweenService:Create(oldInd, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
                    end
                end
                local oldContent = tabContents[currentTab]
                if oldContent then
                    oldContent.Visible = false
                end
            end
            currentTab = tabName
            local newBtn = tabBtn
            newBtn.BackgroundColor3 = GetThemeColor("TabSelected")
            newBtn.BackgroundTransparency = 0.3
            newBtn.TextColor3 = GetThemeColor("Text")
            local newInd = newBtn:FindFirstChild("Indicator")
            if newInd then
                TweenService:Create(newInd, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
            end
            local newContent = tabContent
            newContent.Visible = true
            newContent.CanvasSize = UDim2.new(0, 0, 0, newContent.ContentLayout.AbsoluteContentSize.Y + 20)
        end

        tabBtn.MouseButton1Click:Connect(SelectTab)
        tabBtn.MouseEnter:Connect(function()
            if currentTab ~= tabName then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("TabHover"), BackgroundTransparency = 0.5, TextColor3 = GetThemeColor("Text")}):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if currentTab ~= tabName then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, TextColor3 = GetThemeColor("DarkText")}):Play()
            end
        end)

        table.insert(tabButtons, tabBtn)
        tabContents[tabName] = tabContent
        if #tabButtons == 1 then SelectTab() end

        local tabAPI = {}

        function tabAPI:AddSection(sectionName)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, 0, 0, 35)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            sectionFrame.BackgroundTransparency = 0.4
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Parent = tabContent
            CreateCorner(sectionFrame, 8)
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Size = UDim2.new(1, -15, 1, 0)
            sectionLabel.Position = UDim2.new(0, 10, 0, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = sectionName
            sectionLabel.TextColor3 = GetThemeColor("Accent")
            sectionLabel.TextSize = 15
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.Parent = sectionFrame
            return sectionFrame
        end

        function tabAPI:AddButton(btnData)
            local name = btnData.Name or "Button"
            local callback = btnData.Callback or function() end
            local btnFrame = Instance.new("Frame")
            btnFrame.Size = UDim2.new(1, 0, 0, 40)
            btnFrame.BackgroundColor3 = GetThemeColor("Panel")
            btnFrame.BackgroundTransparency = 0.3
            btnFrame.BorderSizePixel = 0
            btnFrame.Parent = tabContent
            CreateCorner(btnFrame, 8)
            CreateStroke(btnFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = "  " .. name
            btn.TextColor3 = GetThemeColor("Text")
            btn.TextSize = 14
            btn.Font = Enum.Font.Gotham
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Parent = btnFrame
            btn.MouseButton1Click:Connect(function()
                CreateRipple(btn, GetThemeColor("Accent"))
                task.spawn(callback)
            end)
            btn.MouseEnter:Connect(function()
                TweenService:Create(btnFrame, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("Accent"), BackgroundTransparency = 0.2}):Play()
                TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btnFrame, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("Panel"), BackgroundTransparency = 0.3}):Play()
                TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = GetThemeColor("Text")}):Play()
            end)
            return btn
        end

        function tabAPI:AddToggle(toggleData)
            local name = toggleData.Name or "Toggle"
            local default = toggleData.Default or false
            local callback = toggleData.Callback or function() end
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, 0, 0, 45)
            toggleFrame.BackgroundColor3 = GetThemeColor("Panel")
            toggleFrame.BackgroundTransparency = 0.3
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = tabContent
            CreateCorner(toggleFrame, 8)
            CreateStroke(toggleFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.6, -10, 0.7, 0)
            toggleLabel.Position = UDim2.new(0, 10, 0, 2)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = "  " .. name
            toggleLabel.TextColor3 = GetThemeColor("Text")
            toggleLabel.TextSize = 14
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            local descLabel = Instance.new("TextLabel")
            descLabel.Size = UDim2.new(0.6, -10, 0.3, 0)
            descLabel.Position = UDim2.new(0, 10, 0.6, 0)
            descLabel.BackgroundTransparency = 1
            descLabel.Text = toggleData.Description or ""
            descLabel.TextColor3 = GetThemeColor("DarkText")
            descLabel.TextSize = 11
            descLabel.Font = Enum.Font.Gotham
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.Parent = toggleFrame
            local toggleSwitch = Instance.new("Frame")
            toggleSwitch.Size = UDim2.new(0, 44, 0, 22)
            toggleSwitch.Position = UDim2.new(1, -54, 0.5, -11)
            toggleSwitch.BackgroundColor3 = GetThemeColor("ToggleOff")
            toggleSwitch.BorderSizePixel = 0
            toggleSwitch.Parent = toggleFrame
            CreateCorner(toggleSwitch, 11)
            local toggleCircle = Instance.new("Frame")
            toggleCircle.Size = UDim2.new(0, 18, 0, 18)
            toggleCircle.Position = UDim2.new(0, 2, 0.5, -9)
            toggleCircle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            toggleCircle.BorderSizePixel = 0
            toggleCircle.Parent = toggleSwitch
            CreateCorner(toggleCircle, 9)
            local toggleState = default
            local function UpdateToggle(state)
                toggleState = state
                if state then
                    TweenService:Create(toggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = GetThemeColor("ToggleOn")}):Play()
                    TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -20, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                else
                    TweenService:Create(toggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = GetThemeColor("ToggleOff")}):Play()
                    TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
                end
                task.spawn(callback, state)
            end
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(1, 0, 1, 0)
            toggleBtn.BackgroundTransparency = 1
            toggleBtn.Text = ""
            toggleBtn.Parent = toggleFrame
            toggleBtn.MouseButton1Click:Connect(function()
                UpdateToggle(not toggleState)
            end)
            UpdateToggle(toggleState)
            return toggleState
        end

        function tabAPI:AddSlider(sliderData)
            local name = sliderData.Name or "Slider"
            local min = sliderData.Min or 0
            local max = sliderData.Max or 100
            local default = sliderData.Default or 0
            local callback = sliderData.Callback or function() end
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, 0, 0, 55)
            sliderFrame.BackgroundColor3 = GetThemeColor("Panel")
            sliderFrame.BackgroundTransparency = 0.3
            sliderFrame.BorderSizePixel = 0
            sliderFrame.Parent = tabContent
            CreateCorner(sliderFrame, 8)
            CreateStroke(sliderFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(0.6, 0, 0.4, 0)
            sliderLabel.Position = UDim2.new(0, 10, 0, 2)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = "  " .. name
            sliderLabel.TextColor3 = GetThemeColor("Text")
            sliderLabel.TextSize = 14
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
            valueLabel.Position = UDim2.new(0.7, 0, 0, 2)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(default)
            valueLabel.TextColor3 = GetThemeColor("Accent")
            valueLabel.TextSize = 14
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = sliderFrame
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Size = UDim2.new(1, -20, 0, 4)
            sliderTrack.Position = UDim2.new(0, 10, 0.7, 0)
            sliderTrack.BackgroundColor3 = GetThemeColor("SliderTrack")
            sliderTrack.BorderSizePixel = 0
            sliderTrack.Parent = sliderFrame
            CreateCorner(sliderTrack, 2)
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new(0, 0, 1, 0)
            sliderFill.Position = UDim2.new(0, 0, 0, 0)
            sliderFill.BackgroundColor3 = GetThemeColor("SliderFill")
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderTrack
            CreateCorner(sliderFill, 2)
            local sliderKnob = Instance.new("Frame")
            sliderKnob.Size = UDim2.new(0, 14, 0, 14)
            sliderKnob.Position = UDim2.new(0, 0, 0.5, -7)
            sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sliderKnob.BorderSizePixel = 0
            sliderKnob.Parent = sliderTrack
            CreateCorner(sliderKnob, 7)
            local currentVal = default
            local function UpdateSlider(value)
                currentVal = math.clamp(value, min, max)
                local percent = (currentVal - min) / (max - min)
                sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                sliderKnob.Position = UDim2.new(percent, -7, 0.5, -7)
                valueLabel.Text = tostring(math.floor(currentVal))
                task.spawn(callback, currentVal)
            end
            local dragging = false
            local function GetSliderValue(input)
                local x = input.Position.X - sliderTrack.AbsolutePosition.X
                local percent = math.clamp(x / sliderTrack.AbsoluteSize.X, 0, 1)
                return min + percent * (max - min)
            end
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
            end)
            sliderKnob.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local val = GetSliderValue(input)
                    UpdateSlider(val)
                    dragging = true
                end
            end)
            sliderTrack.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local val = GetSliderValue(input)
                    UpdateSlider(val)
                end
            end)
            UpdateSlider(currentVal)
            return currentVal
        end

        function tabAPI:AddDropdown(dropdownData)
            local name = dropdownData.Name or "Dropdown"
            local items = dropdownData.Options or dropdownData.Items or {}
            local default = dropdownData.Default
            local callback = dropdownData.Callback or function() end
            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Size = UDim2.new(1, 0, 0, 45)
            dropdownFrame.BackgroundColor3 = GetThemeColor("Panel")
            dropdownFrame.BackgroundTransparency = 0.3
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.Parent = tabContent
            CreateCorner(dropdownFrame, 8)
            CreateStroke(dropdownFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local dropdownLabel = Instance.new("TextLabel")
            dropdownLabel.Size = UDim2.new(0.6, 0, 1, 0)
            dropdownLabel.Position = UDim2.new(0, 10, 0, 0)
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Text = "  " .. name
            dropdownLabel.TextColor3 = GetThemeColor("Text")
            dropdownLabel.TextSize = 14
            dropdownLabel.Font = Enum.Font.Gotham
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            dropdownLabel.Parent = dropdownFrame
            local dropdownBtn = Instance.new("TextButton")
            dropdownBtn.Size = UDim2.new(0.35, -5, 1, -10)
            dropdownBtn.Position = UDim2.new(0.65, 0, 0.5, -12.5)
            dropdownBtn.BackgroundColor3 = GetThemeColor("Dropdown")
            dropdownBtn.BackgroundTransparency = 0.5
            dropdownBtn.Text = default or "Select"
            dropdownBtn.TextColor3 = GetThemeColor("Text")
            dropdownBtn.TextSize = 12
            dropdownBtn.Font = Enum.Font.Gotham
            dropdownBtn.Parent = dropdownFrame
            CreateCorner(dropdownBtn, 4)
            local dropdownList = Instance.new("ScrollingFrame")
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
            dropdownList.Position = UDim2.new(0, 0, 1, 0)
            dropdownList.BackgroundColor3 = GetThemeColor("Dropdown")
            dropdownList.BackgroundTransparency = 0.1
            dropdownList.BorderSizePixel = 0
            dropdownList.Visible = false
            dropdownList.ClipsDescendants = true
            dropdownList.ScrollBarThickness = 2
            dropdownList.ScrollBarImageColor3 = GetThemeColor("Accent")
            dropdownList.Parent = dropdownFrame
            CreateCorner(dropdownList, 6)
            local listLayout = Instance.new("UIListLayout")
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Padding = UDim.new(0, 2)
            listLayout.Parent = dropdownList
            local listPadding = Instance.new("UIPadding")
            listPadding.PaddingLeft = UDim.new(0, 5)
            listPadding.PaddingRight = UDim.new(0, 5)
            listPadding.PaddingTop = UDim.new(0, 5)
            listPadding.PaddingBottom = UDim.new(0, 5)
            listPadding.Parent = dropdownList
            local selectedItem = default
            local function PopulateDropdown()
                for _, child in pairs(dropdownList:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, item in pairs(items) do
                    local itemBtn = Instance.new("TextButton")
                    itemBtn.Size = UDim2.new(1, 0, 0, 30)
                    itemBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    itemBtn.BackgroundTransparency = 0.5
                    itemBtn.Text = "  " .. item
                    itemBtn.TextColor3 = GetThemeColor("DarkText")
                    itemBtn.TextSize = 12
                    itemBtn.Font = Enum.Font.Gotham
                    itemBtn.TextXAlignment = Enum.TextXAlignment.Left
                    itemBtn.Parent = dropdownList
                    CreateCorner(itemBtn, 4)
                    itemBtn.MouseButton1Click:Connect(function()
                        selectedItem = item
                        dropdownBtn.Text = item
                        dropdownBtn.TextColor3 = GetThemeColor("Accent")
                        dropdownList.Visible = false
                        dropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                        task.spawn(callback, item)
                    end)
                    itemBtn.MouseEnter:Connect(function()
                        TweenService:Create(itemBtn, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("Accent"), BackgroundTransparency = 0.3, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end)
                    itemBtn.MouseLeave:Connect(function()
                        TweenService:Create(itemBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, TextColor3 = GetThemeColor("DarkText")}):Play()
                    end)
                end
                local itemCount = 0
                for _, child in pairs(dropdownList:GetChildren()) do
                    if child:IsA("TextButton") then itemCount = itemCount + 1 end
                end
                local height = math.min(itemCount * 32 + 10, 150)
                dropdownList.Size = UDim2.new(1, 0, 0, height)
            end
            dropdownBtn.MouseButton1Click:Connect(function()
                dropdownList.Visible = not dropdownList.Visible
                if dropdownList.Visible then
                    dropdownFrame.Size = UDim2.new(1, 0, 0, 45 + dropdownList.AbsoluteSize.Y)
                else
                    dropdownFrame.Size = UDim2.new(1, 0, 0, 45)
                end
            end)
            PopulateDropdown()
            if selectedItem then
                dropdownBtn.Text = selectedItem
                dropdownBtn.TextColor3 = GetThemeColor("Accent")
            end
            return dropdownFrame
        end

        function tabAPI:AddTextbox(textboxData)
            local name = textboxData.Name or "Input"
            local placeholder = textboxData.Placeholder or "Type here..."
            local default = textboxData.Default or ""
            local callback = textboxData.Callback or function() end
            local textboxFrame = Instance.new("Frame")
            textboxFrame.Size = UDim2.new(1, 0, 0, 45)
            textboxFrame.BackgroundColor3 = GetThemeColor("Panel")
            textboxFrame.BackgroundTransparency = 0.3
            textboxFrame.BorderSizePixel = 0
            textboxFrame.Parent = tabContent
            CreateCorner(textboxFrame, 8)
            CreateStroke(textboxFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local textboxLabel = Instance.new("TextLabel")
            textboxLabel.Size = UDim2.new(0.5, 0, 1, 0)
            textboxLabel.Position = UDim2.new(0, 10, 0, 0)
            textboxLabel.BackgroundTransparency = 1
            textboxLabel.Text = "  " .. name
            textboxLabel.TextColor3 = GetThemeColor("Text")
            textboxLabel.TextSize = 14
            textboxLabel.Font = Enum.Font.Gotham
            textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
            textboxLabel.Parent = textboxFrame
            local inputBox = Instance.new("TextBox")
            inputBox.Size = UDim2.new(0.5, -10, 1, -10)
            inputBox.Position = UDim2.new(0.5, 0, 0.5, -12.5)
            inputBox.BackgroundColor3 = GetThemeColor("Dropdown")
            inputBox.BackgroundTransparency = 0.5
            inputBox.Text = default
            inputBox.TextColor3 = GetThemeColor("Text")
            inputBox.TextSize = 12
            inputBox.Font = Enum.Font.Gotham
            inputBox.PlaceholderText = placeholder
            inputBox.PlaceholderColor3 = GetThemeColor("DarkText")
            inputBox.Parent = textboxFrame
            CreateCorner(inputBox, 4)
            inputBox.FocusLost:Connect(function()
                task.spawn(callback, inputBox.Text)
            end)
            return inputBox
        end

        function tabAPI:AddKeybind(keybindData)
            local name = keybindData.Name or "Keybind"
            local defaultKey = keybindData.Key or "None"
            local callback = keybindData.Callback or function() end
            local keybindFrame = Instance.new("Frame")
            keybindFrame.Size = UDim2.new(1, 0, 0, 45)
            keybindFrame.BackgroundColor3 = GetThemeColor("Panel")
            keybindFrame.BackgroundTransparency = 0.3
            keybindFrame.BorderSizePixel = 0
            keybindFrame.Parent = tabContent
            CreateCorner(keybindFrame, 8)
            CreateStroke(keybindFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local keybindLabel = Instance.new("TextLabel")
            keybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
            keybindLabel.Position = UDim2.new(0, 10, 0, 0)
            keybindLabel.BackgroundTransparency = 1
            keybindLabel.Text = "  " .. name
            keybindLabel.TextColor3 = GetThemeColor("Text")
            keybindLabel.TextSize = 14
            keybindLabel.Font = Enum.Font.Gotham
            keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            keybindLabel.Parent = keybindFrame
            local keyBtn = Instance.new("TextButton")
            keyBtn.Size = UDim2.new(0.4, -10, 1, -10)
            keyBtn.Position = UDim2.new(0.6, 0, 0.5, -12.5)
            keyBtn.BackgroundColor3 = GetThemeColor("Dropdown")
            keyBtn.BackgroundTransparency = 0.5
            keyBtn.Text = defaultKey
            keyBtn.TextColor3 = GetThemeColor("Accent")
            keyBtn.TextSize = 12
            keyBtn.Font = Enum.Font.GothamBold
            keyBtn.Parent = keybindFrame
            CreateCorner(keyBtn, 4)
            local isBinding = false
            local boundKey = defaultKey
            keyBtn.MouseButton1Click:Connect(function()
                isBinding = not isBinding
                if isBinding then
                    keyBtn.Text = "..."
                    keyBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
                else
                    keyBtn.Text = boundKey
                    keyBtn.TextColor3 = GetThemeColor("Accent")
                end
            end)
            UserInputService.InputBegan:Connect(function(input)
                if isBinding then
                    local keyName = input.KeyCode.Name
                    if keyName and keyName ~= "Unknown" then
                        boundKey = keyName
                        keyBtn.Text = keyName
                        keyBtn.TextColor3 = GetThemeColor("Accent")
                        isBinding = false
                        task.spawn(callback, keyName)
                    end
                end
            end)
            return boundKey
        end

        function tabAPI:AddLabel(labelData)
            local text = labelData.Name or labelData.Text or "Label"
            local labelFrame = Instance.new("TextLabel")
            labelFrame.Size = UDim2.new(1, 0, 0, 25)
            labelFrame.BackgroundTransparency = 1
            labelFrame.Text = "  " .. text
            labelFrame.TextColor3 = GetThemeColor("DarkText")
            labelFrame.TextSize = 13
            labelFrame.Font = Enum.Font.Gotham
            labelFrame.TextXAlignment = Enum.TextXAlignment.Left
            labelFrame.Parent = tabContent
            return labelFrame
        end

        function tabAPI:AddParagraph(paraData)
            local text = paraData.Text or "Paragraph text here"
            local paraFrame = Instance.new("Frame")
            paraFrame.Size = UDim2.new(1, 0, 0, 40)
            paraFrame.BackgroundTransparency = 1
            paraFrame.Parent = tabContent
            local paraLabel = Instance.new("TextLabel")
            paraLabel.Size = UDim2.new(1, -10, 1, 0)
            paraLabel.Position = UDim2.new(0, 10, 0, 0)
            paraLabel.BackgroundTransparency = 1
            paraLabel.Text = text
            paraLabel.TextColor3 = GetThemeColor("DarkText")
            paraLabel.TextSize = 12
            paraLabel.Font = Enum.Font.Gotham
            paraLabel.TextXAlignment = Enum.TextXAlignment.Left
            paraLabel.TextWrapped = true
            paraLabel.Parent = paraFrame
            return paraFrame
        end

        function tabAPI:AddColorPicker(colorData)
            local name = colorData.Name or "Color Picker"
            local default = colorData.Default or GetThemeColor("Accent")
            local callback = colorData.Callback or function() end
            local pickerFrame = Instance.new("Frame")
            pickerFrame.Size = UDim2.new(1, 0, 0, 60)
            pickerFrame.BackgroundColor3 = GetThemeColor("Panel")
            pickerFrame.BackgroundTransparency = 0.3
            pickerFrame.BorderSizePixel = 0
            pickerFrame.Parent = tabContent
            CreateCorner(pickerFrame, 8)
            CreateStroke(pickerFrame, GetThemeColor("Stroke"), 0.5, 0.4)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.5, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = "  " .. name
            label.TextColor3 = GetThemeColor("Text")
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = pickerFrame
            local colorDisplay = Instance.new("Frame")
            colorDisplay.Size = UDim2.new(0, 40, 0, 30)
            colorDisplay.Position = UDim2.new(0.65, 0, 0.5, -15)
            colorDisplay.BackgroundColor3 = default
            colorDisplay.BorderSizePixel = 0
            colorDisplay.Parent = pickerFrame
            CreateCorner(colorDisplay, 4)
            CreateStroke(colorDisplay, GetThemeColor("Stroke"), 1, 0.3)
            local rInput = Instance.new("TextBox")
            rInput.Size = UDim2.new(0, 24, 0, 20)
            rInput.Position = UDim2.new(0.85, -40, 0.5, -10)
            rInput.BackgroundColor3 = GetThemeColor("Dropdown")
            rInput.BackgroundTransparency = 0.5
            rInput.Text = tostring(math.floor(default.R * 255))
            rInput.TextColor3 = GetThemeColor("Text")
            rInput.TextSize = 10
            rInput.Font = Enum.Font.Gotham
            rInput.PlaceholderText = "R"
            rInput.PlaceholderColor3 = GetThemeColor("DarkText")
            rInput.Parent = pickerFrame
            CreateCorner(rInput, 3)
            local gInput = Instance.new("TextBox")
            gInput.Size = UDim2.new(0, 24, 0, 20)
            gInput.Position = UDim2.new(0.85, 12, 0.5, -10)
            gInput.BackgroundColor3 = GetThemeColor("Dropdown")
            gInput.BackgroundTransparency = 0.5
            gInput.Text = tostring(math.floor(default.G * 255))
            gInput.TextColor3 = GetThemeColor("Text")
            gInput.TextSize = 10
            gInput.Font = Enum.Font.Gotham
            gInput.PlaceholderText = "G"
            gInput.PlaceholderColor3 = GetThemeColor("DarkText")
            gInput.Parent = pickerFrame
            CreateCorner(gInput, 3)
            local bInput = Instance.new("TextBox")
            bInput.Size = UDim2.new(0, 24, 0, 20)
            bInput.Position = UDim2.new(0.85, 64, 0.5, -10)
            bInput.BackgroundColor3 = GetThemeColor("Dropdown")
            bInput.BackgroundTransparency = 0.5
            bInput.Text = tostring(math.floor(default.B * 255))
            bInput.TextColor3 = GetThemeColor("Text")
            bInput.TextSize = 10
            bInput.Font = Enum.Font.Gotham
            bInput.PlaceholderText = "B"
            bInput.PlaceholderColor3 = GetThemeColor("DarkText")
            bInput.Parent = pickerFrame
            CreateCorner(bInput, 3)
            local function UpdateColorFromRGB()
                local r = tonumber(rInput.Text) or 0
                local g = tonumber(gInput.Text) or 0
                local b = tonumber(bInput.Text) or 0
                local color = Color3.fromRGB(math.clamp(r, 0, 255), math.clamp(g, 0, 255), math.clamp(b, 0, 255))
                colorDisplay.BackgroundColor3 = color
                task.spawn(callback, color)
            end
            rInput.FocusLost:Connect(UpdateColorFromRGB)
            gInput.FocusLost:Connect(UpdateColorFromRGB)
            bInput.FocusLost:Connect(UpdateColorFromRGB)
            return colorDisplay
        end

        function self:UpdateContentSize()
            for _, content in pairs(tabContents) do
                content.CanvasSize = UDim2.new(0, 0, 0, content.ContentLayout.AbsoluteContentSize.Y + 20)
            end
        end

        tabContent.ChildAdded:Connect(function() self:UpdateContentSize() end)
        tabContent.ChildRemoved:Connect(function() self:UpdateContentSize() end)

        return tabAPI
    end

    local dragStart = nil
    local startPos = nil
    local dragging = false
    headerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = windowFrame.Position
            dragging = true
        end
    end)
    headerFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            windowFrame.Position = newPos
        end
    end)

    local resizeDragging = false
    local resizeStart = nil
    local resizeStartSize = nil
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizeDragging = true
            resizeStart = input.Position
            resizeStartSize = windowFrame.Size
        end
    end)
    resizeHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizeDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizeDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local newWidth = math.clamp(resizeStartSize.X.Offset + delta.X, minSize.X, maxSize.X)
            local newHeight = math.clamp(resizeStartSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)
            windowFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)

    local windowMinimized = false
    local function MinimizeWindow()
        windowMinimized = not windowMinimized
        if windowMinimized then
            TweenService:Create(windowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(0, windowSize.X, 0, 50)}):Play()
            sidebar.Visible = false
            contentContainer.Visible = false
        else
            TweenService:Create(windowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(0, windowSize.X, 0, windowSize.Y)}):Play()
            sidebar.Visible = true
            contentContainer.Visible = true
        end
    end
    minimizeBtn.MouseButton1Click:Connect(MinimizeWindow)

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(windowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.3, function() windowFrame.Visible = false end)
    end)

    local windowOpen = true
    local function ToggleWindow()
        windowOpen = not windowOpen
        if windowOpen then
            windowFrame.Visible = true
            TweenService:Create(windowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.05, Size = UDim2.new(0, windowSize.X, 0, windowSize.Y)}):Play()
        else
            TweenService:Create(windowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
            task.delay(0.3, function() windowFrame.Visible = false end)
        end
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == toggleKey then
            ToggleWindow()
        end
    end)

    function self:UpdateTheme()
        windowFrame.BackgroundColor3 = GetThemeColor("Background")
        windowFrame.BackgroundTransparency = 0.05
        local stroke = windowFrame:FindFirstChild("UIStroke")
        if stroke then
            stroke.Color = GetThemeColor("Stroke")
            stroke.Thickness = 1.5
        end
        titleLabel.TextColor3 = GetThemeColor("Text")
        subtitleLabel.TextColor3 = GetThemeColor("DarkText")
        for _, tabBtn in pairs(tabButtons) do
            local ind = tabBtn:FindFirstChild("Indicator")
            if ind then
                ind.BackgroundColor3 = GetThemeColor("Accent")
            end
            if tabBtn.BackgroundColor3 == GetThemeColor("TabSelected") then
                tabBtn.BackgroundColor3 = GetThemeColor("TabSelected")
            end
        end
        for _, content in pairs(tabContents) do
            content.ScrollBarImageColor3 = GetThemeColor("Accent")
        end
        resizeHandle.BackgroundColor3 = GetThemeColor("Accent")
    end

    table.insert(WindowInstances, self)

    function self:AddTab(tabName, tabIcon)
        return AddTab(tabName, tabIcon)
    end

    function self:SetSize(newSize)
        windowSize = newSize
        windowFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
    end

    function self:Toggle()
        ToggleWindow()
    end

    function self:Destroy()
        windowFrame:Destroy()
        local index = table.find(WindowInstances, self)
        if index then
            table.remove(WindowInstances, index)
        end
    end

    return self
end

function Library.CreateWindow(data)
    return CreateWindow(data)
end
function Library.MakeWindow(data)
    return CreateWindow(data)
end
function Library.NewWindow(data)
    return CreateWindow(data)
end

function Library.SaveConfig(configName, data)
    local folder = "KOD_Configs"
    local fullPath = folder .. "/" .. configName .. ".json"
    local success, result = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if success then
        writefile(fullPath, result)
        return true
    end
    return false
end

function Library.LoadConfig(configName)
    local folder = "KOD_Configs"
    local fullPath = folder .. "/" .. configName .. ".json"
    if isfile(fullPath) then
        local content = readfile(fullPath)
        local success, result = pcall(function()
            return HttpService:JSONDecode(content)
        end)
        if success then
            return result
        end
    end
    return nil
end

function Library.ListConfigs()
    local folder = "KOD_Configs"
    local files = {}
    if isfolder(folder) then
        for _, file in pairs(listfiles(folder)) do
            local fileName = file:match("([^/\\]+)$")
            if fileName and fileName:match("%.json$") then
                table.insert(files, fileName:gsub("%.json$", ""))
            end
        end
    end
    return files
end

function Library.Cleanup()
    for _, win in pairs(WindowInstances) do
        if win.Destroy then win:Destroy() end
    end
    table.clear(WindowInstances)
end

return Library
