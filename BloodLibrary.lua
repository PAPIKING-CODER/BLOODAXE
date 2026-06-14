--[[
	╔══════════════════════════════════════════════════════╗
	║              B L O O D   L I B R A R Y              ║
	║         Premium Universal Roblox UI Framework       ║
	║              Version 1.0 — by Developer             ║
	╚══════════════════════════════════════════════════════╝

	USAGE:
		local Blood = loadstring(game:HttpGet("YOUR_RAW_URL"))()

		local Window = Blood:CreateWindow({
			Name    = "My Hub",
			Title   = "Welcome",
			Theme   = "Blood",
		})

		local Tab = Window:CreateTab({ Name = "Main", Icon = "🏠" })
		local Section = Tab:CreateSection({ Name = "Player" })

		Section:AddToggle({ Title = "God Mode", Description = "Makes you invincible.", Default = false,
			Callback = function(state) end })

		Section:AddSlider({ Title = "WalkSpeed", Description = "Change your walk speed.",
			Min = 0, Max = 500, Default = 16,
			Callback = function(value) end })

		Section:AddButton({ Title = "Execute", Description = "Run action.",
			Callback = function() end })

		Section:AddDropdown({ Title = "Select Rock", Options = {"Tiny Rock","Golden Rock"},
			Default = "Tiny Rock",
			Callback = function(value) end })

		Section:AddInput({ Title = "Size", Placeholder = "Type here...", Default = "2", Numeric = true,
			Callback = function(value) end })

		Section:AddKeybind({ Title = "Toggle UI", Default = Enum.KeyCode.RightControl,
			Callback = function(key) end })

		Section:AddColorPicker({ Title = "Accent Color", Default = Color3.fromRGB(180,0,0),
			Callback = function(color) end })

		Section:AddLabel({ Text = "Hello World" })
		Section:AddParagraph({ Title = "Info", Content = "Some text here." })
		Section:AddDivider()

		Blood:Notify({ Title = "Welcome!", Content = "Blood Library loaded.", Duration = 5 })
]]

-- ══════════════════════════════════════════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════════════════════════════════════════
local UserInputService    = game:GetService("UserInputService")
local TweenService        = game:GetService("TweenService")
local RunService          = game:GetService("RunService")
local Players             = game:GetService("Players")
local CoreGui             = game:GetService("CoreGui")
local HttpService         = game:GetService("HttpService")

local LocalPlayer         = Players.LocalPlayer
local Mouse               = LocalPlayer:GetMouse()

-- ══════════════════════════════════════════════════════════════════════════
-- THEME SYSTEM
-- ══════════════════════════════════════════════════════════════════════════
local Themes = {
	Blood = {
		Background       = Color3.fromRGB(12, 8, 8),
		BackgroundAlt    = Color3.fromRGB(18, 12, 12),
		Sidebar          = Color3.fromRGB(15, 8, 8),
		Header           = Color3.fromRGB(10, 5, 5),
		Accent           = Color3.fromRGB(180, 0, 0),
		AccentDark       = Color3.fromRGB(100, 0, 0),
		AccentLight      = Color3.fromRGB(220, 40, 40),
		Section          = Color3.fromRGB(22, 14, 14),
		SectionBorder    = Color3.fromRGB(60, 15, 15),
		ItemBackground   = Color3.fromRGB(28, 18, 18),
		TextPrimary      = Color3.fromRGB(255, 255, 255),
		TextSecondary    = Color3.fromRGB(180, 140, 140),
		TextMuted        = Color3.fromRGB(110, 80, 80),
		Toggle           = Color3.fromRGB(40, 20, 20),
		ToggleOn         = Color3.fromRGB(180, 0, 0),
		Slider           = Color3.fromRGB(40, 20, 20),
		SliderFill       = Color3.fromRGB(180, 0, 0),
		Input            = Color3.fromRGB(22, 14, 14),
		InputBorder      = Color3.fromRGB(70, 20, 20),
		Button           = Color3.fromRGB(140, 0, 0),
		ButtonHover      = Color3.fromRGB(180, 20, 20),
		Scrollbar        = Color3.fromRGB(80, 15, 15),
		Shadow           = Color3.fromRGB(0, 0, 0),
		Notification     = Color3.fromRGB(18, 10, 10),
		NotifBorder      = Color3.fromRGB(180, 0, 0),
		TabActive        = Color3.fromRGB(180, 0, 0),
		TabInactive      = Color3.fromRGB(25, 14, 14),
		TabHover         = Color3.fromRGB(50, 18, 18),
		Divider          = Color3.fromRGB(60, 20, 20),
		CloseBtn         = Color3.fromRGB(180, 0, 0),
		MinBtn           = Color3.fromRGB(100, 60, 0),
		MaxBtn           = Color3.fromRGB(0, 100, 40),
	},
	Dark = {
		Background       = Color3.fromRGB(15, 15, 18),
		BackgroundAlt    = Color3.fromRGB(20, 20, 24),
		Sidebar          = Color3.fromRGB(12, 12, 16),
		Header           = Color3.fromRGB(10, 10, 14),
		Accent           = Color3.fromRGB(90, 90, 220),
		AccentDark       = Color3.fromRGB(50, 50, 150),
		AccentLight      = Color3.fromRGB(130, 130, 255),
		Section          = Color3.fromRGB(22, 22, 28),
		SectionBorder    = Color3.fromRGB(50, 50, 70),
		ItemBackground   = Color3.fromRGB(28, 28, 36),
		TextPrimary      = Color3.fromRGB(255, 255, 255),
		TextSecondary    = Color3.fromRGB(170, 170, 200),
		TextMuted        = Color3.fromRGB(100, 100, 130),
		Toggle           = Color3.fromRGB(35, 35, 50),
		ToggleOn         = Color3.fromRGB(90, 90, 220),
		Slider           = Color3.fromRGB(35, 35, 50),
		SliderFill       = Color3.fromRGB(90, 90, 220),
		Input            = Color3.fromRGB(22, 22, 30),
		InputBorder      = Color3.fromRGB(60, 60, 90),
		Button           = Color3.fromRGB(70, 70, 180),
		ButtonHover      = Color3.fromRGB(100, 100, 220),
		Scrollbar        = Color3.fromRGB(50, 50, 80),
		Shadow           = Color3.fromRGB(0, 0, 0),
		Notification     = Color3.fromRGB(18, 18, 25),
		NotifBorder      = Color3.fromRGB(90, 90, 220),
		TabActive        = Color3.fromRGB(90, 90, 220),
		TabInactive      = Color3.fromRGB(20, 20, 28),
		TabHover         = Color3.fromRGB(40, 40, 60),
		Divider          = Color3.fromRGB(50, 50, 70),
		CloseBtn         = Color3.fromRGB(200, 50, 50),
		MinBtn           = Color3.fromRGB(200, 150, 0),
		MaxBtn           = Color3.fromRGB(0, 160, 60),
	},
}

-- ══════════════════════════════════════════════════════════════════════════
-- UTILITIES
-- ══════════════════════════════════════════════════════════════════════════
local Util = {}

function Util.Tween(obj, props, duration, style, direction)
	style     = style     or Enum.EasingStyle.Quart
	direction = direction or Enum.EasingDirection.Out
	local info = TweenInfo.new(duration or 0.25, style, direction)
	local tw   = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

function Util.MakeDraggable(frame, handle)
	handle = handle or frame
	local dragging, dragInput, dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			dragStart = input.Position
			startPos  = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

function Util.Create(class, props, parent)
	local obj = Instance.new(class)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	if parent then obj.Parent = parent end
	return obj
end

function Util.AddCorner(parent, radius)
	return Util.Create("UICorner", { CornerRadius = UDim.new(0, radius or 6) }, parent)
end

function Util.AddStroke(parent, color, thickness, transparency)
	return Util.Create("UIStroke", {
		Color        = color or Color3.fromRGB(60, 20, 20),
		Thickness    = thickness or 1,
		Transparency = transparency or 0,
	}, parent)
end

function Util.AddPadding(parent, top, right, bottom, left)
	return Util.Create("UIPadding", {
		PaddingTop    = UDim.new(0, top    or 4),
		PaddingRight  = UDim.new(0, right  or 4),
		PaddingBottom = UDim.new(0, bottom or 4),
		PaddingLeft   = UDim.new(0, left   or 4),
	}, parent)
end

function Util.AddListLayout(parent, padding, fillDir, hAlign, vAlign)
	return Util.Create("UIListLayout", {
		Padding          = UDim.new(0, padding  or 6),
		FillDirection    = fillDir or Enum.FillDirection.Vertical,
		HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Left,
		VerticalAlignment   = vAlign or Enum.VerticalAlignment.Top,
		SortOrder        = Enum.SortOrder.LayoutOrder,
	}, parent)
end

function Util.AutoSize(frame, layout)
	layout.Changed:Connect(function()
		frame.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 12)
	end)
end

-- ══════════════════════════════════════════════════════════════════════════
-- BLOOD LIBRARY CORE
-- ══════════════════════════════════════════════════════════════════════════
local BloodLibrary = {}
BloodLibrary.__index = BloodLibrary
BloodLibrary._windows  = {}
BloodLibrary._notifQueue = {}
BloodLibrary._notifActive = 0

