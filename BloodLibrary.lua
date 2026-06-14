--[[
	╔════════════════════════════════════════════╗
	║           BLOOD LIBRARY  v1.0              ║
	║     Premium Roblox UI Framework            ║
	║     Estilo Dark Blood Red / KOD            ║
	║                                            ║
	║  Uso:                                      ║
	║   local Library = loadstring(             ║
	║     game:HttpGet("URL_DEL_GIST")           ║
	║   )()                                      ║
	║                                            ║
	║  local Window = Library.new({             ║
	║    Title = "KOD",                          ║
	║    Theme = "Blood",                        ║
	║  })                                        ║
	╚════════════════════════════════════════════╝
]]

-- ════════════════════════════════════════════════════════════════
--  SERVICES
-- ════════════════════════════════════════════════════════════════
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════════
--  UTILS
-- ════════════════════════════════════════════════════════════════
local Utils = {}

function Utils.Round(n, step)
	step = step or 1
	return math.floor(n / step + 0.5) * step
end

function Utils.Clamp(v, min, max)
	return math.max(min, math.min(max, v))
end

function Utils.Lerp(a, b, t)
	return a + (b - a) * t
end

function Utils.Tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

Utils.FAST   = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Utils.MED    = TweenInfo.new(0.30, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Utils.SLOW   = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Utils.SPRING = TweenInfo.new(0.35, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)

function Utils.New(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then inst[k] = v end
	end
	for _, child in ipairs(children or {}) do child.Parent = inst end
	if props and props.Parent then inst.Parent = props.Parent end
	return inst
end

function Utils.Corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = radius or UDim.new(0, 6)
	c.Parent = parent
	return c
end

function Utils.Stroke(parent, color, thickness, trans)
	local s = Instance.new("UIStroke")
	s.Color = color or Color3.fromRGB(60, 60, 60)
	s.Thickness = thickness or 1
	s.Transparency = trans or 0
	s.Parent = parent
	return s
end

function Utils.Padding(parent, t, r, b, l)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, t or 0)
	p.PaddingRight  = UDim.new(0, r or 0)
	p.PaddingBottom = UDim.new(0, b or 0)
	p.PaddingLeft   = UDim.new(0, l or 0)
	p.Parent = parent
	return p
end

function Utils.ListLayout(parent, axis, align, padding, sort)
	local l = Instance.new("UIListLayout")
	l.FillDirection       = axis  or Enum.FillDirection.Vertical
	l.HorizontalAlignment = align or Enum.HorizontalAlignment.Left
	l.Padding             = UDim.new(0, padding or 0)
	l.SortOrder           = sort  or Enum.SortOrder.LayoutOrder
	l.Parent = parent
	return l
end

function Utils.MakeDraggable(frame, handle)
	handle = handle or frame
	local dragging, dragStart, startPos
	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then return end
		dragging = true
		dragStart = input.Position
		startPos  = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		                           startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end)
end

function Utils.IsMobile()
	return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

