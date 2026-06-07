-- King Hub UI Library
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Colors = {
    Main = Color3.fromRGB(255, 170, 0),
    Background = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(45, 45, 55),
    Text = Color3.fromRGB(255, 255, 255),
    Disabled = Color3.fromRGB(100, 100, 100)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingHubUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Colors.Main
Title.Text = "KING HUB"
Title.TextColor3 = Colors.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Colors.Main
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local dragging = false
local dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 100, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Colors.Accent
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -100, 1, -40)
ContentContainer.Position = UDim2.new(0, 100, 0, 40)
ContentContainer.BackgroundColor3 = Colors.Background
BorderSizePixel = 0
ContentContainer.Parent = MainFrame

local tabs = {}
local currentTab = nil

function Library:CreateTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.Text = name
    tabBtn.BackgroundColor3 = Colors.Accent
    tabBtn.TextColor3 = Colors.Text
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.Parent = TabContainer
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 6
    tabContent.Visible = false
    tabContent.Parent = ContentContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = tabContent
    
    tabBtn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible = false
        end
        tabContent.Visible = true
        currentTab = tabContent
        for _, btn in pairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Colors.Accent
            end
        end
        tabBtn.BackgroundColor3 = Colors.Main
    end)
    
    if next(tabs) == nil then
        tabBtn.MouseButton1Click:Fire()
    end
    
    tabs[name] = tabContent
    return {
        AddButton = function(self, text, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 35)
            btn.Position = UDim2.new(0, 10, 0, 0)
            btn.Text = text
            btn.BackgroundColor3 = Colors.Accent
            btn.TextColor3 = Colors.Text
            btn.Font = Enum.Font.Gotham
            btn.Parent = tabContent
            btn.MouseButton1Click:Connect(callback)
        end,
        AddToggle = function(self, text, default, callback)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -20, 0, 35)
            toggleFrame.Position = UDim2.new(0, 10, 0, 0)
            toggleFrame.BackgroundColor3 = Colors.Accent
            toggleFrame.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.8, 0, 1, 0)
            label.Text = text
            label.BackgroundTransparency = 1
            label.TextColor3 = Colors.Text
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = toggleFrame
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 40, 0, 30)
            toggleBtn.Position = UDim2.new(1, -50, 0.5, -15)
            toggleBtn.Text = default and "ON" or "OFF"
            toggleBtn.BackgroundColor3 = default and Colors.Main or Colors.Disabled
            toggleBtn.TextColor3 = Colors.Text
            toggleBtn.Parent = toggleFrame
            
            local state = default
            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggleBtn.Text = state and "ON" or "OFF"
                toggleBtn.BackgroundColor3 = state and Colors.Main or Colors.Disabled
                callback(state)
            end)
            callback(state)
        end,
        AddSlider = function(self, text, min, max, default, callback)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, -20, 0, 70)
            sliderFrame.Position = UDim2.new(0, 10, 0, 0)
            sliderFrame.BackgroundColor3 = Colors.Accent
            sliderFrame.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Text = text .. ": " .. default
            label.BackgroundTransparency = 1
            label.TextColor3 = Colors.Text
            label.Parent = sliderFrame
            
            local slider = Instance.new("Frame")
            slider.Size = UDim2.new(1, -20, 0, 10)
            slider.Position = UDim2.new(0, 10, 0, 30)
            slider.BackgroundColor3 = Colors.Disabled
            slider.Parent = sliderFrame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            fill.BackgroundColor3 = Colors.Main
            fill.Parent = slider
            
            local value = default
            local draggingSlider = false
            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    local x = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    value = min + (max - min) * x
                    fill.Size = UDim2.new(x, 0, 1, 0)
                    label.Text = text .. ": " .. math.floor(value)
                    callback(value)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local x = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    value = min + (max - min) * x
                    fill.Size = UDim2.new(x, 0, 1, 0)
                    label.Text = text .. ": " .. math.floor(value)
                    callback(value)
                end
            end)
            callback(value)
        end
    }
end

return Library