function BloodLibrary.new()
	local self = setmetatable({}, BloodLibrary)
	self._theme = Themes.Blood

	-- Root ScreenGui
	local ok, existing = pcall(function()
		return CoreGui:FindFirstChild("BloodLibrary_Root")
	end)
	if ok and existing then existing:Destroy() end

	self._root = Util.Create("ScreenGui", {
		Name             = "BloodLibrary_Root",
		ResetOnSpawn     = false,
		ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
		DisplayOrder     = 999,
	}, CoreGui)

	-- Notification container (top-right)
	self._notifContainer = Util.Create("Frame", {
		Name              = "NotifContainer",
		AnchorPoint       = Vector2.new(1, 0),
		Position          = UDim2.new(1, -16, 0, 16),
		Size              = UDim2.new(0, 300, 1, -32),
		BackgroundTransparency = 1,
		ZIndex            = 200,
	}, self._root)
	Util.AddListLayout(self._notifContainer, 8, Enum.FillDirection.Vertical,
		Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top)

	return self
end

function BloodLibrary:SetTheme(name)
	if Themes[name] then
		self._theme = Themes[name]
	end
end

-- ══════════════════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ══════════════════════════════════════════════════════════════════════════
function BloodLibrary:Notify(opts)
	opts = opts or {}
	local T   = self._theme
	local dur = opts.Duration or 5
	local typ = opts.Type or "Info" -- "Info","Success","Warning","Error"

	local iconMap = { Info = "ℹ", Success = "✓", Warning = "⚠", Error = "✕" }
	local colorMap = {
		Info    = T.Accent,
		Success = Color3.fromRGB(0, 160, 60),
		Warning = Color3.fromRGB(200, 140, 0),
		Error   = Color3.fromRGB(200, 40, 40),
	}

	local notif = Util.Create("Frame", {
		Name              = "Notification",
		Size              = UDim2.new(1, 0, 0, 70),
		BackgroundColor3  = T.Notification,
		BackgroundTransparency = 0.1,
		ClipsDescendants  = true,
	}, self._notifContainer)
	Util.AddCorner(notif, 8)
	Util.AddStroke(notif, colorMap[typ] or T.NotifBorder, 1)

	-- Top accent bar
	Util.Create("Frame", {
		Size             = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = colorMap[typ] or T.Accent,
		BorderSizePixel  = 0,
	}, notif)

	-- Icon
	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 10, 0, 16),
		Size             = UDim2.new(0, 28, 0, 28),
		Text             = iconMap[typ] or "•",
		TextColor3       = colorMap[typ] or T.Accent,
		TextSize         = 18,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
	}, notif)

	-- Title
	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 44, 0, 14),
		Size             = UDim2.new(1, -54, 0, 20),
		Text             = opts.Title or "Notification",
		TextColor3       = T.TextPrimary,
		TextSize         = 13,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
		TextXAlignment   = Enum.TextXAlignment.Left,
	}, notif)

	-- Content
	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 44, 0, 34),
		Size             = UDim2.new(1, -54, 0, 28),
		Text             = opts.Content or "",
		TextColor3       = T.TextSecondary,
		TextSize         = 11,
		Font             = Enum.Font.Gotham,
		BackgroundTransparency = 1,
		TextXAlignment   = Enum.TextXAlignment.Left,
		TextWrapped      = true,
	}, notif)

	-- Progress bar
	local progress = Util.Create("Frame", {
		Position         = UDim2.new(0, 0, 1, -3),
		Size             = UDim2.new(1, 0, 0, 3),
		BackgroundColor3 = colorMap[typ] or T.Accent,
		BorderSizePixel  = 0,
	}, notif)

	-- Entrance animation
	notif.Position = UDim2.new(1, 10, 0, 0)
	Util.Tween(notif, { Position = UDim2.new(0, 0, 0, 0) }, 0.4)
	Util.Tween(progress, { Size = UDim2.new(0, 0, 0, 3) }, dur, Enum.EasingStyle.Linear, Enum.EasingDirection.In)

	task.delay(dur, function()
		Util.Tween(notif, { Position = UDim2.new(1, 10, 0, 0) }, 0.35)
		task.wait(0.35)
		notif:Destroy()
	end)
end

-- ══════════════════════════════════════════════════════════════════════════
-- LOADING SCREEN
-- ══════════════════════════════════════════════════════════════════════════
function BloodLibrary:ShowLoader(opts)
	opts = opts or {}
	local T = self._theme

	local overlay = Util.Create("Frame", {
		Name             = "LoadingOverlay",
		Size             = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0,
		ZIndex           = 500,
	}, self._root)

	local card = Util.Create("Frame", {
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(0.5, 0, 0.5, 0),
		Size             = UDim2.new(0, 340, 0, 180),
		BackgroundColor3 = T.Background,
		ZIndex           = 501,
	}, overlay)
	Util.AddCorner(card, 10)
	Util.AddStroke(card, T.Accent, 1)

	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 0, 0, 30),
		Size             = UDim2.new(1, 0, 0, 28),
		Text             = opts.Title or "LOADING",
		TextColor3       = T.TextPrimary,
		TextSize         = 20,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
		ZIndex           = 502,
	}, card)

	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 0, 0, 62),
		Size             = UDim2.new(1, 0, 0, 18),
		Text             = opts.Subtitle or "Please wait...",
		TextColor3       = T.TextSecondary,
		TextSize         = 12,
		Font             = Enum.Font.Gotham,
		BackgroundTransparency = 1,
		ZIndex           = 502,
	}, card)

	-- Bar background
	local barBg = Util.Create("Frame", {
		Position         = UDim2.new(0, 30, 0, 100),
		Size             = UDim2.new(1, -60, 0, 8),
		BackgroundColor3 = T.Toggle,
		ZIndex           = 502,
	}, card)
	Util.AddCorner(barBg, 4)

	local barFill = Util.Create("Frame", {
		Size             = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = T.Accent,
		ZIndex           = 503,
	}, barBg)
	Util.AddCorner(barFill, 4)

	local statusLabel = Util.Create("TextLabel", {
		Position         = UDim2.new(0, 0, 0, 118),
		Size             = UDim2.new(1, 0, 0, 16),
		Text             = "",
		TextColor3       = T.TextMuted,
		TextSize         = 10,
		Font             = Enum.Font.Gotham,
		BackgroundTransparency = 1,
		ZIndex           = 502,
	}, card)

	local function setProgress(pct, status)
		Util.Tween(barFill, { Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0) }, 0.3)
		if status then statusLabel.Text = status end
	end

	local function dismiss()
		Util.Tween(overlay, { BackgroundTransparency = 1 }, 0.5)
		Util.Tween(card, { BackgroundTransparency = 1 }, 0.5)
		task.wait(0.5)
		overlay:Destroy()
	end

	return { SetProgress = setProgress, Dismiss = dismiss }
end