function Utils.ColorToHex(c)
	return string.format("#%02X%02X%02X",
		math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
end

function Utils.Save(scope, key, value)
	pcall(function()
		game:GetService("DataStoreService"):GetDataStore(scope):SetAsync(key, value)
	end)
end

function Utils.Load(scope, key)
	local ok, val = pcall(function()
		return game:GetService("DataStoreService"):GetDataStore(scope):GetAsync(key)
	end)
	return ok and val or nil
end

-- ════════════════════════════════════════════════════════════════
--  THEMES
-- ════════════════════════════════════════════════════════════════
local Themes = {}

Themes.Blood = {
	Name="Blood",
	Background=Color3.fromRGB(10,10,12), BackgroundAlt=Color3.fromRGB(16,16,18),
	Sidebar=Color3.fromRGB(13,13,15), Card=Color3.fromRGB(20,20,22), CardHover=Color3.fromRGB(26,26,28),
	Border=Color3.fromRGB(40,10,10), BorderLight=Color3.fromRGB(55,15,15),
	Accent=Color3.fromRGB(200,20,20), AccentBright=Color3.fromRGB(230,50,50),
	AccentDim=Color3.fromRGB(140,15,15), AccentGlow=Color3.fromRGB(255,60,60),
	TextPrimary=Color3.fromRGB(240,235,235), TextSecondary=Color3.fromRGB(160,150,150),
	TextMuted=Color3.fromRGB(90,85,85), TextAccent=Color3.fromRGB(230,80,80),
	InputBg=Color3.fromRGB(16,14,14), InputBorder=Color3.fromRGB(50,20,20),
	ToggleOn=Color3.fromRGB(200,20,20), ToggleOff=Color3.fromRGB(45,40,40),
	SliderBg=Color3.fromRGB(30,25,25), SliderFill=Color3.fromRGB(200,20,20), SliderKnob=Color3.fromRGB(255,255,255),
	TabActive=Color3.fromRGB(200,20,20), TabInactive=Color3.fromRGB(0,0,0),
	TabHover=Color3.fromRGB(30,12,12), TabText=Color3.fromRGB(240,235,235), TabTextInactive=Color3.fromRGB(130,120,120),
	BtnPrimary=Color3.fromRGB(200,20,20), BtnPrimaryHover=Color3.fromRGB(230,40,40),
	BtnSecondary=Color3.fromRGB(30,28,28), BtnSecHover=Color3.fromRGB(40,38,38),
	NotifBg=Color3.fromRGB(18,16,16), SearchBg=Color3.fromRGB(16,14,14), ProfileBg=Color3.fromRGB(16,14,14),
	DividerColor=Color3.fromRGB(40,15,15), StatusOnline=Color3.fromRGB(50,200,90),
	StatusOffline=Color3.fromRGB(180,50,50), SectionTitle=Color3.fromRGB(200,20,20),
	Font=Enum.Font.GothamSemibold, FontBold=Enum.Font.GothamBlack, FontMono=Enum.Font.Code,
	Radius=UDim.new(0,6), RadiusFull=UDim.new(1,0), Padding=10, Scale=1,
}

Themes.Dark = {
	Name="Dark",
	Background=Color3.fromRGB(12,12,14), BackgroundAlt=Color3.fromRGB(18,18,20),
	Sidebar=Color3.fromRGB(14,14,16), Card=Color3.fromRGB(22,22,24), CardHover=Color3.fromRGB(28,28,30),
	Border=Color3.fromRGB(35,35,40), BorderLight=Color3.fromRGB(50,50,55),
	Accent=Color3.fromRGB(80,140,255), AccentBright=Color3.fromRGB(100,160,255),
	AccentDim=Color3.fromRGB(50,100,200), AccentGlow=Color3.fromRGB(120,180,255),
	TextPrimary=Color3.fromRGB(240,240,245), TextSecondary=Color3.fromRGB(160,160,170),
	TextMuted=Color3.fromRGB(90,90,100), TextAccent=Color3.fromRGB(100,160,255),
	InputBg=Color3.fromRGB(15,15,18), InputBorder=Color3.fromRGB(45,45,55),
	ToggleOn=Color3.fromRGB(80,140,255), ToggleOff=Color3.fromRGB(45,45,50),
	SliderBg=Color3.fromRGB(30,30,35), SliderFill=Color3.fromRGB(80,140,255), SliderKnob=Color3.fromRGB(255,255,255),
	TabActive=Color3.fromRGB(80,140,255), TabInactive=Color3.fromRGB(0,0,0),
	TabHover=Color3.fromRGB(25,30,40), TabText=Color3.fromRGB(240,240,245), TabTextInactive=Color3.fromRGB(120,120,130),
	BtnPrimary=Color3.fromRGB(80,140,255), BtnPrimaryHover=Color3.fromRGB(100,160,255),
	BtnSecondary=Color3.fromRGB(30,30,35), BtnSecHover=Color3.fromRGB(40,40,45),
	NotifBg=Color3.fromRGB(20,20,24), SearchBg=Color3.fromRGB(15,15,18), ProfileBg=Color3.fromRGB(16,16,19),
	DividerColor=Color3.fromRGB(35,35,42), StatusOnline=Color3.fromRGB(50,200,90),
	StatusOffline=Color3.fromRGB(180,50,50), SectionTitle=Color3.fromRGB(80,140,255),
	Font=Enum.Font.GothamSemibold, FontBold=Enum.Font.GothamBlack, FontMono=Enum.Font.Code,
	Radius=UDim.new(0,6), RadiusFull=UDim.new(1,0), Padding=10, Scale=1,
}

Themes.Neon = {
	Name="Neon",
	Background=Color3.fromRGB(5,5,10), BackgroundAlt=Color3.fromRGB(10,10,18),
	Sidebar=Color3.fromRGB(7,7,14), Card=Color3.fromRGB(14,14,22), CardHover=Color3.fromRGB(20,20,30),
	Border=Color3.fromRGB(20,5,50), BorderLight=Color3.fromRGB(50,10,100),
	Accent=Color3.fromRGB(160,0,255), AccentBright=Color3.fromRGB(190,50,255),
	AccentDim=Color3.fromRGB(100,0,180), AccentGlow=Color3.fromRGB(210,100,255),
	TextPrimary=Color3.fromRGB(230,220,255), TextSecondary=Color3.fromRGB(150,140,180),
	TextMuted=Color3.fromRGB(80,70,110), TextAccent=Color3.fromRGB(190,100,255),
	InputBg=Color3.fromRGB(10,8,18), InputBorder=Color3.fromRGB(50,15,100),
	ToggleOn=Color3.fromRGB(160,0,255), ToggleOff=Color3.fromRGB(35,30,55),
	SliderBg=Color3.fromRGB(25,20,40), SliderFill=Color3.fromRGB(160,0,255), SliderKnob=Color3.fromRGB(255,255,255),
	TabActive=Color3.fromRGB(160,0,255), TabInactive=Color3.fromRGB(0,0,0),
	TabHover=Color3.fromRGB(25,15,40), TabText=Color3.fromRGB(230,220,255), TabTextInactive=Color3.fromRGB(110,100,140),
	BtnPrimary=Color3.fromRGB(160,0,255), BtnPrimaryHover=Color3.fromRGB(190,50,255),
	BtnSecondary=Color3.fromRGB(25,20,40), BtnSecHover=Color3.fromRGB(35,28,55),
	NotifBg=Color3.fromRGB(14,12,22), SearchBg=Color3.fromRGB(10,8,18), ProfileBg=Color3.fromRGB(12,10,20),
	DividerColor=Color3.fromRGB(35,15,65), StatusOnline=Color3.fromRGB(50,255,150),
	StatusOffline=Color3.fromRGB(200,50,80), SectionTitle=Color3.fromRGB(160,0,255),
	Font=Enum.Font.GothamSemibold, FontBold=Enum.Font.GothamBlack, FontMono=Enum.Font.Code,
	Radius=UDim.new(0,6), RadiusFull=UDim.new(1,0), Padding=10, Scale=1,
}

Themes.Midnight = {
	Name="Midnight",
	Background=Color3.fromRGB(8,10,20), BackgroundAlt=Color3.fromRGB(12,15,28),
	Sidebar=Color3.fromRGB(10,12,22), Card=Color3.fromRGB(16,20,35), CardHover=Color3.fromRGB(22,27,45),
	Border=Color3.fromRGB(30,35,65), BorderLight=Color3.fromRGB(45,55,90),
	Accent=Color3.fromRGB(65,130,255), AccentBright=Color3.fromRGB(90,160,255),
	AccentDim=Color3.fromRGB(40,90,180), AccentGlow=Color3.fromRGB(120,190,255),
	TextPrimary=Color3.fromRGB(220,225,245), TextSecondary=Color3.fromRGB(140,150,185),
	TextMuted=Color3.fromRGB(80,90,120), TextAccent=Color3.fromRGB(100,165,255),
	InputBg=Color3.fromRGB(10,12,24), InputBorder=Color3.fromRGB(40,50,90),
	ToggleOn=Color3.fromRGB(65,130,255), ToggleOff=Color3.fromRGB(35,40,70),
	SliderBg=Color3.fromRGB(25,30,55), SliderFill=Color3.fromRGB(65,130,255), SliderKnob=Color3.fromRGB(255,255,255),
	TabActive=Color3.fromRGB(65,130,255), TabInactive=Color3.fromRGB(0,0,0),
	TabHover=Color3.fromRGB(20,28,50), TabText=Color3.fromRGB(220,225,245), TabTextInactive=Color3.fromRGB(110,120,160),
	BtnPrimary=Color3.fromRGB(65,130,255), BtnPrimaryHover=Color3.fromRGB(90,155,255),
	BtnSecondary=Color3.fromRGB(22,27,48), BtnSecHover=Color3.fromRGB(30,38,62),
	NotifBg=Color3.fromRGB(14,18,32), SearchBg=Color3.fromRGB(10,13,24), ProfileBg=Color3.fromRGB(12,15,28),
	DividerColor=Color3.fromRGB(30,38,70), StatusOnline=Color3.fromRGB(60,210,110),
	StatusOffline=Color3.fromRGB(190,60,60), SectionTitle=Color3.fromRGB(65,130,255),
	Font=Enum.Font.GothamSemibold, FontBold=Enum.Font.GothamBlack, FontMono=Enum.Font.Code,
	Radius=UDim.new(0,6), RadiusFull=UDim.new(1,0), Padding=10, Scale=1,
}

function Themes.Get(name) return Themes[name] or Themes.Blood end
function Themes.List() return {"Blood","Dark","Neon","Midnight"} end
function Themes.Merge(base, over)
	local r = {}
	for k,v in pairs(base) do r[k]=v end
	for k,v in pairs(over or {}) do r[k]=v end
	return r
end

-- ════════════════════════════════════════════════════════════════
--  WINDOW
-- ════════════════════════════════════════════════════════════════
local Window = {}
Window.__index = Window

function Window.new(options, theme, library)
	local self = setmetatable({}, Window)
	self.Library   = library
	self.Theme     = theme
	self.Minimized = false
	self.Visible   = true

	local title     = options.Title    or "BLOOD LIBRARY"
	local logo      = options.Logo     or "rbxassetid://72559578724301"
	local subtitle  = options.Subtitle or ""
	local size      = options.Size     or UDim2.new(0, 640, 0, 470)
	local draggable = options.Draggable ~= false
	local T         = theme

	local gui = Instance.new("ScreenGui")
	gui.Name           = "BloodLibrary"
	gui.ResetOnSpawn   = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.IgnoreGuiInset = true
	pcall(function() gui.Parent = game:GetService("CoreGui") end)
	if not gui.Parent then gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end
	self.ScreenGui = gui

	Utils.New("ImageLabel",{Name="Shadow",Size=UDim2.new(0,size.X.Offset+60,0,size.Y.Offset+60),
		Position=UDim2.new(0.5,-(size.X.Offset+60)/2,0.5,-(size.Y.Offset+60)/2),
		BackgroundTransparency=1,Image="rbxassetid://6015897843",ImageColor3=Color3.new(0,0,0),
		ImageTransparency=0.55,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),
		ZIndex=8,Parent=gui})

	local main = Utils.New("Frame",{Name="Main",Size=UDim2.new(0,0,0,0),
		Position=UDim2.new(0.5,-size.X.Offset/2,0.5,-size.Y.Offset/2),
		BackgroundColor3=T.Background,BorderSizePixel=0,ClipsDescendants=true,ZIndex=10,Parent=gui})
	Utils.Corner(main,T.Radius); Utils.Stroke(main,T.Border,1)
	self.Main = main
	Utils.Tween(main, Utils.SPRING, {Size=size})

	local sidebarW = Utils.IsMobile() and 110 or 155
	local sidebar = Utils.New("Frame",{Name="Sidebar",Size=UDim2.new(0,sidebarW,1,0),
		BackgroundColor3=T.Sidebar,BorderSizePixel=0,ZIndex=12,Parent=main})
	Utils.Corner(sidebar,T.Radius); self.Sidebar = sidebar
	Utils.New("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,0,0,0),
		BackgroundColor3=T.Border,BorderSizePixel=0,ZIndex=13,Parent=sidebar})

	local logoZone = Utils.New("Frame",{Name="LogoZone",Size=UDim2.new(1,0,0,72),
		BackgroundTransparency=1,ZIndex=13,Parent=sidebar})
	if logo ~= "" then
		Utils.New("ImageLabel",{Name="Logo",Size=UDim2.new(0,36,0,36),Position=UDim2.new(0.5,-18,0,10),
			BackgroundTransparency=1,Image=logo,ZIndex=14,Parent=logoZone})
	end
	Utils.New("TextLabel",{Name="LibTitle",Size=UDim2.new(1,0,0,18),
		Position=UDim2.new(0,0,0,logo~="" and 50 or 18),BackgroundTransparency=1,
		Text=title,TextColor3=T.Accent,Font=T.FontBold,TextSize=13,ZIndex=14,Parent=logoZone})
	Utils.New("Frame",{Size=UDim2.new(1,-20,0,1),Position=UDim2.new(0,10,1,-1),
		BackgroundColor3=T.Border,BorderSizePixel=0,ZIndex=13,Parent=logoZone})

	local tabList = Utils.New("ScrollingFrame",{Name="TabList",Size=UDim2.new(1,0,1,-130),
		Position=UDim2.new(0,0,0,72),BackgroundTransparency=1,BorderSizePixel=0,
		ScrollBarThickness=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
		ZIndex=13,Parent=sidebar})
	Utils.ListLayout(tabList,Enum.FillDirection.Vertical,nil,3)
	Utils.Padding(tabList,6,8,6,8)
	self.TabList = tabList

	local profileZone = Utils.New("Frame",{Name="ProfileZone",Size=UDim2.new(1,0,0,58),
		Position=UDim2.new(0,0,1,-58),BackgroundColor3=T.ProfileBg,BorderSizePixel=0,
		ZIndex=13,Parent=sidebar})
	Utils.Corner(profileZone,T.Radius)
	Utils.New("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=T.Border,BorderSizePixel=0,
		ZIndex=12,Parent=profileZone})
	self.ProfileZone = profileZone
	self:BuildProfile(profileZone, T)

	local rightPane = Utils.New("Frame",{Name="RightPane",Size=UDim2.new(1,-sidebarW,1,0),
		Position=UDim2.new(0,sidebarW,0,0),BackgroundColor3=T.Background,BorderSizePixel=0,
		ZIndex=11,Parent=main})
	self.RightPane = rightPane

	local titleBar = Utils.New("Frame",{Name="TitleBar",Size=UDim2.new(1,0,0,48),
		BackgroundColor3=T.BackgroundAlt,BorderSizePixel=0,ZIndex=14,Parent=rightPane})
	self.TitleBar = titleBar
	Utils.New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),
		BackgroundColor3=T.Border,BorderSizePixel=0,ZIndex=14,Parent=titleBar})

	local searchFrame = Utils.New("Frame",{Name="SearchFrame",Size=UDim2.new(1,-90,0,28),
		Position=UDim2.new(0,12,0.5,-14),BackgroundColor3=T.SearchBg,BorderSizePixel=0,
		ZIndex=15,Parent=titleBar})
	Utils.Corner(searchFrame,T.Radius); Utils.Stroke(searchFrame,T.InputBorder,1)
	Utils.New("ImageLabel",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,8,0.5,-7),
		BackgroundTransparency=1,Image="rbxassetid://3926305904",ImageColor3=T.TextMuted,
		ZIndex=16,Parent=searchFrame})
	local searchBox = Utils.New("TextBox",{Name="SearchBox",Size=UDim2.new(1,-30,1,0),
		Position=UDim2.new(0,28,0,0),BackgroundTransparency=1,Text="",PlaceholderText="Buscar...",
		TextColor3=T.TextPrimary,PlaceholderColor3=T.TextMuted,Font=T.Font,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ZIndex=16,Parent=searchFrame})
	self.SearchBox = searchBox

	local minBtn = Utils.New("TextButton",{Name="MinBtn",Size=UDim2.new(0,26,0,26),
		Position=UDim2.new(1,-58,0.5,-13),BackgroundColor3=T.BtnSecondary,BorderSizePixel=0,
		Text="—",TextColor3=T.TextSecondary,Font=T.Font,TextSize=13,AutoButtonColor=false,
		ZIndex=15,Parent=titleBar})
	Utils.Corner(minBtn,T.Radius)
	minBtn.MouseEnter:Connect(function() Utils.Tween(minBtn,Utils.FAST,{BackgroundColor3=T.BtnSecHover,TextColor3=T.TextPrimary}) end)
	minBtn.MouseLeave:Connect(function() Utils.Tween(minBtn,Utils.FAST,{BackgroundColor3=T.BtnSecondary,TextColor3=T.TextSecondary}) end)
	minBtn.MouseButton1Click:Connect(function() self:ToggleMinimize() end)

	local closeBtn = Utils.New("TextButton",{Name="CloseBtn",Size=UDim2.new(0,26,0,26),
		Position=UDim2.new(1,-28,0.5,-13),BackgroundColor3=T.Accent,BorderSizePixel=0,
		Text="✕",TextColor3=Color3.fromRGB(255,255,255),Font=T.FontBold,TextSize=12,
		AutoButtonColor=false,ZIndex=15,Parent=titleBar})
	Utils.Corner(closeBtn,T.Radius)
	closeBtn.MouseEnter:Connect(function() Utils.Tween(closeBtn,Utils.FAST,{BackgroundColor3=T.AccentBright}) end)
	closeBtn.MouseLeave:Connect(function() Utils.Tween(closeBtn,Utils.FAST,{BackgroundColor3=T.Accent}) end)
	closeBtn.MouseButton1Click:Connect(function() self:Close() end)

	local pageHeader = Utils.New("Frame",{Name="PageHeader",Size=UDim2.new(1,0,0,42),
		Position=UDim2.new(0,0,0,48),BackgroundTransparency=1,ZIndex=14,Parent=rightPane})
	Utils.Padding(pageHeader,0,12,0,14)
	self.PageTitle = Utils.New("TextLabel",{Name="PageTitle",Size=UDim2.new(1,0,0,22),
		Position=UDim2.new(0,0,0,4),BackgroundTransparency=1,Text="Main",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=17,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=15,Parent=pageHeader})
	self.PageSubtitle = Utils.New("TextLabel",{Name="PageSubtitle",Size=UDim2.new(1,0,0,14),
		Position=UDim2.new(0,0,0,26),BackgroundTransparency=1,Text=subtitle,TextColor3=T.Accent,
		Font=T.Font,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=15,Parent=pageHeader})

	local contentScroll = Utils.New("ScrollingFrame",{Name="ContentScroll",
		Size=UDim2.new(1,0,1,-112),Position=UDim2.new(0,0,0,90),BackgroundTransparency=1,
		BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=T.Accent,
		CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.None,
		ZIndex=13,Parent=rightPane})
	self.ContentScroll = contentScroll

	if draggable then
		Utils.MakeDraggable(main, titleBar)
		Utils.MakeDraggable(main, logoZone)
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		self:FilterElements(searchBox.Text:lower())
	end)

	return self
