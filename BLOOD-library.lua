local Blood = {}
Blood.__index = Blood
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Theme = {
	Background = Color3.fromRGB(10, 10, 12),
	Secondary = Color3.fromRGB(18, 18, 22),
	Tertiary = Color3.fromRGB(24, 24, 30),
	Accent = Color3.fromRGB(180, 20, 30),
	AccentDark = Color3.fromRGB(120, 10, 18),
	AccentGlow = Color3.fromRGB(200, 30, 40),
	Text = Color3.fromRGB(240, 240, 245),
	TextDim = Color3.fromRGB(150, 150, 160),
	Border = Color3.fromRGB(45, 20, 25),
	BorderLight = Color3.fromRGB(80, 30, 40),
	Success = Color3.fromRGB(40, 180, 100),
	Warning = Color3.fromRGB(220, 160, 40),
	Error = Color3.fromRGB(200, 50, 50),
	Transparency = 0.06,
}
local Fonts = {
	Bold = Enum.Font.GothamBold,
	Semi = Enum.Font.GothamSemibold,
	Regular = Enum.Font.Gotham,
}
local Tweens = {
	Fast = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	Medium = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	Slow = TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	Spring = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	Bounce = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
}
local ActiveWindows = {}
local ConfigData = {}
local function Tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end
local function MakeDraggable(frame, handle)
	local dragging, dragStart, startPos = false, nil, nil
	handle = handle or frame
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	handle.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end
local function CreateCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 8)
	c.Parent = parent
	return c
end
local function CreateStroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or Theme.Border
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end
local function CreatePadding(parent, top, right, bottom, left)
	local p = Instance.new("UIPadding")
	p.PaddingTop = UDim.new(0, top or 8)
	p.PaddingRight = UDim.new(0, right or 8)
	p.PaddingBottom = UDim.new(0, bottom or 8)
	p.PaddingLeft = UDim.new(0, left or 8)
	p.Parent = parent
	return p
end
local function CreateFrame(props)
	local f = Instance.new("Frame")
	f.BackgroundColor3 = props.Color or Theme.Secondary
	f.BackgroundTransparency = props.Transparency or 0
	f.BorderSizePixel = 0
	f.Size = props.Size or UDim2.new(1, 0, 0, 40)
	f.Position = props.Position or UDim2.new(0, 0, 0, 0)
	f.ClipsDescendants = props.Clip or false
	if props.Parent then f.Parent = props.Parent end
	if props.ZIndex then f.ZIndex = props.ZIndex end
	if props.Name then f.Name = props.Name end
	return f
end
local function CreateLabel(props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = props.Text or ""
	l.TextColor3 = props.Color or Theme.Text
	l.Font = props.Font or Fonts.Regular
	l.TextSize = props.Size or 13
	l.TextXAlignment = props.AlignX or Enum.TextXAlignment.Left
	l.TextYAlignment = props.AlignY or Enum.TextYAlignment.Center
	l.TextTruncate = Enum.TextTruncate.AtEnd
	l.RichText = props.Rich or false
	l.Size = props.FrameSize or UDim2.new(1, 0, 1, 0)
	l.Position = props.Position or UDim2.new(0, 0, 0, 0)
	if props.Parent then l.Parent = props.Parent end
	if props.ZIndex then l.ZIndex = props.ZIndex end
	if props.Name then l.Name = props.Name end
	return l
end
local function CreateButton(props)
	local b = Instance.new("TextButton")
	b.BackgroundColor3 = props.Color or Theme.Tertiary
	b.BackgroundTransparency = props.Transparency or 0
	b.BorderSizePixel = 0
	b.Text = props.Text or ""
	b.TextColor3 = props.TextColor or Theme.Text
	b.Font = props.Font or Fonts.Semi
	b.TextSize = props.TextSize or 13
	b.Size = props.Size or UDim2.new(1, 0, 0, 36)
	b.Position = props.Position or UDim2.new(0, 0, 0, 0)
	b.AutoButtonColor = false
	if props.Parent then b.Parent = props.Parent end
	if props.ZIndex then b.ZIndex = props.ZIndex end
	if props.Name then b.Name = props.Name end
	return b
end
local function CreateImage(props)
	local i = Instance.new("ImageLabel")
	i.BackgroundTransparency = 1
	i.Image = props.Image or ""
	i.ImageColor3 = props.Color or Color3.new(1, 1, 1)
	i.Size = props.Size or UDim2.new(0, 20, 0, 20)
	i.Position = props.Position or UDim2.new(0, 0, 0.5, -10)
	i.ScaleType = Enum.ScaleType.Fit
	if props.Parent then i.Parent = props.Parent end
	if props.ZIndex then i.ZIndex = props.ZIndex end
	if props.Name then i.Name = props.Name end
	return i
end
local function GlowEffect(parent, color, size)
	local glow = Instance.new("ImageLabel")
	glow.Name = "Glow"
	glow.BackgroundTransparency = 1
	glow.Image = "rbxassetid://5028857084"
	glow.ImageColor3 = color or Theme.Accent
	glow.ImageTransparency = 0.75
	glow.Size = UDim2.new(1, size or 20, 1, size or 20)
	glow.Position = UDim2.new(0, -(size or 20) / 2, 0, -(size or 20) / 2)
	glow.ZIndex = parent.ZIndex - 1
	glow.Parent = parent
	return glow
end
local NotifHolder = nil
local function EnsureNotifHolder()
	if NotifHolder and NotifHolder.Parent then return end
	local sg = Instance.new("ScreenGui")
	sg.Name = "BloodNotifications"
	sg.ResetOnSpawn = false
	sg.DisplayOrder = 999
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
	NotifHolder = Instance.new("Frame")
	NotifHolder.Name = "Holder"
	NotifHolder.BackgroundTransparency = 1
	NotifHolder.Size = UDim2.new(0, 300, 1, 0)
	NotifHolder.Position = UDim2.new(1, -310, 0, 0)
	NotifHolder.Parent = sg
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	layout.Padding = UDim.new(0, 8)
	layout.Parent = NotifHolder
	CreatePadding(NotifHolder, 10, 0, 10, 0)
end
function Blood:Notify(config)
	EnsureNotifHolder()
	local title = config.Title or "Notification"
	local text = config.Text or ""
	local duration = config.Duration or 5
	local ntype = config.Type or "info"
	local accentColor = Theme.Accent
	if ntype == "success" then accentColor = Theme.Success
	elseif ntype == "warning" then accentColor = Theme.Warning
	elseif ntype == "error" then accentColor = Theme.Error end
	local card = CreateFrame({
		Color = Theme.Secondary,
		Size = UDim2.new(1, 0, 0, 70),
		Parent = NotifHolder,
	})
	card.ClipsDescendants = true
	CreateCorner(card, 8)
	CreateStroke(card, Theme.Border, 1)
	local bar = CreateFrame({
		Color = accentColor,
		Size = UDim2.new(0, 3, 1, 0),
		Parent = card,
	})
	CreateCorner(bar, 2)
	local titleL = CreateLabel({
		Text = title,
		Color = Theme.Text,
		Font = Fonts.Bold,
		Size = 13,
		FrameSize = UDim2.new(1, -20, 0, 18),
		Position = UDim2.new(0, 12, 0, 12),
		Parent = card,
	})
	local textL = CreateLabel({
		Text = text,
		Color = Theme.TextDim,
		Font = Fonts.Regular,
		Size = 12,
		FrameSize = UDim2.new(1, -20, 0, 30),
		Position = UDim2.new(0, 12, 0, 32),
		AlignY = Enum.TextYAlignment.Top,
		Parent = card,
	})
	textL.TextWrapped = true
	local progress = CreateFrame({
		Color = accentColor,
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		Parent = card,
	})
	card.Position = UDim2.new(1, 20, 0, 0)
	card.BackgroundTransparency = 1
	Tween(card, Tweens.Spring, { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 })
	Tween(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 2) })
	task.delay(duration, function()
		Tween(card, Tweens.Medium, { Position = UDim2.new(1, 20, 0, 0), BackgroundTransparency = 1 })
		task.delay(0.35, function()
			card:Destroy()
		end)
	end)
