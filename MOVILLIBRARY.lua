if getgenv().BloodLib then
	pcall(function() getgenv().BloodLib:Destroy() end)
end

cloneref = cloneref or function(o) return o end

local Players          = cloneref(game:GetService("Players"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService       = cloneref(game:GetService("RunService"))
local TweenService     = cloneref(game:GetService("TweenService"))
local HttpService      = cloneref(game:GetService("HttpService"))
local CoreGui          = cloneref(game:GetService("CoreGui"))
local TextService      = cloneref(game:GetService("TextService"))

gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local assets = {
	toggleBG     = "rbxassetid://18772190202",
	toggleHead   = "rbxassetid://18772309008",
	sliderBar    = "rbxassetid://18772615246",
	sliderHead   = "rbxassetid://18772834246",
	searchIcon   = "rbxassetid://86737463322606",
	btnImage     = "rbxassetid://10709791437",
	dropArrow    = "rbxassetid://18865373378",
	libIcon      = "rbxassetid://72559578724301",
	gradient     = "rbxassetid://5417459462",
	shadow       = "rbxassetid://6014261993",
}

local function tw(obj, props, t, s, d)
	TweenService:Create(obj, TweenInfo.new(t or 0.2, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out), props):Play()
end

local function corner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 6)
	c.Parent = p
	return c
end

local function stroke(p, col, thick, trans)
	local s = Instance.new("UIStroke")
	s.Color = col or Color3.fromRGB(60, 0, 0)
	s.Thickness = thick or 1
	s.Transparency = trans or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = p
	return s
end

local function pad(p, t, r, b, l)
	local u = Instance.new("UIPadding")
	u.PaddingTop    = UDim.new(0, t or 0)
	u.PaddingRight  = UDim.new(0, r or 0)
	u.PaddingBottom = UDim.new(0, b or 0)
	u.PaddingLeft   = UDim.new(0, l or 0)
	u.Parent = p
end

local function lbl(parent, props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.BorderSizePixel = 0
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextYAlignment = Enum.TextYAlignment.Center
	l.Font = Enum.Font.Gotham
	l.TextSize = 14
	l.TextColor3 = Color3.fromRGB(230,230,230)
	l.RichText = true
	for k,v in pairs(props or {}) do l[k] = v end
	l.Parent = parent
	return l
end

local function img(parent, props)
	local i = Instance.new("ImageLabel")
	i.BackgroundTransparency = 1
	i.BorderSizePixel = 0
	for k,v in pairs(props or {}) do i[k] = v end
	i.Parent = parent
	return i
end

local function newFrame(parent, props)
	local f = Instance.new("Frame")
	f.BackgroundTransparency = 1
	f.BorderSizePixel = 0
	for k,v in pairs(props or {}) do f[k] = v end
	f.Parent = parent
	return f
end

local function btn(parent, props)
	local b = Instance.new("TextButton")
	b.BackgroundTransparency = 1
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Text = ""
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.TextColor3 = Color3.fromRGB(230,230,230)
	for k,v in pairs(props or {}) do b[k] = v end
	b.Parent = parent
	return b
end

local T = {
	BG          = Color3.fromRGB(13, 13, 13),
	Sidebar     = Color3.fromRGB(18, 18, 18),
	Section     = Color3.fromRGB(20, 20, 20),
	Element     = Color3.fromRGB(25, 25, 25),
	ElementHov  = Color3.fromRGB(30, 30, 30),
	Accent      = Color3.fromRGB(185, 0, 0),
	AccentHov   = Color3.fromRGB(215, 25, 25),
	AccentDim   = Color3.fromRGB(100, 0, 0),
	Border      = Color3.fromRGB(38, 8, 8),
	BorderDim   = Color3.fromRGB(28, 6, 6),
	Text        = Color3.fromRGB(235, 235, 235),
	TextDim     = Color3.fromRGB(145, 145, 145),
	TextDark    = Color3.fromRGB(80, 80, 80),
	Success     = Color3.fromRGB(0, 155, 55),
	Warning     = Color3.fromRGB(210, 140, 0),
	Error       = Color3.fromRGB(200, 30, 30),
	Info        = Color3.fromRGB(20, 100, 210),
}

local BloodLib = {}
BloodLib.__index = BloodLib
BloodLib.Flags = {}
BloodLib.Configs = {}
BloodLib.ConfigFolder = "BloodLibrary"

function BloodLib:SaveConfig(name)
	pcall(function()
		if not isfolder(self.ConfigFolder) then makefolder(self.ConfigFolder) end
		writefile(self.ConfigFolder.."/"..tostring(name or "default")..".json", HttpService:JSONEncode(self.Flags))
	end)
end

function BloodLib:LoadConfig(name)
	pcall(function()
		local p = self.ConfigFolder.."/"..tostring(name or "default")..".json"
		if isfile(p) then
			local d = HttpService:JSONDecode(readfile(p))
			for k,v in pairs(d) do self.Flags[k] = v end
		end
	end)
end

local NotifGui do
	NotifGui = Instance.new("ScreenGui")
	NotifGui.Name = "BloodNotifs"
	NotifGui.ResetOnSpawn = false
	NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	NotifGui.DisplayOrder = 2147483647
	pcall(function() NotifGui.Parent = gethui() end)
	if not NotifGui.Parent then NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local holder = newFrame(NotifGui, {
		Name = "Holder",
		Size = UDim2.new(0,340,1,0),
		Position = UDim2.new(1,-350,0,0),
	})
	local ul = Instance.new("UIListLayout")
	ul.SortOrder = Enum.SortOrder.LayoutOrder
	ul.VerticalAlignment = Enum.VerticalAlignment.Bottom
	ul.Padding = UDim.new(0,8)
	ul.Parent = holder
	pad(holder, 10,10,10,10)
end

local function Notify(opts)
	local title = opts.Title or "Notification"
	local text  = opts.Text or ""
	local dur   = opts.Duration or 5
	local ntype = opts.Type or "info"
	local ac = (ntype=="success" and T.Success) or (ntype=="warning" and T.Warning) or (ntype=="error" and T.Error) or T.Accent

	local holder = NotifGui:FindFirstChild("Holder")

	local card = Instance.new("Frame")
	card.BackgroundColor3 = Color3.fromRGB(18,18,18)
	card.BorderSizePixel = 0
	card.Size = UDim2.new(1,0,0,0)
	card.ClipsDescendants = true
	card.LayoutOrder = -tick()
	card.Parent = holder
	corner(card, 8)
	stroke(card, ac, 1, 0.5)

	local bar = Instance.new("Frame")
	bar.BackgroundColor3 = ac
	bar.BorderSizePixel = 0
	bar.Size = UDim2.new(0,3,1,0)
	bar.Parent = card
	corner(bar, 3)

	local inner = newFrame(card, {
		Size = UDim2.new(1,-14,1,0),
		Position = UDim2.new(0,10,0,0),
	})

	lbl(inner, {
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = T.Text,
		Size = UDim2.new(1,0,0,16),
		Position = UDim2.new(0,0,0,8),
	})
	lbl(inner, {
		Text = text,
		TextSize = 11,
		TextColor3 = T.TextDim,
		Size = UDim2.new(1,0,0,14),
		Position = UDim2.new(0,0,0,26),
		TextWrapped = true,
	})

	local prog = Instance.new("Frame")
	prog.BackgroundColor3 = ac
	prog.BackgroundTransparency = 0.4
	prog.BorderSizePixel = 0
	prog.Size = UDim2.new(1,0,0,2)
	prog.Position = UDim2.new(0,0,1,-2)
	prog.Parent = card

	tw(card, {Size = UDim2.new(1,0,0,62)}, 0.3)
	tw(prog, {Size = UDim2.new(0,0,0,2)}, dur, Enum.EasingStyle.Linear, Enum.EasingDirection.In)

	task.delay(dur, function()
		tw(card, {Size = UDim2.new(1,0,0,0)}, 0.25)
		task.wait(0.3)
		pcall(function() card:Destroy() end)
	end)
end

BloodLib.Notify  = function(_, o)   Notify(o)                                          end
BloodLib.Success = function(_, t,x,d) Notify({Title=t,Text=x,Duration=d,Type="success"}) end
BloodLib.Warning = function(_, t,x,d) Notify({Title=t,Text=x,Duration=d,Type="warning"}) end
BloodLib.Error   = function(_, t,x,d) Notify({Title=t,Text=x,Duration=d,Type="error"})   end

function BloodLib:CreateWindow(opts)
	opts = opts or {}

	local win = {}
	win._tabs       = {}
	win._activeTab  = nil
	win._visible    = true
	win._minimized  = false
	win._toggleKey  = opts.ToggleKey or Enum.KeyCode.RightShift

	local gui = Instance.new("ScreenGui")
	gui.Name = opts.Name or "BloodLibrary"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.DisplayOrder = 2147483646
	pcall(function() gui.Parent = gethui() end)
	if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
	win._gui = gui

	local winSize = opts.Size or UDim2.fromOffset(750, 480)

	local base = Instance.new("Frame")
	base.Name = "Base"
	base.AnchorPoint = Vector2.new(0.5, 0.5)
	base.BackgroundColor3 = T.BG
	base.BorderSizePixel = 0
	base.Position = opts.Position or UDim2.fromScale(0.5, 0.5)
	base.Size = winSize
	base.ClipsDescendants = false
	base.Parent = gui
	corner(base, 10)
	stroke(base, T.Border, 1, 0)

	local shadowImg = img(base, {
		Image = assets.shadow,
		ImageColor3 = Color3.fromRGB(0,0,0),
		ImageTransparency = 0.55,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49,49,450,450),
		Size = UDim2.new(1,50,1,50),
		Position = UDim2.new(0,-25,0,-25),
		ZIndex = 0,
	})

	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.BackgroundColor3 = T.Sidebar
	sidebar.BorderSizePixel = 0
	sidebar.Size = UDim2.new(0, 165, 1, 0)
	sidebar.ClipsDescendants = true
	sidebar.Parent = base
	local sbCorner = Instance.new("UICorner")
	sbCorner.CornerRadius = UDim.new(0, 10)
	sbCorner.Parent = sidebar

	local sbCoverRight = newFrame(sidebar, {
		BackgroundColor3 = T.Sidebar,
		BackgroundTransparency = 0,
		Size = UDim2.new(0, 12, 1, 0),
		Position = UDim2.new(1, -12, 0, 0),
	})

	local sbDivider = Instance.new("Frame")
	sbDivider.BackgroundColor3 = T.Border
	sbDivider.BorderSizePixel = 0
	sbDivider.Size = UDim2.new(0, 1, 1, 0)
	sbDivider.Position = UDim2.new(1, -1, 0, 0)
	sbDivider.Parent = sidebar

	local sideTop = newFrame(sidebar, {
		BackgroundColor3 = Color3.fromRGB(14,14,14),
		BackgroundTransparency = 0,
		Size = UDim2.new(1,0,0,72),
	})

	local iconBtn = img(sideTop, {
		Image = assets.libIcon,
		Size = UDim2.fromOffset(36, 36),
		Position = UDim2.new(0, 14, 0, 10),
		ScaleType = Enum.ScaleType.Fit,
	})
	corner(iconBtn, 8)

	lbl(sideTop, {
		Text = opts.Title or "Blood Library",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = T.Text,
		Size = UDim2.new(1,-60,0,16),
		Position = UDim2.new(0,56,0,13),
	})
	lbl(sideTop, {
		Text = opts.Subtitle or "Blood Library",
		TextSize = 11,
		TextColor3 = T.TextDim,
		Size = UDim2.new(1,-60,0,14),
		Position = UDim2.new(0,56,0,31),
	})

	local sideTopDiv = Instance.new("Frame")
	sideTopDiv.BackgroundColor3 = T.Border
	sideTopDiv.BorderSizePixel = 0
	sideTopDiv.Size = UDim2.new(1,0,0,1)
	sideTopDiv.Position = UDim2.new(0,0,1,-1)
	sideTopDiv.Parent = sideTop

	local tabScroll = Instance.new("ScrollingFrame")
	tabScroll.BackgroundTransparency = 1
	tabScroll.BorderSizePixel = 0
	tabScroll.Size = UDim2.new(1, 0, 1, -72)
	tabScroll.Position = UDim2.new(0, 0, 0, 72)
	tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabScroll.ScrollBarThickness = 2
	tabScroll.ScrollBarImageColor3 = T.AccentDim
	tabScroll.ElasticBehavior = Enum.ElasticBehavior.Never
	tabScroll.Parent = sidebar
	pad(tabScroll, 6, 8, 6, 8)

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Padding = UDim.new(0, 3)
	tabLayout.Parent = tabScroll

	local content = newFrame(base, {
		Name = "Content",
		Size = UDim2.new(1,-175,1,-44),
		Position = UDim2.new(0,170,0,44),
	})

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.BackgroundColor3 = Color3.fromRGB(14,14,14)
	header.BorderSizePixel = 0
	header.Size = UDim2.new(1,-165,0,44)
	header.Position = UDim2.new(0,165,0,0)
	header.Parent = base
	stroke(header, T.Border, 1, 0.6)

	local headerDiv = Instance.new("Frame")
	headerDiv.BackgroundColor3 = T.Border
	headerDiv.BorderSizePixel = 0
	headerDiv.Size = UDim2.new(1,0,0,1)
	headerDiv.Position = UDim2.new(0,0,1,-1)
	headerDiv.Parent = header

	local tabTitle = lbl(header, {
		Text = "",
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = T.Text,
		Size = UDim2.new(0,200,1,0),
		Position = UDim2.new(0,16,0,0),
	})
	win._tabTitleLabel = tabTitle

	local searchHolder = newFrame(header, {
		Size = UDim2.fromOffset(160, 28),
		Position = UDim2.new(1,-262,0.5,-14),
	})
	searchHolder.BackgroundColor3 = Color3.fromRGB(22,22,22)
	searchHolder.BackgroundTransparency = 0
	corner(searchHolder, 6)
	stroke(searchHolder, T.Border, 1, 0.3)

	local searchIconImg = img(searchHolder, {
		Image = assets.searchIcon,
		ImageColor3 = T.TextDark,
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(0, 8, 0.5, -7),
	})

	local searchBox = Instance.new("TextBox")
	searchBox.PlaceholderText = "Search..."
	searchBox.Text = ""
	searchBox.TextSize = 12
	searchBox.Font = Enum.Font.Gotham
	searchBox.TextColor3 = T.Text
	searchBox.PlaceholderColor3 = T.TextDark
	searchBox.BackgroundTransparency = 1
	searchBox.BorderSizePixel = 0
	searchBox.Size = UDim2.new(1,-28,1,0)
	searchBox.Position = UDim2.new(0,26,0,0)
	searchBox.ClearTextOnFocus = false
	searchBox.Parent = searchHolder
	win._searchBox = searchBox

	local minBtn = btn(header, {
		BackgroundColor3 = Color3.fromRGB(22,22,22),
		BackgroundTransparency = 0,
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(1,-68,0.5,-14),
		Text = "â”€",
		TextSize = 14,
		TextColor3 = T.TextDim,
	})
	corner(minBtn, 6)

	local closeBtn = btn(header, {
		BackgroundColor3 = T.Accent,
		BackgroundTransparency = 0,
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(1,-34,0.5,-14),
		Text = "âœ•",
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
	})
	corner(closeBtn, 6)

	closeBtn.MouseEnter:Connect(function() tw(closeBtn, {BackgroundColor3 = T.AccentHov}, 0.15) end)
	closeBtn.MouseLeave:Connect(function() tw(closeBtn, {BackgroundColor3 = T.Accent}, 0.15) end)
	closeBtn.MouseButton1Click:Connect(function()
		tw(base, {Size = UDim2.new(base.Size.X.Scale, base.Size.X.Offset, 0, 0)}, 0.25)
		task.wait(0.28)
		gui:Destroy()
	end)

	minBtn.MouseEnter:Connect(function() tw(minBtn, {BackgroundColor3 = Color3.fromRGB(35,35,35)}, 0.15) end)
	minBtn.MouseLeave:Connect(function() tw(minBtn, {BackgroundColor3 = Color3.fromRGB(22,22,22)}, 0.15) end)
	minBtn.MouseButton1Click:Connect(function()
		win._minimized = not win._minimized
		if win._minimized then
			tw(base, {Size = UDim2.new(0, base.AbsoluteSize.X, 0, 44)}, 0.25)
			content.Visible = false
		else
			tw(base, {Size = winSize}, 0.25)
			content.Visible = true
		end
	end)

	do
		local drag, dstart, dpos = false, nil, nil
		header.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				drag = true
				dstart = i.Position
				dpos = base.Position
			end
		end)
		UserInputService.InputChanged:Connect(function(i)
			if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
				local d = i.Position - dstart
				base.Position = UDim2.new(dpos.X.Scale, dpos.X.Offset+d.X, dpos.Y.Scale, dpos.Y.Offset+d.Y)
			end
		end)
		UserInputService.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				drag = false
			end
		end)
	end

	UserInputService.InputBegan:Connect(function(i, gp)
		if gp then return end
		if i.KeyCode == win._toggleKey then
			win._visible = not win._visible
			base.Visible = win._visible
		end
	end)

	base.Size = UDim2.new(winSize.X.Scale, winSize.X.Offset, 0, 0)
	base.BackgroundTransparency = 1
	task.defer(function()
		tw(base, {Size = winSize, BackgroundTransparency = 0}, 0.35)
	end)

	function win:SetTitle(t) tabTitle.Text = t end
	function win:SetIcon(i)  iconBtn.Image = i  end
	function win:ToggleKey(k) win._toggleKey = k end
	function win:Destroy()
		tw(base, {Size = UDim2.new(winSize.X.Scale, winSize.X.Offset, 0, 0), BackgroundTransparency = 1}, 0.25)
		task.wait(0.3)
		gui:Destroy()
	end

	function win:AddTab(o) return self:CreateTab(o) end

	function win:CreateTab(opts2)
		opts2 = opts2 or {}
		local tab = {}
		tab._sections = {}
		tab._elements = {}
		tab._order = #win._tabs + 1

		local tabBtn = Instance.new("Frame")
		tabBtn.BackgroundColor3 = Color3.fromRGB(22,22,22)
		tabBtn.BackgroundTransparency = 1
		tabBtn.BorderSizePixel = 0
		tabBtn.Size = UDim2.new(1, 0, 0, 36)
		tabBtn.LayoutOrder = tab._order
		corner(tabBtn, 6)
		tabBtn.Parent = tabScroll

		local accentBar = Instance.new("Frame")
		accentBar.BackgroundColor3 = T.Accent
		accentBar.BorderSizePixel = 0
		accentBar.Size = UDim2.new(0, 3, 0.55, 0)
		accentBar.Position = UDim2.new(0, 0, 0.225, 0)
		accentBar.BackgroundTransparency = 1
		corner(accentBar, 2)
		accentBar.Parent = tabBtn

		local tabIconL = lbl(tabBtn, {
			Text = opts2.Icon or "",
			TextSize = 15,
			TextColor3 = T.TextDim,
			Size = UDim2.new(0, 22, 1, 0),
			Position = UDim2.new(0, 10, 0, 0),
			TextXAlignment = Enum.TextXAlignment.Center,
		})

		local tabTitleL = lbl(tabBtn, {
			Text = opts2.Title or "Tab",
			TextSize = 13,
			TextColor3 = T.TextDim,
			Size = UDim2.new(1, -36, 1, 0),
			Position = UDim2.new(0, 34, 0, 0),
		})

		local tabHitbox = btn(tabBtn, {
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 5,
		})

		local tabFrame = Instance.new("ScrollingFrame")
		tabFrame.BackgroundTransparency = 1
		tabFrame.BorderSizePixel = 0
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tabFrame.ScrollBarThickness = 3
		tabFrame.ScrollBarImageColor3 = T.AccentDim
		tabFrame.ElasticBehavior = Enum.ElasticBehavior.Never
		tabFrame.Visible = false
		tabFrame.Parent = content
		pad(tabFrame, 8, 8, 12, 8)

		local frameLayout = Instance.new("UIListLayout")
		frameLayout.SortOrder = Enum.SortOrder.LayoutOrder
		frameLayout.Padding = UDim.new(0, 8)
		frameLayout.Parent = tabFrame

		tab._btn      = tabBtn
		tab._frame    = tabFrame
		tab._accent   = accentBar
		tab._titleL   = tabTitleL
		tab._iconL    = tabIconL

		local function activate()
			for _, t2 in ipairs(win._tabs) do
				tw(t2._btn, {BackgroundTransparency = 1}, 0.15)
				tw(t2._accent, {BackgroundTransparency = 1}, 0.15)
				t2._titleL.TextColor3 = T.TextDim
				t2._titleL.Font = Enum.Font.Gotham
				t2._iconL.TextColor3 = T.TextDim
				t2._frame.Visible = false
			end
			tw(tabBtn, {BackgroundTransparency = 0.88}, 0.15)
			tw(accentBar, {BackgroundTransparency = 0}, 0.15)
			tabTitleL.TextColor3 = T.Accent
			tabTitleL.Font = Enum.Font.GothamSemibold
			tabIconL.TextColor3 = T.Accent
			tabFrame.Visible = true
			win._activeTab = tab
			tabTitle.Text = opts2.Title or ""
		end

		tabHitbox.MouseButton1Click:Connect(activate)
		tabHitbox.MouseEnter:Connect(function()
			if win._activeTab ~= tab then tw(tabBtn, {BackgroundTransparency = 0.94}, 0.12) end
		end)
		tabHitbox.MouseLeave:Connect(function()
			if win._activeTab ~= tab then tw(tabBtn, {BackgroundTransparency = 1}, 0.12) end
		end)

		table.insert(win._tabs, tab)
		if #win._tabs == 1 then activate() end

		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			local q = searchBox.Text:lower()
			for _, el in ipairs(tab._elements) do
				if el._row then
					el._row.Visible = q == "" or (el._name or ""):lower():find(q, 1, true) ~= nil
				end
			end
		end)

		function tab:SetTabTitle(t) tabTitleL.Text = t end
		function tab:SetTabIcon(i)  tabIconL.Text  = i  end
		function tab:SelectTab()    activate()           end

		function tab:AddSection(o)    return self:CreateSection(o)    end
		function tab:CreateSection(opts3)
			opts3 = opts3 or {}
			local sec = {}
			sec._elements = {}
			sec._order = #tab._sections + 1

			local secFrame = Instance.new("Frame")
			secFrame.BackgroundColor3 = T.Section
			secFrame.BorderSizePixel = 0
			secFrame.Size = UDim2.new(1, 0, 0, 0)
			secFrame.AutomaticSize = Enum.AutomaticSize.Y
			secFrame.LayoutOrder = sec._order
			corner(secFrame, 8)
			stroke(secFrame, T.Border, 1, 0.4)
			secFrame.Parent = tabFrame

			local secHeader = newFrame(secFrame, {
				Size = UDim2.new(1, 0, 0, 30),
			})

			local secAccent = Instance.new("Frame")
			secAccent.BackgroundColor3 = T.Accent
			secAccent.BorderSizePixel = 0
			secAccent.Size = UDim2.new(0, 3, 0.5, 0)
			secAccent.Position = UDim2.new(0, 10, 0.25, 0)
			corner(secAccent, 2)
			secAccent.Parent = secHeader

			lbl(secHeader, {
				Text = opts3.Title or "Section",
				Font = Enum.Font.GothamSemibold,
				TextSize = 12,
				TextColor3 = T.Accent,
				Size = UDim2.new(1, -20, 1, 0),
				Position = UDim2.new(0, 18, 0, 0),
			})

			local secDivider = Instance.new("Frame")
			secDivider.BackgroundColor3 = T.Border
			secDivider.BorderSizePixel = 0
			secDivider.Size = UDim2.new(1, -20, 0, 1)
			secDivider.Position = UDim2.new(0, 10, 0, 29)
			secDivider.Parent = secFrame

			local secContent = newFrame(secFrame, {
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				Position = UDim2.new(0, 0, 0, 30),
			})
			local secLayout = Instance.new("UIListLayout")
			secLayout.SortOrder = Enum.SortOrder.LayoutOrder
			secLayout.Padding = UDim.new(0, 0)
			secLayout.Parent = secContent

			sec._frame = secFrame
			sec._content = secContent

			table.insert(tab._sections, sec)

			local elIndex = 0
			local function nextOrd() elIndex = elIndex + 1 return elIndex end

			local function makeRow(name, height)
				height = height or 40
				local row = newFrame(secContent, {
					BackgroundColor3 = T.ElementHov,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, height),
					LayoutOrder = nextOrd(),
				})

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1, -20, 0, 1)
				rowDiv.Position = UDim2.new(0, 10, 1, -1)
				rowDiv.Parent = row

				lbl(row, {
					Text = name or "",
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(0.55, -10, 1, 0),
					Position = UDim2.new(0, 14, 0, 0),
				})

				row.MouseEnter:Connect(function() tw(row, {BackgroundTransparency = 0.93}, 0.1) end)
				row.MouseLeave:Connect(function() tw(row, {BackgroundTransparency = 1}, 0.1) end)

				return row
			end

			function sec:AddButton(o)    return self:CreateButton(o)    end
			function sec:CreateButton(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local cb = opts4.Callback or function() end

				local row = newFrame(secContent, {
					BackgroundColor3 = T.ElementHov,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 44),
					LayoutOrder = nextOrd(),
				})
				el._row = row

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1,-20,0,1)
				rowDiv.Position = UDim2.new(0,10,1,-1)
				rowDiv.Parent = row

				lbl(row, {
					Text = opts4.Name or "",
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(0.5,-10,1,0),
					Position = UDim2.new(0,14,0,0),
				})

				local execBtn = Instance.new("ImageButton")
				execBtn.Image = assets.btnImage
				execBtn.ScaleType = Enum.ScaleType.Slice
				execBtn.SliceCenter = Rect.new(4,4,10,10)
				execBtn.ImageColor3 = T.Accent
				execBtn.BackgroundColor3 = T.Accent
				execBtn.BackgroundTransparency = 0
				execBtn.BorderSizePixel = 0
				execBtn.Size = UDim2.new(0, 84, 0, 28)
				execBtn.Position = UDim2.new(1,-98,0.5,-14)
				execBtn.AutoButtonColor = false
				corner(execBtn, 6)

				lbl(execBtn, {
					Text = opts4.ButtonText or "Execute",
					Font = Enum.Font.GothamSemibold,
					TextSize = 12,
					TextColor3 = Color3.fromRGB(255,255,255),
					Size = UDim2.new(1,0,1,0),
					TextXAlignment = Enum.TextXAlignment.Center,
				})
				execBtn.Parent = row

				execBtn.MouseEnter:Connect(function() tw(execBtn, {ImageColor3 = T.AccentHov}, 0.15) end)
				execBtn.MouseLeave:Connect(function() tw(execBtn, {ImageColor3 = T.Accent}, 0.15) end)
				execBtn.MouseButton1Click:Connect(function()
					tw(execBtn, {ImageColor3 = T.AccentDim}, 0.08)
					task.wait(0.1)
					tw(execBtn, {ImageColor3 = T.Accent}, 0.15)
					pcall(cb)
				end)

				row.MouseEnter:Connect(function() tw(row, {BackgroundTransparency = 0.93}, 0.1) end)
				row.MouseLeave:Connect(function() tw(row, {BackgroundTransparency = 1}, 0.1) end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:SetButtonText(t) end
				function el:ButtonCallback(f) cb = f end
				return el
			end

			function sec:AddToggle(o)    return self:CreateToggle(o)    end
			function sec:CreateToggle(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local val = opts4.Default == true
				local cb = opts4.Callback or function() end

				local row = makeRow(opts4.Name or "")
				el._row = row

				local toggleFrame = newFrame(row, {
					Size = UDim2.fromOffset(42, 24),
					Position = UDim2.new(1,-54,0.5,-12),
				})

				local toggleBGImg = img(toggleFrame, {
					Image = assets.toggleBG,
					ImageColor3 = val and T.Accent or Color3.fromRGB(55,55,55),
					Size = UDim2.new(1,0,1,0),
					ScaleType = Enum.ScaleType.Stretch,
				})

				local toggleHead = img(toggleFrame, {
					Image = assets.toggleHead,
					Size = UDim2.fromOffset(20,20),
					Position = val and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10),
				})

				if opts4.Flag and BloodLib.Flags[opts4.Flag] ~= nil then
					val = BloodLib.Flags[opts4.Flag]
					toggleBGImg.ImageColor3 = val and T.Accent or Color3.fromRGB(55,55,55)
					toggleHead.Position = val and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10)
				end

				local function setVal(v, silent)
					val = v
					tw(toggleBGImg, {ImageColor3 = v and T.Accent or Color3.fromRGB(55,55,55)}, 0.2)
					tw(toggleHead, {Position = v and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10)}, 0.2)
					if opts4.Flag then BloodLib.Flags[opts4.Flag] = v end
					if not silent then pcall(cb, v) end
				end

				local hb = btn(row, {Size = UDim2.new(1,0,1,0), ZIndex = 5})
				hb.MouseButton1Click:Connect(function() setVal(not val) end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:SetValue(v)      setVal(v)   end
				function el:GetValue()       return val  end
				function el:ToggleCallback(f) cb = f     end
				return el
			end

			function sec:AddSlider(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local min2 = opts4.Min or 0
				local max2 = opts4.Max or 100
				local val = math.clamp(opts4.Default or min2, min2, max2)
				local cb = opts4.Callback or function() end

				local row = newFrame(secContent, {
					BackgroundColor3 = T.ElementHov,
					BackgroundTransparency = 1,
					Size = UDim2.new(1,0,0,52),
					LayoutOrder = nextOrd(),
				})
				el._row = row

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1,-20,0,1)
				rowDiv.Position = UDim2.new(0,10,1,-1)
				rowDiv.Parent = row

				lbl(row, {
					Text = opts4.Name or "",
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(0.65,-10,0,22),
					Position = UDim2.new(0,14,0,6),
				})

				local valLbl = lbl(row, {
					Text = tostring(val),
					Font = Enum.Font.GothamSemibold,
					TextSize = 12,
					TextColor3 = T.Accent,
					Size = UDim2.new(0.35,-14,0,22),
					Position = UDim2.new(0.65,0,0,6),
					TextXAlignment = Enum.TextXAlignment.Right,
				})

				local trackBG = img(row, {
					Image = assets.sliderBar,
					ImageColor3 = Color3.fromRGB(45,45,45),
					Size = UDim2.new(1,-28,0,6),
					Position = UDim2.new(0,14,0,34),
					ScaleType = Enum.ScaleType.Stretch,
				})

				local pct = (val - min2) / math.max(max2 - min2, 0.001)

				local trackFill = img(row, {
					Image = assets.sliderBar,
					ImageColor3 = T.Accent,
					Size = UDim2.new(pct, -28*pct, 0, 6),
					Position = UDim2.new(0,14,0,34),
					ScaleType = Enum.ScaleType.Stretch,
				})

				local sliderKnob = img(row, {
					Image = assets.sliderHead,
					Size = UDim2.fromOffset(14,14),
					Position = UDim2.new(pct, 14 + pct*(-28) - 7, 0, 27),
				})

				local dragging = false
				local function updateSlider(px)
					local abs = trackBG.AbsolutePosition
					local sz  = trackBG.AbsoluteSize
					local p = math.clamp((px - abs.X) / sz.X, 0, 1)
					val = math.floor(min2 + p * (max2 - min2) + 0.5)
					p = (val - min2) / math.max(max2 - min2, 0.001)
					trackFill.Size = UDim2.new(p, -28*p, 0, 6)
					sliderKnob.Position = UDim2.new(p, 14 + p*(-28) - 7, 0, 27)
					valLbl.Text = tostring(val)
					if opts4.Flag then BloodLib.Flags[opts4.Flag] = val end
					pcall(cb, val)
				end

				trackBG.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						updateSlider(i.Position.X)
					end
				end)
				UserInputService.InputChanged:Connect(function(i)
					if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
						updateSlider(i.Position.X)
					end
				end)
				UserInputService.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				row.MouseEnter:Connect(function() tw(row, {BackgroundTransparency = 0.93}, 0.1) end)
				row.MouseLeave:Connect(function() tw(row, {BackgroundTransparency = 1}, 0.1) end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:SetMin(v) min2 = v end
				function el:SetMax(v) max2 = v end
				function el:GetValue() return val end
				function el:SliderCallback(f) cb = f end
				return el
			end

			function sec:AddDropdown(o)    return self:CreateDropdown(o)    end
			function sec:CreateDropdown(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local opts5 = opts4.Options or {}
				local sel = opts4.Default or (opts5[1] or "None")
				local open = false
				local cb = opts4.Callback or function() end

				local wrapper = newFrame(secContent, {
					BackgroundColor3 = T.ElementHov,
					BackgroundTransparency = 1,
					Size = UDim2.new(1,0,0,40),
					LayoutOrder = nextOrd(),
					ClipsDescendants = false,
				})
				el._row = wrapper

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1,-20,0,1)
				rowDiv.Position = UDim2.new(0,10,0,39)
				rowDiv.Parent = wrapper

				lbl(wrapper, {
					Text = opts4.Name or "",
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(0.45,-10,1,0),
					Position = UDim2.new(0,14,0,0),
				})

				local dropBtn = newFrame(wrapper, {
					BackgroundColor3 = Color3.fromRGB(22,22,22),
					BackgroundTransparency = 0,
					Size = UDim2.new(0.5,-12,0,28),
					Position = UDim2.new(0.5,0,0.5,-14),
				})
				corner(dropBtn, 6)
				stroke(dropBtn, T.Border, 1, 0.3)

				local selLbl = lbl(dropBtn, {
					Text = sel,
					TextSize = 12,
					TextColor3 = T.Accent,
					Size = UDim2.new(1,-24,1,0),
					Position = UDim2.new(0,8,0,0),
				})

				local arrImg = img(dropBtn, {
					Image = assets.dropArrow,
					ImageColor3 = T.TextDim,
					Size = UDim2.fromOffset(12,12),
					Position = UDim2.new(1,-18,0.5,-6),
				})

				local menu = newFrame(wrapper, {
					BackgroundColor3 = Color3.fromRGB(22,22,22),
					BackgroundTransparency = 0,
					Size = UDim2.new(0.5,-12,0,0),
					Position = UDim2.new(0.5,0,0,42),
					ClipsDescendants = true,
					ZIndex = 20,
				})
				corner(menu, 6)
				stroke(menu, T.Border, 1, 0.3)

				local menuLayout = Instance.new("UIListLayout")
				menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
				menuLayout.Parent = menu

				local optBtns = {}
				local function rebuildMenu()
					for _, b2 in ipairs(optBtns) do b2:Destroy() end
					optBtns = {}
					for i2, opt in ipairs(opts5) do
						local ob = btn(menu, {
							BackgroundColor3 = Color3.fromRGB(28,28,28),
							BackgroundTransparency = 1,
							Size = UDim2.new(1,0,0,30),
							LayoutOrder = i2,
							ZIndex = 21,
						})
						lbl(ob, {
							Text = opt,
							TextSize = 12,
							TextColor3 = T.Text,
							Size = UDim2.new(1,-16,1,0),
							Position = UDim2.new(0,8,0,0),
							ZIndex = 21,
						})
						ob.MouseEnter:Connect(function() tw(ob, {BackgroundTransparency = 0.88}, 0.1) end)
						ob.MouseLeave:Connect(function() tw(ob, {BackgroundTransparency = 1}, 0.1) end)
						ob.MouseButton1Click:Connect(function()
							sel = opt
							selLbl.Text = opt
							open = false
							tw(menu, {Size = UDim2.new(0.5,-12,0,0)}, 0.2)
							tw(arrImg, {Rotation = 0}, 0.2)
							if opts4.Flag then BloodLib.Flags[opts4.Flag] = opt end
							pcall(cb, opt)
						end)
						table.insert(optBtns, ob)
					end
				end
				rebuildMenu()

				local dbHit = btn(dropBtn, {Size = UDim2.new(1,0,1,0), ZIndex = 22})
				dbHit.MouseButton1Click:Connect(function()
					open = not open
					local h = #opts5 * 30
					tw(menu, {Size = UDim2.new(0.5,-12,0, open and math.min(h,150) or 0)}, 0.2)
					tw(arrImg, {Rotation = open and 180 or 0}, 0.2)
				end)

				wrapper.MouseEnter:Connect(function() tw(wrapper, {BackgroundTransparency = 0.93}, 0.1) end)
				wrapper.MouseLeave:Connect(function() tw(wrapper, {BackgroundTransparency = 1}, 0.1) end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:AddOption(o2)    table.insert(opts5, o2); rebuildMenu() end
				function el:RemoveOption(o2) for i2,v in ipairs(opts5) do if v==o2 then table.remove(opts5,i2) break end end rebuildMenu() end
				function el:DropdownCallback(f) cb = f end
				function el:GetValue()       return sel end
				function el:SetValue(v)      sel = v; selLbl.Text = v end
				return el
			end

			function sec:AddTextbox(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local cb = opts4.Callback or function() end

				local row = makeRow(opts4.Name or "")
				el._row = row

				local box = Instance.new("TextBox")
				box.PlaceholderText = opts4.Placeholder or "Enter text..."
				box.Text = opts4.Default or ""
				box.TextSize = 12
				box.Font = Enum.Font.Gotham
				box.TextColor3 = T.Text
				box.PlaceholderColor3 = T.TextDark
				box.BackgroundColor3 = Color3.fromRGB(22,22,22)
				box.BackgroundTransparency = 0
				box.BorderSizePixel = 0
				box.Size = UDim2.new(0.45,-12,0,26)
				box.Position = UDim2.new(0.55,0,0.5,-13)
				box.ClearTextOnFocus = false
				corner(box, 6)
				pad(box, 4,8,4,8)
				stroke(box, T.Border, 1, 0.3)
				box.Parent = row

				box.Focused:Connect(function() tw(box, {BackgroundColor3 = Color3.fromRGB(30,30,30)}, 0.15) end)
				box.FocusLost:Connect(function(e)
					tw(box, {BackgroundColor3 = Color3.fromRGB(22,22,22)}, 0.15)
					pcall(cb, box.Text, e)
				end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:SetPlaceholder(t) box.PlaceholderText = t end
				function el:GetValue()        return box.Text         end
				function el:SetValue(v)       box.Text = tostring(v)  end
				function el:TextboxCallback(f) cb = f                 end
				return el
			end

			function sec:AddLabel(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Text}

				local row = newFrame(secContent, {
					BackgroundTransparency = 1,
					Size = UDim2.new(1,0,0,32),
					LayoutOrder = nextOrd(),
				})
				el._row = row

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1,-20,0,1)
				rowDiv.Position = UDim2.new(0,10,1,-1)
				rowDiv.Parent = row

				local l2 = lbl(row, {
					Text = opts4.Text or "",
					TextSize = 13,
					TextColor3 = opts4.Color or T.TextDim,
					Size = UDim2.new(1,-24,1,0),
					Position = UDim2.new(0,14,0,0),
					TextWrapped = true,
				})

				if opts4.Right then
					l2.Size = UDim2.new(0.5,-10,1,0)
					lbl(row, {
						Text = tostring(opts4.Right),
						TextSize = 12,
						Font = Enum.Font.GothamSemibold,
						TextColor3 = opts4.RightColor or T.Accent,
						Size = UDim2.new(0.5,-14,1,0),
						Position = UDim2.new(0.5,0,0,0),
						TextXAlignment = Enum.TextXAlignment.Right,
					})
				end

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:SetText(t) l2.Text = t end
				function el:GetText()  return l2.Text end
				return el
			end

			function sec:AddParagraph(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Title}

				local wrapper2 = newFrame(secContent, {
					BackgroundTransparency = 1,
					Size = UDim2.new(1,0,0,0),
					AutomaticSize = Enum.AutomaticSize.Y,
					LayoutOrder = nextOrd(),
				})
				el._row = wrapper2

				lbl(wrapper2, {
					Text = opts4.Title or "",
					Font = Enum.Font.GothamSemibold,
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(1,-24,0,20),
					Position = UDim2.new(0,14,0,6),
				})
				lbl(wrapper2, {
					Text = opts4.Content or "",
					TextSize = 12,
					TextColor3 = T.TextDim,
					Size = UDim2.new(1,-24,0,0),
					AutomaticSize = Enum.AutomaticSize.Y,
					Position = UDim2.new(0,14,0,28),
					TextWrapped = true,
				})

				local bot = newFrame(wrapper2, {
					BackgroundColor3 = T.Border,
					BackgroundTransparency = 0.5,
					Size = UDim2.new(1,-20,0,1),
					Position = UDim2.new(0,10,1,-1),
				})

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				return el
			end

			function sec:AddDivider()
				local el = {_name = "Divider"}
				local wrapper3 = newFrame(secContent, {
					Size = UDim2.new(1,0,0,10),
					LayoutOrder = nextOrd(),
				})
				el._row = wrapper3

				local line = Instance.new("Frame")
				line.BackgroundColor3 = T.Border
				line.BorderSizePixel = 0
				line.Size = UDim2.new(1,-24,0,1)
				line.Position = UDim2.new(0,12,0.5,0)
				line.Parent = wrapper3

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				return el
			end

			function sec:AddKeybind(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local curKey = opts4.Default or Enum.KeyCode.Unknown
				local listening = false
				local cb = opts4.Callback or function() end

				local row = makeRow(opts4.Name or "")
				el._row = row

				local keyFrame = newFrame(row, {
					BackgroundColor3 = Color3.fromRGB(22,22,22),
					BackgroundTransparency = 0,
					Size = UDim2.fromOffset(100,26),
					Position = UDim2.new(1,-112,0.5,-13),
				})
				corner(keyFrame, 6)
				stroke(keyFrame, T.Border, 1, 0.3)

				local keyLbl = lbl(keyFrame, {
					Text = curKey.Name,
					TextSize = 11,
					Font = Enum.Font.GothamSemibold,
					TextColor3 = T.Accent,
					Size = UDim2.new(1,0,1,0),
					TextXAlignment = Enum.TextXAlignment.Center,
				})

				local kHit = btn(keyFrame, {Size = UDim2.new(1,0,1,0), ZIndex = 5})
				kHit.MouseButton1Click:Connect(function()
					if listening then return end
					listening = true
					keyLbl.Text = "..."
					keyLbl.TextColor3 = T.Warning
					local c
					c = UserInputService.InputBegan:Connect(function(i2, gp)
						if gp then return end
						if i2.UserInputType == Enum.UserInputType.Keyboard then
							curKey = i2.KeyCode
							keyLbl.Text = i2.KeyCode.Name
							keyLbl.TextColor3 = T.Accent
							listening = false
							c:Disconnect()
						end
					end)
				end)

				UserInputService.InputBegan:Connect(function(i2, gp)
					if gp then return end
					if i2.KeyCode == curKey then pcall(cb, curKey) end
				end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:GetValue()        return curKey     end
				function el:SetValue(k)       curKey = k; keyLbl.Text = k.Name end
				function el:KeybindCallback(f) cb = f          end
				return el
			end

			function sec:AddColorPicker(opts4)
				opts4 = opts4 or {}
				local el = {_name = opts4.Name}
				local col = opts4.Default or Color3.fromRGB(185,0,0)
				local open2 = false
				local cb = opts4.Callback or function() end

				local wrapper4 = newFrame(secContent, {
					BackgroundColor3 = T.ElementHov,
					BackgroundTransparency = 1,
					Size = UDim2.new(1,0,0,40),
					LayoutOrder = nextOrd(),
					ClipsDescendants = false,
				})
				el._row = wrapper4

				local rowDiv = Instance.new("Frame")
				rowDiv.BackgroundColor3 = T.Border
				rowDiv.BackgroundTransparency = 0.5
				rowDiv.BorderSizePixel = 0
				rowDiv.Size = UDim2.new(1,-20,0,1)
				rowDiv.Position = UDim2.new(0,10,0,39)
				rowDiv.Parent = wrapper4

				lbl(wrapper4, {
					Text = opts4.Name or "",
					TextSize = 13,
					TextColor3 = T.Text,
					Size = UDim2.new(0.6,-10,1,0),
					Position = UDim2.new(0,14,0,0),
				})

				local preview = btn(wrapper4, {
					BackgroundColor3 = col,
					BackgroundTransparency = 0,
					Size = UDim2.fromOffset(40,24),
					Position = UDim2.new(1,-52,0.5,-12),
				})
				corner(preview, 6)
				stroke(preview, T.Border, 1, 0.2)

				local picker = newFrame(wrapper4, {
					BackgroundColor3 = Color3.fromRGB(22,22,22),
					BackgroundTransparency = 0,
					Size = UDim2.new(1,-24,0,0),
					Position = UDim2.new(0,12,0,42),
					ClipsDescendants = true,
					ZIndex = 15,
				})
				corner(picker, 8)
				stroke(picker, T.Border, 1, 0.3)

				local r2,g2,b2 = col.R*255,col.G*255,col.B*255

				local function makeChannel(name2, refT, startV, yPos)
					local ch = newFrame(picker, {
						Size = UDim2.new(1,0,0,28),
						Position = UDim2.new(0,0,0,yPos),
						ZIndex = 16,
					})
					lbl(ch, {
						Text = name2,
						TextSize = 10,
						Font = Enum.Font.GothamBold,
						TextColor3 = T.TextDim,
						Size = UDim2.fromOffset(14,28),
						Position = UDim2.new(0,8,0,0),
						TextXAlignment = Enum.TextXAlignment.Center,
						ZIndex = 16,
					})
					local track2 = newFrame(ch, {
						BackgroundColor3 = Color3.fromRGB(45,45,45),
						BackgroundTransparency = 0,
						Size = UDim2.new(1,-90,0,4),
						Position = UDim2.new(0,26,0.5,-2),
						ZIndex = 16,
					})
					corner(track2, 2)
					local fill2 = newFrame(track2, {
						BackgroundColor3 = T.Accent,
						BackgroundTransparency = 0,
						Size = UDim2.new(startV/255,0,1,0),
						ZIndex = 16,
					})
					corner(fill2, 2)
					local knob2 = newFrame(track2, {
						BackgroundColor3 = Color3.fromRGB(255,255,255),
						BackgroundTransparency = 0,
						Size = UDim2.fromOffset(10,10),
						Position = UDim2.new(startV/255,0,0.5,-5),
						ZIndex = 17,
					})
					corner(knob2, 5)
					local numBox = Instance.new("TextBox")
					numBox.Text = tostring(math.floor(startV))
					numBox.TextSize = 11
					numBox.Font = Enum.Font.Gotham
					numBox.TextColor3 = T.Text
					numBox.BackgroundColor3 = Color3.fromRGB(16,16,16)
					numBox.BackgroundTransparency = 0
					numBox.BorderSizePixel = 0
					numBox.Size = UDim2.fromOffset(42,22)
					numBox.Position = UDim2.new(1,-50,0.5,-11)
					numBox.ZIndex = 16
					corner(numBox, 4)
					numBox.Parent = ch

					local drag2 = false
					track2.InputBegan:Connect(function(i2)
						if i2.UserInputType == Enum.UserInputType.MouseButton1 or i2.UserInputType == Enum.UserInputType.Touch then
							drag2 = true
						end
					end)
					UserInputService.InputChanged:Connect(function(i2)
						if drag2 and (i2.UserInputType == Enum.UserInputType.MouseMovement or i2.UserInputType == Enum.UserInputType.Touch) then
							local p = math.clamp((i2.Position.X - track2.AbsolutePosition.X)/track2.AbsoluteSize.X,0,1)
							fill2.Size = UDim2.new(p,0,1,0)
							knob2.Position = UDim2.new(p,0,0.5,-5)
							refT[1] = math.floor(p*255)
							numBox.Text = tostring(refT[1])
							col = Color3.fromRGB(r2,g2,b2)
							preview.BackgroundColor3 = col
							pcall(cb,col)
						end
					end)
					UserInputService.InputEnded:Connect(function(i2)
						if i2.UserInputType == Enum.UserInputType.MouseButton1 or i2.UserInputType == Enum.UserInputType.Touch then drag2 = false end
					end)
					return fill2, knob2, numBox, track2
				end

				local rv,gv,bv = {r2},{g2},{b2}
				makeChannel("R",rv,r2,6)
				makeChannel("G",gv,g2,38)
				makeChannel("B",bv,b2,70)

				preview.MouseButton1Click:Connect(function()
					open2 = not open2
					tw(picker, {Size = UDim2.new(1,-24,0, open2 and 108 or 0)}, 0.2)
				end)

				wrapper4.MouseEnter:Connect(function() tw(wrapper4, {BackgroundTransparency = 0.93}, 0.1) end)
				wrapper4.MouseLeave:Connect(function() tw(wrapper4, {BackgroundTransparency = 1}, 0.1) end)

				table.insert(tab._elements, el)
				table.insert(sec._elements, el)
				function el:GetValue()      return col  end
				function el:SetValue(c)     col = c; preview.BackgroundColor3 = c end
				function el:ColorCallback(f) cb = f    end
				return el
			end

			table.insert(tab._sections, sec)
			return sec
		end

		return tab
	end

	getgenv().BloodLib = win
	return win
end

return BloodLib