end

function Window:BuildProfile(zone, T)
	local player = Players.LocalPlayer
	local avatarFrame = Utils.New("Frame",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(0,10,0.5,-16),
		BackgroundColor3=T.Card,BorderSizePixel=0,ZIndex=14,Parent=zone})
	Utils.Corner(avatarFrame, UDim.new(1,0))
	local img = Instance.new("ImageLabel")
	img.Size=UDim2.new(1,0,1,0); img.BackgroundTransparency=1
	img.Image="https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=48&height=48&format=png"
	img.ZIndex=15; Utils.Corner(img, UDim.new(1,0)); img.Parent=avatarFrame

	Utils.New("TextLabel",{Size=UDim2.new(1,-58,0,16),Position=UDim2.new(0,48,0,12),
		BackgroundTransparency=1,Text=player.DisplayName or player.Name,TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,
		TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=14,Parent=zone})
	local statusRow = Utils.New("Frame",{Size=UDim2.new(1,-58,0,14),Position=UDim2.new(0,48,0,30),
		BackgroundTransparency=1,ZIndex=14,Parent=zone})
	local dot = Utils.New("Frame",{Size=UDim2.new(0,7,0,7),Position=UDim2.new(0,0,0.5,-3),
		BackgroundColor3=self.Theme.StatusOnline,BorderSizePixel=0,ZIndex=15,Parent=statusRow})
	Utils.Corner(dot, UDim.new(1,0))
	Utils.New("TextLabel",{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,12,0,0),
		BackgroundTransparency=1,Text="Conectado",TextColor3=self.Theme.StatusOnline,
		Font=self.Theme.Font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=15,Parent=statusRow})
