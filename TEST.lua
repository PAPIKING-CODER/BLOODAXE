local KODBloodUILibrary = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KODBloodUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local Themes = {
	["KOD Blood"] = {
		Background = Color3.fromRGB(10, 0, 0),
		Secondary = Color3.fromRGB(25, 0, 0),
		Frame = Color3.fromRGB(40, 0, 0),
		Theme = Color3.fromRGB(200, 0, 0),
		Stroke = Color3.fromRGB(255, 0, 0),
		Text = Color3.fromRGB(255, 255, 255),
		DarkText = Color3.fromRGB(150, 100, 100),
		Glow = Color3.fromRGB(180, 0, 0),
		Transparency = 0.1
	},
	["Cyber Purple"] = {
		Background = Color3.fromRGB(5, 0, 15),
		Secondary = Color3.fromRGB(15, 0, 30),
		Frame = Color3.fromRGB(30, 0, 50),
		Theme = Color3.fromRGB(150, 0, 255),
		Stroke = Color3.fromRGB(200, 100, 255),
		Text = Color3.fromRGB(255, 255, 255),
		DarkText = Color3.fromRGB(180, 150, 200),
		Glow = Color3.fromRGB(120, 0, 200),
		Transparency = 0.1
	},
	["Dark Blue"] = {
		Background = Color3.fromRGB(0, 0, 10),
		Secondary = Color3.fromRGB(0, 5, 25),
		Frame = Color3.fromRGB(0, 10, 40),
		Theme = Color3.fromRGB(0, 120, 255),
		Stroke = Color3.fromRGB(50, 150, 255),
		Text = Color3.fromRGB(255, 255, 255),
		DarkText = Color3.fromRGB(150, 180, 200),
		Glow = Color3.fromRGB(0, 100, 200),
		Transparency = 0.1
	},
	["Emerald"] = {
		Background = Color3.fromRGB(0, 10, 5),
		Secondary = Color3.fromRGB(0, 25, 10),
		Frame = Color3.fromRGB(0, 40, 20),
		Theme = Color3.fromRGB(0, 200, 100),
		Stroke = Color3.fromRGB(50, 255, 150),
		Text = Color3.fromRGB(255, 255, 255),
		DarkText = Color3.fromRGB(150, 200, 170),
		Glow = Color3.fromRGB(0, 180, 80),
		Transparency = 0.1
	}
}
local CurrentTheme = "KOD Blood"
local function GetThemeColor(colorKey)
	return Themes[CurrentTheme][colorKey] or Themes["KOD Blood"][colorKey]
end
local function CreateGradient(frame, color1, color2, direction)
	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color1), ColorSequenceKeypoint.new(1, color2)})
	if direction == "Horizontal" then
		grad.Rotation = 90
	elseif direction == "Diagonal" then
		grad.Rotation = 45
	end
	grad.Parent = frame
	return grad