end
function Blood:SetTheme(custom)
	for k, v in pairs(custom) do
		if Theme[k] ~= nil then
			Theme[k] = v
		end
	end
end
function Blood:ApplyPreset(name)
	local presets = {
		Red = { Accent = Color3.fromRGB(180, 20, 30), AccentDark = Color3.fromRGB(120, 10, 18), Border = Color3.fromRGB(45, 20, 25) },
		Blue = { Accent = Color3.fromRGB(30, 100, 220), AccentDark = Color3.fromRGB(20, 60, 160), Border = Color3.fromRGB(20, 30, 60) },
		Purple = { Accent = Color3.fromRGB(130, 40, 200), AccentDark = Color3.fromRGB(90, 20, 140), Border = Color3.fromRGB(35, 20, 55) },
		Green = { Accent = Color3.fromRGB(30, 170, 80), AccentDark = Color3.fromRGB(20, 110, 55), Border = Color3.fromRGB(20, 40, 25) },
	}
	if presets[name] then
		self:SetTheme(presets[name])
	end
end
function Blood:SetLogo(assetId)
	for _, w in ipairs(ActiveWindows) do
		if w.LogoImage then
			w.LogoImage.Image = assetId
		end
	end
end
function Blood:CreateWindow(config)
	local WindowObj = {}
	WindowObj.Tabs = {}
	WindowObj.ActiveTab = nil
	WindowObj.Open = true
	local title = config.Title or "Blood Library"
	local logo = config.Logo or ""
	local windowSize = config.Size or UDim2.new(0, 580, 0, 420)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "BloodLibrary_" .. title
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 100
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	local Backdrop = CreateFrame({
		Color = Color3.fromRGB(0, 0, 0),
		Transparency = 0.6,
		Size = UDim2.new(1, 0, 1, 0),
		Parent = ScreenGui,
	})
	Backdrop.Name = "Backdrop"
	Backdrop.ZIndex = 1
	Backdrop.Visible = false
	local Main = CreateFrame({
		Color = Theme.Background,
		Transparency = Theme.Transparency,
		Size = windowSize,
		Position = UDim2.new(0.5, -windowSize.X.Offset / 2, 0.5, -windowSize.Y.Offset / 2),
		Parent = ScreenGui,
	})
	Main.Name = "Main"
	Main.ZIndex = 10
	CreateCorner(Main, 10)
	CreateStroke(Main, Theme.Border, 1)
	local mainGlow = Instance.new("ImageLabel")
	mainGlow.Name = "Glow"
	mainGlow.BackgroundTransparency = 1
	mainGlow.Image = "rbxassetid://5028857084"
	mainGlow.ImageColor3 = Theme.Accent
	mainGlow.ImageTransparency = 0.88
	mainGlow.Size = UDim2.new(1, 60, 1, 60)
	mainGlow.Position = UDim2.new(0, -30, 0, -30)
	mainGlow.ZIndex = 9
	mainGlow.Parent = Main
	local Titlebar = CreateFrame({
		Color = Theme.Secondary,
		Size = UDim2.new(1, 0, 0, 50),
		Parent = Main,
	})
	Titlebar.Name = "Titlebar"
	Titlebar.ZIndex = 12
	local titlebarCorner = Instance.new("UICorner")
	titlebarCorner.CornerRadius = UDim.new(0, 10)
	titlebarCorner.Parent = Titlebar
	local titlebarFix = CreateFrame({
		Color = Theme.Secondary,
		Size = UDim2.new(1, 0, 0, 10),
		Position = UDim2.new(0, 0, 1, -10),
		Parent = Titlebar,
	})
	titlebarFix.ZIndex = 12
	local titlebarBorder = CreateFrame({
		Color = Theme.Border,
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
		Parent = Titlebar,
	})
	titlebarBorder.ZIndex = 13
	local LogoImage = CreateImage({
		Image = logo,
		Size = UDim2.new(0, 28, 0, 28),
		Position = UDim2.new(0, 14, 0.5, -14),
		Parent = Titlebar,
	})
	LogoImage.ZIndex = 13
	WindowObj.LogoImage = LogoImage
	local TitleLabel = CreateLabel({
		Text = title,
		Color = Theme.Text,
		Font = Fonts.Bold,
		Size = 16,
		FrameSize = UDim2.new(1, -160, 1, 0),
		Position = UDim2.new(0, 52, 0, 0),
		Parent = Titlebar,
	})
	TitleLabel.ZIndex = 13
	local SubLabel = CreateLabel({
		Text = "Blood Library  •  by King",
		Color = Theme.TextDim,
		Font = Fonts.Regular,
		Size = 11,
		FrameSize = UDim2.new(1, -160, 0, 14),
		Position = UDim2.new(0, 52, 1, -18),
		Parent = Titlebar,
	})
	SubLabel.ZIndex = 13
	local CloseBtn = CreateButton({
		Color = Color3.fromRGB(180, 30, 40),
		Size = UDim2.new(0, 32, 0, 32),
		Position = UDim2.new(1, -42, 0.5, -16),
		Text = "✕",
		TextColor = Color3.new(1, 1, 1),
		TextSize = 13,
		Font = Fonts.Bold,
		Parent = Titlebar,
	})
	CloseBtn.ZIndex = 14
	CreateCorner(CloseBtn, 6)
	CloseBtn.MouseEnter:Connect(function()
		Tween(CloseBtn, Tweens.Fast, { BackgroundColor3 = Color3.fromRGB(220, 50, 60) })
	end)
	CloseBtn.MouseLeave:Connect(function()
		Tween(CloseBtn, Tweens.Fast, { BackgroundColor3 = Color3.fromRGB(180, 30, 40) })
	end)
	local MinBtn = CreateButton({
		Color = Theme.Tertiary,
		Size = UDim2.new(0, 32, 0, 32),
		Position = UDim2.new(1, -80, 0.5, -16),
		Text = "−",
		TextColor = Theme.TextDim,
		TextSize = 18,
		Font = Fonts.Bold,
		Parent = Titlebar,
	})
	MinBtn.ZIndex = 14
	CreateCorner(MinBtn, 6)
	CreateStroke(MinBtn, Theme.Border, 1)
	MinBtn.MouseEnter:Connect(function()
		Tween(MinBtn, Tweens.Fast, { BackgroundColor3 = Theme.Border })
	end)
	MinBtn.MouseLeave:Connect(function()
		Tween(MinBtn, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
	end)
	local Body = CreateFrame({
		Color = Color3.fromRGB(0, 0, 0),
		Transparency = 1,
		Size = UDim2.new(1, 0, 1, -50),
		Position = UDim2.new(0, 0, 0, 50),
		Parent = Main,
	})
	Body.Name = "Body"
	Body.ZIndex = 11
	local Sidebar = CreateFrame({
		Color = Theme.Secondary,
		Size = UDim2.new(0, 160, 1, 0),
		Parent = Body,
	})
	Sidebar.Name = "Sidebar"
	Sidebar.ZIndex = 12
	local sidebarCornerFix = CreateFrame({
		Color = Theme.Secondary,
		Size = UDim2.new(0, 10, 1, 0),
		Position = UDim2.new(1, -10, 0, 0),
		Parent = Sidebar,
	})
	sidebarCornerFix.ZIndex = 12
	local SidebarBorder = CreateFrame({
		Color = Theme.Border,
		Size = UDim2.new(0, 1, 1, 0),
		Position = UDim2.new(1, -1, 0, 0),
		Parent = Sidebar,
	})
	SidebarBorder.ZIndex = 13
	local TabList = Instance.new("Frame")
	TabList.Name = "TabList"
	TabList.BackgroundTransparency = 1
	TabList.Size = UDim2.new(1, 0, 1, 0)
	TabList.Parent = Sidebar
	TabList.ZIndex = 13
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 2)
	TabLayout.Parent = TabList
	CreatePadding(TabList, 8, 8, 8, 8)
	local ContentArea = CreateFrame({
		Color = Color3.fromRGB(0, 0, 0),
		Transparency = 1,
		Size = UDim2.new(1, -160, 1, 0),
		Position = UDim2.new(0, 160, 0, 0),
		Clip = true,
		Parent = Body,
	})
	ContentArea.Name = "ContentArea"
	ContentArea.ZIndex = 11
	MakeDraggable(Main, Titlebar)
	local FloatBtn = CreateButton({
		Color = Theme.Accent,
		Size = UDim2.new(0, 44, 0, 44),
		Position = UDim2.new(0, 20, 0.5, -22),
		Text = "⚔",
		TextColor = Color3.new(1, 1, 1),
		TextSize = 18,
		Parent = ScreenGui,
	})
	FloatBtn.Name = "FloatBtn"
	FloatBtn.ZIndex = 50
	FloatBtn.Visible = false
	CreateCorner(FloatBtn, 22)
	CreateStroke(FloatBtn, Theme.Border, 1)
	local floatGlow = Instance.new("ImageLabel")
	floatGlow.BackgroundTransparency = 1
	floatGlow.Image = "rbxassetid://5028857084"
	floatGlow.ImageColor3 = Theme.Accent
	floatGlow.ImageTransparency = 0.7
	floatGlow.Size = UDim2.new(1, 30, 1, 30)
	floatGlow.Position = UDim2.new(0, -15, 0, -15)
	floatGlow.ZIndex = 49
	floatGlow.Parent = FloatBtn
	MakeDraggable(FloatBtn)
	FloatBtn.MouseEnter:Connect(function()
		Tween(FloatBtn, Tweens.Fast, { BackgroundColor3 = Theme.AccentGlow })
	end)
	FloatBtn.MouseLeave:Connect(function()
		Tween(FloatBtn, Tweens.Fast, { BackgroundColor3 = Theme.Accent })
	end)
	Main.Size = UDim2.new(0, windowSize.X.Offset * 0.85, 0, windowSize.Y.Offset * 0.85)
	Main.BackgroundTransparency = 1
	Tween(Main, Tweens.Spring, {
		Size = windowSize,
		BackgroundTransparency = Theme.Transparency,
	})
	CloseBtn.MouseButton1Click:Connect(function()
		Tween(Main, Tweens.Medium, {
			Size = UDim2.new(0, windowSize.X.Offset * 0.85, 0, windowSize.Y.Offset * 0.85),
			BackgroundTransparency = 1,
		})
		task.delay(0.3, function()
			ScreenGui:Destroy()
		end)
	end)
	MinBtn.MouseButton1Click:Connect(function()
		WindowObj.Open = false
		Tween(Main, Tweens.Medium, {
			Size = UDim2.new(0, windowSize.X.Offset * 0.85, 0, windowSize.Y.Offset * 0.85),
			BackgroundTransparency = 1,
		})
		task.delay(0.3, function()
			Main.Visible = false
			FloatBtn.Visible = true
			FloatBtn.BackgroundTransparency = 1
			FloatBtn.Size = UDim2.new(0, 30, 0, 30)
			Tween(FloatBtn, Tweens.Spring, {
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 44, 0, 44),
			})
		end)
	end)
	FloatBtn.MouseButton1Click:Connect(function()
		WindowObj.Open = true
		FloatBtn.Visible = false
		Main.Visible = true
		Main.Size = UDim2.new(0, windowSize.X.Offset * 0.85, 0, windowSize.Y.Offset * 0.85)
		Main.BackgroundTransparency = 1
		Tween(Main, Tweens.Spring, {
			Size = windowSize,
			BackgroundTransparency = Theme.Transparency,
		})
	end)
	table.insert(ActiveWindows, WindowObj)
	function WindowObj:AddTab(tabConfig)
		local TabObj = {}
		TabObj.Elements = {}
		TabObj.Button = nil
		TabObj.Content = nil
		TabObj.Active = false
		local tabName = tabConfig.Name or "Tab"
		local tabIcon = tabConfig.Icon or ""
		local TabBtn = CreateButton({
			Color = Color3.fromRGB(0, 0, 0),
			Transparency = 1,
			Size = UDim2.new(1, 0, 0, 36),
			Parent = TabList,
		})
		TabBtn.Name = tabName
		TabBtn.ZIndex = 14
		TabBtn.LayoutOrder = #WindowObj.Tabs + 1
		CreateCorner(TabBtn, 7)
		local activeBar = CreateFrame({
			Color = Theme.Accent,
			Size = UDim2.new(0, 3, 0.6, 0),
			Position = UDim2.new(0, 0, 0.2, 0),
			Parent = TabBtn,
		})
		activeBar.ZIndex = 15
		activeBar.BackgroundTransparency = 1
		CreateCorner(activeBar, 2)
		local iconImg = nil
		local labelOffset = 12
		if tabIcon ~= "" then
			iconImg = CreateImage({
				Image = tabIcon,
				Size = UDim2.new(0, 16, 0, 16),
				Position = UDim2.new(0, 10, 0.5, -8),
				Color = Theme.TextDim,
				Parent = TabBtn,
			})
			iconImg.ZIndex = 15
			labelOffset = 34
		end
		local TabLabel = CreateLabel({
			Text = tabName,
			Color = Theme.TextDim,
			Font = Fonts.Semi,
			Size = 13,
			FrameSize = UDim2.new(1, -labelOffset - 4, 1, 0),
			Position = UDim2.new(0, labelOffset, 0, 0),
			Parent = TabBtn,
		})
		TabLabel.ZIndex = 15
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = "Tab_" .. tabName
		TabContent.BackgroundTransparency = 1
		TabContent.Size = UDim2.new(1, 0, 1, 0)
		TabContent.Position = UDim2.new(0, 0, 0, 0)
		TabContent.ScrollBarThickness = 3
		TabContent.ScrollBarImageColor3 = Theme.Accent
		TabContent.BorderSizePixel = 0
		TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
		TabContent.Visible = false
		TabContent.ZIndex = 12
		TabContent.Parent = ContentArea
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 6)
		ContentLayout.Parent = TabContent
		CreatePadding(TabContent, 10, 10, 10, 10)
		TabObj.Button = TabBtn
		TabObj.Content = TabContent
		TabObj.Label = TabLabel
		TabObj.Icon = iconImg
		TabObj.ActiveBar = activeBar
		local function SetActive(active)
			TabObj.Active = active
			if active then
				Tween(TabBtn, Tweens.Fast, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Tertiary })
				Tween(TabLabel, Tweens.Fast, { TextColor3 = Theme.Text })
				Tween(activeBar, Tweens.Fast, { BackgroundTransparency = 0 })
				if iconImg then Tween(iconImg, Tweens.Fast, { ImageColor3 = Theme.Accent }) end
				TabContent.Visible = true
			else
				Tween(TabBtn, Tweens.Fast, { BackgroundTransparency = 1 })
				Tween(TabLabel, Tweens.Fast, { TextColor3 = Theme.TextDim })
				Tween(activeBar, Tweens.Fast, { BackgroundTransparency = 1 })
				if iconImg then Tween(iconImg, Tweens.Fast, { ImageColor3 = Theme.TextDim }) end
				TabContent.Visible = false
			end
		end
		TabBtn.MouseEnter:Connect(function()
			if not TabObj.Active then
				Tween(TabBtn, Tweens.Fast, { BackgroundTransparency = 0.5, BackgroundColor3 = Theme.Tertiary })
			end
		end)
		TabBtn.MouseLeave:Connect(function()
			if not TabObj.Active then
				Tween(TabBtn, Tweens.Fast, { BackgroundTransparency = 1 })
			end
		end)
		TabBtn.MouseButton1Click:Connect(function()
			if WindowObj.ActiveTab and WindowObj.ActiveTab ~= TabObj then
				WindowObj.ActiveTab.Active = false
				local prevBtn = WindowObj.ActiveTab.Button
				local prevLabel = WindowObj.ActiveTab.Label
				local prevBar = WindowObj.ActiveTab.ActiveBar
				local prevIcon = WindowObj.ActiveTab.Icon
				Tween(prevBtn, Tweens.Fast, { BackgroundTransparency = 1 })
				Tween(prevLabel, Tweens.Fast, { TextColor3 = Theme.TextDim })
				Tween(prevBar, Tweens.Fast, { BackgroundTransparency = 1 })
				if prevIcon then Tween(prevIcon, Tweens.Fast, { ImageColor3 = Theme.TextDim }) end
				WindowObj.ActiveTab.Content.Visible = false
			end
			SetActive(true)
			WindowObj.ActiveTab = TabObj
		end)
		if #WindowObj.Tabs == 0 then
			SetActive(true)
			WindowObj.ActiveTab = TabObj
		end
		table.insert(WindowObj.Tabs, TabObj)
		function TabObj:AddSection(sectionConfig)
			local SectionObj = {}
			local sectionName = sectionConfig.Name or "Section"
			local SectionFrame = CreateFrame({
				Color = Theme.Secondary,
				Size = UDim2.new(1, 0, 0, 32),
				Parent = TabContent,
			})
			SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
			SectionFrame.Name = "Section_" .. sectionName
			SectionFrame.LayoutOrder = #TabObj.Elements + 1
			SectionFrame.ZIndex = 13
			CreateCorner(SectionFrame, 8)
			CreateStroke(SectionFrame, Theme.Border, 1)
			local SectionLayout = Instance.new("UIListLayout")
			SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionLayout.Padding = UDim.new(0, 4)
			SectionLayout.Parent = SectionFrame
			local SectionPad = Instance.new("UIPadding")
			SectionPad.PaddingTop = UDim.new(0, 34)
			SectionPad.PaddingBottom = UDim.new(0, 8)
			SectionPad.PaddingLeft = UDim.new(0, 8)
			SectionPad.PaddingRight = UDim.new(0, 8)
			SectionPad.Parent = SectionFrame
			local SectionHeader = CreateFrame({
				Color = Theme.Tertiary,
				Size = UDim2.new(1, 0, 0, 28),
				Parent = SectionFrame,
			})
			SectionHeader.ZIndex = 14
			SectionHeader.LayoutOrder = -1
			CreateCorner(SectionHeader, 6)
			local headerAccent = CreateFrame({
				Color = Theme.Accent,
				Size = UDim2.new(0, 3, 0.6, 0),
				Position = UDim2.new(0, 0, 0.2, 0),
				Parent = SectionHeader,
			})
			headerAccent.ZIndex = 15
			CreateCorner(headerAccent, 1)
			local SectionLabel = CreateLabel({
				Text = sectionName,
				Color = Theme.TextDim,
				Font = Fonts.Semi,
				Size = 11,
				FrameSize = UDim2.new(1, -16, 1, 0),
				Position = UDim2.new(0, 12, 0, 0),
				Parent = SectionHeader,
			})
			SectionLabel.ZIndex = 15
			SectionLabel.TextTransparency = 0.2
			table.insert(TabObj.Elements, SectionFrame)
			SectionObj.Frame = SectionFrame
			local function AddElement(element)
				element.Parent = SectionFrame
				element.ZIndex = 14
				table.insert(TabObj.Elements, element)
				return element
			end
			function SectionObj:AddButton(btnConfig)
				local btnName = btnConfig.Name or "Button"
				local callback = btnConfig.Callback or function() end
				local BtnFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
				})
				BtnFrame.Name = "Btn_" .. btnName
				BtnFrame.LayoutOrder = #TabObj.Elements + 1
				local BtnEl = CreateButton({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 1, 0),
					Text = "",
					Parent = BtnFrame,
				})
				BtnEl.ZIndex = 15
				CreateCorner(BtnEl, 6)
				CreateStroke(BtnEl, Theme.Border, 1)
				local BtnLabel = CreateLabel({
					Text = btnName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(1, -16, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Parent = BtnEl,
				})
				BtnLabel.ZIndex = 16
				local clickAnim = CreateFrame({
					Color = Theme.Accent,
					Transparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = BtnEl,
				})
				clickAnim.ZIndex = 16
				CreateCorner(clickAnim, 6)
				BtnEl.MouseEnter:Connect(function()
					Tween(BtnEl, Tweens.Fast, { BackgroundColor3 = Theme.Border })
				end)
				BtnEl.MouseLeave:Connect(function()
					Tween(BtnEl, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
				end)
				BtnEl.MouseButton1Click:Connect(function()
					Tween(clickAnim, Tweens.Fast, { BackgroundTransparency = 0.7 })
					task.delay(0.18, function()
						Tween(clickAnim, Tweens.Fast, { BackgroundTransparency = 1 })
					end)
					task.spawn(callback)
				end)
				AddElement(BtnFrame)
				return BtnEl
			end
			function SectionObj:AddToggle(togConfig)
				local togName = togConfig.Name or "Toggle"
				local default = togConfig.Default or false
				local callback = togConfig.Callback or function() end
				local state = default
				local TogFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
				})
				TogFrame.Name = "Tog_" .. togName
				TogFrame.LayoutOrder = #TabObj.Elements + 1
				local TogEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = TogFrame,
				})
				TogEl.ZIndex = 15
				CreateCorner(TogEl, 6)
				CreateStroke(TogEl, Theme.Border, 1)
				local TogLabel = CreateLabel({
					Text = togName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(1, -60, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Parent = TogEl,
				})
				TogLabel.ZIndex = 16
				local Track = CreateFrame({
					Color = Theme.Background,
					Size = UDim2.new(0, 38, 0, 20),
					Position = UDim2.new(1, -50, 0.5, -10),
					Parent = TogEl,
				})
				Track.ZIndex = 16
				CreateCorner(Track, 10)
				CreateStroke(Track, Theme.Border, 1)
				local Knob = CreateFrame({
					Color = Theme.TextDim,
					Size = UDim2.new(0, 14, 0, 14),
					Position = UDim2.new(0, 3, 0.5, -7),
					Parent = Track,
				})
				Knob.ZIndex = 17
				CreateCorner(Knob, 7)
				local function SetToggle(val)
					state = val
					if state then
						Tween(Track, Tweens.Fast, { BackgroundColor3 = Theme.AccentDark })
						Tween(Knob, Tweens.Fast, { Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Theme.Accent })
					else
						Tween(Track, Tweens.Fast, { BackgroundColor3 = Theme.Background })
						Tween(Knob, Tweens.Fast, { Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Theme.TextDim })
					end
					task.spawn(callback, state)
				end
				SetToggle(state)
				local ClickBtn = CreateButton({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = TogFrame,
				})
				ClickBtn.ZIndex = 18
				ClickBtn.MouseEnter:Connect(function()
					Tween(TogEl, Tweens.Fast, { BackgroundColor3 = Theme.Border })
				end)
				ClickBtn.MouseLeave:Connect(function()
					Tween(TogEl, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
				end)
				ClickBtn.MouseButton1Click:Connect(function()
					SetToggle(not state)
				end)
				AddElement(TogFrame)
				local TogAPI = {}
				function TogAPI:Set(val)
					SetToggle(val)
				end
				function TogAPI:Get()
					return state
				end
				return TogAPI
			end
			function SectionObj:AddSlider(sliderConfig)
				local sliderName = sliderConfig.Name or "Slider"
				local min = sliderConfig.Min or 0
				local max = sliderConfig.Max or 100
				local default = sliderConfig.Default or min
				local callback = sliderConfig.Callback or function() end
				local value = default
				local SliderFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 52),
				})
				SliderFrame.Name = "Slider_" .. sliderName
				SliderFrame.LayoutOrder = #TabObj.Elements + 1
				local SliderEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = SliderFrame,
				})
				SliderEl.ZIndex = 15
				CreateCorner(SliderEl, 6)
				CreateStroke(SliderEl, Theme.Border, 1)
				CreatePadding(SliderEl, 8, 10, 8, 12)
				local TopRow = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					Parent = SliderEl,
				})
				TopRow.ZIndex = 16
				local SliderLabel = CreateLabel({
					Text = sliderName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(0.7, 0, 1, 0),
					Parent = TopRow,
				})
				SliderLabel.ZIndex = 17
				local ValLabel = CreateLabel({
					Text = tostring(value),
					Color = Theme.Accent,
					Font = Fonts.Bold,
					Size = 12,
					FrameSize = UDim2.new(0.3, 0, 1, 0),
					Position = UDim2.new(0.7, 0, 0, 0),
					AlignX = Enum.TextXAlignment.Right,
					Parent = TopRow,
				})
				ValLabel.ZIndex = 17
				local TrackBg = CreateFrame({
					Color = Theme.Background,
					Size = UDim2.new(1, 0, 0, 6),
					Position = UDim2.new(0, 0, 1, -6),
					Parent = SliderEl,
				})
				TrackBg.ZIndex = 16
				CreateCorner(TrackBg, 3)
				local Fill = CreateFrame({
					Color = Theme.Accent,
					Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
					Parent = TrackBg,
				})
				Fill.ZIndex = 17
				CreateCorner(Fill, 3)
				local Handle = CreateFrame({
					Color = Color3.new(1, 1, 1),
					Size = UDim2.new(0, 12, 0, 12),
					Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6),
					Parent = TrackBg,
				})
				Handle.ZIndex = 18
				CreateCorner(Handle, 6)
				local sliding = false
				local function UpdateSlider(input)
					local relX = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
					value = math.floor(min + relX * (max - min) + 0.5)
					local pct = (value - min) / (max - min)
					Fill.Size = UDim2.new(pct, 0, 1, 0)
					Handle.Position = UDim2.new(pct, -6, 0.5, -6)
					ValLabel.Text = tostring(value)
					task.spawn(callback, value)
				end
				TrackBg.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliding = true
						UpdateSlider(input)
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						UpdateSlider(input)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliding = false
					end
				end)
				AddElement(SliderFrame)
				local SliderAPI = {}
				function SliderAPI:Set(val)
					value = math.clamp(val, min, max)
					local pct = (value - min) / (max - min)
					Fill.Size = UDim2.new(pct, 0, 1, 0)
					Handle.Position = UDim2.new(pct, -6, 0.5, -6)
					ValLabel.Text = tostring(value)
					task.spawn(callback, value)
				end
				function SliderAPI:Get()
					return value
				end
				return SliderAPI
			end
			function SectionObj:AddDropdown(ddConfig)
				local ddName = ddConfig.Name or "Dropdown"
				local options = ddConfig.Options or {}
				local callback = ddConfig.Callback or function() end
				local selected = ddConfig.Default or nil
				local open = false
				local DDFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
				})
				DDFrame.Name = "DD_" .. ddName
				DDFrame.LayoutOrder = #TabObj.Elements + 1
				DDFrame.ZIndex = 20
				DDFrame.ClipsDescendants = false
				local DDEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 0, 36),
					Parent = DDFrame,
				})
				DDEl.ZIndex = 20
				CreateCorner(DDEl, 6)
				CreateStroke(DDEl, Theme.Border, 1)
				local DDLabel = CreateLabel({
					Text = ddName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(0.6, 0, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Parent = DDEl,
				})
				DDLabel.ZIndex = 21
				local SelLabel = CreateLabel({
					Text = selected or "Select...",
					Color = Theme.Accent,
					Font = Fonts.Regular,
					Size = 12,
					FrameSize = UDim2.new(0.38, 0, 1, 0),
					Position = UDim2.new(0.58, 0, 0, 0),
					AlignX = Enum.TextXAlignment.Right,
					Parent = DDEl,
				})
				SelLabel.ZIndex = 21
				local Arrow = CreateLabel({
					Text = "▼",
					Color = Theme.TextDim,
					Font = Fonts.Regular,
					Size = 10,
					FrameSize = UDim2.new(0, 20, 1, 0),
					Position = UDim2.new(1, -24, 0, 0),
					AlignX = Enum.TextXAlignment.Center,
					Parent = DDEl,
				})
				Arrow.ZIndex = 21
				local Dropdown = CreateFrame({
					Color = Theme.Secondary,
					Size = UDim2.new(1, 0, 0, 0),
					Position = UDim2.new(0, 0, 1, 4),
					Clip = true,
					Parent = DDFrame,
				})
				Dropdown.ZIndex = 30
				Dropdown.Name = "DropList"
				CreateCorner(Dropdown, 6)
				CreateStroke(Dropdown, Theme.Border, 1)
				local DropLayout = Instance.new("UIListLayout")
				DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropLayout.Padding = UDim.new(0, 2)
				DropLayout.Parent = Dropdown
				CreatePadding(Dropdown, 4, 4, 4, 4)
				local function PopulateDropdown()
					for _, child in ipairs(Dropdown:GetChildren()) do
						if child:IsA("Frame") or child:IsA("TextButton") then
							child:Destroy()
						end
					end
					for i, opt in ipairs(options) do
						local OptBtn = CreateButton({
							Color = Color3.fromRGB(0, 0, 0),
							Transparency = 1,
							Size = UDim2.new(1, 0, 0, 30),
							Text = opt,
							TextColor = opt == selected and Theme.Accent or Theme.Text,
							TextSize = 12,
							Font = opt == selected and Fonts.Semi or Fonts.Regular,
							Parent = Dropdown,
						})
						OptBtn.ZIndex = 31
						OptBtn.LayoutOrder = i
						CreateCorner(OptBtn, 5)
						OptBtn.MouseEnter:Connect(function()
							Tween(OptBtn, Tweens.Fast, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Tertiary })
						end)
						OptBtn.MouseLeave:Connect(function()
							Tween(OptBtn, Tweens.Fast, { BackgroundTransparency = 1 })
						end)
						OptBtn.MouseButton1Click:Connect(function()
							selected = opt
							SelLabel.Text = opt
							open = false
							Tween(Dropdown, Tweens.Fast, { Size = UDim2.new(1, 0, 0, 0) })
							Tween(Arrow, Tweens.Fast, { Rotation = 0 })
							DDFrame.Size = UDim2.new(1, 0, 0, 36)
							PopulateDropdown()
							task.spawn(callback, opt)
						end)
					end
				end
				PopulateDropdown()
				local OpenBtn = CreateButton({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
					Parent = DDFrame,
				})
				OpenBtn.ZIndex = 22
				OpenBtn.MouseEnter:Connect(function()
					Tween(DDEl, Tweens.Fast, { BackgroundColor3 = Theme.Border })
				end)
				OpenBtn.MouseLeave:Connect(function()
					Tween(DDEl, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
				end)
				OpenBtn.MouseButton1Click:Connect(function()
					open = not open
					local totalH = math.min(#options * 34 + 12, 160)
					if open then
						Tween(Dropdown, Tweens.Fast, { Size = UDim2.new(1, 0, 0, totalH) })
						Tween(Arrow, Tweens.Fast, { Rotation = 180 })
						DDFrame.Size = UDim2.new(1, 0, 0, 36 + totalH + 4)
					else
						Tween(Dropdown, Tweens.Fast, { Size = UDim2.new(1, 0, 0, 0) })
						Tween(Arrow, Tweens.Fast, { Rotation = 0 })
						DDFrame.Size = UDim2.new(1, 0, 0, 36)
					end
				end)
				AddElement(DDFrame)
				local DDAPI = {}
				function DDAPI:Set(val)
					if table.find(options, val) then
						selected = val
						SelLabel.Text = val
						PopulateDropdown()
						task.spawn(callback, val)
					end
				end
				function DDAPI:Get() return selected end
				function DDAPI:SetOptions(newOpts)
					options = newOpts
					PopulateDropdown()
				end
				return DDAPI
			end
			function SectionObj:AddTextbox(tbConfig)
				local tbName = tbConfig.Name or "Input"
				local placeholder = tbConfig.Placeholder or "Enter text..."
				local callback = tbConfig.Callback or function() end
				local TBFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 52),
				})
				TBFrame.Name = "TB_" .. tbName
				TBFrame.LayoutOrder = #TabObj.Elements + 1
				local TBEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = TBFrame,
				})
				TBEl.ZIndex = 15
				CreateCorner(TBEl, 6)
				CreateStroke(TBEl, Theme.Border, 1)
				CreatePadding(TBEl, 6, 10, 6, 12)
				local TBLabel = CreateLabel({
					Text = tbName,
					Color = Theme.TextDim,
					Font = Fonts.Semi,
					Size = 11,
					FrameSize = UDim2.new(1, 0, 0, 16),
					Parent = TBEl,
				})
				TBLabel.ZIndex = 16
				local TBInput = Instance.new("TextBox")
				TBInput.BackgroundColor3 = Theme.Background
				TBInput.BorderSizePixel = 0
				TBInput.Size = UDim2.new(1, 0, 0, 24)
				TBInput.Position = UDim2.new(0, 0, 1, -24)
				TBInput.Text = ""
				TBInput.PlaceholderText = placeholder
				TBInput.PlaceholderColor3 = Theme.TextDim
				TBInput.TextColor3 = Theme.Text
				TBInput.Font = Fonts.Regular
				TBInput.TextSize = 12
				TBInput.TextXAlignment = Enum.TextXAlignment.Left
				TBInput.ClearTextOnFocus = false
				TBInput.ZIndex = 16
				TBInput.Parent = TBEl
				CreateCorner(TBInput, 4)
				CreatePadding(TBInput, 0, 6, 0, 6)
				TBInput.Focused:Connect(function()
					Tween(TBEl, Tweens.Fast, { BackgroundColor3 = Theme.Border })
					CreateStroke(TBInput, Theme.Accent, 1)
				end)
				TBInput.FocusLost:Connect(function(enter)
					Tween(TBEl, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
					if enter then
						task.spawn(callback, TBInput.Text)
					end
				end)
				AddElement(TBFrame)
				local TBAPI = {}
				function TBAPI:Get() return TBInput.Text end
				function TBAPI:Set(val) TBInput.Text = val end
				return TBAPI
			end
			function SectionObj:AddKeybind(kbConfig)
				local kbName = kbConfig.Name or "Key"
				local defaultKey = kbConfig.Default or Enum.KeyCode.RightShift
				local callback = kbConfig.Callback or function() end
				local currentKey = defaultKey
				local listening = false
				local KBFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
				})
				KBFrame.Name = "KB_" .. kbName
				KBFrame.LayoutOrder = #TabObj.Elements + 1
				local KBEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = KBFrame,
				})
				KBEl.ZIndex = 15
				CreateCorner(KBEl, 6)
				CreateStroke(KBEl, Theme.Border, 1)
				local KBLabel = CreateLabel({
					Text = kbName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(0.6, 0, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Parent = KBEl,
				})
				KBLabel.ZIndex = 16
				local KeyTag = CreateFrame({
					Color = Theme.Background,
					Size = UDim2.new(0, 80, 0, 24),
					Position = UDim2.new(1, -92, 0.5, -12),
					Parent = KBEl,
				})
				KeyTag.ZIndex = 16
				CreateCorner(KeyTag, 5)
				CreateStroke(KeyTag, Theme.Accent, 1)
				local KeyLabel = CreateLabel({
					Text = currentKey.Name,
					Color = Theme.Accent,
					Font = Fonts.Semi,
					Size = 11,
					AlignX = Enum.TextXAlignment.Center,
					Parent = KeyTag,
				})
				KeyLabel.ZIndex = 17
				local BindBtn = CreateButton({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = KBFrame,
				})
				BindBtn.ZIndex = 18
				BindBtn.MouseButton1Click:Connect(function()
					listening = true
					KeyLabel.Text = "..."
					Tween(KeyTag, Tweens.Fast, { BackgroundColor3 = Theme.AccentDark })
				end)
				UserInputService.InputBegan:Connect(function(input, processed)
					if listening and not processed then
						if input.UserInputType == Enum.UserInputType.Keyboard then
							currentKey = input.KeyCode
							listening = false
							KeyLabel.Text = currentKey.Name
							Tween(KeyTag, Tweens.Fast, { BackgroundColor3 = Theme.Background })
						end
					elseif not listening and input.KeyCode == currentKey then
						task.spawn(callback, currentKey)
					end
				end)
				AddElement(KBFrame)
				local KBAPI = {}
				function KBAPI:Get() return currentKey end
				function KBAPI:Set(key)
					currentKey = key
					KeyLabel.Text = key.Name
				end
				return KBAPI
			end
			function SectionObj:AddLabel(text)
				local LFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 28),
				})
				LFrame.Name = "Lbl"
				LFrame.LayoutOrder = #TabObj.Elements + 1
				local L = CreateLabel({
					Text = text or "",
					Color = Theme.TextDim,
					Font = Fonts.Regular,
					Size = 12,
					FrameSize = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Rich = true,
					Parent = LFrame,
				})
				L.ZIndex = 15
				AddElement(LFrame)
				return L
			end
			function SectionObj:AddColorPicker(cpConfig)
				local cpName = cpConfig.Name or "Color"
				local defaultColor = cpConfig.Default or Color3.fromRGB(180, 20, 30)
				local callback = cpConfig.Callback or function() end
				local currentColor = defaultColor
				local open = false
				local CPFrame = CreateFrame({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
				})
				CPFrame.Name = "CP_" .. cpName
				CPFrame.LayoutOrder = #TabObj.Elements + 1
				CPFrame.ClipsDescendants = false
				local CPEl = CreateFrame({
					Color = Theme.Tertiary,
					Size = UDim2.new(1, 0, 0, 36),
					Parent = CPFrame,
				})
				CPEl.ZIndex = 15
				CreateCorner(CPEl, 6)
				CreateStroke(CPEl, Theme.Border, 1)
				local CPLabel = CreateLabel({
					Text = cpName,
					Color = Theme.Text,
					Font = Fonts.Semi,
					Size = 13,
					FrameSize = UDim2.new(0.7, 0, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Parent = CPEl,
				})
				CPLabel.ZIndex = 16
				local Swatch = CreateFrame({
					Color = currentColor,
					Size = UDim2.new(0, 28, 0, 20),
					Position = UDim2.new(1, -40, 0.5, -10),
					Parent = CPEl,
				})
				Swatch.ZIndex = 16
				CreateCorner(Swatch, 5)
				CreateStroke(Swatch, Theme.Border, 1)
				local CPPanel = CreateFrame({
					Color = Theme.Secondary,
					Size = UDim2.new(1, 0, 0, 0),
					Position = UDim2.new(0, 0, 1, 4),
					Clip = true,
					Parent = CPFrame,
				})
				CPPanel.ZIndex = 30
				CreateCorner(CPPanel, 6)
				CreateStroke(CPPanel, Theme.Border, 1)
				local function BuildColorPanel()
					for _, c in ipairs(CPPanel:GetChildren()) do
						if not c:IsA("UICorner") and not c:IsA("UIStroke") then c:Destroy() end
					end
					local hue, sat, val = Color3.toHSV(currentColor)
					local SVBox = CreateFrame({
						Color = Color3.fromHSV(hue, 1, 1),
						Size = UDim2.new(1, -16, 0, 80),
						Position = UDim2.new(0, 8, 0, 8),
						Parent = CPPanel,
					})
					SVBox.ZIndex = 31
					CreateCorner(SVBox, 4)
					local WhiteGrad = Instance.new("UIGradient")
					WhiteGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
					WhiteGrad.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
					WhiteGrad.Rotation = 0
					WhiteGrad.Parent = SVBox
					local BlackGrad = Instance.new("UIGradient")
					BlackGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) })
					BlackGrad.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
					BlackGrad.Rotation = 270
					BlackGrad.Parent = SVBox
					local HueBar = CreateFrame({
						Color = Color3.new(1, 0, 0),
						Size = UDim2.new(1, -16, 0, 14),
						Position = UDim2.new(0, 8, 0, 96),
						Parent = CPPanel,
					})
					HueBar.ZIndex = 31
					CreateCorner(HueBar, 4)
					local HueGrad = Instance.new("UIGradient")
					HueGrad.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
						ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
						ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)),
						ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
						ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)),
						ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1)),
					})
					HueGrad.Parent = HueBar
					local r, g, b = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
					local RGBLabel = CreateLabel({
						Text = string.format("R: %d  G: %d  B: %d", r, g, b),
						Color = Theme.TextDim,
						Font = Fonts.Regular,
						Size = 11,
						FrameSize = UDim2.new(1, -16, 0, 20),
						Position = UDim2.new(0, 8, 0, 118),
						AlignX = Enum.TextXAlignment.Center,
						Parent = CPPanel,
					})
					RGBLabel.ZIndex = 31
					local function UpdateFromHue(input)
						local relX = math.clamp((input.Position.X - HueBar.AbsolutePosition.X) / HueBar.AbsoluteSize.X, 0, 1)
						hue = relX
						currentColor = Color3.fromHSV(hue, sat, val)
						Swatch.BackgroundColor3 = currentColor
						SVBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
						local nr, ng, nb = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
						RGBLabel.Text = string.format("R: %d  G: %d  B: %d", nr, ng, nb)
						task.spawn(callback, currentColor)
					end
					local function UpdateFromSV(input)
						local relX = math.clamp((input.Position.X - SVBox.AbsolutePosition.X) / SVBox.AbsoluteSize.X, 0, 1)
						local relY = math.clamp((input.Position.Y - SVBox.AbsolutePosition.Y) / SVBox.AbsoluteSize.Y, 0, 1)
						sat = relX
						val = 1 - relY
						currentColor = Color3.fromHSV(hue, sat, val)
						Swatch.BackgroundColor3 = currentColor
						local nr, ng, nb = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
						RGBLabel.Text = string.format("R: %d  G: %d  B: %d", nr, ng, nb)
						task.spawn(callback, currentColor)
					end
					local draggingSV, draggingHue = false, false
					SVBox.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingSV = true
							UpdateFromSV(input)
						end
					end)
					HueBar.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingHue = true
							UpdateFromHue(input)
						end
					end)
					UserInputService.InputChanged:Connect(function(input)
						if draggingSV and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
							UpdateFromSV(input)
						end
						if draggingHue and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
							UpdateFromHue(input)
						end
					end)
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingSV = false
							draggingHue = false
						end
					end)
				end
				local ToggleBtn = CreateButton({
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 1,
					Size = UDim2.new(1, 0, 0, 36),
					Parent = CPFrame,
				})
				ToggleBtn.ZIndex = 17
				ToggleBtn.MouseEnter:Connect(function()
					Tween(CPEl, Tweens.Fast, { BackgroundColor3 = Theme.Border })
				end)
				ToggleBtn.MouseLeave:Connect(function()
					Tween(CPEl, Tweens.Fast, { BackgroundColor3 = Theme.Tertiary })
				end)
				ToggleBtn.MouseButton1Click:Connect(function()
					open = not open
					if open then
						BuildColorPanel()
						Tween(CPPanel, Tweens.Fast, { Size = UDim2.new(1, 0, 0, 148) })
						CPFrame.Size = UDim2.new(1, 0, 0, 36 + 152)
					else
						Tween(CPPanel, Tweens.Fast, { Size = UDim2.new(1, 0, 0, 0) })
						CPFrame.Size = UDim2.new(1, 0, 0, 36)
					end
				end)
				AddElement(CPFrame)
				local CPAPI = {}
				function CPAPI:Get() return currentColor end
				function CPAPI:Set(color)
					currentColor = color
					Swatch.BackgroundColor3 = color
					task.spawn(callback, color)
				end
				return CPAPI
			end
			function TabObj:AddButton(config) return SectionObj:AddButton(config) end
			function TabObj:AddToggle(config) return SectionObj:AddToggle(config) end
			function TabObj:AddSlider(config) return SectionObj:AddSlider(config) end
			function TabObj:AddDropdown(config) return SectionObj:AddDropdown(config) end
			function TabObj:AddTextbox(config) return SectionObj:AddTextbox(config) end
			function TabObj:AddKeybind(config) return SectionObj:AddKeybind(config) end
			function TabObj:AddLabel(text) return SectionObj:AddLabel(text) end
			function TabObj:AddColorPicker(config) return SectionObj:AddColorPicker(config) end
			return SectionObj
		end
		function TabObj:AddButton(btnConfig)
			local s = self:AddSection({ Name = btnConfig.Name or "Action" })
			return s:AddButton(btnConfig)
		end
		function TabObj:AddToggle(togConfig)
			local s = self:AddSection({ Name = togConfig.Name or "" })
			return s:AddToggle(togConfig)
		end
		function TabObj:AddSlider(sliderConfig)
			local s = self:AddSection({ Name = sliderConfig.Name or "" })
			return s:AddSlider(sliderConfig)
		end
		function TabObj:AddDropdown(ddConfig)
			local s = self:AddSection({ Name = ddConfig.Name or "" })
			return s:AddDropdown(ddConfig)
		end
		function TabObj:AddTextbox(tbConfig)
			local s = self:AddSection({ Name = tbConfig.Name or "" })
			return s:AddTextbox(tbConfig)
		end
		function TabObj:AddKeybind(kbConfig)
			local s = self:AddSection({ Name = kbConfig.Name or "" })
			return s:AddKeybind(kbConfig)
		end
		function TabObj:AddLabel(text)
			local s = self:AddSection({ Name = "" })
			return s:AddLabel(text)
		end
		function TabObj:AddColorPicker(cpConfig)
			local s = self:AddSection({ Name = cpConfig.Name or "" })
			return s:AddColorPicker(cpConfig)
		end
		return TabObj
	end
	function WindowObj:SaveConfig(name)
		local key = "BloodLib_" .. (name or "default")
		local data = {}
		ConfigData[key] = data
	end
	function WindowObj:LoadConfig(name)
		local key = "BloodLib_" .. (name or "default")
		return ConfigData[key] or {}
	end
	function WindowObj:Destroy()
		ScreenGui:Destroy()
	end
	return WindowObj
end
function Blood:Destroy()
	for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
		if gui.Name:find("BloodLibrary") or gui.Name == "BloodNotifications" then
			gui:Destroy()
		end
	end
end
return Blood