end

function Window:FilterElements(query)
	if not self.ContentScroll then return end
	for _, child in ipairs(self.ContentScroll:GetChildren()) do
		if child:IsA("Frame") and child.Visible then
			for _, sub in ipairs(child:GetDescendants()) do
				if sub:IsA("Frame") then
					local lbl = sub:FindFirstChildOfClass("TextLabel")
					if lbl then
						sub.Visible = query=="" or lbl.Text:lower():find(query,1,true) ~= nil
					end
				end
			end
		end
	end
end

function Window:ToggleMinimize()
	self.Minimized = not self.Minimized
	if self.Minimized then
		self.RightPane.Visible = false
		Utils.Tween(self.Main,Utils.MED,{Size=UDim2.new(0,self.Sidebar.AbsoluteSize.X,0,self.Main.AbsoluteSize.Y)})
	else
		self.RightPane.Visible = true
		Utils.Tween(self.Main,Utils.MED,{Size=UDim2.new(0,640,0,470)})
	end
end

function Window:Close()
	Utils.Tween(self.Main,Utils.MED,{Size=UDim2.new(0,0,0,0)})
	task.delay(0.35, function() self.ScreenGui:Destroy() end)
end

function Window:SetTitle(text, subtitle)
	self.PageTitle.Text = text
	if subtitle then self.PageSubtitle.Text = subtitle end
end

function Window:SetVisible(v) self.Main.Visible = v end

-- ════════════════════════════════════════════════════════════════
--  ELEMENTS
-- ════════════════════════════════════════════════════════════════
local Elements = {}
Elements.__index = Elements

local function makeCard(T, parent, h, autoY)
	local f = Utils.New("Frame",{Size=autoY and UDim2.new(1,0,0,0) or UDim2.new(1,0,0,h or 42),
		BackgroundColor3=T.Card,BorderSizePixel=0,
		AutomaticSize=autoY and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,Parent=parent})
	Utils.Corner(f,T.Radius); Utils.Stroke(f,T.Border,1)
	return f
end