-- ══════════════════════════════════════════════════════════════════════════
-- WINDOW
-- ══════════════════════════════════════════════════════════════════════════
function BloodLibrary:CreateWindow(opts)
	opts = opts or {}
	local T = self._theme

	if opts.Theme and Themes[opts.Theme] then
		T = Themes[opts.Theme]
		self._theme = T
	end

	local winWidth  = opts.Width  or 860
	local winHeight = opts.Height or 540
	local sideWidth = 180

	-- ── Main frame ─────────────────────────────────────────────────────
	local mainFrame = Util.Create("Frame", {
		Name             = "BloodWindow",
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(0.5, 0, 0.5, 0),
		Size             = UDim2.new(0, winWidth, 0, winHeight),
		BackgroundColor3 = T.Background,
		ClipsDescendants = false,
	}, self._root)
	Util.AddCorner(mainFrame, 10)
	Util.AddStroke(mainFrame, T.SectionBorder, 1)

	-- Drop shadow
	local shadow = Util.Create("ImageLabel", {
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(0.5, 0, 0.5, 8),
		Size             = UDim2.new(1, 40, 1, 40),
		Image            = "rbxassetid://7912134082",
		ImageColor3      = Color3.fromRGB(0,0,0),
		ImageTransparency = 0.5,
		BackgroundTransparency = 1,
		ScaleType        = Enum.ScaleType.Slice,
		SliceCenter      = Rect.new(49, 49, 450, 450),
		ZIndex           = -1,
	}, mainFrame)

	-- ── Header ─────────────────────────────────────────────────────────
	local header = Util.Create("Frame", {
		Name             = "Header",
		Size             = UDim2.new(1, 0, 0, 46),
		BackgroundColor3 = T.Header,
		ZIndex           = 2,
	}, mainFrame)
	Util.AddCorner(header, 10)

	-- Fix bottom corners of header
	Util.Create("Frame", {
		Position         = UDim2.new(0, 0, 0.5, 0),
		Size             = UDim2.new(1, 0, 0.5, 0),
		BackgroundColor3 = T.Header,
		BorderSizePixel  = 0,
	}, header)

	-- Logo / Name
	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 14, 0, 0),
		Size             = UDim2.new(0, 220, 1, 0),
		Text             = opts.Name or "BLOOD HUB",
		TextColor3       = T.Accent,
		TextSize         = 15,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
		TextXAlignment   = Enum.TextXAlignment.Left,
	}, header)

	-- Subtitle
	Util.Create("TextLabel", {
		Position         = UDim2.new(0.5, -150, 0, 0),
		Size             = UDim2.new(0, 300, 1, 0),
		Text             = opts.Title or "",
		TextColor3       = T.TextMuted,
		TextSize         = 11,
		Font             = Enum.Font.Gotham,
		BackgroundTransparency = 1,
	}, header)

	-- Search bar (optional)
	local searchBox = Util.Create("TextBox", {
		Position         = UDim2.new(0, 240, 0, 8),
		Size             = UDim2.new(0, 220, 0, 30),
		BackgroundColor3 = T.ItemBackground,
		Text             = "",
		PlaceholderText  = "🔍  Search...",
		PlaceholderColor3 = T.TextMuted,
		TextColor3       = T.TextPrimary,
		TextSize         = 12,
		Font             = Enum.Font.Gotham,
		ClearTextOnFocus = false,
	}, header)
	Util.AddCorner(searchBox, 6)
	Util.AddPadding(searchBox, 0, 8, 0, 10)

	-- Window controls (close, minimize, maximize)
	local function makeCtrlBtn(color, xOffset, icon, callback)
		local btn = Util.Create("TextButton", {
			Position         = UDim2.new(1, xOffset, 0.5, -10),
			Size             = UDim2.new(0, 20, 0, 20),
			BackgroundColor3 = color,
			Text             = icon,
			TextColor3       = Color3.fromRGB(255,255,255),
			TextSize         = 11,
			Font             = Enum.Font.GothamBold,
		}, header)
		Util.AddCorner(btn, 5)
		btn.MouseEnter:Connect(function()
			Util.Tween(btn, { BackgroundTransparency = 0.3 }, 0.15)
		end)
		btn.MouseLeave:Connect(function()
			Util.Tween(btn, { BackgroundTransparency = 0 }, 0.15)
		end)
		btn.Activated:Connect(callback)
		return btn
	end

	local isMinimized = false
	local bodyFrame   -- forward declare

	makeCtrlBtn(T.CloseBtn,  -14, "×", function()
		Util.Tween(mainFrame, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 }, 0.3)
		task.wait(0.3)
		mainFrame:Destroy()
	end)

	makeCtrlBtn(T.MaxBtn, -40, "□", function()
		-- toggle size between normal and slightly smaller
		local curW = mainFrame.AbsoluteSize.X
		local target = curW > 700 and UDim2.new(0, 560, 0, 400) or UDim2.new(0, winWidth, 0, winHeight)
		Util.Tween(mainFrame, { Size = target }, 0.3)
	end)

	makeCtrlBtn(T.MinBtn, -66, "—", function()
		isMinimized = not isMinimized
		local target = isMinimized
			and UDim2.new(0, winWidth, 0, 46)
			or  UDim2.new(0, winWidth, 0, winHeight)
		Util.Tween(mainFrame, { Size = target }, 0.3)
	end)

	Util.MakeDraggable(mainFrame, header)

	-- ── Sidebar ─────────────────────────────────────────────────────────
	local sidebar = Util.Create("Frame", {
		Name             = "Sidebar",
		Position         = UDim2.new(0, 0, 0, 46),
		Size             = UDim2.new(0, sideWidth, 1, -46),
		BackgroundColor3 = T.Sidebar,
	}, mainFrame)

	-- Fix top corner of sidebar
	Util.Create("Frame", {
		Size             = UDim2.new(1, 0, 0, 10),
		BackgroundColor3 = T.Sidebar,
		BorderSizePixel  = 0,
	}, sidebar)

	-- Bottom left corner rounding
	Util.Create("UICorner", { CornerRadius = UDim.new(0, 10) }, sidebar)
	Util.Create("Frame", {
		AnchorPoint      = Vector2.new(1, 0),
		Position         = UDim2.new(1, 0, 0, 0),
		Size             = UDim2.new(0, 10, 1, 0),
		BackgroundColor3 = T.Sidebar,
		BorderSizePixel  = 0,
	}, sidebar)

	-- Sidebar separator line
	Util.Create("Frame", {
		AnchorPoint      = Vector2.new(1, 0),
		Position         = UDim2.new(1, 0, 0, 0),
		Size             = UDim2.new(0, 1, 1, 0),
		BackgroundColor3 = T.SectionBorder,
		BorderSizePixel  = 0,
	}, sidebar)

	-- Tab list in sidebar
	local tabList = Util.Create("ScrollingFrame", {
		Position         = UDim2.new(0, 0, 0, 10),
		Size             = UDim2.new(1, 0, 1, -80),
		BackgroundTransparency = 1,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = T.Scrollbar,
		CanvasSize        = UDim2.new(0, 0, 0, 0),
	}, sidebar)
	local tabListLayout = Util.AddListLayout(tabList, 2)
	tabListLayout.Changed:Connect(function()
		tabList.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y + 20)
	end)

	-- User info panel at bottom of sidebar
	local userPanel = Util.Create("Frame", {
		AnchorPoint      = Vector2.new(0, 1),
		Position         = UDim2.new(0, 8, 1, -8),
		Size             = UDim2.new(1, -16, 0, 60),
		BackgroundColor3 = T.ItemBackground,
	}, sidebar)
	Util.AddCorner(userPanel, 8)
	Util.AddStroke(userPanel, T.SectionBorder, 1)

	local avatarFrame = Util.Create("Frame", {
		Position         = UDim2.new(0, 8, 0.5, -16),
		Size             = UDim2.new(0, 32, 0, 32),
		BackgroundColor3 = T.Accent,
	}, userPanel)
	Util.AddCorner(avatarFrame, 16)

	Util.Create("TextLabel", {
		Size             = UDim2.new(1, 0, 1, 0),
		Text             = string.sub(LocalPlayer.Name, 1, 1):upper(),
		TextColor3       = Color3.fromRGB(255, 255, 255),
		TextSize         = 16,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
	}, avatarFrame)

	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 48, 0, 8),
		Size             = UDim2.new(1, -56, 0, 18),
		Text             = LocalPlayer.Name,
		TextColor3       = T.TextPrimary,
		TextSize         = 12,
		Font             = Enum.Font.GothamBold,
		BackgroundTransparency = 1,
		TextXAlignment   = Enum.TextXAlignment.Left,
		TextTruncate     = Enum.TextTruncate.AtEnd,
	}, userPanel)

	-- Status indicator
	local statusDot = Util.Create("Frame", {
		Position         = UDim2.new(0, 48, 0, 32),
		Size             = UDim2.new(0, 8, 0, 8),
		BackgroundColor3 = Color3.fromRGB(0, 200, 80),
	}, userPanel)
	Util.AddCorner(statusDot, 4)

	Util.Create("TextLabel", {
		Position         = UDim2.new(0, 62, 0, 26),
		Size             = UDim2.new(1, -70, 0, 18),
		Text             = "● Connected",
		TextColor3       = Color3.fromRGB(0, 200, 80),
		TextSize         = 10,
		Font             = Enum.Font.Gotham,
		BackgroundTransparency = 1,
		TextXAlignment   = Enum.TextXAlignment.Left,
	}, userPanel)

	-- ── Content area ─────────────────────────────────────────────────────
	bodyFrame = Util.Create("Frame", {
		Name             = "Body",
		Position         = UDim2.new(0, sideWidth, 0, 46),
		Size             = UDim2.new(1, -sideWidth, 1, -46),
		BackgroundColor3 = T.BackgroundAlt,
		ClipsDescendants = true,
	}, mainFrame)

	-- Bottom right corner rounding
	Util.Create("UICorner", { CornerRadius = UDim.new(0, 10) }, bodyFrame)
	Util.Create("Frame", {
		Size             = UDim2.new(0, 10, 1, 0),
		BackgroundColor3 = T.BackgroundAlt,
		BorderSizePixel  = 0,
	}, bodyFrame)
	Util.Create("Frame", {
		Size             = UDim2.new(1, 0, 0, 10),
		BackgroundColor3 = T.BackgroundAlt,
		BorderSizePixel  = 0,
	}, bodyFrame)

	-- ── Window object ──────────────────────────────────────────────────
	local Window = {
		_frame      = mainFrame,
		_sidebar    = sidebar,
		_tabList    = tabList,
		_body       = bodyFrame,
		_theme      = T,
		_tabs       = {},
		_activeTab  = nil,
		_lib        = self,
		_searchBox  = searchBox,
	}

	-- Search functionality
	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local query = searchBox.Text:lower()
		for _, tabData in pairs(Window._tabs) do
			for _, item in pairs(tabData._searchItems or {}) do
				if item._frame then
					local visible = query == "" or item._searchKey:lower():find(query, 1, true) ~= nil
					item._frame.Visible = visible
				end
			end
		end
	end)

	-- Entrance animation
	mainFrame.Size = UDim2.new(0, 0, 0, 0)
	mainFrame.BackgroundTransparency = 1
	Util.Tween(mainFrame, {
		Size = UDim2.new(0, winWidth, 0, winHeight),
		BackgroundTransparency = 0,
	}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

	-- Keybind to toggle visibility
	local toggleKey = opts.ToggleKey or Enum.KeyCode.RightControl
	UserInputService.InputBegan:Connect(function(input, gpe)
		if not gpe and input.KeyCode == toggleKey then
			mainFrame.Visible = not mainFrame.Visible
		end
	end)

	-- ── Tab creation ───────────────────────────────────────────────────
	function Window:CreateTab(tabOpts)
		tabOpts = tabOpts or {}
		local T2 = self._theme

		local isFirst = #self._tabs == 0

		-- Sidebar button
		local tabBtn = Util.Create("TextButton", {
			Size             = UDim2.new(1, -12, 0, 38),
			Position         = UDim2.new(0, 6, 0, 0),
			BackgroundColor3 = isFirst and T2.TabActive or T2.TabInactive,
			Text             = "",
			AutoButtonColor  = false,
		}, tabList)
		Util.AddCorner(tabBtn, 7)

		-- Icon
		local iconLabel = Util.Create("TextLabel", {
			Position         = UDim2.new(0, 10, 0.5, -8),
			Size             = UDim2.new(0, 18, 0, 18),
			Text             = tabOpts.Icon or "•",
			TextColor3       = isFirst and T2.TextPrimary or T2.TextMuted,
			TextSize         = 14,
			Font             = Enum.Font.GothamBold,
			BackgroundTransparency = 1,
		}, tabBtn)

		-- Name
		local nameLabel = Util.Create("TextLabel", {
			Position         = UDim2.new(0, 34, 0, 0),
			Size             = UDim2.new(1, -44, 1, 0),
			Text             = tabOpts.Name or "Tab",
			TextColor3       = isFirst and T2.TextPrimary or T2.TextSecondary,
			TextSize         = 13,
			Font             = Enum.Font.GothamMedium,
			BackgroundTransparency = 1,
			TextXAlignment   = Enum.TextXAlignment.Left,
		}, tabBtn)

		-- Active indicator bar (left side)
		local activeBar = Util.Create("Frame", {
			Position         = UDim2.new(0, 0, 0.15, 0),
			Size             = UDim2.new(0, 3, 0.7, 0),
			BackgroundColor3 = T2.Accent,
			Visible          = isFirst,
		}, tabBtn)
		Util.AddCorner(activeBar, 2)

		-- Content page
		local page = Util.Create("ScrollingFrame", {
			Position         = UDim2.new(0, 0, 0, 0),
			Size             = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = T2.Scrollbar,
			CanvasSize        = UDim2.new(0, 0, 0, 0),
			Visible           = isFirst,
		}, self._body)
		Util.AddPadding(page, 14, 14, 14, 14)
		local pageLayout = Util.AddListLayout(page, 10)
		pageLayout.Changed:Connect(function()
			page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 28)
		end)

		-- Page header
		local pageHeader = Util.Create("Frame", {
			Size             = UDim2.new(1, 0, 0, 40),
			BackgroundTransparency = 1,
			LayoutOrder      = -999,
		}, page)

		Util.Create("TextLabel", {
			Position         = UDim2.new(0, 0, 0, 0),
			Size             = UDim2.new(1, 0, 0, 24),
			Text             = tabOpts.Name or "Tab",
			TextColor3       = T2.TextPrimary,
			TextSize         = 18,
			Font             = Enum.Font.GothamBold,
			BackgroundTransparency = 1,
			TextXAlignment   = Enum.TextXAlignment.Left,
		}, pageHeader)

		if tabOpts.Description then
			Util.Create("TextLabel", {
				Position         = UDim2.new(0, 0, 0, 24),
				Size             = UDim2.new(1, 0, 0, 16),
				Text             = tabOpts.Description,
				TextColor3       = T2.Accent,
				TextSize         = 11,
				Font             = Enum.Font.Gotham,
				BackgroundTransparency = 1,
				TextXAlignment   = Enum.TextXAlignment.Left,
			}, pageHeader)
		end

		local Tab = {
			_btn         = tabBtn,
			_page        = page,
			_activeBar   = activeBar,
			_nameLabel   = nameLabel,
			_iconLabel   = iconLabel,
			_theme       = T2,
			_searchItems = {},
			_win         = self,
		}

		-- Tab hover effects
		tabBtn.MouseEnter:Connect(function()
			if self._activeTab ~= Tab then
				Util.Tween(tabBtn, { BackgroundColor3 = T2.TabHover }, 0.15)
			end
		end)
		tabBtn.MouseLeave:Connect(function()
			if self._activeTab ~= Tab then
				Util.Tween(tabBtn, { BackgroundColor3 = T2.TabInactive }, 0.15)
			end
		end)

		tabBtn.Activated:Connect(function()
			Window:_SwitchTab(Tab)
		end)

		table.insert(self._tabs, Tab)
		if isFirst then
			self._activeTab = Tab
		end

		-- ── Section creation ─────────────────────────────────────────────
		function Tab:CreateSection(secOpts)
			secOpts = secOpts or {}
			local T3 = self._theme

			local sectionFrame = Util.Create("Frame", {
				Size             = UDim2.new(1, 0, 0, 40),
				BackgroundColor3 = T3.Section,
				ClipsDescendants = false,
			}, self._page)
			Util.AddCorner(sectionFrame, 8)
			Util.AddStroke(sectionFrame, T3.SectionBorder, 1)

			-- Section title bar
			local sectionHeader = Util.Create("Frame", {
				Size             = UDim2.new(1, 0, 0, 32),
				BackgroundTransparency = 1,
			}, sectionFrame)

			-- Section icon
			local sIcon = Util.Create("TextLabel", {
				Position         = UDim2.new(0, 12, 0.5, -9),
				Size             = UDim2.new(0, 18, 0, 18),
				Text             = secOpts.Icon or "⊕",
				TextColor3       = T3.Accent,
				TextSize         = 12,
				Font             = Enum.Font.GothamBold,
				BackgroundTransparency = 1,
			}, sectionHeader)

			Util.Create("TextLabel", {
				Position         = UDim2.new(0, 36, 0, 0),
				Size             = UDim2.new(0.7, -36, 1, 0),
				Text             = secOpts.Name or "Section",
				TextColor3       = T3.Accent,
				TextSize         = 13,
				Font             = Enum.Font.GothamBold,
				BackgroundTransparency = 1,
				TextXAlignment   = Enum.TextXAlignment.Left,
			}, sectionHeader)

			-- Items container
			local itemsContainer = Util.Create("Frame", {
				Position         = UDim2.new(0, 0, 0, 34),
				Size             = UDim2.new(1, 0, 0, 0),
				BackgroundTransparency = 1,
				ClipsDescendants = false,
			}, sectionFrame)
			Util.AddPadding(itemsContainer, 0, 10, 8, 10)
			local itemsLayout = Util.AddListLayout(itemsContainer, 4)

			local function updateSectionSize()
				local h = itemsLayout.AbsoluteContentSize.Y + 46
				sectionFrame.Size = UDim2.new(1, 0, 0, math.max(h, 42))
				itemsContainer.Size = UDim2.new(1, 0, 0, itemsLayout.AbsoluteContentSize.Y + 12)
			end
			itemsLayout.Changed:Connect(updateSectionSize)

			local Section = {
				_frame      = sectionFrame,
				_container  = itemsContainer,
				_theme      = T3,
				_tab        = self,
			}

			-- ── Item factory ─────────────────────────────────────────────
			local function makeItemBase(itemOpts, height)
				height = height or 44
				local frame = Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, height),
					BackgroundColor3 = T3.ItemBackground,
					ClipsDescendants = false,
				}, itemsContainer)
				Util.AddCorner(frame, 6)

				local titleLabel = Util.Create("TextLabel", {
					Position         = UDim2.new(0, 12, 0, 0),
					Size             = UDim2.new(0.6, -12, 0, 22),
					Text             = itemOpts.Title or "",
					TextColor3       = T3.TextPrimary,
					TextSize         = 13,
					Font             = Enum.Font.GothamMedium,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
				}, frame)

				if itemOpts.Description and itemOpts.Description ~= "" then
					Util.Create("TextLabel", {
						Position         = UDim2.new(0, 12, 0, 22),
						Size             = UDim2.new(0.7, -12, 0, 16),
						Text             = itemOpts.Description,
						TextColor3       = T3.TextSecondary,
						TextSize         = 10,
						Font             = Enum.Font.Gotham,
						BackgroundTransparency = 1,
						TextXAlignment   = Enum.TextXAlignment.Left,
					}, frame)
				end

				-- Register for search
				local searchKey = (itemOpts.Title or "") .. " " .. (itemOpts.Description or "")
				table.insert(self._searchItems, { _frame = frame, _searchKey = searchKey })

				return frame, titleLabel
			end

			-- ╔══════════════════════════════════╗
			-- ║  TOGGLE                          ║
			-- ╚══════════════════════════════════╝
			function Section:AddToggle(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)
				local state = opts2.Default or false

				local toggleBg = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 44, 0, 24),
					BackgroundColor3 = state and T3.ToggleOn or T3.Toggle,
				}, frame)
				Util.AddCorner(toggleBg, 12)

				local toggleCircle = Util.Create("Frame", {
					Position         = UDim2.new(state and 1 or 0, state and -22 or 2, 0.5, -10),
					Size             = UDim2.new(0, 20, 0, 20),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				}, toggleBg)
				Util.AddCorner(toggleCircle, 10)

				local btn = Util.Create("TextButton", {
					Size             = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text             = "",
				}, frame)

				local togObj = { Value = state }

				local function setToggle(newState)
					state = newState
					togObj.Value = state
					Util.Tween(toggleBg, { BackgroundColor3 = state and T3.ToggleOn or T3.Toggle }, 0.2)
					Util.Tween(toggleCircle, {
						Position = state
							and UDim2.new(1, -22, 0.5, -10)
							or  UDim2.new(0, 2,   0.5, -10)
					}, 0.2)
					if opts2.Callback then
						task.spawn(opts2.Callback, state)
					end
				end

				btn.Activated:Connect(function()
					setToggle(not state)
				end)

				function togObj:Set(val) setToggle(val) end
				return togObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  BUTTON                          ║
			-- ╚══════════════════════════════════╝
			function Section:AddButton(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)

				local btn = Util.Create("TextButton", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 90, 0, 28),
					BackgroundColor3 = T3.Button,
					Text             = opts2.ButtonText or "Execute",
					TextColor3       = Color3.fromRGB(255, 255, 255),
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					AutoButtonColor  = false,
				}, frame)
				Util.AddCorner(btn, 6)

				btn.MouseEnter:Connect(function()
					Util.Tween(btn, { BackgroundColor3 = T3.ButtonHover }, 0.15)
				end)
				btn.MouseLeave:Connect(function()
					Util.Tween(btn, { BackgroundColor3 = T3.Button }, 0.15)
				end)
				btn.Activated:Connect(function()
					Util.Tween(btn, { BackgroundColor3 = T3.AccentDark }, 0.1)
					task.delay(0.1, function()
						Util.Tween(btn, { BackgroundColor3 = T3.Button }, 0.15)
					end)
					if opts2.Callback then
						task.spawn(opts2.Callback)
					end
				end)
			end

			-- ╔══════════════════════════════════╗
			-- ║  SLIDER                          ║
			-- ╚══════════════════════════════════╝
			function Section:AddSlider(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 56)

				local min   = opts2.Min     or 0
				local max   = opts2.Max     or 100
				local val   = opts2.Default or min
				local suffix = opts2.Suffix or ""

				local valLabel = Util.Create("TextLabel", {
					AnchorPoint      = Vector2.new(1, 0),
					Position         = UDim2.new(1, -12, 0, 10),
					Size             = UDim2.new(0, 60, 0, 20),
					Text             = tostring(val) .. suffix,
					TextColor3       = T3.Accent,
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Right,
				}, frame)

				local sliderBg = Util.Create("Frame", {
					Position         = UDim2.new(0, 12, 0, 38),
					Size             = UDim2.new(1, -24, 0, 6),
					BackgroundColor3 = T3.Slider,
				}, frame)
				Util.AddCorner(sliderBg, 3)

				local pct = (val - min) / (max - min)
				local sliderFill = Util.Create("Frame", {
					Size             = UDim2.new(pct, 0, 1, 0),
					BackgroundColor3 = T3.SliderFill,
				}, sliderBg)
				Util.AddCorner(sliderFill, 3)

				local sliderKnob = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(0.5, 0.5),
					Position         = UDim2.new(pct, 0, 0.5, 0),
					Size             = UDim2.new(0, 16, 0, 16),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				}, sliderBg)
				Util.AddCorner(sliderKnob, 8)
				Util.AddStroke(sliderKnob, T3.Accent, 2)

				local draggingSlider = false
				local sliderObj = { Value = val }

				local function setValue(newPct)
					newPct = math.clamp(newPct, 0, 1)
					local newVal = math.floor(min + newPct * (max - min) + 0.5)
					val = newVal
					sliderObj.Value = newVal
					valLabel.Text = tostring(newVal) .. suffix
					Util.Tween(sliderFill,  { Size     = UDim2.new(newPct, 0, 1, 0) }, 0.05)
					Util.Tween(sliderKnob,  { Position = UDim2.new(newPct, 0, 0.5, 0) }, 0.05)
					if opts2.Callback then
						task.spawn(opts2.Callback, newVal)
					end
				end

				sliderBg.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
						draggingSlider = true
						local relX = (input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
						setValue(relX)
					end
				end)

				sliderBg.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
						draggingSlider = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if draggingSlider and (
						input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch
					) then
						local relX = (input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
						setValue(relX)
					end
				end)

				function sliderObj:Set(v) setValue((v - min) / (max - min)) end
				return sliderObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  DROPDOWN                        ║
			-- ╚══════════════════════════════════╝
			function Section:AddDropdown(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)

				local selected = opts2.Default or (opts2.Options and opts2.Options[1]) or "Select..."
				local isOpen   = false

				local dropBtn = Util.Create("TextButton", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 160, 0, 28),
					BackgroundColor3 = T3.Input,
					Text             = "",
					AutoButtonColor  = false,
				}, frame)
				Util.AddCorner(dropBtn, 6)
				Util.AddStroke(dropBtn, T3.InputBorder, 1)

				local dropLabel = Util.Create("TextLabel", {
					Position         = UDim2.new(0, 8, 0, 0),
					Size             = UDim2.new(1, -26, 1, 0),
					Text             = selected,
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.Gotham,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
					TextTruncate     = Enum.TextTruncate.AtEnd,
				}, dropBtn)

				Util.Create("TextLabel", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -6, 0.5, 0),
					Size             = UDim2.new(0, 14, 0, 14),
					Text             = "▾",
					TextColor3       = T3.TextMuted,
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
				}, dropBtn)

				-- Dropdown list (opens below)
				local dropList = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0),
					Position         = UDim2.new(1, -12, 1, 4),
					Size             = UDim2.new(0, 160, 0, 0),
					BackgroundColor3 = T3.Section,
					ClipsDescendants = true,
					ZIndex           = 20,
					Visible          = false,
				}, frame)
				Util.AddCorner(dropList, 6)
				Util.AddStroke(dropList, T3.InputBorder, 1)

				-- Search inside dropdown
				local dropSearch = Util.Create("TextBox", {
					Position         = UDim2.new(0, 6, 0, 4),
					Size             = UDim2.new(1, -12, 0, 24),
					BackgroundColor3 = T3.ItemBackground,
					Text             = "",
					PlaceholderText  = "Search...",
					PlaceholderColor3 = T3.TextMuted,
					TextColor3       = T3.TextPrimary,
					TextSize         = 11,
					Font             = Enum.Font.Gotham,
					ClearTextOnFocus = false,
					ZIndex           = 21,
				}, dropList)
				Util.AddCorner(dropSearch, 4)
				Util.AddPadding(dropSearch, 0, 6, 0, 6)

				local optScroll = Util.Create("ScrollingFrame", {
					Position          = UDim2.new(0, 0, 0, 32),
					Size              = UDim2.new(1, 0, 1, -32),
					BackgroundTransparency = 1,
					ScrollBarThickness = 2,
					ScrollBarImageColor3 = T3.Scrollbar,
					CanvasSize         = UDim2.new(0, 0, 0, 0),
					ZIndex             = 21,
				}, dropList)
				local optLayout = Util.AddListLayout(optScroll, 2)
				optLayout.Changed:Connect(function()
					optScroll.CanvasSize = UDim2.new(0, 0, 0, optLayout.AbsoluteContentSize.Y + 4)
				end)

				local dropObj = { Value = selected, _items = {} }
				local optButtons = {}

				local function addOption(text)
					local optBtn = Util.Create("TextButton", {
						Size             = UDim2.new(1, -8, 0, 26),
						Position         = UDim2.new(0, 4, 0, 0),
						BackgroundColor3 = T3.ItemBackground,
						Text             = text,
						TextColor3       = T3.TextPrimary,
						TextSize         = 12,
						Font             = Enum.Font.Gotham,
						AutoButtonColor  = false,
						ZIndex           = 22,
					}, optScroll)
					Util.AddCorner(optBtn, 4)

					optBtn.MouseEnter:Connect(function()
						Util.Tween(optBtn, { BackgroundColor3 = T3.TabHover }, 0.1)
					end)
					optBtn.MouseLeave:Connect(function()
						Util.Tween(optBtn, { BackgroundColor3 = T3.ItemBackground }, 0.1)
					end)
					optBtn.Activated:Connect(function()
						selected = text
						dropLabel.Text = text
						dropObj.Value  = text
						-- Close
						isOpen = false
						Util.Tween(dropList, { Size = UDim2.new(0, 160, 0, 0) }, 0.2)
						task.delay(0.2, function() dropList.Visible = false end)
						if opts2.Callback then
							task.spawn(opts2.Callback, text)
						end
					end)

					table.insert(optButtons, { btn = optBtn, text = text })
					return optBtn
				end

				-- Add initial options
				for _, optText in ipairs(opts2.Options or {}) do
					addOption(optText)
					table.insert(dropObj._items, optText)
				end

				-- Search filter
				dropSearch:GetPropertyChangedSignal("Text"):Connect(function()
					local q = dropSearch.Text:lower()
					for _, item in pairs(optButtons) do
						item.btn.Visible = q == "" or item.text:lower():find(q, 1, true) ~= nil
					end
				end)

				dropBtn.Activated:Connect(function()
					isOpen = not isOpen
					dropList.Visible = true
					local targetH = isOpen and math.min(#optButtons * 28 + 38, 160) or 0
					Util.Tween(dropList, { Size = UDim2.new(0, 160, 0, targetH) }, 0.2)
					if not isOpen then
						task.delay(0.2, function() dropList.Visible = false end)
					end
				end)

				function dropObj:Set(v)
					selected = v
					dropLabel.Text = v
					dropObj.Value = v
				end

				function dropObj:AddOption(text)
					addOption(text)
					table.insert(self._items, text)
				end

				return dropObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  MULTI-DROPDOWN                  ║
			-- ╚══════════════════════════════════╝
			function Section:AddMultiDropdown(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)

				local selected  = {}
				local isOpen    = false

				local dropBtn = Util.Create("TextButton", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 160, 0, 28),
					BackgroundColor3 = T3.Input,
					Text             = "",
					AutoButtonColor  = false,
				}, frame)
				Util.AddCorner(dropBtn, 6)
				Util.AddStroke(dropBtn, T3.InputBorder, 1)

				local dropLabel = Util.Create("TextLabel", {
					Position         = UDim2.new(0, 8, 0, 0),
					Size             = UDim2.new(1, -26, 1, 0),
					Text             = "None selected",
					TextColor3       = T3.TextMuted,
					TextSize         = 11,
					Font             = Enum.Font.Gotham,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
					TextTruncate     = Enum.TextTruncate.AtEnd,
				}, dropBtn)

				Util.Create("TextLabel", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -6, 0.5, 0),
					Size             = UDim2.new(0, 14, 0, 14),
					Text             = "▾",
					TextColor3       = T3.TextMuted,
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
				}, dropBtn)

				local dropList = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0),
					Position         = UDim2.new(1, -12, 1, 4),
					Size             = UDim2.new(0, 160, 0, 0),
					BackgroundColor3 = T3.Section,
					ClipsDescendants = true,
					ZIndex           = 20,
					Visible          = false,
				}, frame)
				Util.AddCorner(dropList, 6)
				Util.AddStroke(dropList, T3.InputBorder, 1)

				local optScroll = Util.Create("ScrollingFrame", {
					Position          = UDim2.new(0, 0, 0, 4),
					Size              = UDim2.new(1, 0, 1, -4),
					BackgroundTransparency = 1,
					ScrollBarThickness = 2,
					ScrollBarImageColor3 = T3.Scrollbar,
					CanvasSize         = UDim2.new(0, 0, 0, 0),
					ZIndex             = 21,
				}, dropList)
				local optLayout = Util.AddListLayout(optScroll, 2)
				optLayout.Changed:Connect(function()
					optScroll.CanvasSize = UDim2.new(0, 0, 0, optLayout.AbsoluteContentSize.Y + 4)
				end)

				local multiObj = { Value = selected }

				local function updateLabel()
					if #selected == 0 then
						dropLabel.Text = "None selected"
						dropLabel.TextColor3 = T3.TextMuted
					else
						dropLabel.Text = table.concat(selected, ", ")
						dropLabel.TextColor3 = T3.TextPrimary
					end
				end

				for _, optText in ipairs(opts2.Options or {}) do
					local isChecked = false
					local optFrame = Util.Create("Frame", {
						Size             = UDim2.new(1, -8, 0, 28),
						Position         = UDim2.new(0, 4, 0, 0),
						BackgroundColor3 = T3.ItemBackground,
						ZIndex           = 21,
					}, optScroll)
					Util.AddCorner(optFrame, 4)

					local checkBox = Util.Create("Frame", {
						Position         = UDim2.new(0, 6, 0.5, -8),
						Size             = UDim2.new(0, 16, 0, 16),
						BackgroundColor3 = T3.Toggle,
						ZIndex           = 22,
					}, optFrame)
					Util.AddCorner(checkBox, 3)
					Util.AddStroke(checkBox, T3.InputBorder, 1)

					local checkMark = Util.Create("TextLabel", {
						Size             = UDim2.new(1, 0, 1, 0),
						Text             = "✓",
						TextColor3       = Color3.fromRGB(255,255,255),
						TextSize         = 11,
						Font             = Enum.Font.GothamBold,
						BackgroundTransparency = 1,
						Visible          = false,
						ZIndex           = 23,
					}, checkBox)

					Util.Create("TextLabel", {
						Position         = UDim2.new(0, 28, 0, 0),
						Size             = UDim2.new(1, -34, 1, 0),
						Text             = optText,
						TextColor3       = T3.TextPrimary,
						TextSize         = 12,
						Font             = Enum.Font.Gotham,
						BackgroundTransparency = 1,
						TextXAlignment   = Enum.TextXAlignment.Left,
						ZIndex           = 22,
					}, optFrame)

					local optBtn = Util.Create("TextButton", {
						Size             = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						Text             = "",
						ZIndex           = 23,
					}, optFrame)

					optBtn.Activated:Connect(function()
						isChecked = not isChecked
						if isChecked then
							table.insert(selected, optText)
							checkMark.Visible = true
							Util.Tween(checkBox, { BackgroundColor3 = T3.ToggleOn }, 0.15)
						else
							for i, v in ipairs(selected) do
								if v == optText then table.remove(selected, i) break end
							end
							checkMark.Visible = false
							Util.Tween(checkBox, { BackgroundColor3 = T3.Toggle }, 0.15)
						end
						multiObj.Value = selected
						updateLabel()
						if opts2.Callback then
							task.spawn(opts2.Callback, selected)
						end
					end)
				end

				dropBtn.Activated:Connect(function()
					isOpen = not isOpen
					dropList.Visible = true
					local itemCount = #(opts2.Options or {})
					local targetH = isOpen and math.min(itemCount * 30 + 8, 150) or 0
					Util.Tween(dropList, { Size = UDim2.new(0, 160, 0, targetH) }, 0.2)
					if not isOpen then
						task.delay(0.2, function() dropList.Visible = false end)
					end
				end)

				return multiObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  INPUT / TEXTBOX                 ║
			-- ╚══════════════════════════════════╝
			function Section:AddInput(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)

				local inputBox = Util.Create("TextBox", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 150, 0, 28),
					BackgroundColor3 = T3.Input,
					Text             = opts2.Default or "",
					PlaceholderText  = opts2.Placeholder or "Type here...",
					PlaceholderColor3 = T3.TextMuted,
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.Gotham,
					ClearTextOnFocus = not opts2.NoFocusClear,
				}, frame)
				Util.AddCorner(inputBox, 6)
				Util.AddStroke(inputBox, T3.InputBorder, 1)
				Util.AddPadding(inputBox, 0, 8, 0, 8)

				inputBox.Focused:Connect(function()
					Util.Tween(inputBox, { BackgroundColor3 = T3.BackgroundAlt }, 0.15)
				end)
				inputBox.FocusLost:Connect(function()
					Util.Tween(inputBox, { BackgroundColor3 = T3.Input }, 0.15)
					if opts2.Numeric then
						local n = tonumber(inputBox.Text)
						if not n then inputBox.Text = opts2.Default or "" end
					end
					if opts2.Callback then
						task.spawn(opts2.Callback, inputBox.Text)
					end
				end)

				local inputObj = { Value = inputBox.Text }
				inputBox:GetPropertyChangedSignal("Text"):Connect(function()
					inputObj.Value = inputBox.Text
					if opts2.OnChange then
						task.spawn(opts2.OnChange, inputBox.Text)
					end
				end)

				function inputObj:Set(v)
					inputBox.Text = tostring(v)
				end
				return inputObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  KEYBIND                         ║
			-- ╚══════════════════════════════════╝
			function Section:AddKeybind(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)
				local currentKey = opts2.Default or Enum.KeyCode.RightControl
				local listening  = false

				local keyBtn = Util.Create("TextButton", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 110, 0, 28),
					BackgroundColor3 = T3.Input,
					Text             = "[" .. currentKey.Name .. "]",
					TextColor3       = T3.Accent,
					TextSize         = 11,
					Font             = Enum.Font.GothamBold,
					AutoButtonColor  = false,
				}, frame)
				Util.AddCorner(keyBtn, 6)
				Util.AddStroke(keyBtn, T3.InputBorder, 1)

				local keybindObj = { Value = currentKey }

				keyBtn.Activated:Connect(function()
					listening = true
					keyBtn.Text = "[ ... ]"
					keyBtn.TextColor3 = T3.TextMuted
				end)

				UserInputService.InputBegan:Connect(function(input, gpe)
					if listening and input.UserInputType == Enum.UserInputType.Keyboard then
						listening = false
						currentKey = input.KeyCode
						keybindObj.Value = currentKey
						keyBtn.Text = "[" .. currentKey.Name .. "]"
						keyBtn.TextColor3 = T3.Accent
						if opts2.Callback then
							task.spawn(opts2.Callback, currentKey)
						end
					end
				end)

				return keybindObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  COLOR PICKER                    ║
			-- ╚══════════════════════════════════╝
			function Section:AddColorPicker(opts2)
				opts2 = opts2 or {}
				local frame, _ = makeItemBase(opts2, 44)

				local color = opts2.Default or Color3.fromRGB(180, 0, 0)
				local isOpen = false

				local preview = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 40, 0, 24),
					BackgroundColor3 = color,
				}, frame)
				Util.AddCorner(preview, 5)
				Util.AddStroke(preview, T3.InputBorder, 1)

				local previewBtn = Util.Create("TextButton", {
					Size             = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text             = "",
				}, preview)

				-- Simple HSV picker popup
				local picker = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0),
					Position         = UDim2.new(1, -12, 1, 6),
					Size             = UDim2.new(0, 180, 0, 0),
					BackgroundColor3 = T3.Section,
					ClipsDescendants = true,
					ZIndex           = 20,
					Visible          = false,
				}, frame)
				Util.AddCorner(picker, 8)
				Util.AddStroke(picker, T3.InputBorder, 1)

				local h, s, v2 = Color3.toHSV(color)

				-- Hue slider
				local hueGrad = Util.Create("Frame", {
					Position         = UDim2.new(0, 10, 0, 12),
					Size             = UDim2.new(1, -20, 0, 16),
					ZIndex           = 21,
				}, picker)
				Util.AddCorner(hueGrad, 4)

				local gradImg = Util.Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,0,0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255,255,0)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,255,0)),
						ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(0,255,255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0,0,255)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255,0,255)),
						ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,0,0)),
					}),
				}, hueGrad)

				-- Hex input
				local hexInput = Util.Create("TextBox", {
					Position         = UDim2.new(0, 10, 0, 36),
					Size             = UDim2.new(1, -20, 0, 24),
					BackgroundColor3 = T3.Input,
					Text             = string.format("#%02X%02X%02X",
						math.floor(color.R*255),
						math.floor(color.G*255),
						math.floor(color.B*255)),
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.Code,
					ZIndex           = 21,
				}, picker)
				Util.AddCorner(hexInput, 4)
				Util.AddPadding(hexInput, 0, 6, 0, 6)

				local colorObj = { Value = color }

				local function applyColor(c)
					color = c
					colorObj.Value = c
					preview.BackgroundColor3 = c
					hexInput.Text = string.format("#%02X%02X%02X",
						math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
					if opts2.Callback then
						task.spawn(opts2.Callback, c)
					end
				end

				hexInput.FocusLost:Connect(function()
					local hex = hexInput.Text:gsub("#","")
					if #hex == 6 then
						local r = tonumber(hex:sub(1,2),16)
						local g = tonumber(hex:sub(3,4),16)
						local b = tonumber(hex:sub(5,6),16)
						if r and g and b then
							applyColor(Color3.fromRGB(r,g,b))
						end
					end
				end)

				local draggingHue = false
				hueGrad.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						draggingHue = true
						h = math.clamp((input.Position.X - hueGrad.AbsolutePosition.X) / hueGrad.AbsoluteSize.X, 0, 1)
						applyColor(Color3.fromHSV(h, s, v2))
					end
				end)
				hueGrad.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						draggingHue = false
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if draggingHue and input.UserInputType == Enum.UserInputType.MouseMovement then
						h = math.clamp((input.Position.X - hueGrad.AbsolutePosition.X) / hueGrad.AbsoluteSize.X, 0, 1)
						applyColor(Color3.fromHSV(h, s, v2))
					end
				end)

				previewBtn.Activated:Connect(function()
					isOpen = not isOpen
					picker.Visible = true
					Util.Tween(picker, { Size = UDim2.new(0, 180, 0, isOpen and 70 or 0) }, 0.2)
					if not isOpen then
						task.delay(0.2, function() picker.Visible = false end)
					end
				end)

				function colorObj:Set(c) applyColor(c) end
				return colorObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  LABEL                           ║
			-- ╚══════════════════════════════════╝
			function Section:AddLabel(opts2)
				opts2 = opts2 or {}
				local label = Util.Create("TextLabel", {
					Size             = UDim2.new(1, 0, 0, 20),
					BackgroundTransparency = 1,
					Text             = opts2.Text or "",
					TextColor3       = opts2.Color or T3.TextSecondary,
					TextSize         = opts2.TextSize or 12,
					Font             = opts2.Bold and Enum.Font.GothamBold or Enum.Font.Gotham,
					TextXAlignment   = Enum.TextXAlignment.Left,
					RichText         = true,
				}, itemsContainer)
				Util.AddPadding(label, 0, 0, 0, 12)

				local labelObj = {}
				function labelObj:SetText(text) label.Text = text end
				return labelObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  PARAGRAPH                       ║
			-- ╚══════════════════════════════════╝
			function Section:AddParagraph(opts2)
				opts2 = opts2 or {}
				local pFrame = Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, 40),
					BackgroundTransparency = 1,
				}, itemsContainer)

				Util.Create("TextLabel", {
					Size             = UDim2.new(1, -12, 0, 16),
					Position         = UDim2.new(0, 12, 0, 0),
					Text             = opts2.Title or "",
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
				}, pFrame)

				local content = Util.Create("TextLabel", {
					Size             = UDim2.new(1, -12, 0, 24),
					Position         = UDim2.new(0, 12, 0, 16),
					Text             = opts2.Content or "",
					TextColor3       = T3.TextSecondary,
					TextSize         = 11,
					Font             = Enum.Font.Gotham,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
					TextWrapped      = true,
					RichText         = true,
				}, pFrame)

				content:GetPropertyChangedSignal("TextBounds"):Connect(function()
					local h = content.TextBounds.Y
					content.Size = UDim2.new(1, -12, 0, h)
					pFrame.Size  = UDim2.new(1, 0, 0, h + 20)
				end)
			end

			-- ╔══════════════════════════════════╗
			-- ║  DIVIDER                         ║
			-- ╚══════════════════════════════════╝
			function Section:AddDivider()
				Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = T3.Divider,
					BorderSizePixel  = 0,
				}, itemsContainer)
			end

			-- ╔══════════════════════════════════╗
			-- ║  BADGE                           ║
			-- ╚══════════════════════════════════╝
			function Section:AddBadge(opts2)
				opts2 = opts2 or {}
				local badgeFrame = Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, 28),
					BackgroundTransparency = 1,
				}, itemsContainer)

				Util.Create("TextLabel", {
					Position         = UDim2.new(0, 12, 0, 0),
					Size             = UDim2.new(0.5, 0, 1, 0),
					Text             = opts2.Title or "",
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.GothamMedium,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
				}, badgeFrame)

				local badge = Util.Create("Frame", {
					AnchorPoint      = Vector2.new(1, 0.5),
					Position         = UDim2.new(1, -12, 0.5, 0),
					Size             = UDim2.new(0, 0, 0, 20),
					BackgroundColor3 = opts2.Color or T3.Accent,
					AutomaticSize    = Enum.AutomaticSize.X,
				}, badgeFrame)
				Util.AddCorner(badge, 4)
				Util.AddPadding(badge, 0, 8, 0, 8)

				local badgeLabel = Util.Create("TextLabel", {
					Size             = UDim2.new(0, 0, 1, 0),
					AutomaticSize    = Enum.AutomaticSize.X,
					Text             = opts2.Value or "",
					TextColor3       = Color3.fromRGB(255,255,255),
					TextSize         = 11,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
				}, badge)

				local badgeObj = {}
				function badgeObj:Set(text) badgeLabel.Text = tostring(text) end
				return badgeObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  INFO TABLE ROW                  ║
			-- ╚══════════════════════════════════╝
			function Section:AddInfo(opts2)
				opts2 = opts2 or {}
				local row = Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
				}, itemsContainer)

				Util.Create("TextLabel", {
					Position         = UDim2.new(0, 12, 0, 0),
					Size             = UDim2.new(0.5, 0, 1, 0),
					Text             = opts2.Key or "",
					TextColor3       = T3.TextSecondary,
					TextSize         = 12,
					Font             = Enum.Font.Gotham,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
				}, row)

				local valLabel = Util.Create("TextLabel", {
					AnchorPoint      = Vector2.new(1, 0),
					Position         = UDim2.new(1, -12, 0, 0),
					Size             = UDim2.new(0.5, 0, 1, 0),
					Text             = opts2.Value or "",
					TextColor3       = opts2.ValueColor or T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.GothamMedium,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Right,
				}, row)

				local infoObj = {}
				function infoObj:Set(text, color)
					valLabel.Text = tostring(text)
					if color then valLabel.TextColor3 = color end
				end
				return infoObj
			end

			-- ╔══════════════════════════════════╗
			-- ║  FOLDER (COLLAPSIBLE)            ║
			-- ╚══════════════════════════════════╝
			function Section:AddFolder(opts2)
				opts2 = opts2 or {}
				local folderFrame = Util.Create("Frame", {
					Size             = UDim2.new(1, 0, 0, 30),
					BackgroundColor3 = T3.ItemBackground,
					ClipsDescendants = false,
				}, itemsContainer)
				Util.AddCorner(folderFrame, 6)
				Util.AddStroke(folderFrame, T3.SectionBorder, 1)

				local headerBtn = Util.Create("TextButton", {
					Size             = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 1,
					Text             = "",
				}, folderFrame)

				Util.Create("TextLabel", {
					Position         = UDim2.new(0, 26, 0, 0),
					Size             = UDim2.new(1, -36, 1, 0),
					Text             = opts2.Name or "Folder",
					TextColor3       = T3.TextPrimary,
					TextSize         = 12,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					TextXAlignment   = Enum.TextXAlignment.Left,
				}, folderFrame)

				local arrowLabel = Util.Create("TextLabel", {
					Position         = UDim2.new(0, 8, 0.5, -8),
					Size             = UDim2.new(0, 16, 0, 16),
					Text             = "▶",
					TextColor3       = T3.Accent,
					TextSize         = 10,
					Font             = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
				}, folderFrame)

				local folderContent = Util.Create("Frame", {
					Position         = UDim2.new(0, 0, 0, 32),
					Size             = UDim2.new(1, 0, 0, 0),
					BackgroundTransparency = 1,
					ClipsDescendants = false,
					Visible          = false,
				}, folderFrame)
				Util.AddPadding(folderContent, 0, 8, 4, 8)
				local folderLayout = Util.AddListLayout(folderContent, 4)

				local isOpen = false

				local function updateFolderSize()
					local contentH = isOpen and (folderLayout.AbsoluteContentSize.Y + 12) or 0
					folderContent.Size = UDim2.new(1, 0, 0, contentH)
					Util.Tween(folderFrame, { Size = UDim2.new(1, 0, 0, 30 + contentH) }, 0.2)
				end

				folderLayout.Changed:Connect(function()
					if isOpen then updateFolderSize() end
				end)

				headerBtn.Activated:Connect(function()
					isOpen = not isOpen
					folderContent.Visible = isOpen
					Util.Tween(arrowLabel, { Rotation = isOpen and 90 or 0 }, 0.2)
					updateFolderSize()
				end)

				-- Folder is itself a mini-section
				local FolderSection = {
					_frame      = folderFrame,
					_container  = folderContent,
					_theme      = T3,
					_tab        = self._tab,
				}

				-- Copy all component methods to folder
				local function makeItemInFolder(opts2f, height)
					height = height or 44
					local frame = Util.Create("Frame", {
						Size             = UDim2.new(1, 0, 0, height),
						BackgroundColor3 = T3.Section,
						ClipsDescendants = false,
					}, folderContent)
					Util.AddCorner(frame, 5)

					if opts2f.Title then
						Util.Create("TextLabel", {
							Position         = UDim2.new(0, 10, 0, 0),
							Size             = UDim2.new(0.6, -10, 0, 22),
							Text             = opts2f.Title,
							TextColor3       = T3.TextPrimary,
							TextSize         = 12,
							Font             = Enum.Font.GothamMedium,
							BackgroundTransparency = 1,
							TextXAlignment   = Enum.TextXAlignment.Left,
						}, frame)
					end
					if opts2f.Description then
						Util.Create("TextLabel", {
							Position         = UDim2.new(0, 10, 0, 22),
							Size             = UDim2.new(0.7, -10, 0, 16),
							Text             = opts2f.Description,
							TextColor3       = T3.TextSecondary,
							TextSize         = 10,
							Font             = Enum.Font.Gotham,
							BackgroundTransparency = 1,
							TextXAlignment   = Enum.TextXAlignment.Left,
						}, frame)
					end
					return frame
				end

				-- Toggle in folder
				function FolderSection:AddSwitch(opts2f, callback)
					if type(opts2f) == "string" then
						opts2f = { Title = opts2f, Callback = callback }
					end
					local frame = makeItemInFolder(opts2f, 38)
					local state = opts2f.Default or false

					local toggleBg = Util.Create("Frame", {
						AnchorPoint      = Vector2.new(1, 0.5),
						Position         = UDim2.new(1, -10, 0.5, 0),
						Size             = UDim2.new(0, 40, 0, 22),
						BackgroundColor3 = state and T3.ToggleOn or T3.Toggle,
					}, frame)
					Util.AddCorner(toggleBg, 11)
					local tCircle = Util.Create("Frame", {
						Position = UDim2.new(state and 1 or 0, state and -20 or 2, 0.5, -9),
						Size     = UDim2.new(0, 18, 0, 18),
						BackgroundColor3 = Color3.fromRGB(255,255,255),
					}, toggleBg)
					Util.AddCorner(tCircle, 9)

					local btn = Util.Create("TextButton", {
						Size = UDim2.new(1,0,1,0), BackgroundTransparency=1, Text=""
					}, frame)

					local togObj = { Value = state }
					local function setT(v)
						state = v; togObj.Value = v
						Util.Tween(toggleBg, { BackgroundColor3 = v and T3.ToggleOn or T3.Toggle }, 0.2)
						Util.Tween(tCircle, { Position = v and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9) }, 0.2)
						local cb = opts2f.Callback or callback
						if cb then task.spawn(cb, v) end
					end
					btn.Activated:Connect(function() setT(not state) end)
					function togObj:Set(v) setT(v) end
					return togObj
				end

				-- Button in folder
				function FolderSection:AddButton(opts2f, callback)
					if type(opts2f) == "string" then
						opts2f = { Title = opts2f, Callback = callback }
					end
					local frame = makeItemInFolder(opts2f, 38)
					local btn = Util.Create("TextButton", {
						AnchorPoint = Vector2.new(1,0.5),
						Position    = UDim2.new(1,-10,0.5,0),
						Size        = UDim2.new(0,80,0,26),
						BackgroundColor3 = T3.Button,
						Text        = opts2f.ButtonText or "Execute",
						TextColor3  = Color3.fromRGB(255,255,255),
						TextSize    = 11, Font = Enum.Font.GothamBold,
						AutoButtonColor = false,
					}, frame)
					Util.AddCorner(btn, 5)
					btn.Activated:Connect(function()
						local cb = opts2f.Callback or callback
						if cb then task.spawn(cb) end
					end)
				end

				-- Label in folder
				function FolderSection:AddLabel(text)
					Util.Create("TextLabel", {
						Size             = UDim2.new(1,0,0,18),
						BackgroundTransparency = 1,
						Text             = text or "",
						TextColor3       = T3.TextSecondary,
						TextSize         = 11,
						Font             = Enum.Font.Gotham,
						TextXAlignment   = Enum.TextXAlignment.Left,
					}, folderContent)
				end

				-- Divider in folder
				function FolderSection:AddDivider()
					Util.Create("Frame", {
						Size = UDim2.new(1,0,0,1),
						BackgroundColor3 = T3.Divider, BorderSizePixel = 0,
					}, folderContent)
				end

				return FolderSection
			end

			return Section
		end

		return Tab
	end

	-- Switch active tab
	function Window:_SwitchTab(targetTab)
		if self._activeTab == targetTab then return end

		-- Hide current
		if self._activeTab then
			self._activeTab._page.Visible = false
			Util.Tween(self._activeTab._btn, { BackgroundColor3 = self._theme.TabInactive }, 0.2)
			self._activeTab._activeBar.Visible = false
			self._activeTab._nameLabel.TextColor3 = self._theme.TextSecondary
			self._activeTab._iconLabel.TextColor3 = self._theme.TextMuted
		end

		-- Show target
		targetTab._page.Visible = true
		Util.Tween(targetTab._btn, { BackgroundColor3 = self._theme.TabActive }, 0.2)
		targetTab._activeBar.Visible = true
		targetTab._nameLabel.TextColor3 = self._theme.TextPrimary
		targetTab._iconLabel.TextColor3 = self._theme.TextPrimary

		self._activeTab = targetTab
	end

	table.insert(self._windows, Window)
	return Window
end

-- ══════════════════════════════════════════════════════════════════════════
-- PUBLIC API — SAVE / LOAD CONFIG
-- ══════════════════════════════════════════════════════════════════════════
function BloodLibrary:SaveConfig(name, data)
	local ok, err = pcall(function()
		writefile("BloodLibrary_" .. name .. ".json", HttpService:JSONEncode(data))
	end)
	if not ok then warn("[BloodLibrary] SaveConfig failed:", err) end
end

function BloodLibrary:LoadConfig(name)
	local ok, result = pcall(function()
		return HttpService:JSONDecode(readfile("BloodLibrary_" .. name .. ".json"))
	end)
	if ok then return result end
	return nil
end

-- ══════════════════════════════════════════════════════════════════════════
-- RETURN SINGLETON
-- ══════════════════════════════════════════════════════════════════════════
return BloodLibrary.new()