end
local function CreateCorner(frame, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = frame
	return corner
end
local function CreateStroke(frame, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 0, 0)
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0.5
	stroke.Parent = frame
	return stroke
end
local function CreateShadow(frame, size, transparency, color)
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://6015897843"
	shadow.ImageTransparency = transparency or 0.6
	shadow.ImageColor3 = color or Color3.fromRGB(0, 0, 0)
	shadow.Size = UDim2.new(1, size or 20, 1, size or 20)
	shadow.Position = UDim2.new(-0.5, -(size or 20)/2, -0.5, -(size or 20)/2)
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(100, 100, 100, 100)
	shadow.Parent = frame
	return shadow
end
local function CreateBlur(frame, size)
	local blur = Instance.new("BlurEffect")
	blur.Size = size or 16
	blur.Parent = frame or Lighting
	return blur
end
local function CreateRipple(button, color)
	local ripple = Instance.new("ImageLabel")
	ripple.Name = "Ripple"
	ripple.BackgroundTransparency = 1
	ripple.Image = "rbxassetid://7733813662"
	ripple.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
	ripple.ImageTransparency = 0.6
	ripple.Size = UDim2.new(0, 0, 0, 0)
	ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
	ripple.ZIndex = 10
	ripple.Parent = button
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local targetSize = UDim2.new(3, 0, 3, 0)
	local targetTransparency = 1
	local tween = TweenService:Create(ripple, tweenInfo, {Size = targetSize, ImageTransparency = targetTransparency})
	tween:Play()
	tween.Completed:Connect(function()
		ripple:Destroy()
	end)
end
local function CreateGlow(frame, color, size)
	local glow = Instance.new("ImageLabel")
	glow.Name = "Glow"
	glow.BackgroundTransparency = 1
	glow.Image = "rbxassetid://7734137438"
	glow.ImageColor3 = color or Color3.fromRGB(255, 0, 0)
	glow.ImageTransparency = 0.7
	glow.Size = UDim2.new(1, size or 30, 1, size or 30)
	glow.Position = UDim2.new(-0.5, -(size or 30)/2, -0.5, -(size or 30)/2)
	glow.ScaleType = Enum.ScaleType.Slice
	glow.SliceCenter = Rect.new(100, 100, 100, 100)
	glow.Parent = frame
	return glow
end
local WindowInstances = {}
local Notifications = {}
local function CreateNotification(data)
	local notifyFrame = Instance.new("Frame")
	notifyFrame.Name = "Notification"
	notifyFrame.Size = UDim2.new(0, 300, 0, 70)
	notifyFrame.Position = UDim2.new(1.1, 0, 0.9, 0)
	notifyFrame.BackgroundColor3 = GetThemeColor("Secondary")
	notifyFrame.BackgroundTransparency = 0.1
	notifyFrame.BorderSizePixel = 0
	notifyFrame.Parent = ScreenGui
	CreateCorner(notifyFrame, 8)
	CreateStroke(notifyFrame, GetThemeColor("Stroke"), 1, 0.3)
	CreateGradient(notifyFrame, GetThemeColor("Background"), GetThemeColor("Frame"), "Diagonal")
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, -20, 0.3, 0)
	titleLabel.Position = UDim2.new(0, 10, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = data.Title or "KOD"
	titleLabel.TextColor3 = GetThemeColor("Theme")
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = notifyFrame
	local contentLabel = Instance.new("TextLabel")
	contentLabel.Name = "Content"
	contentLabel.Size = UDim2.new(1, -20, 0.7, -5)
	contentLabel.Position = UDim2.new(0, 10, 0.3, 0)
	contentLabel.BackgroundTransparency = 1
	contentLabel.Text = data.Content or "Notification"
	contentLabel.TextColor3 = GetThemeColor("Text")
	contentLabel.TextSize = 14
	contentLabel.Font = Enum.Font.Gotham
	contentLabel.TextXAlignment = Enum.TextXAlignment.Left
	contentLabel.TextWrapped = true
	contentLabel.Parent = notifyFrame
	local tweenIn = TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.9, -310, 0.9, 0)})
	tweenIn:Play()
	tweenIn.Completed:Connect(function()
		task.delay(data.Time or 5, function()
			local tweenOut = TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1.1, 0, 0.9, 0), BackgroundTransparency = 1})
			tweenOut:Play()
			tweenOut.Completed:Connect(function()
				notifyFrame:Destroy()
			end)
		end)
	end)
	table.insert(Notifications, notifyFrame)
	return notifyFrame
end
function KODBloodUILibrary.Notify(data)
	return CreateNotification(data)
end
function KODBloodUILibrary.SetTheme(themeName)
	if Themes[themeName] then
		CurrentTheme = themeName
		for _, window in pairs(WindowInstances) do
			window:UpdateTheme()
		end
		return true
	end
	return false