function Elements:Button(opts)
	opts=opts or {}; local T=self.Theme
	local card=makeCard(T,self.Container,40)
	Utils.New("TextLabel",{Size=UDim2.new(1,-90,0,18),Position=UDim2.new(0,12,0,4),
		BackgroundTransparency=1,Text=opts.Text or "Button",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	Utils.New("TextLabel",{Size=UDim2.new(1,-90,0,14),Position=UDim2.new(0,12,0,22),
		BackgroundTransparency=1,Text=opts.Description or "",TextColor3=T.TextMuted,
		Font=T.Font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	local execBtn=Utils.New("TextButton",{Size=UDim2.new(0,70,0,26),Position=UDim2.new(1,-78,0.5,-13),
		BackgroundColor3=T.BtnPrimary,BorderSizePixel=0,Text=opts.ButtonText or "Ejecutar",
		TextColor3=Color3.fromRGB(255,255,255),Font=T.FontBold,TextSize=11,AutoButtonColor=false,ZIndex=5,Parent=card})
	Utils.Corner(execBtn,T.Radius)
	execBtn.MouseEnter:Connect(function() Utils.Tween(execBtn,Utils.FAST,{BackgroundColor3=T.BtnPrimaryHover}) end)
	execBtn.MouseLeave:Connect(function() Utils.Tween(execBtn,Utils.FAST,{BackgroundColor3=T.BtnPrimary}) end)
	execBtn.MouseButton1Click:Connect(function()
		Utils.Tween(execBtn,TweenInfo.new(0.06),{Size=UDim2.new(0,65,0,24)})
		task.delay(0.1,function() Utils.Tween(execBtn,TweenInfo.new(0.12),{Size=UDim2.new(0,70,0,26)}) end)
		if opts.Callback then pcall(opts.Callback) end
	end)
	card.MouseEnter:Connect(function() Utils.Tween(card,Utils.FAST,{BackgroundColor3=T.CardHover}) end)
	card.MouseLeave:Connect(function() Utils.Tween(card,Utils.FAST,{BackgroundColor3=T.Card}) end)
	return {Instance=card}
end

function Elements:Toggle(opts)
	opts=opts or{}; local T=self.Theme; local toggled=opts.Default==true
	local card=makeCard(T,self.Container,40)
	Utils.New("TextLabel",{Size=UDim2.new(1,-70,0,18),Position=UDim2.new(0,12,0,5),
		BackgroundTransparency=1,Text=opts.Text or "Toggle",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	Utils.New("TextLabel",{Size=UDim2.new(1,-70,0,13),Position=UDim2.new(0,12,0,23),
		BackgroundTransparency=1,Text=opts.Description or "",TextColor3=T.TextMuted,
		Font=T.Font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	local pill=Utils.New("Frame",{Size=UDim2.new(0,44,0,24),Position=UDim2.new(1,-54,0.5,-12),
		BackgroundColor3=toggled and T.ToggleOn or T.ToggleOff,BorderSizePixel=0,ZIndex=5,Parent=card})
	Utils.Corner(pill,UDim.new(1,0))
	local knob=Utils.New("Frame",{Size=UDim2.new(0,18,0,18),
		Position=toggled and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
		BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=6,Parent=pill})
	Utils.Corner(knob,UDim.new(1,0))
	local hit=Utils.New("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=7,Parent=card})
	local function refresh(anim)
		local c=toggled and T.ToggleOn or T.ToggleOff
		local kp=toggled and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
		if anim then Utils.Tween(pill,Utils.FAST,{BackgroundColor3=c}); Utils.Tween(knob,Utils.FAST,{Position=kp})
		else pill.BackgroundColor3=c; knob.Position=kp end
	end
	hit.MouseButton1Click:Connect(function() toggled=not toggled; refresh(true); if opts.Callback then pcall(opts.Callback,toggled) end end)
	card.MouseEnter:Connect(function() Utils.Tween(card,Utils.FAST,{BackgroundColor3=T.CardHover}) end)
	card.MouseLeave:Connect(function() Utils.Tween(card,Utils.FAST,{BackgroundColor3=T.Card}) end)
	refresh(false)
	return {Instance=card, GetValue=function() return toggled end, SetValue=function(v) toggled=v; refresh(true) end}
end

function Elements:Slider(opts)
	opts=opts or{}; local T=self.Theme
	local min=opts.Min or 0; local max=opts.Max or 100
	local val=Utils.Clamp(opts.Default or min,min,max); local suf=opts.Suffix or ""
	local card=makeCard(T,self.Container,52)
	Utils.New("TextLabel",{Size=UDim2.new(1,-70,0,16),Position=UDim2.new(0,12,0,6),
		BackgroundTransparency=1,Text=opts.Text or "Slider",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	local valueL=Utils.New("TextLabel",{Size=UDim2.new(0,55,0,16),Position=UDim2.new(1,-62,0,6),
		BackgroundTransparency=1,Text=tostring(val)..suf,TextColor3=T.TextAccent,
		Font=T.FontBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=4,Parent=card})
	local track=Utils.New("Frame",{Size=UDim2.new(1,-24,0,6),Position=UDim2.new(0,12,0,32),
		BackgroundColor3=T.SliderBg,BorderSizePixel=0,ZIndex=4,Parent=card})
	Utils.Corner(track,UDim.new(1,0))
	local fill=Utils.New("Frame",{Size=UDim2.new((val-min)/(max-min),0,1,0),
		BackgroundColor3=T.SliderFill,BorderSizePixel=0,ZIndex=5,Parent=track})
	Utils.Corner(fill,UDim.new(1,0))
	local knob=Utils.New("Frame",{Size=UDim2.new(0,12,0,12),
		Position=UDim2.new((val-min)/(max-min),-6,0.5,-6),
		BackgroundColor3=T.SliderKnob,BorderSizePixel=0,ZIndex=6,Parent=track})
	Utils.Corner(knob,UDim.new(1,0)); Utils.Stroke(knob,T.Accent,2)
	local hit=Utils.New("TextButton",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,-10),
		BackgroundTransparency=1,Text="",ZIndex=7,Parent=track})
	local dragging=false
	local function setVal(nx)
		local pct=Utils.Clamp(nx,0,1)
		val=Utils.Round(min+(max-min)*pct)
		fill.Size=UDim2.new(pct,0,1,0); knob.Position=UDim2.new(pct,-6,0.5,-6)
		valueL.Text=tostring(val)..suf
	end
	hit.MouseButton1Down:Connect(function() dragging=true end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			if dragging then dragging=false; if opts.Callback then pcall(opts.Callback,val) end end
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if not dragging then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local abs=track.AbsoluteSize.X; if abs==0 then return end
		setVal((i.Position.X-track.AbsolutePosition.X)/abs)
	end)
	setVal((val-min)/(max-min))
	return {Instance=card, GetValue=function() return val end,
		SetValue=function(v) setVal((Utils.Clamp(v,min,max)-min)/(max-min)) end}
end

function Elements:Dropdown(opts)
	opts=opts or{}; local T=self.Theme
	local items=opts.Items or{}; local multi=opts.Multi or false
	local sel=multi and {} or (opts.Default or nil); local isOpen=false
	if multi then for _,v in ipairs(opts.Default or {}) do sel[v]=true end end
	local wrapper=Utils.New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundTransparency=1,
		ClipsDescendants=false,ZIndex=20,Parent=self.Container})
	local card=makeCard(T,wrapper,40); card.ClipsDescendants=false; card.ZIndex=20
	Utils.New("TextLabel",{Size=UDim2.new(1,-80,0,40),Position=UDim2.new(0,12,0,0),
		BackgroundTransparency=1,Text=opts.Text or "Dropdown",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=21,Parent=card})
	local selectedL=Utils.New("TextLabel",{Size=UDim2.new(0,100,0,40),Position=UDim2.new(1,-140,0,0),
		BackgroundTransparency=1,Text=multi and "0 elegido" or (sel or "Elegir"),
		TextColor3=T.TextAccent,Font=T.Font,TextSize=11,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=21,Parent=card})
	local arrow=Utils.New("TextLabel",{Size=UDim2.new(0,20,0,40),Position=UDim2.new(1,-24,0,0),
		BackgroundTransparency=1,Text="▾",TextColor3=T.TextMuted,Font=T.Font,TextSize=14,ZIndex=21,Parent=card})
	local panel=Utils.New("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,4),
		BackgroundColor3=T.BackgroundAlt,BorderSizePixel=0,ClipsDescendants=true,ZIndex=30,Parent=card})
	Utils.Corner(panel,T.Radius); Utils.Stroke(panel,T.Border,1)
	local searchBg=Utils.New("Frame",{Size=UDim2.new(1,-12,0,26),Position=UDim2.new(0,6,0,6),
		BackgroundColor3=T.SearchBg,BorderSizePixel=0,ZIndex=31,Parent=panel})
	Utils.Corner(searchBg,T.Radius)
	local searchBox=Utils.New("TextBox",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
		BackgroundTransparency=1,Text="",PlaceholderText="Buscar...",TextColor3=T.TextPrimary,
		PlaceholderColor3=T.TextMuted,Font=T.Font,TextSize=11,ClearTextOnFocus=false,ZIndex=32,Parent=searchBg})
	local itemScroll=Utils.New("ScrollingFrame",{Size=UDim2.new(1,-12,1,-40),Position=UDim2.new(0,6,0,36),
		BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=T.Accent,
		CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ZIndex=31,Parent=panel})
	Utils.ListLayout(itemScroll,nil,nil,3)
	local itemBtns={}
	local function updateLabel()
		if multi then
			local count=0; for _,v in pairs(sel) do if v then count+=1 end end
			selectedL.Text=count==0 and "0 elegido" or (count.." elegido"..(count>1 and "s" or ""))
		else selectedL.Text=sel or "Elegir" end
	end
	local function rebuildItems(filter)
		for _,b in ipairs(itemBtns) do b:Destroy() end; itemBtns={}
		local f=(filter or ""):lower()
		for _,item in ipairs(items) do
			local iStr=tostring(item)
			if f~="" and not iStr:lower():find(f,1,true) then continue end
			local isAct=multi and sel[item] or (sel==item)
			local row=Utils.New("TextButton",{Size=UDim2.new(1,0,0,28),BackgroundColor3=isAct and T.BtnPrimary or T.Card,
				BorderSizePixel=0,Text=iStr,TextColor3=isAct and Color3.fromRGB(255,255,255) or T.TextPrimary,
				Font=T.Font,TextSize=12,AutoButtonColor=false,ZIndex=32,Parent=itemScroll})
			Utils.Corner(row,UDim.new(0,4))
			row.MouseEnter:Connect(function()
				if not(multi and sel[item] or sel==item) then Utils.Tween(row,Utils.FAST,{BackgroundColor3=T.CardHover}) end
			end)
			row.MouseLeave:Connect(function()
				local a=multi and sel[item] or sel==item
				Utils.Tween(row,Utils.FAST,{BackgroundColor3=a and T.BtnPrimary or T.Card})
			end)
			row.MouseButton1Click:Connect(function()
				if multi then
					sel[item]=not sel[item]
					row.BackgroundColor3=sel[item] and T.BtnPrimary or T.Card
					row.TextColor3=sel[item] and Color3.fromRGB(255,255,255) or T.TextPrimary
				else
					sel=item
					for _,b in ipairs(itemBtns) do b.BackgroundColor3=T.Card; b.TextColor3=T.TextPrimary end
					row.BackgroundColor3=T.BtnPrimary; row.TextColor3=Color3.fromRGB(255,255,255)
				end
				updateLabel()
				if opts.Callback then
					if multi then local l={}; for k,v in pairs(sel) do if v then table.insert(l,k) end end; pcall(opts.Callback,l)
					else pcall(opts.Callback,sel) end
				end
			end)
			table.insert(itemBtns,row)
		end
	end
	rebuildItems()
	searchBox:GetPropertyChangedSignal("Text"):Connect(function() rebuildItems(searchBox.Text) end)
	local dropH=math.min(#items*31+44,200)
	local hitBtn=Utils.New("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=22,Parent=card})
	hitBtn.MouseButton1Click:Connect(function()
		isOpen=not isOpen; local ph=isOpen and dropH or 0
		Utils.Tween(panel,Utils.MED,{Size=UDim2.new(1,0,0,ph)})
		Utils.Tween(wrapper,Utils.MED,{Size=UDim2.new(1,0,0,isOpen and 40+ph+4 or 40)})
		arrow.Text=isOpen and "▴" or "▾"
	end)
	updateLabel()
	return {Instance=wrapper, GetValue=function()
		if multi then local l={}; for k,v in pairs(sel) do if v then table.insert(l,k) end end; return l end
		return sel
	end, SetValue=function(v) sel=v; updateLabel() end}
end

function Elements:Textbox(opts)
	opts=opts or{}; local T=self.Theme
	local card=makeCard(T,self.Container,52)
	Utils.New("TextLabel",{Size=UDim2.new(1,-16,0,16),Position=UDim2.new(0,12,0,6),
		BackgroundTransparency=1,Text=opts.Text or "Input",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	local inputBg=Utils.New("Frame",{Size=UDim2.new(1,-24,0,24),Position=UDim2.new(0,12,0,24),
		BackgroundColor3=T.InputBg,BorderSizePixel=0,ZIndex=4,Parent=card})
	Utils.Corner(inputBg,T.Radius); local stroke=Utils.Stroke(inputBg,T.InputBorder,1)
	local box=Utils.New("TextBox",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
		BackgroundTransparency=1,Text=opts.Default or "",PlaceholderText=opts.Placeholder or "Escribe aquí...",
		TextColor3=T.TextPrimary,PlaceholderColor3=T.TextMuted,Font=T.Font,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ZIndex=5,Parent=inputBg})
	box.Focused:Connect(function() Utils.Tween(stroke,Utils.FAST,{Color=T.Accent}) end)
	box.FocusLost:Connect(function(enter)
		Utils.Tween(stroke,Utils.FAST,{Color=T.InputBorder})
		if opts.Callback then pcall(opts.Callback,box.Text,enter) end
	end)
	return {Instance=card, GetValue=function() return box.Text end, SetValue=function(v) box.Text=v end}
end

function Elements:Keybind(opts)
	opts=opts or{}; local T=self.Theme
	local key=opts.Default or Enum.KeyCode.Unknown; local listening=false
	local card=makeCard(T,self.Container,40)
	Utils.New("TextLabel",{Size=UDim2.new(1,-100,0,40),Position=UDim2.new(0,12,0,0),
		BackgroundTransparency=1,Text=opts.Text or "Tecla",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=card})
	local keyBadge=Utils.New("TextButton",{Size=UDim2.new(0,80,0,26),Position=UDim2.new(1,-88,0.5,-13),
		BackgroundColor3=T.BtnSecondary,BorderSizePixel=0,
		Text=key==Enum.KeyCode.Unknown and "Ninguna" or key.Name,TextColor3=T.TextAccent,
		Font=T.FontBold,TextSize=11,AutoButtonColor=false,ZIndex=5,Parent=card})
	Utils.Corner(keyBadge,T.Radius); Utils.Stroke(keyBadge,T.InputBorder,1)
	keyBadge.MouseButton1Click:Connect(function()
		listening=true; keyBadge.Text="..."; keyBadge.TextColor3=T.Accent
		Utils.Tween(keyBadge,Utils.FAST,{BackgroundColor3=T.BtnSecHover})
	end)
	UserInputService.InputBegan:Connect(function(input,proc)
		if proc then return end
		if listening then
			listening=false; key=input.KeyCode; keyBadge.Text=key.Name
			keyBadge.TextColor3=T.TextAccent; Utils.Tween(keyBadge,Utils.FAST,{BackgroundColor3=T.BtnSecondary})
			if opts.Callback then pcall(opts.Callback,key) end
		elseif input.KeyCode==key then
			if opts.Callback then pcall(opts.Callback,key) end
		end
	end)
	return {Instance=card, GetValue=function() return key end, SetValue=function(k) key=k; keyBadge.Text=k.Name end}
end

function Elements:ColorPicker(opts)
	opts=opts or{}; local T=self.Theme
	local col=opts.Default or Color3.fromRGB(200,20,20)
	local h,s,v=Color3.toHSV(col); h=h*360; local isOpen=false
	local wrapper=Utils.New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundTransparency=1,ZIndex=10,Parent=self.Container})
	local card=makeCard(T,wrapper,40); card.ClipsDescendants=false
	Utils.New("TextLabel",{Size=UDim2.new(1,-72,0,40),Position=UDim2.new(0,12,0,0),
		BackgroundTransparency=1,Text=opts.Text or "Color",TextColor3=T.TextPrimary,
		Font=T.FontBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=11,Parent=card})
	local preview=Utils.New("Frame",{Size=UDim2.new(0,28,0,22),Position=UDim2.new(1,-40,0.5,-11),
		BackgroundColor3=col,BorderSizePixel=0,ZIndex=11,Parent=card})
	Utils.Corner(preview,T.Radius); Utils.Stroke(preview,T.Border,1)
	local panel=Utils.New("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,4),
		BackgroundColor3=T.Card,BorderSizePixel=0,ClipsDescendants=true,ZIndex=20,Parent=card})
	Utils.Corner(panel,T.Radius); Utils.Stroke(panel,T.Border,1)
	local svArea=Utils.New("Frame",{Size=UDim2.new(1,-12,0,90),Position=UDim2.new(0,6,0,6),
		BackgroundColor3=Color3.fromHSV(h/360,1,1),BorderSizePixel=0,ClipsDescendants=true,ZIndex=21,Parent=panel})
	Utils.Corner(svArea,T.Radius)
	Utils.New("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)}),Parent=svArea})
	local bOverlay=Utils.New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(0,0,0),ZIndex=22,Parent=svArea})
	Utils.New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),
		Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}),Parent=bOverlay})
	local svKnob=Utils.New("Frame",{Size=UDim2.new(0,10,0,10),Position=UDim2.new(s,-5,1-v,-5),
		BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=24,Parent=svArea})
	Utils.Corner(svKnob,UDim.new(1,0)); Utils.Stroke(svKnob,Color3.new(0,0,0),1)
	local svHit=Utils.New("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=25,Parent=svArea})
	local hueBar=Utils.New("Frame",{Size=UDim2.new(1,-12,0,12),Position=UDim2.new(0,6,0,100),
		BackgroundColor3=Color3.fromRGB(128,128,128),BorderSizePixel=0,ZIndex=21,Parent=panel})
	Utils.Corner(hueBar,UDim.new(1,0))
	local hueKeys={};for i=0,1,1/6 do table.insert(hueKeys,ColorSequenceKeypoint.new(i,Color3.fromHSV(i,1,1))) end
	table.insert(hueKeys,ColorSequenceKeypoint.new(1,Color3.fromHSV(1,1,1)))
	Utils.New("UIGradient",{Color=ColorSequence.new(hueKeys),Parent=hueBar})
	local hueKnob=Utils.New("Frame",{Size=UDim2.new(0,8,0,16),Position=UDim2.new(h/360,-4,0.5,-8),
		BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=22,Parent=hueBar})
	Utils.Corner(hueKnob,UDim.new(0,3)); Utils.Stroke(hueKnob,Color3.new(0,0,0),1)
	local hueHit=Utils.New("TextButton",{Size=UDim2.new(1,0,0,24),Position=UDim2.new(0,0,0.5,-12),
		BackgroundTransparency=1,Text="",ZIndex=23,Parent=hueBar})
	local hexBg=Utils.New("Frame",{Size=UDim2.new(1,-12,0,24),Position=UDim2.new(0,6,0,116),
		BackgroundColor3=T.InputBg,ZIndex=21,Parent=panel})
	Utils.Corner(hexBg,T.Radius); Utils.Stroke(hexBg,T.InputBorder,1)
	local hexL=Utils.New("TextLabel",{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,6,0,0),
		BackgroundTransparency=1,Text=Utils.ColorToHex(col),TextColor3=T.TextAccent,
		Font=T.FontMono,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=22,Parent=hexBg})
	local function updateColor()
		col=Color3.fromHSV(h/360,s,v); preview.BackgroundColor3=col
		svArea.BackgroundColor3=Color3.fromHSV(h/360,1,1)
		svKnob.Position=UDim2.new(s,-5,1-v,-5); hueKnob.Position=UDim2.new(h/360,-4,0.5,-8)
		hexL.Text=Utils.ColorToHex(col)
		if opts.Callback then pcall(opts.Callback,col) end
	end
	local svDrag=false; svHit.MouseButton1Down:Connect(function() svDrag=true end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then svDrag=false end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if not svDrag then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local as=svArea.AbsoluteSize; if as.X==0 or as.Y==0 then return end
		s=Utils.Clamp((i.Position.X-svArea.AbsolutePosition.X)/as.X,0,1)
		v=1-Utils.Clamp((i.Position.Y-svArea.AbsolutePosition.Y)/as.Y,0,1); updateColor()
	end)
	local hueDrag=false; hueHit.MouseButton1Down:Connect(function() hueDrag=true end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then hueDrag=false end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if not hueDrag then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local as=hueBar.AbsoluteSize.X; if as==0 then return end
		h=Utils.Clamp((i.Position.X-hueBar.AbsolutePosition.X)/as,0,1)*360; updateColor()
	end)
	local hitBtn=Utils.New("TextButton",{Size=UDim2.new(0,36,0,30),Position=UDim2.new(1,-44,0.5,-15),
		BackgroundTransparency=1,Text="",ZIndex=12,Parent=card})
	hitBtn.MouseButton1Click:Connect(function()
		isOpen=not isOpen; local ph=isOpen and 148 or 0
		Utils.Tween(panel,Utils.MED,{Size=UDim2.new(1,0,0,ph)})
		Utils.Tween(wrapper,Utils.MED,{Size=UDim2.new(1,0,0,isOpen and 40+ph+4 or 40)})
	end)
	return {Instance=wrapper, GetValue=function() return col end,
		SetValue=function(c) col=c; h,s,v=Color3.toHSV(c); h=h*360; updateColor() end}
end

function Elements:Label(opts)
	opts=opts or{}; local T=self.Theme
	local card=makeCard(T,self.Container,32)
	local lbl=Utils.New("TextLabel",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,12,0,0),
		BackgroundTransparency=1,Text=opts.Text or "",TextColor3=T.TextPrimary,Font=T.Font,
		TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,RichText=true,ZIndex=4,Parent=card})
	return {Instance=card, GetValue=function() return lbl.Text end, SetValue=function(v) lbl.Text=v end}
end

function Elements:Paragraph(opts)
	opts=opts or{}; local T=self.Theme
	local card=makeCard(T,self.Container,0,true); Utils.Padding(card,10,12,10,12)
	local lay=Instance.new("UIListLayout"); lay.SortOrder=Enum.SortOrder.LayoutOrder; lay.Padding=UDim.new(0,4); lay.Parent=card
	if opts.Title then
		Utils.New("TextLabel",{Name="PTitle",Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,
			Text=opts.Title,TextColor3=T.TextAccent,Font=T.FontBold,TextSize=13,
			TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1,ZIndex=4,Parent=card})
	end
	local body=Utils.New("TextLabel",{Name="PBody",Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,
		Text=opts.Text or "",TextColor3=T.TextSecondary,Font=T.Font,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,AutomaticSize=Enum.AutomaticSize.Y,
		LayoutOrder=2,RichText=true,ZIndex=4,Parent=card})
	return {Instance=card, GetValue=function() return body.Text end, SetValue=function(v) body.Text=v end}