end
local function CreateWindow(data)
	local self = {}
	local windowSize = data.Size or Vector2.new(600, 400)
	local windowTitle = data.Title or "KOD Blood Hub"
	local windowSubtitle = data.SubTitle or "Premium"
	local toggleKey = data.ToggleKey or Enum.KeyCode.RightShift
	local windowFrame = Instance.new("Frame")
	windowFrame.Name = "Window"
	windowFrame.Size = UDim2.new(0, windowSize.X, 0, windowSize.Y)
	windowFrame.Position = UDim2.new(0.5, -windowSize.X/2, 0.5, -windowSize.Y/2)
	windowFrame.BackgroundColor3 = GetThemeColor("Secondary")
	windowFrame.BackgroundTransparency = 0.05
	windowFrame.BorderSizePixel = 0
	windowFrame.Parent = ScreenGui
	windowFrame.Visible = true
	local windowBlur = Instance.new("ImageLabel")
	windowBlur.Name = "Blur"
	windowBlur.Size = UDim2.new(1, 0, 1, 0)
	windowBlur.Position = UDim2.new(0, 0, 0, 0)
	windowBlur.BackgroundTransparency = 1
	windowBlur.Image = "rbxassetid://7734124487"
	windowBlur.ImageTransparency = 0.85
	windowBlur.ScaleType = Enum.ScaleType.Slice
	windowBlur.SliceCenter = Rect.new(200, 200, 200, 200)
	windowBlur.Parent = windowFrame
	CreateCorner(windowFrame, 12)
	CreateStroke(windowFrame, GetThemeColor("Stroke"), 1.5, 0.2)
	CreateGradient(windowFrame, GetThemeColor("Background"), GetThemeColor("Frame"), "Diagonal")
	CreateGlow(windowFrame, GetThemeColor("Glow"), 40)
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 45)
	titleBar.Position = UDim2.new(0, 0, 0, 0)
	titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	titleBar.BackgroundTransparency = 0.3
	titleBar.BorderSizePixel = 0
	titleBar.Parent = windowFrame
	CreateCorner(titleBar, 12)
	local titleBarCorner = Instance.new("UICorner")
	titleBarCorner.CornerRadius = UDim.new(0, 12)
	titleBarCorner.Parent = titleBar
	local logoText = Instance.new("TextLabel")
	logoText.Name = "Logo"
	logoText.Size = UDim2.new(0, 120, 0, 30)
	logoText.Position = UDim2.new(0, 15, 0, 7)
	logoText.BackgroundTransparency = 1
	logoText.Text = "KOD"
	logoText.TextColor3 = GetThemeColor("Theme")
	logoText.TextSize = 24
	logoText.Font = Enum.Font.GothamBlack
	logoText.TextXAlignment = Enum.TextXAlignment.Left
	logoText.Parent = titleBar
	local subtitleText = Instance.new("TextLabel")
	subtitleText.Name = "Subtitle"
	subtitleText.Size = UDim2.new(0, 80, 0, 20)
	subtitleText.Position = UDim2.new(0, 15, 0, 27)
	subtitleText.BackgroundTransparency = 1
	subtitleText.Text = windowSubtitle
	subtitleText.TextColor3 = GetThemeColor("DarkText")
	subtitleText.TextSize = 12
	subtitleText.Font = Enum.Font.Gotham
	subtitleText.TextXAlignment = Enum.TextXAlignment.Left
	subtitleText.Parent = titleBar
	local minimizeBtn = Instance.new("TextButton")
	minimizeBtn.Name = "Minimize"
	minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
	minimizeBtn.Position = UDim2.new(1, -90, 0, 7)
	minimizeBtn.BackgroundTransparency = 1
	minimizeBtn.Text = "-"
	minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	minimizeBtn.TextSize = 18
	minimizeBtn.Font = Enum.Font.GothamBold
	minimizeBtn.Parent = titleBar
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "Close"
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -50, 0, 7)
	closeBtn.BackgroundTransparency = 1
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
	closeBtn.TextSize = 18
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.Parent = titleBar
	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.Size = UDim2.new(0, 160, 1, -45)
	sidebar.Position = UDim2.new(0, 0, 0, 45)
	sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	sidebar.BackgroundTransparency = 0.4
	sidebar.BorderSizePixel = 0
	sidebar.Parent = windowFrame
	CreateCorner(sidebar, 8)
	local contentContainer = Instance.new("Frame")
	contentContainer.Name = "ContentContainer"
	contentContainer.Size = UDim2.new(1, -170, 1, -55)
	contentContainer.Position = UDim2.new(0, 160, 0, 50)
	contentContainer.BackgroundTransparency = 1
	contentContainer.BorderSizePixel = 0
	contentContainer.Parent = windowFrame
	local tabButtons = {}
	local tabContents = {}
	local currentTab = nil
	local function AddTab(tabName, icon)
		local tabBtn = Instance.new("TextButton")
		tabBtn.Name = "Tab_" .. tabName
		tabBtn.Size = UDim2.new(1, -10, 0, 35)
		tabBtn.Position = UDim2.new(0, 5, 0, #tabButtons * 40 + 5)
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
		local tabIndicator = Instance.new("Frame")
		tabIndicator.Name = "Indicator"
		tabIndicator.Size = UDim2.new(0, 3, 0.6, 0)
		tabIndicator.Position = UDim2.new(0, 0, 0.2, 0)
		tabIndicator.BackgroundColor3 = GetThemeColor("Theme")
		tabIndicator.BackgroundTransparency = 1
		tabIndicator.BorderSizePixel = 0
		tabIndicator.Parent = tabBtn
		CreateCorner(tabIndicator, 2)
		local tabContent = Instance.new("ScrollingFrame")
		tabContent.Name = "Content_" .. tabName
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.Position = UDim2.new(0, 0, 0, 0)
		tabContent.BackgroundTransparency = 1
		tabContent.BorderSizePixel = 0
		tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabContent.ScrollBarThickness = 4
		tabContent.ScrollBarImageColor3 = GetThemeColor("Theme")
		tabContent.ScrollBarImageTransparency = 0.5
		tabContent.Visible = false
		tabContent.Parent = contentContainer
		local contentLayout = Instance.new("UIListLayout")
		contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		contentLayout.Padding = UDim.new(0, 8)
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
				TweenService:Create(tabBtn, TweenInfo.new(0.2), {TextColor3 = GetThemeColor("Text")}):Play()
			end
		end)
		tabBtn.MouseLeave:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, TweenInfo.new(0.2), {TextColor3 = GetThemeColor("DarkText")}):Play()
			end
		end)
		table.insert(tabButtons, tabBtn)
		tabContents[tabName] = tabContent
		if #tabButtons == 1 then
			SelectTab()
		end
		local tabAPI = {}
		function tabAPI:AddSection(sectionName)
			local sectionFrame = Instance.new("Frame")
			sectionFrame.Name = "Section_" .. sectionName
			sectionFrame.Size = UDim2.new(1, 0, 0, 30)
			sectionFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			sectionFrame.BackgroundTransparency = 0.3
			sectionFrame.BorderSizePixel = 0
			sectionFrame.Parent = tabContent
			CreateCorner(sectionFrame, 6)
			local sectionLabel = Instance.new("TextLabel")
			sectionLabel.Name = "Label"
			sectionLabel.Size = UDim2.new(1, -15, 1, 0)
			sectionLabel.Position = UDim2.new(0, 10, 0, 0)
			sectionLabel.BackgroundTransparency = 1
			sectionLabel.Text = sectionName
			sectionLabel.TextColor3 = GetThemeColor("Theme")
			sectionLabel.TextSize = 14
			sectionLabel.Font = Enum.Font.GothamBold
			sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
			sectionLabel.Parent = sectionFrame
			local line = Instance.new("Frame")
			line.Name = "Line"
			line.Size = UDim2.new(1, -20, 0, 1)
			line.Position = UDim2.new(0, 10, 1, -2)
			line.BackgroundColor3 = GetThemeColor("Stroke")
			line.BackgroundTransparency = 0.3
			line.BorderSizePixel = 0
			line.Parent = sectionFrame
			return sectionFrame
		end
		function tabAPI:AddButton(btnData)
			local btnFrame = Instance.new("Frame")
			btnFrame.Size = UDim2.new(1, 0, 0, 35)
			btnFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			btnFrame.BackgroundTransparency = 0.5
			btnFrame.BorderSizePixel = 0
			btnFrame.Parent = tabContent
			CreateCorner(btnFrame, 6)
			CreateStroke(btnFrame, GetThemeColor("Stroke"), 0.5, 0.5)
			local btn = Instance.new("TextButton")
			btn.Name = "Button"
			btn.Size = UDim2.new(1, 0, 1, 0)
			btn.Position = UDim2.new(0, 0, 0, 0)
			btn.BackgroundTransparency = 1
			btn.Text = "  " .. (btnData.Name or "Button")
			btn.TextColor3 = GetThemeColor("Text")
			btn.TextSize = 14
			btn.Font = Enum.Font.Gotham
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = btnFrame
			local btnIcon = Instance.new("ImageLabel")
			btnIcon.Name = "Icon"
			btnIcon.Size = UDim2.new(0, 20, 0, 20)
			btnIcon.Position = UDim2.new(1, -30, 0.5, -10)
			btnIcon.BackgroundTransparency = 1
			btnIcon.Image = "rbxassetid://7733986644"
			btnIcon.ImageColor3 = GetThemeColor("DarkText")
			btnIcon.Parent = btnFrame
			btn.MouseButton1Click:Connect(function()
				CreateRipple(btn, GetThemeColor("Theme"))
				if btnData.Callback then
					task.spawn(btnData.Callback)
				end
			end)
			btn.MouseEnter:Connect(function()
				TweenService:Create(btnFrame, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("Theme"), BackgroundTransparency = 0.2}):Play()
				TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			end)
			btn.MouseLeave:Connect(function()
				TweenService:Create(btnFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5}):Play()
				TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = GetThemeColor("Text")}):Play()
			end)
			return btn
		end
		function tabAPI:AddToggle(toggleData)
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Size = UDim2.new(1, 0, 0, 35)
			toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			toggleFrame.BackgroundTransparency = 0.5
			toggleFrame.BorderSizePixel = 0
			toggleFrame.Parent = tabContent
			CreateCorner(toggleFrame, 6)
			local toggleLabel = Instance.new("TextLabel")
			toggleLabel.Size = UDim2.new(0.7, -10, 1, 0)
			toggleLabel.Position = UDim2.new(0, 10, 0, 0)
			toggleLabel.BackgroundTransparency = 1
			toggleLabel.Text = "  " .. (toggleData.Name or "Toggle")
			toggleLabel.TextColor3 = GetThemeColor("Text")
			toggleLabel.TextSize = 14
			toggleLabel.Font = Enum.Font.Gotham
			toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			toggleLabel.Parent = toggleFrame
			local toggleSwitch = Instance.new("Frame")
			toggleSwitch.Size = UDim2.new(0, 44, 0, 22)
			toggleSwitch.Position = UDim2.new(1, -54, 0.5, -11)
			toggleSwitch.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
			local toggleState = toggleData.Default or false
			local function UpdateToggle(state)
				toggleState = state
				if state then
					TweenService:Create(toggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = GetThemeColor("Theme")}):Play()
					TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -20, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				else
					TweenService:Create(toggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
					TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
				end
				if toggleData.Callback then
					task.spawn(toggleData.Callback, state)
				end
			end
			local toggleBtn = Instance.new("TextButton")
			toggleBtn.Size = UDim2.new(1, 0, 1, 0)
			toggleBtn.Position = UDim2.new(0, 0, 0, 0)
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
			local sliderFrame = Instance.new("Frame")
			sliderFrame.Size = UDim2.new(1, 0, 0, 50)
			sliderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			sliderFrame.BackgroundTransparency = 0.5
			sliderFrame.BorderSizePixel = 0
			sliderFrame.Parent = tabContent
			CreateCorner(sliderFrame, 6)
			local sliderLabel = Instance.new("TextLabel")
			sliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
			sliderLabel.Position = UDim2.new(0, 10, 0, 5)
			sliderLabel.BackgroundTransparency = 1
			sliderLabel.Text = "  " .. (sliderData.Name or "Slider")
			sliderLabel.TextColor3 = GetThemeColor("Text")
			sliderLabel.TextSize = 14
			sliderLabel.Font = Enum.Font.Gotham
			sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			sliderLabel.Parent = sliderFrame
			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0.3, 0, 0, 20)
			valueLabel.Position = UDim2.new(0.7, 0, 0, 5)
			valueLabel.BackgroundTransparency = 1
			valueLabel.Text = tostring(sliderData.Default or 0)
			valueLabel.TextColor3 = GetThemeColor("Theme")
			valueLabel.TextSize = 14
			valueLabel.Font = Enum.Font.GothamBold
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right
			valueLabel.Parent = sliderFrame
			local sliderTrack = Instance.new("Frame")
			sliderTrack.Size = UDim2.new(1, -20, 0, 4)
			sliderTrack.Position = UDim2.new(0, 10, 0, 35)
			sliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			sliderTrack.BorderSizePixel = 0
			sliderTrack.Parent = sliderFrame
			CreateCorner(sliderTrack, 2)
			local sliderFill = Instance.new("Frame")
			sliderFill.Size = UDim2.new(0, 0, 1, 0)
			sliderFill.Position = UDim2.new(0, 0, 0, 0)
			sliderFill.BackgroundColor3 = GetThemeColor("Theme")
			sliderFill.BorderSizePixel = 0
			sliderFill.Parent = sliderTrack
			CreateCorner(sliderFill, 2)
			local sliderKnob = Instance.new("Frame")
			sliderKnob.Size = UDim2.new(0, 12, 0, 12)
			sliderKnob.Position = UDim2.new(0, 0, 0.5, -6)
			sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sliderKnob.BorderSizePixel = 0
			sliderKnob.Parent = sliderTrack
			CreateCorner(sliderKnob, 6)
			local minVal = sliderData.Min or 0
			local maxVal = sliderData.Max or 100
			local currentVal = sliderData.Default or 0
			local function UpdateSlider(value)
				currentVal = math.clamp(value, minVal, maxVal)
				local percent = (currentVal - minVal) / (maxVal - minVal)
				sliderFill.Size = UDim2.new(percent, 0, 1, 0)
				sliderKnob.Position = UDim2.new(percent, -6, 0.5, -6)
				valueLabel.Text = tostring(math.floor(currentVal))
				if sliderData.Callback then
					task.spawn(sliderData.Callback, currentVal)
				end
			end
			local dragging = false
			local function GetSliderValue(input)
				local x = input.Position.X - sliderTrack.AbsolutePosition.X
				local percent = math.clamp(x / sliderTrack.AbsoluteSize.X, 0, 1)
				return minVal + percent * (maxVal - minVal)
			end
			sliderKnob.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
				end
			end)
			sliderKnob.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			sliderTrack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					local val = GetSliderValue(input)
					UpdateSlider(val)
					dragging = true
				end
			end)
			sliderTrack.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
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
			local dropdownFrame = Instance.new("Frame")
			dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
			dropdownFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			dropdownFrame.BackgroundTransparency = 0.5
			dropdownFrame.BorderSizePixel = 0
			dropdownFrame.Parent = tabContent
			CreateCorner(dropdownFrame, 6)
			local dropdownLabel = Instance.new("TextLabel")
			dropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
			dropdownLabel.Position = UDim2.new(0, 10, 0, 0)
			dropdownLabel.BackgroundTransparency = 1
			dropdownLabel.Text = "  " .. (dropdownData.Name or "Dropdown")
			dropdownLabel.TextColor3 = GetThemeColor("Text")
			dropdownLabel.TextSize = 14
			dropdownLabel.Font = Enum.Font.Gotham
			dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
			dropdownLabel.Parent = dropdownFrame
			local dropdownBtn = Instance.new("TextButton")
			dropdownBtn.Size = UDim2.new(0.3, -5, 1, -10)
			dropdownBtn.Position = UDim2.new(0.7, 0, 0.5, -12.5)
			dropdownBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			dropdownBtn.BackgroundTransparency = 0.5
			dropdownBtn.Text = "Select"
			dropdownBtn.TextColor3 = GetThemeColor("Text")
			dropdownBtn.TextSize = 12
			dropdownBtn.Font = Enum.Font.Gotham
			dropdownBtn.Parent = dropdownFrame
			CreateCorner(dropdownBtn, 4)
			local dropdownList = Instance.new("ScrollingFrame")
			dropdownList.Size = UDim2.new(1, 0, 0, 0)
			dropdownList.Position = UDim2.new(0, 0, 1, 0)
			dropdownList.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
			dropdownList.BackgroundTransparency = 0.1
			dropdownList.BorderSizePixel = 0
			dropdownList.Visible = false
			dropdownList.ClipsDescendants = true
			dropdownList.ScrollBarThickness = 2
			dropdownList.ScrollBarImageColor3 = GetThemeColor("Theme")
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
			local items = dropdownData.Items or {}
			local selectedItem = dropdownData.Default or nil
			local function UpdateDropdownHeight()
				local count = #dropdownList:GetChildren()
				local itemCount = 0
				for _, child in pairs(dropdownList:GetChildren()) do
					if child:IsA("TextButton") then
						itemCount = itemCount + 1
					end
				end
				local height = math.min(itemCount * 32 + 10, 150)
				dropdownList.Size = UDim2.new(1, 0, 0, height)
				dropdownFrame.Size = UDim2.new(1, 0, 0, 35 + height)
			end
			local function PopulateDropdown()
				for _, child in pairs(dropdownList:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
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
						dropdownBtn.TextColor3 = GetThemeColor("Theme")
						dropdownList.Visible = false
						dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
						if dropdownData.Callback then
							task.spawn(dropdownData.Callback, item)
						end
					end)
					itemBtn.MouseEnter:Connect(function()
						TweenService:Create(itemBtn, TweenInfo.new(0.2), {BackgroundColor3 = GetThemeColor("Theme"), BackgroundTransparency = 0.3, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end)
					itemBtn.MouseLeave:Connect(function()
						TweenService:Create(itemBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, TextColor3 = GetThemeColor("DarkText")}):Play()
					end)
				end
				UpdateDropdownHeight()
			end
			dropdownBtn.MouseButton1Click:Connect(function()
				dropdownList.Visible = not dropdownList.Visible
				if dropdownList.Visible then
					dropdownFrame.Size = UDim2.new(1, 0, 0, 35 + dropdownList.AbsoluteSize.Y)
				else
					dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
				end
			end)
			PopulateDropdown()
			if selectedItem then
				dropdownBtn.Text = selectedItem
				dropdownBtn.TextColor3 = GetThemeColor("Theme")
			end
			function self:AddItem(item)
				table.insert(items, item)
				PopulateDropdown()
			end
			function self:RemoveItem(item)
				local index = table.find(items, item)
				if index then
					table.remove(items, index)
					PopulateDropdown()
				end
			end
			function self:ClearItems()
				items = {}
				PopulateDropdown()
			end
			return self
		end
		function tabAPI:AddTextbox(textboxData)
			local textboxFrame = Instance.new("Frame")
			textboxFrame.Size = UDim2.new(1, 0, 0, 35)
			textboxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			textboxFrame.BackgroundTransparency = 0.5
			textboxFrame.BorderSizePixel = 0
			textboxFrame.Parent = tabContent
			CreateCorner(textboxFrame, 6)
			local textboxLabel = Instance.new("TextLabel")
			textboxLabel.Size = UDim2.new(0.5, 0, 1, 0)
			textboxLabel.Position = UDim2.new(0, 10, 0, 0)
			textboxLabel.BackgroundTransparency = 1
			textboxLabel.Text = "  " .. (textboxData.Name or "Input")
			textboxLabel.TextColor3 = GetThemeColor("Text")
			textboxLabel.TextSize = 14
			textboxLabel.Font = Enum.Font.Gotham
			textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
			textboxLabel.Parent = textboxFrame
			local inputBox = Instance.new("TextBox")
			inputBox.Size = UDim2.new(0.5, -10, 1, -10)
			inputBox.Position = UDim2.new(0.5, 0, 0.5, -12.5)
			inputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			inputBox.BackgroundTransparency = 0.5
			inputBox.Text = textboxData.Default or ""
			inputBox.TextColor3 = GetThemeColor("Text")
			inputBox.TextSize = 12
			inputBox.Font = Enum.Font.Gotham
			inputBox.PlaceholderText = textboxData.Placeholder or "Input..."
			inputBox.PlaceholderColor3 = GetThemeColor("DarkText")
			inputBox.Parent = textboxFrame
			CreateCorner(inputBox, 4)
			inputBox.FocusLost:Connect(function(enterPressed)
				if textboxData.Callback then
					task.spawn(textboxData.Callback, inputBox.Text)
				end
			end)
			return inputBox
		end
		function tabAPI:AddKeybind(keybindData)
			local keybindFrame = Instance.new("Frame")
			keybindFrame.Size = UDim2.new(1, 0, 0, 35)
			keybindFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			keybindFrame.BackgroundTransparency = 0.5
			keybindFrame.BorderSizePixel = 0
			keybindFrame.Parent = tabContent
			CreateCorner(keybindFrame, 6)
			local keybindLabel = Instance.new("TextLabel")
			keybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
			keybindLabel.Position = UDim2.new(0, 10, 0, 0)
			keybindLabel.BackgroundTransparency = 1
			keybindLabel.Text = "  " .. (keybindData.Name or "Keybind")
			keybindLabel.TextColor3 = GetThemeColor("Text")
			keybindLabel.TextSize = 14
			keybindLabel.Font = Enum.Font.Gotham
			keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
			keybindLabel.Parent = keybindFrame
			local keyBtn = Instance.new("TextButton")
			keyBtn.Size = UDim2.new(0.4, -10, 1, -10)
			keyBtn.Position = UDim2.new(0.6, 0, 0.5, -12.5)
			keyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			keyBtn.BackgroundTransparency = 0.5
			keyBtn.Text = keybindData.Key or "None"
			keyBtn.TextColor3 = GetThemeColor("Theme")
			keyBtn.TextSize = 12
			keyBtn.Font = Enum.Font.GothamBold
			keyBtn.Parent = keybindFrame
			CreateCorner(keyBtn, 4)
			local isBinding = false
			local boundKey = keybindData.Key or "None"
			keyBtn.MouseButton1Click:Connect(function()
				isBinding = not isBinding
				if isBinding then
					keyBtn.Text = "..."
					keyBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
				else
					keyBtn.Text = boundKey
					keyBtn.TextColor3 = GetThemeColor("Theme")
				end
			end)
			UserInputService.InputBegan:Connect(function(input)
				if isBinding then
					local keyName = input.KeyCode.Name
					if keyName and keyName ~= "Unknown" then
						boundKey = keyName
						keyBtn.Text = keyName
						keyBtn.TextColor3 = GetThemeColor("Theme")
						isBinding = false
						if keybindData.Callback then
							task.spawn(keybindData.Callback, keyName)
						end
					end
				end
			end)
			return boundKey
		end
		function tabAPI:AddLabel(labelData)
			local labelFrame = Instance.new("TextLabel")
			labelFrame.Size = UDim2.new(1, 0, 0, 25)
			labelFrame.BackgroundTransparency = 1
			labelFrame.Text = "  " .. (labelData.Name or "Label")
			labelFrame.TextColor3 = GetThemeColor("DarkText")
			labelFrame.TextSize = 13
			labelFrame.Font = Enum.Font.Gotham
			labelFrame.TextXAlignment = Enum.TextXAlignment.Left
			labelFrame.Parent = tabContent
			return labelFrame
		end
		function tabAPI:AddParagraph(paraData)
			local paraFrame = Instance.new("Frame")
			paraFrame.Size = UDim2.new(1, 0, 0, 40)
			paraFrame.BackgroundTransparency = 1
			paraFrame.Parent = tabContent
			local paraLabel = Instance.new("TextLabel")
			paraLabel.Size = UDim2.new(1, -10, 1, 0)
			paraLabel.Position = UDim2.new(0, 10, 0, 0)
			paraLabel.BackgroundTransparency = 1
			paraLabel.Text = paraData.Text or "Paragraph text here"
			paraLabel.TextColor3 = GetThemeColor("DarkText")
			paraLabel.TextSize = 12
			paraLabel.Font = Enum.Font.Gotham
			paraLabel.TextXAlignment = Enum.TextXAlignment.Left
			paraLabel.TextWrapped = true
			paraLabel.Parent = paraFrame
			return paraFrame
		end
		function self:UpdateContentSize()
			for _, content in pairs(tabContents) do
				content.CanvasSize = UDim2.new(0, 0, 0, content.ContentLayout.AbsoluteContentSize.Y + 20)
			end
		end
		tabContent.ChildAdded:Connect(function()
			self:UpdateContentSize()
		end)
		tabContent.ChildRemoved:Connect(function()
			self:UpdateContentSize()
		end)
		return tabAPI
	end
	local dragStart = nil
	local startPos = nil
	local dragging = false
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragStart = input.Position
			startPos = windowFrame.Position
			dragging = true
		end
	end)
	titleBar.InputEnded:Connect(function(input)
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
	local windowMinimized = false
	local function MinimizeWindow()
		windowMinimized = not windowMinimized
		if windowMinimized then
			TweenService:Create(windowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(0, windowSize.X, 0, 45)}):Play()
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
		task.delay(0.3, function()
			windowFrame.Visible = false
		end)
	end)
	local windowOpen = true
	local function ToggleWindow()
		windowOpen = not windowOpen
		if windowOpen then
			windowFrame.Visible = true
			TweenService:Create(windowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.05, Size = UDim2.new(0, windowSize.X, 0, windowSize.Y)}):Play()
		else
			TweenService:Create(windowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
			task.delay(0.3, function()
				windowFrame.Visible = false
			end)
		end
	end
	local keybindConnection = UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == toggleKey then
			ToggleWindow()
		end
	end)
	function self:UpdateTheme()
		windowFrame.BackgroundColor3 = GetThemeColor("Secondary")
		windowFrame.BackgroundTransparency = 0.05
		local stroke = windowFrame:FindFirstChild("UIStroke")
		if stroke then
			stroke.Color = GetThemeColor("Stroke")
		end
		local glow = windowFrame:FindFirstChild("Glow")
		if glow then
			glow.ImageColor3 = GetThemeColor("Glow")
		end
		local grad = windowFrame:FindFirstChild("UIGradient")
		if grad then
			grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, GetThemeColor("Background")), ColorSequenceKeypoint.new(1, GetThemeColor("Frame"))})
		end
		logoText.TextColor3 = GetThemeColor("Theme")
		for _, tabBtn in pairs(tabButtons) do
			local ind = tabBtn:FindFirstChild("Indicator")
			if ind then
				ind.BackgroundColor3 = GetThemeColor("Theme")
			end
			if tabBtn.TextColor3 == GetThemeColor("Text") then
				tabBtn.TextColor3 = GetThemeColor("Text")
			else
				tabBtn.TextColor3 = GetThemeColor("DarkText")
			end
		end
		for _, content in pairs(tabContents) do
			content.ScrollBarImageColor3 = GetThemeColor("Theme")
		end
	end
	table.insert(WindowInstances, self)
	function self:AddTab(tabName, icon)
		return AddTab(tabName, icon)
	end
	function self:Destroy()
		windowFrame:Destroy()
		keybindConnection:Disconnect()
		local index = table.find(WindowInstances, self)
		if index then
			table.remove(WindowInstances, index)
		end
	end
	return self
end
function KODBloodUILibrary.CreateWindow(data)
	return CreateWindow(data)
end
local function SaveConfig(configName, data)
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
local function LoadConfig(configName)
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
function KODBloodUILibrary.SaveConfig(configName, data)
	return SaveConfig(configName, data)
end
function KODBloodUILibrary.LoadConfig(configName)
	return LoadConfig(configName)
end
local function ListConfigs()
	local folder = "KOD_Configs"
	local files = {}
	if isfolder(folder) then
		for _, file in pairs(listfiles(folder)) do
			local fileName = file:match("([^/\\]+)$")
			if fileName:match("%.json$") then
				table.insert(files, fileName:gsub("%.json$", ""))
			end
		end
	end
	return files
end
function KODBloodUILibrary.ListConfigs()
	return ListConfigs()
end
return KODBloodUILibrary