end

function Elements:Divider(opts)
	opts=opts or{}; local T=self.Theme; local hasText=opts.Text and opts.Text~=""
	local frame=Utils.New("Frame",{Size=UDim2.new(1,0,0,hasText and 24 or 12),
		BackgroundTransparency=1,ZIndex=3,Parent=self.Container})
	Utils.New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),
		BackgroundColor3=T.DividerColor,BorderSizePixel=0,ZIndex=3,Parent=frame})
	if hasText then
		Utils.New("TextLabel",{Size=UDim2.new(0,0,1,0),Position=UDim2.new(0,10,0,0),
			BackgroundColor3=T.BackgroundAlt,BackgroundTransparency=0,AutomaticSize=Enum.AutomaticSize.X,
			Text="  "..opts.Text.."  ",TextColor3=T.TextMuted,Font=T.Font,TextSize=10,ZIndex=4,Parent=frame})
	end
	return frame
end

-- ════════════════════════════════════════════════════════════════
--  NOTIFICATIONS
-- ════════════════════════════════════════════════════════════════
local Notifications = {}
Notifications.__index = Notifications

function Notifications.new(gui, theme)
	local self=setmetatable({},Notifications); self.Theme=theme; self.Count=0
	self.Container=Utils.New("Frame",{Name="Toasts",Size=UDim2.new(0,300,1,-20),
		Position=UDim2.new(1,-310,0,10),BackgroundTransparency=1,ZIndex=200,Parent=gui})
	Utils.ListLayout(self.Container,Enum.FillDirection.Vertical,nil,8)
	local pad=Instance.new("UIPadding"); pad.PaddingTop=UDim.new(0,10); pad.Parent=self.Container
	return self
end

function Notifications:Notify(opts)
	opts=opts or{}; local T=self.Theme; self.Count+=1
	local title=opts.Title or "Notificación"; local content=opts.Content or ""
	local duration=opts.Duration or 5; local nType=opts.Type or "Info"
	local colorMap={Info=T.Accent,Success=T.StatusOnline,Warning=Color3.fromRGB(255,190,40),Error=Color3.fromRGB(220,60,60)}
	local ac=colorMap[nType] or T.Accent
	local card=Utils.New("Frame",{Name="Toast_"..self.Count,Size=UDim2.new(1,0,0,64),
		BackgroundColor3=T.NotifBg,BorderSizePixel=0,ZIndex=201,Parent=self.Container})
	Utils.Corner(card,T.Radius); Utils.Stroke(card,T.Border,1)
	local bar=Utils.New("Frame",{Size=UDim2.new(0,3,1,-12),Position=UDim2.new(0,0,0,6),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=202,Parent=card})
	Utils.Corner(bar,UDim.new(1,0))
	local prog=Utils.New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,-2),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=202,Parent=card})
	Utils.Corner(prog,UDim.new(1,0))
	Utils.New("TextLabel",{Size=UDim2.new(1,-20,0,20),Position=UDim2.new(0,14,0,8),
		BackgroundTransparency=1,Text=title,TextColor3=T.TextPrimary,Font=T.FontBold,TextSize=13,
		TextXAlignment=Enum.TextXAlignment.Left,ZIndex=202,Parent=card})
	Utils.New("TextLabel",{Size=UDim2.new(1,-20,0,30),Position=UDim2.new(0,14,0,28),
		BackgroundTransparency=1,Text=content,TextColor3=T.TextSecondary,Font=T.Font,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=202,Parent=card})
	local badge=Utils.New("Frame",{Size=UDim2.new(0,50,0,16),Position=UDim2.new(1,-58,0,8),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=202,Parent=card})
	Utils.Corner(badge,T.Radius)
	Utils.New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=nType:upper(),
		TextColor3=Color3.fromRGB(255,255,255),Font=T.FontBold,TextSize=9,ZIndex=203,Parent=badge})
	card.Position=UDim2.new(1,10,0,0)
	Utils.Tween(card,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)})
	Utils.Tween(prog,TweenInfo.new(duration,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,2)})
	task.delay(duration,function()
		if not card or not card.Parent then return end
		Utils.Tween(card,TweenInfo.new(0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Size=UDim2.new(1,0,0,0)})
		task.delay(0.28,function() if card and card.Parent then card:Destroy() end end)
	end)
	return card
end

-- ════════════════════════════════════════════════════════════════
--  CONFIG
-- ════════════════════════════════════════════════════════════════
local Config = {}
Config.__index = Config

function Config.new(library) local self=setmetatable({},Config); self.Library=library; return self end

function Config:LoadFromURL(url)
	local ok,raw=pcall(function() return HttpService:GetAsync(url) end)
	if not ok then warn("[BloodLibrary] Config load failed: "..tostring(raw)); return false end
	return self:_apply(raw)
end

function Config:LoadFromString(json) return self:_apply(json) end

function Config:_apply(raw)
	local ok,data=pcall(function() return HttpService:JSONDecode(raw) end)
	if not ok then warn("[BloodLibrary] Config JSON decode failed"); return false end
	if data.Theme then self.Library:SetTheme(data.Theme) end
	if data.WindowTitle then self.Library.WindowInstance:SetTitle(data.WindowTitle) end
	if data.Tabs then
		for _,td in ipairs(data.Tabs) do
			local tab=self.Library:CreateTab({Name=td.Name,Icon=td.Icon,Order=td.Order,Subtitle=td.Subtitle})
			if td.Elements then
				for _,ed in ipairs(td.Elements) do
					local fn=tab[ed.Type]; if fn then fn(tab,ed) end
				end
			end
		end
	end
	if data.Settings then for k,v in pairs(data.Settings) do self.Library.Settings[k]=v end end
	return true
end

function Config:Export()
	local data={Theme=self.Library.CurrentThemeName,Tabs={},Settings=self.Library.Settings}
	for _,t in ipairs(self.Library.TabList) do table.insert(data.Tabs,{Name=t.Name,Icon=t.Icon or "",Order=t.Order}) end
	local ok,json=pcall(function() return HttpService:JSONEncode(data) end)
	return ok and json or "{}"
end

-- ════════════════════════════════════════════════════════════════
--  LIBRARY  (Entry Point)
-- ════════════════════════════════════════════════════════════════
local Library = {}
Library.__index = Library

function Library.new(opts)
	opts=opts or{}
	local self=setmetatable({},Library)
	self.CurrentThemeName = opts.Theme or "Blood"
	self.Theme            = Themes.Get(self.CurrentThemeName)
	self.Settings         = {}
	self.TabList          = {}
	self.ActiveTab        = nil
	self.Version          = "1.0"

	self.WindowInstance = Window.new({
		Title    = opts.Title    or "BLOOD LIBRARY",
		Logo     = opts.Logo     or "rbxassetid://72559578724301",
		Subtitle = opts.Subtitle or "Welcome",
		Size     = opts.Size,
		Draggable = opts.Draggable,
	}, self.Theme, self)

	self.Notifs        = Notifications.new(self.WindowInstance.ScreenGui, self.Theme)
	self.ConfigManager = Config.new(self)
	self:_buildStatusBar()
	return self
end

function Library:_buildStatusBar()
	local T=self.Theme; local W=self.WindowInstance
	local bar=Utils.New("Frame",{Name="StatusBar",Size=UDim2.new(1,0,0,22),
		Position=UDim2.new(0,0,1,-22),BackgroundColor3=T.BackgroundAlt,
		BorderSizePixel=0,ZIndex=30,Parent=W.Main})
	Utils.Stroke(bar,T.Border,1)
	Utils.New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),
		BackgroundTransparency=1,Text="BLOOD LIBRARY  •  v"..self.Version.."  •  Premium",
		TextColor3=T.TextMuted,Font=T.Font,TextSize=10,
		TextXAlignment=Enum.TextXAlignment.Left,ZIndex=31,Parent=bar})
	Utils.New("TextLabel",{Size=UDim2.new(0,120,1,0),Position=UDim2.new(1,-130,0,0),
		BackgroundTransparency=1,Text=T.Name.." Theme",TextColor3=T.Accent,Font=T.FontBold,
		TextSize=10,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=31,Parent=bar})
end

function Library:CreateTab(opts)
	opts=opts or{}; local T=self.Theme; local W=self.WindowInstance
	local name=opts.Name or "Tab"; local icon=opts.Icon or ""
	local order=opts.Order or #self.TabList+1; local subtitle=opts.Subtitle or ""
	local enabled=opts.Enabled~=false; local isFirst=#self.TabList==0

	local btnFrame=Utils.New("Frame",{Name="TabBtn_"..name,Size=UDim2.new(1,0,0,34),
		BackgroundColor3=isFirst and T.TabActive or T.TabInactive,BorderSizePixel=0,
		LayoutOrder=order,ZIndex=14,Parent=W.TabList})
	Utils.Corner(btnFrame,T.Radius)
	local activeStrip=Utils.New("Frame",{Size=UDim2.new(0,3,0,18),Position=UDim2.new(0,0,0.5,-9),
		BackgroundColor3=T.Accent,BorderSizePixel=0,Visible=isFirst,ZIndex=15,Parent=btnFrame})
	Utils.Corner(activeStrip,UDim.new(1,0))
	local xOff=icon~="" and 28 or 12
	if icon~="" then
		Utils.New("ImageLabel",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,10,0.5,-8),
			BackgroundTransparency=1,Image=icon,
			ImageColor3=isFirst and Color3.fromRGB(255,255,255) or T.TabTextInactive,ZIndex=15,Parent=btnFrame})
	end
	local btnLabel=Utils.New("TextLabel",{Size=UDim2.new(1,-(xOff+6),1,0),Position=UDim2.new(0,xOff,0,0),
		BackgroundTransparency=1,Text=name,TextColor3=isFirst and T.TabText or T.TabTextInactive,
		Font=T.FontBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=15,Parent=btnFrame})

	local contentFrame=Utils.New("Frame",{Name="Content_"..name,Size=UDim2.new(1,0,0,0),
		AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Visible=isFirst,
		ZIndex=14,Parent=W.ContentScroll})
	local frameLayout=Utils.ListLayout(contentFrame,Enum.FillDirection.Vertical,nil,6)
	Utils.Padding(contentFrame,10,12,14,12)
	frameLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self.ActiveTab and self.ActiveTab.Container==contentFrame then
			W.ContentScroll.CanvasSize=UDim2.new(0,0,0,frameLayout.AbsoluteContentSize.Y+24)
		end
	end)

	local tab={Name=name,Icon=icon,Subtitle=subtitle,Order=order,Enabled=enabled,
		Container=contentFrame,Layout=frameLayout,Button=btnFrame,BtnLabel=btnLabel,
		Strip=activeStrip,Library=self,Theme=T,ElementList={}}

	local hitBtn=Utils.New("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text="",ZIndex=16,Parent=btnFrame})
	hitBtn.MouseEnter:Connect(function()
		if self.ActiveTab==tab then return end
		Utils.Tween(btnFrame,Utils.FAST,{BackgroundColor3=T.TabHover})
	end)
	hitBtn.MouseLeave:Connect(function()
		if self.ActiveTab==tab then return end
		Utils.Tween(btnFrame,Utils.FAST,{BackgroundColor3=T.TabInactive})
	end)
	hitBtn.MouseButton1Click:Connect(function()
		if not tab.Enabled then return end; self:SelectTab(tab)
	end)

	local E=Elements
	local function addElem(elem) table.insert(tab.ElementList,elem); return elem end

	function tab:Button(o)      return addElem(E.Button({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Toggle(o)      return addElem(E.Toggle({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Slider(o)      return addElem(E.Slider({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Dropdown(o)    return addElem(E.Dropdown({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Textbox(o)     return addElem(E.Textbox({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Keybind(o)     return addElem(E.Keybind({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:ColorPicker(o) return addElem(E.ColorPicker({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Label(o)       return addElem(E.Label({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Paragraph(o)   return addElem(E.Paragraph({Container=contentFrame,Theme=T,Library=self.Library},o)) end
	function tab:Divider(o)     E.Divider({Container=contentFrame,Theme=T,Library=self.Library},o) end

	function tab:SetEnabled(vv)
		self.Enabled=vv
		btnFrame.BackgroundTransparency=vv and 0 or 0.5
		btnLabel.TextTransparency=vv and 0 or 0.5
	end

	table.insert(self.TabList,tab)
	if isFirst then
		self.ActiveTab=tab; W:SetTitle(name,subtitle)
		task.defer(function()
			W.ContentScroll.CanvasSize=UDim2.new(0,0,0,frameLayout.AbsoluteContentSize.Y+24)
		end)
	end
	return tab
end

function Library:SelectTab(tab)
	local T=self.Theme; local scroll=self.WindowInstance.ContentScroll
	scroll.CanvasPosition=Vector2.new(0,0)
	for _,t in ipairs(self.TabList) do
		t.Container.Visible=false
		Utils.Tween(t.Button,Utils.FAST,{BackgroundColor3=T.TabInactive})
		Utils.Tween(t.BtnLabel,Utils.FAST,{TextColor3=T.TabTextInactive})
		t.Strip.Visible=false
		local img=t.Button:FindFirstChildOfClass("ImageLabel")
		if img then Utils.Tween(img,Utils.FAST,{ImageColor3=T.TabTextInactive}) end
	end
	self.ActiveTab=tab; tab.Container.Visible=true
	Utils.Tween(tab.Button,Utils.FAST,{BackgroundColor3=T.TabActive})
	Utils.Tween(tab.BtnLabel,Utils.FAST,{TextColor3=T.TabText})
	tab.Strip.Visible=true
	local img=tab.Button:FindFirstChildOfClass("ImageLabel")
	if img then Utils.Tween(img,Utils.FAST,{ImageColor3=Color3.fromRGB(255,255,255)}) end
	self.WindowInstance:SetTitle(tab.Name,tab.Subtitle or "")
	task.defer(function()
		if tab.Layout then
			scroll.CanvasSize=UDim2.new(0,0,0,tab.Layout.AbsoluteContentSize.Y+24)
		end
	end)
end

function Library:SetTheme(nameOrTable)
	if type(nameOrTable)=="string" then
		self.CurrentThemeName=nameOrTable; self.Theme=Themes.Get(nameOrTable)
	else self.Theme=Themes.Merge(Themes.Blood,nameOrTable); self.CurrentThemeName="Custom" end
end

function Library:Notify(opts) return self.Notifs:Notify(opts) end

function Library:LoadConfig(urlOrJson)
	if urlOrJson:find("://") then return self.ConfigManager:LoadFromURL(urlOrJson) end
	return self.ConfigManager:LoadFromString(urlOrJson)
end

function Library:ExportConfig() return self.ConfigManager:Export() end

function Library:SaveSetting(key,value) self.Settings[key]=value; Utils.Save("BloodLibrary",key,value) end

function Library:LoadSetting(key)
	local v=Utils.Load("BloodLibrary",key); if v~=nil then self.Settings[key]=v end; return v
end

function Library:SetScale(scale)
	local m=self.WindowInstance.Main
	m.Size=UDim2.new(0,640*scale,0,470*scale)
end

function Library:CheckUpdate(url,current)
	local ok,raw=pcall(function() return HttpService:GetAsync(url) end); if not ok then return end
	local ok2,data=pcall(function() return HttpService:JSONDecode(raw) end)
	if ok2 and data.Version and data.Version>current then
		self:Notify({Title="Nueva versión",Content="v"..data.Version.." disponible",Type="Info",Duration=8})
	end
end

return Library
