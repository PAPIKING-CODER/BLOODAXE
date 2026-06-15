--[[
  ____  _     ___   ___  ____    _     ___ ____  ____    _    ____  _   _
 | __ )| |   / _ \ / _ \|  _ \  | |   |_ _| __ )|  _ \  / \  |  _ \| \ | |
 |  _ \| |  | | | | | | | | | | | |    | ||  _ \| |_) |/ _ \ | |_) |  \| |
 | |_) | |__| |_| | |_| | |_| | | |___ | || |_) |  _ </ ___ \|  _ <| |\  |
 |____/|_____\___/ \___/|____/  |_____|___|____/|_| \_/_/   \_\_| \_\_| \_|

  BLOOD LIBRARY v1.0  –  Premium Roblox UI Framework
  Carga: local L = loadstring(game:HttpGet("RAW_URL"))()
]]

-- ─── Services ─────────────────────────────────────────────────────────────────
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local PL  = game:GetService("Players")
local HS  = game:GetService("HttpService")

-- ─── Utils ────────────────────────────────────────────────────────────────────
local U = {}

U.F  = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
U.M  = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
U.SP = TweenInfo.new(0.40, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)

function U.tw(o, i, p) local t=TS:Create(o,i,p); t:Play(); return t end
function U.clamp(v,a,b) return math.max(a,math.min(b,v)) end
function U.round(n,s) s=s or 1; return math.floor(n/s+0.5)*s end
function U.hex(c) return string.format("#%02X%02X%02X",c.R*255//1,c.G*255//1,c.B*255//1) end
function U.mobile() return UIS.TouchEnabled and not UIS.KeyboardEnabled end

function U.new(cls, p, ch)
	local i = Instance.new(cls)
	for k,v in pairs(p or {}) do if k~="Parent" then i[k]=v end end
	for _,c in ipairs(ch or {}) do c.Parent=i end
	if p and p.Parent then i.Parent=p.Parent end
	return i
end

function U.corner(obj, r)
	local c=Instance.new("UICorner"); c.CornerRadius=r or UDim.new(0,6); c.Parent=obj; return c
end

function U.stroke(obj, col, px, tr)
	local s=Instance.new("UIStroke"); s.Color=col or Color3.new(.3,.3,.3)
	s.Thickness=px or 1; s.Transparency=tr or 0; s.Parent=obj; return s
end

function U.pad(obj, t, r, b, l)
	local p=Instance.new("UIPadding")
	p.PaddingTop=UDim.new(0,t or 0); p.PaddingRight=UDim.new(0,r or 0)
	p.PaddingBottom=UDim.new(0,b or 0); p.PaddingLeft=UDim.new(0,l or 0)
	p.Parent=obj; return p
end

function U.list(obj, dir, gap, align)
	local l=Instance.new("UIListLayout")
	l.FillDirection=dir or Enum.FillDirection.Vertical
	l.Padding=UDim.new(0,gap or 0)
	l.SortOrder=Enum.SortOrder.LayoutOrder
	l.HorizontalAlignment=align or Enum.HorizontalAlignment.Left
	l.Parent=obj; return l
end

function U.drag(win, handle)
	handle=handle or win
	local drag,ds,sp
	handle.InputBegan:Connect(function(i)
		if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
		drag=true; ds=i.Position; sp=win.Position
		i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end)
	end)
	UIS.InputChanged:Connect(function(i)
		if not drag then return end
		local d=i.Position-ds
		win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
	end)
end

function U.save(ns,k,v) pcall(function() game:GetService("DataStoreService"):GetDataStore(ns):SetAsync(k,v) end) end
function U.load(ns,k)
	local ok,v=pcall(function() return game:GetService("DataStoreService"):GetDataStore(ns):GetAsync(k) end)
	return ok and v or nil
end

-- ─── Themes ───────────────────────────────────────────────────────────────────
local T = {}

T.Blood = {
	name="Blood",
	bg      = Color3.fromRGB(10,10,12),    bgAlt = Color3.fromRGB(16,16,18),
	sidebar = Color3.fromRGB(13,13,15),    card  = Color3.fromRGB(20,20,22),
	cardHov = Color3.fromRGB(26,26,28),
	secBg   = Color3.fromRGB(17,17,19),
	secHdr  = Color3.fromRGB(22,8,8),
	border  = Color3.fromRGB(38,12,12),    borderL = Color3.fromRGB(55,18,18),
	accent  = Color3.fromRGB(204,20,20),   accentHi= Color3.fromRGB(235,50,50),
	txt1    = Color3.fromRGB(240,235,235), txt2=Color3.fromRGB(150,140,140),
	txtM    = Color3.fromRGB(85,78,78),    txtA=Color3.fromRGB(225,75,75),
	inBg    = Color3.fromRGB(15,13,13),    inBd=Color3.fromRGB(50,18,18),
	togOn   = Color3.fromRGB(204,20,20),   togOff=Color3.fromRGB(44,40,40),
	slBg    = Color3.fromRGB(38,28,28),    slFill=Color3.fromRGB(204,20,20),
	btnP    = Color3.fromRGB(180,18,18),   btnPH=Color3.fromRGB(220,38,38),
	btnS    = Color3.fromRGB(30,28,28),    btnSH=Color3.fromRGB(40,38,38),
	-- active tab = full accent-dark bg (matching KOD style)
	tabA    = Color3.fromRGB(180,18,18),   tabI=Color3.fromRGB(0,0,0),
	tabHov  = Color3.fromRGB(28,10,10),
	tabTxt  = Color3.fromRGB(255,255,255), tabTxtI=Color3.fromRGB(120,110,110),
	notifBg = Color3.fromRGB(19,17,17),
	divider = Color3.fromRGB(38,14,14),
	online  = Color3.fromRGB(50,200,90),   offline=Color3.fromRGB(180,50,50),
	secTxt  = Color3.fromRGB(204,20,20),
	font    = Enum.Font.GothamSemibold,    fontB=Enum.Font.GothamBlack,
	fontM   = Enum.Font.Code,
	r       = UDim.new(0,5),
}

T.Dark = {
	name="Dark",
	bg=Color3.fromRGB(12,12,14), bgAlt=Color3.fromRGB(18,18,20),
	sidebar=Color3.fromRGB(14,14,17), card=Color3.fromRGB(22,22,25),
	cardHov=Color3.fromRGB(28,28,32),
	secBg=Color3.fromRGB(19,19,22), secHdr=Color3.fromRGB(16,20,38),
	border=Color3.fromRGB(36,36,44), borderL=Color3.fromRGB(52,52,62),
	accent=Color3.fromRGB(80,142,255), accentHi=Color3.fromRGB(105,165,255),
	txt1=Color3.fromRGB(238,240,248), txt2=Color3.fromRGB(148,150,162),
	txtM=Color3.fromRGB(88,90,102), txtA=Color3.fromRGB(100,162,255),
	inBg=Color3.fromRGB(15,15,18), inBd=Color3.fromRGB(44,44,56),
	togOn=Color3.fromRGB(80,142,255), togOff=Color3.fromRGB(44,44,50),
	slBg=Color3.fromRGB(28,28,38), slFill=Color3.fromRGB(80,142,255),
	btnP=Color3.fromRGB(60,120,230), btnPH=Color3.fromRGB(80,145,255),
	btnS=Color3.fromRGB(28,28,34), btnSH=Color3.fromRGB(38,38,46),
	tabA=Color3.fromRGB(50,100,220), tabI=Color3.fromRGB(0,0,0),
	tabHov=Color3.fromRGB(18,20,32),
	tabTxt=Color3.fromRGB(255,255,255), tabTxtI=Color3.fromRGB(108,110,126),
	notifBg=Color3.fromRGB(20,20,24),
	divider=Color3.fromRGB(34,34,44),
	online=Color3.fromRGB(50,200,90), offline=Color3.fromRGB(180,50,50),
	secTxt=Color3.fromRGB(80,142,255),
	font=Enum.Font.GothamSemibold, fontB=Enum.Font.GothamBlack,
	fontM=Enum.Font.Code, r=UDim.new(0,5),
}

T.Neon = {
	name="Neon",
	bg=Color3.fromRGB(6,6,11), bgAlt=Color3.fromRGB(11,11,20),
	sidebar=Color3.fromRGB(8,8,15), card=Color3.fromRGB(15,15,24),
	cardHov=Color3.fromRGB(22,22,33),
	secBg=Color3.fromRGB(12,12,22), secHdr=Color3.fromRGB(20,6,44),
	border=Color3.fromRGB(22,6,52), borderL=Color3.fromRGB(48,10,98),
	accent=Color3.fromRGB(162,0,255), accentHi=Color3.fromRGB(192,55,255),
	txt1=Color3.fromRGB(228,218,255), txt2=Color3.fromRGB(148,138,178),
	txtM=Color3.fromRGB(78,68,110), txtA=Color3.fromRGB(190,102,255),
	inBg=Color3.fromRGB(10,8,19), inBd=Color3.fromRGB(48,14,98),
	togOn=Color3.fromRGB(162,0,255), togOff=Color3.fromRGB(34,28,54),
	slBg=Color3.fromRGB(30,22,48), slFill=Color3.fromRGB(162,0,255),
	btnP=Color3.fromRGB(140,0,220), btnPH=Color3.fromRGB(175,50,255),
	btnS=Color3.fromRGB(24,18,40), btnSH=Color3.fromRGB(34,26,56),
	tabA=Color3.fromRGB(130,0,220), tabI=Color3.fromRGB(0,0,0),
	tabHov=Color3.fromRGB(18,10,30),
	tabTxt=Color3.fromRGB(255,255,255), tabTxtI=Color3.fromRGB(108,98,140),
	notifBg=Color3.fromRGB(14,12,23),
	divider=Color3.fromRGB(34,14,66),
	online=Color3.fromRGB(50,255,150), offline=Color3.fromRGB(200,50,80),
	secTxt=Color3.fromRGB(162,0,255),
	font=Enum.Font.GothamSemibold, fontB=Enum.Font.GothamBlack,
	fontM=Enum.Font.Code, r=UDim.new(0,5),
}

T.Midnight = {
	name="Midnight",
	bg=Color3.fromRGB(8,10,20), bgAlt=Color3.fromRGB(12,15,28),
	sidebar=Color3.fromRGB(10,12,22), card=Color3.fromRGB(16,20,35),
	cardHov=Color3.fromRGB(22,28,46),
	secBg=Color3.fromRGB(13,16,30), secHdr=Color3.fromRGB(14,20,46),
	border=Color3.fromRGB(28,34,64), borderL=Color3.fromRGB(44,54,90),
	accent=Color3.fromRGB(65,132,255), accentHi=Color3.fromRGB(90,160,255),
	txt1=Color3.fromRGB(220,225,245), txt2=Color3.fromRGB(138,148,182),
	txtM=Color3.fromRGB(78,88,120), txtA=Color3.fromRGB(100,165,255),
	inBg=Color3.fromRGB(10,12,24), inBd=Color3.fromRGB(38,48,90),
	togOn=Color3.fromRGB(65,132,255), togOff=Color3.fromRGB(34,38,70),
	slBg=Color3.fromRGB(26,32,58), slFill=Color3.fromRGB(65,132,255),
	btnP=Color3.fromRGB(50,110,230), btnPH=Color3.fromRGB(80,145,255),
	btnS=Color3.fromRGB(22,26,48), btnSH=Color3.fromRGB(30,36,62),
	tabA=Color3.fromRGB(45,100,210), tabI=Color3.fromRGB(0,0,0),
	tabHov=Color3.fromRGB(14,18,38),
	tabTxt=Color3.fromRGB(255,255,255), tabTxtI=Color3.fromRGB(108,118,158),
	notifBg=Color3.fromRGB(14,18,32),
	divider=Color3.fromRGB(28,36,70),
	online=Color3.fromRGB(60,210,110), offline=Color3.fromRGB(190,60,60),
	secTxt=Color3.fromRGB(65,132,255),
	font=Enum.Font.GothamSemibold, fontB=Enum.Font.GothamBlack,
	fontM=Enum.Font.Code, r=UDim.new(0,5),
}

function T.get(n) return T[n] or T.Blood end
function T.list() return {"Blood","Dark","Neon","Midnight"} end
function T.merge(base,ov)
	local r={}; for k,v in pairs(base) do r[k]=v end
	for k,v in pairs(ov or {}) do r[k]=v end; return r
end

-- ─── Window ───────────────────────────────────────────────────────────────────
local Win={}; Win.__index=Win

function Win.new(opts, th, lib)
	local self=setmetatable({},Win)
	self.lib=lib; self.theme=th; self.min=false
	local title  = opts.Title    or "BLOOD LIBRARY"
	local logo   = opts.Logo     or "rbxassetid://72559578724301"
	local sub    = opts.Subtitle or "BLOOD HUB"
	local sz     = opts.Size     or UDim2.new(0,780,0,530)
	local drag   = opts.Draggable~=false
	self.fullSize = sz

	-- ScreenGui
	local sg=Instance.new("ScreenGui")
	sg.Name="BloodLib"; sg.ResetOnSpawn=false
	sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; sg.IgnoreGuiInset=true
	pcall(function() sg.Parent=game:GetService("CoreGui") end)
	if not sg.Parent then sg.Parent=PL.LocalPlayer:WaitForChild("PlayerGui") end
	self.sg=sg

	-- Drop shadow
	U.new("ImageLabel",{Name="Shadow",
		Size=UDim2.new(0,sz.X.Offset+60,0,sz.Y.Offset+60),
		Position=UDim2.new(0.5,-(sz.X.Offset+60)/2,0.5,-(sz.Y.Offset+60)/2),
		BackgroundTransparency=1,Image="rbxassetid://6015897843",
		ImageColor3=Color3.new(0,0,0),ImageTransparency=0.55,
		ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),
		ZIndex=1,Parent=sg})

	-- Main container
	local main=U.new("Frame",{Name="Main",
		Size=UDim2.new(0,0,0,0),
		Position=UDim2.new(0.5,-sz.X.Offset/2,0.5,-sz.Y.Offset/2),
		BackgroundColor3=th.bg,BorderSizePixel=0,
		ClipsDescendants=false,ZIndex=2,Parent=sg})
	U.corner(main,th.r); U.stroke(main,th.border,1)
	self.main=main
	U.tw(main,U.SP,{Size=sz})

	local sw = U.mobile() and 130 or 168

	-- ── Sidebar ────────────────────────────────────────────────────────────────
	local sb=U.new("Frame",{Name="Sidebar",Size=UDim2.new(0,sw,1,0),
		BackgroundColor3=th.sidebar,BorderSizePixel=0,ZIndex=3,Parent=main})
	U.corner(sb,th.r)
	-- Square off right corners
	U.new("Frame",{Size=UDim2.new(0,th.r.Offset*2,1,0),Position=UDim2.new(1,-th.r.Offset*2,0,0),
		BackgroundColor3=th.sidebar,BorderSizePixel=0,ZIndex=3,Parent=sb})
	-- Right separator
	U.new("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,0,0,0),
		BackgroundColor3=th.border,BorderSizePixel=0,ZIndex=4,Parent=sb})
	self.sb=sb

	-- Logo zone (bigger, matching KOD style)
	local lz=U.new("Frame",{Name="Logo",Size=UDim2.new(1,0,0,110),
		BackgroundTransparency=1,ZIndex=4,Parent=sb})
	-- Logo image (large, centered)
	if logo~="" then
		U.new("ImageLabel",{Size=UDim2.new(0,80,0,56),Position=UDim2.new(0.5,-40,0,10),
			BackgroundTransparency=1,Image=logo,ZIndex=5,Parent=lz})
	end
	-- Title text below logo
	U.new("TextLabel",{Size=UDim2.new(1,0,0,18),
		Position=UDim2.new(0,0,0,logo~="" and 70 or 14),
		BackgroundTransparency=1,Text=title,TextColor3=th.accent,
		Font=th.fontB,TextSize=15,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5,Parent=lz})
	U.new("TextLabel",{Size=UDim2.new(1,0,0,13),
		Position=UDim2.new(0,0,0,logo~="" and 89 or 32),
		BackgroundTransparency=1,Text=sub,TextColor3=th.txtM,
		Font=th.font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5,Parent=lz})
	-- Divider under logo
	U.new("Frame",{Size=UDim2.new(1,-14,0,1),Position=UDim2.new(0,7,1,-1),
		BackgroundColor3=th.border,BorderSizePixel=0,ZIndex=4,Parent=lz})

	-- Tab scroll
	local tabScroll=U.new("ScrollingFrame",{Name="Tabs",
		Size=UDim2.new(1,0,1,-160),Position=UDim2.new(0,0,0,110),
		BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,
		CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
		ZIndex=4,Parent=sb})
	U.list(tabScroll,Enum.FillDirection.Vertical,2)
	U.pad(tabScroll,6,6,6,6)
	self.tabScroll=tabScroll

	-- Profile zone (bottom of sidebar)
	local pz=U.new("Frame",{Name="Profile",Size=UDim2.new(1,0,0,50),
		Position=UDim2.new(0,0,1,-50),BackgroundColor3=th.bgAlt,
		BorderSizePixel=0,ZIndex=4,Parent=sb})
	U.new("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.border,
		BorderSizePixel=0,ZIndex=3,Parent=pz})
	self:_buildProfile(pz,th)

	-- ── Right pane ─────────────────────────────────────────────────────────────
	local rp=U.new("Frame",{Name="Right",Size=UDim2.new(1,-sw,1,0),
		Position=UDim2.new(0,sw,0,0),BackgroundColor3=th.bg,
		BorderSizePixel=0,ZIndex=3,Parent=main})
	self.rp=rp

	-- Top bar (search + controls)
	local tb=U.new("Frame",{Name="TopBar",Size=UDim2.new(1,0,0,44),
		BackgroundColor3=th.bgAlt,BorderSizePixel=0,ZIndex=5,Parent=rp})
	U.new("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),
		BackgroundColor3=th.border,BorderSizePixel=0,ZIndex=5,Parent=tb})
	self.tb=tb

	-- Search bar (KOD style – left aligned in topbar)
	local sf=U.new("Frame",{Name="Search",Size=UDim2.new(1,-70,0,28),
		Position=UDim2.new(0,10,0.5,-14),BackgroundColor3=th.inBg,
		BorderSizePixel=0,ZIndex=6,Parent=tb})
	U.corner(sf,th.r); U.stroke(sf,th.inBd,1)
	U.new("ImageLabel",{Size=UDim2.new(0,13,0,13),Position=UDim2.new(0,7,0.5,-6),
		BackgroundTransparency=1,Image="rbxassetid://3926305904",
		ImageColor3=th.txtM,ZIndex=7,Parent=sf})
	local sb2=U.new("TextBox",{Size=UDim2.new(1,-28,1,-2),Position=UDim2.new(0,26,0,1),
		BackgroundTransparency=1,Text="",PlaceholderText="Buscar...",
		TextColor3=th.txt1,PlaceholderColor3=th.txtM,Font=th.font,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ZIndex=7,Parent=sf})
	self.sb2=sb2

	-- Minimize / Close buttons
	local minB=U.new("TextButton",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(1,-50,0.5,-11),
		BackgroundColor3=th.btnS,BorderSizePixel=0,Text="—",TextColor3=th.txt2,
		Font=th.fontB,TextSize=11,AutoButtonColor=false,ZIndex=6,Parent=tb})
	U.corner(minB,UDim.new(1,0))
	minB.MouseEnter:Connect(function() U.tw(minB,U.F,{BackgroundColor3=th.btnSH,TextColor3=th.txt1}) end)
	minB.MouseLeave:Connect(function() U.tw(minB,U.F,{BackgroundColor3=th.btnS,TextColor3=th.txt2}) end)
	minB.MouseButton1Click:Connect(function() self:toggleMin() end)

	local clB=U.new("TextButton",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(1,-24,0.5,-11),
		BackgroundColor3=th.accent,BorderSizePixel=0,Text="x",TextColor3=Color3.new(1,1,1),
		Font=th.fontB,TextSize=11,AutoButtonColor=false,ZIndex=6,Parent=tb})
	U.corner(clB,UDim.new(1,0))
	clB.MouseEnter:Connect(function() U.tw(clB,U.F,{BackgroundColor3=th.accentHi}) end)
	clB.MouseLeave:Connect(function() U.tw(clB,U.F,{BackgroundColor3=th.accent}) end)
	clB.MouseButton1Click:Connect(function() self:close() end)

	-- Page header (title + subtitle, below topbar)
	local ph=U.new("Frame",{Size=UDim2.new(1,0,0,46),Position=UDim2.new(0,0,0,44),
		BackgroundTransparency=1,ZIndex=5,Parent=rp})
	U.pad(ph,8,14,0,14)
	self.pgTitle=U.new("TextLabel",{Size=UDim2.new(1,0,0,22),Position=UDim2.new(0,0,0,0),
		BackgroundTransparency=1,Text="Main",TextColor3=th.txt1,Font=th.fontB,
		TextSize=18,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=ph})
	self.pgSub=U.new("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,24),
		BackgroundTransparency=1,Text="",TextColor3=th.txtA,Font=th.font,
		TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=ph})

	-- Content scroll
	local cs=U.new("ScrollingFrame",{Name="Scroll",
		Size=UDim2.new(1,0,1,-112),Position=UDim2.new(0,0,0,90),
		BackgroundTransparency=1,BorderSizePixel=0,
		ScrollBarThickness=3,ScrollBarImageColor3=th.accent,
		CanvasSize=UDim2.new(0,0,0,0),ZIndex=4,Parent=rp})
	self.cs=cs

	-- Status bar (bottom, matching KOD style)
	local stB=U.new("Frame",{Name="Status",Size=UDim2.new(1,0,0,22),
		Position=UDim2.new(0,0,1,-22),BackgroundColor3=th.bgAlt,
		BorderSizePixel=0,ZIndex=5,Parent=rp})
	U.new("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.border,
		BorderSizePixel=0,ZIndex=5,Parent=stB})
	self.stLabel=U.new("TextLabel",{Size=UDim2.new(1,0,1,0),
		BackgroundTransparency=1,
		Text="BLOOD LIBRARY  v1.0  •  Premium Version",
		TextColor3=th.accent,Font=th.font,TextSize=9,
		TextXAlignment=Enum.TextXAlignment.Center,ZIndex=6,Parent=stB})

	if drag then U.drag(main,tb); U.drag(main,lz) end

	-- Search filtering
	sb2:GetPropertyChangedSignal("Text"):Connect(function()
		self:_filter(sb2.Text:lower())
	end)

	return self
end

function Win:_buildProfile(zone, th)
	local pl=PL.LocalPlayer
	local av=U.new("Frame",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(0,8,0.5,-16),
		BackgroundColor3=th.accent,BorderSizePixel=0,ZIndex=5,Parent=zone})
	U.corner(av,UDim.new(1,0))
	local img=Instance.new("ImageLabel")
	img.Size=UDim2.new(1,0,1,0); img.BackgroundTransparency=1
	img.Image="https://www.roblox.com/headshot-thumbnail/image?userId="..pl.UserId.."&width=48&height=48&format=png"
	img.ZIndex=6; U.corner(img,UDim.new(1,0)); img.Parent=av

	U.new("TextLabel",{Size=UDim2.new(1,-52,0,15),Position=UDim2.new(0,46,0,9),
		BackgroundTransparency=1,Text=pl.DisplayName or pl.Name,
		TextColor3=th.txt1,Font=th.fontB,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,
		ZIndex=5,Parent=zone})
	U.new("TextLabel",{Size=UDim2.new(1,-52,0,12),Position=UDim2.new(0,46,0,25),
		BackgroundTransparency=1,Text="Premium",TextColor3=th.accent,
		Font=th.fontB,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=zone})

	-- Green connected dot + label at very bottom
	local dot=U.new("Frame",{Size=UDim2.new(0,5,0,5),Position=UDim2.new(0,8,1,2),
		BackgroundColor3=th.online,BorderSizePixel=0,ZIndex=5,Parent=zone})
	U.corner(dot,UDim.new(1,0))
	U.new("TextLabel",{Size=UDim2.new(1,-20,0,10),Position=UDim2.new(0,16,1,1),
		BackgroundTransparency=1,Text="Conectado",TextColor3=th.online,
		Font=th.font,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=zone})
end

function Win:_filter(q)
	if not self.cs then return end
	for _,cf in ipairs(self.cs:GetChildren()) do
		if not cf:IsA("Frame") then continue end
		-- cf is the grid frame per tab
		for _,col in ipairs(cf:GetChildren()) do
			if not col:IsA("Frame") then continue end
			for _,sec in ipairs(col:GetChildren()) do
				if not sec:IsA("Frame") then continue end
				for _,row in ipairs(sec:GetChildren()) do
					if not row:IsA("Frame") then continue end
					if q=="" then row.Visible=true; continue end
					local found=false
					for _,lbl in ipairs(row:GetDescendants()) do
						if lbl:IsA("TextLabel") and lbl.Text:lower():find(q,1,true) then
							found=true; break
						end
					end
					row.Visible=found
				end
			end
		end
	end
end

function Win:toggleMin()
	self.min=not self.min
	if self.min then
		self.rp.Visible=false
		U.tw(self.main,U.M,{Size=UDim2.new(0,self.sb.AbsoluteSize.X,0,self.main.AbsoluteSize.Y)})
	else
		self.rp.Visible=true
		U.tw(self.main,U.M,{Size=self.fullSize})
	end
end

function Win:close()
	U.tw(self.main,U.M,{Size=UDim2.new(0,0,0,0)})
	task.delay(0.32,function() self.sg:Destroy() end)
end

function Win:setTitle(t,s)
	self.pgTitle.Text=t
	if s then self.pgSub.Text=s end
end

function Win:setVisible(v) self.main.Visible=v end

-- ─── Elements ─────────────────────────────────────────────────────────────────
-- Elements render inside a section container (self.cont = section's inner list frame)
-- Each element is a full-width row card.

local E={}; E.__index=E

local function rowCard(th, parent, h, autoY)
	local f=U.new("Frame",{
		Size=autoY and UDim2.new(1,0,0,0) or UDim2.new(1,0,0,h or 46),
		BackgroundTransparency=1,
		AutomaticSize=autoY and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
		ZIndex=10,Parent=parent})
	return f
end

-- ── Toggle (KOD style: title + desc left, pill right) ─────────────────────────
function E:Toggle(o)
	o=o or{}; local th=self.theme; local on=o.Default==true
	local row=rowCard(th,self.cont,46)

	U.new("TextLabel",{Size=UDim2.new(1,-62,0,16),Position=UDim2.new(0,0,0,6),
		BackgroundTransparency=1,Text=o.Text or "Toggle",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	if o.Description and o.Description~="" then
		U.new("TextLabel",{Size=UDim2.new(1,-62,0,12),Position=UDim2.new(0,0,0,24),
			BackgroundTransparency=1,Text=o.Description,TextColor3=th.txt2,
			Font=th.font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	end

	local pill=U.new("Frame",{Size=UDim2.new(0,42,0,22),Position=UDim2.new(1,-44,0.5,-11),
		BackgroundColor3=on and th.togOn or th.togOff,BorderSizePixel=0,ZIndex=12,Parent=row})
	U.corner(pill,UDim.new(1,0))

	local knob=U.new("Frame",{Size=UDim2.new(0,18,0,18),
		Position=on and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9),
		BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=13,Parent=pill})
	U.corner(knob,UDim.new(1,0))

	local hit=U.new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text="",ZIndex=14,Parent=row})

	local function refresh(anim)
		local bg=on and th.togOn or th.togOff
		local kp=on and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
		if anim then U.tw(pill,U.F,{BackgroundColor3=bg}); U.tw(knob,U.F,{Position=kp})
		else pill.BackgroundColor3=bg; knob.Position=kp end
	end

	hit.MouseButton1Click:Connect(function()
		on=not on; refresh(true)
		if o.Callback then pcall(o.Callback,on) end
	end)
	refresh(false)
	return {Instance=row, GetValue=function() return on end, SetValue=function(v) on=v; refresh(true) end}
end

-- ── Slider (KOD style: title + desc, value right, full-width track) ───────────
function E:Slider(o)
	o=o or{}; local th=self.theme
	local mn=o.Min or 0; local mx=o.Max or 100
	local val=U.clamp(o.Default or mn,mn,mx); local suf=o.Suffix or ""

	local h=(o.Description and o.Description~="") and 64 or 52
	local row=rowCard(th,self.cont,h)

	-- Top row: title left, value right
	U.new("TextLabel",{Size=UDim2.new(1,-52,0,16),Position=UDim2.new(0,0,0,4),
		BackgroundTransparency=1,Text=o.Text or "Slider",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	if o.Description and o.Description~="" then
		U.new("TextLabel",{Size=UDim2.new(1,-52,0,11),Position=UDim2.new(0,0,0,21),
			BackgroundTransparency=1,Text=o.Description,TextColor3=th.txt2,
			Font=th.font,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	end

	-- Value box (KOD style: bordered box top-right)
	local vBox=U.new("Frame",{Size=UDim2.new(0,46,0,18),Position=UDim2.new(1,-46,0,3),
		BackgroundColor3=th.inBg,BorderSizePixel=0,ZIndex=12,Parent=row})
	U.corner(vBox,th.r); U.stroke(vBox,th.inBd,1)
	local vL=U.new("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text=tostring(val)..suf,TextColor3=th.txt1,Font=th.fontB,TextSize=10,ZIndex=13,Parent=vBox})

	-- Track (full width, near bottom of row)
	local tY=(o.Description and o.Description~="") and 46 or 34
	local track=U.new("Frame",{Size=UDim2.new(1,0,0,4),Position=UDim2.new(0,0,0,tY),
		BackgroundColor3=th.slBg,BorderSizePixel=0,ZIndex=12,Parent=row})
	U.corner(track,UDim.new(1,0))

	local fill=U.new("Frame",{Size=UDim2.new((val-mn)/(mx-mn),0,1,0),
		BackgroundColor3=th.slFill,BorderSizePixel=0,ZIndex=13,Parent=track})
	U.corner(fill,UDim.new(1,0))

	local knob=U.new("Frame",{Size=UDim2.new(0,12,0,12),
		Position=UDim2.new((val-mn)/(mx-mn),-6,0.5,-6),
		BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=14,Parent=track})
	U.corner(knob,UDim.new(1,0))

	local hit=U.new("TextButton",{Size=UDim2.new(1,0,0,22),Position=UDim2.new(0,0,0.5,-11),
		BackgroundTransparency=1,Text="",ZIndex=15,Parent=track})

	local drg=false
	local function setV(nx)
		local p=U.clamp(nx,0,1)
		val=U.round(mn+(mx-mn)*p)
		fill.Size=UDim2.new(p,0,1,0); knob.Position=UDim2.new(p,-6,0.5,-6)
		vL.Text=tostring(val)..suf
	end
	hit.MouseButton1Down:Connect(function() drg=true end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			if drg then drg=false; if o.Callback then pcall(o.Callback,val) end end
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if not drg then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local a=track.AbsoluteSize.X; if a==0 then return end
		setV((i.Position.X-track.AbsolutePosition.X)/a)
	end)
	setV((val-mn)/(mx-mn))
	return {Instance=row, GetValue=function() return val end,
		SetValue=function(v) setV((U.clamp(v,mn,mx)-mn)/(mx-mn)) end}
end

-- ── Button (KOD style: title + desc left, button right) ───────────────────────
function E:Button(o)
	o=o or{}; local th=self.theme
	local row=rowCard(th,self.cont,46)

	U.new("TextLabel",{Size=UDim2.new(1,-90,0,16),Position=UDim2.new(0,0,0,6),
		BackgroundTransparency=1,Text=o.Text or "Button",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	if o.Description and o.Description~="" then
		U.new("TextLabel",{Size=UDim2.new(1,-90,0,12),Position=UDim2.new(0,0,0,24),
			BackgroundTransparency=1,Text=o.Description,TextColor3=th.txt2,
			Font=th.font,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	end

	local eb=U.new("TextButton",{Size=UDim2.new(0,76,0,28),Position=UDim2.new(1,-78,0.5,-14),
		BackgroundColor3=th.btnP,BorderSizePixel=0,
		Text=o.ButtonText or "Ejecutar",TextColor3=Color3.new(1,1,1),
		Font=th.fontB,TextSize=11,AutoButtonColor=false,ZIndex=12,Parent=row})
	U.corner(eb,th.r)

	eb.MouseEnter:Connect(function() U.tw(eb,U.F,{BackgroundColor3=th.btnPH}) end)
	eb.MouseLeave:Connect(function() U.tw(eb,U.F,{BackgroundColor3=th.btnP}) end)
	eb.MouseButton1Click:Connect(function()
		U.tw(eb,TweenInfo.new(0.07),{Size=UDim2.new(0,70,0,26)})
		task.delay(0.1,function() U.tw(eb,TweenInfo.new(0.12),{Size=UDim2.new(0,76,0,28)}) end)
		if o.Callback then pcall(o.Callback) end
	end)
	return {Instance=row}
end

-- ── Textbox ───────────────────────────────────────────────────────────────────
function E:Textbox(o)
	o=o or{}; local th=self.theme
	local row=rowCard(th,self.cont,52)
	U.new("TextLabel",{Size=UDim2.new(1,-16,0,15),Position=UDim2.new(0,0,0,4),
		BackgroundTransparency=1,Text=o.Text or "Input",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	local iBg=U.new("Frame",{Size=UDim2.new(1,0,0,24),Position=UDim2.new(0,0,0,24),
		BackgroundColor3=th.inBg,BorderSizePixel=0,ZIndex=12,Parent=row})
	U.corner(iBg,th.r); local sk=U.stroke(iBg,th.inBd,1)
	local box=U.new("TextBox",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
		BackgroundTransparency=1,Text=o.Default or "",
		PlaceholderText=o.Placeholder or "Escribe aqui...",
		TextColor3=th.txt1,PlaceholderColor3=th.txtM,Font=th.font,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ZIndex=13,Parent=iBg})
	box.Focused:Connect(function() U.tw(sk,U.F,{Color=th.accent}) end)
	box.FocusLost:Connect(function(enter)
		U.tw(sk,U.F,{Color=th.inBd})
		if o.Callback then pcall(o.Callback,box.Text,enter) end
	end)
	return {Instance=row, GetValue=function() return box.Text end, SetValue=function(v) box.Text=v end}
end

-- ── Dropdown ──────────────────────────────────────────────────────────────────
function E:Dropdown(o)
	o=o or{}; local th=self.theme
	local items=o.Items or{}; local multi=o.Multi or false
	local sel=multi and {} or (o.Default or nil); local open=false
	if multi then for _,v in ipairs(o.Default or {}) do sel[v]=true end end

	local wrap=U.new("Frame",{Size=UDim2.new(1,0,0,42),
		BackgroundTransparency=1,ClipsDescendants=false,ZIndex=20,Parent=self.cont})

	U.new("TextLabel",{Size=UDim2.new(1,-80,0,42),Position=UDim2.new(0,0,0,0),
		BackgroundTransparency=1,Text=o.Text or "Dropdown",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=21,Parent=wrap})
	local selL=U.new("TextLabel",{Size=UDim2.new(0,70,0,42),Position=UDim2.new(1,-92,0,0),
		BackgroundTransparency=1,Text=multi and "0 sel." or (sel or "Elegir"),
		TextColor3=th.txtA,Font=th.font,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Right,ZIndex=21,Parent=wrap})
	U.new("TextLabel",{Size=UDim2.new(0,18,0,42),Position=UDim2.new(1,-18,0,0),
		BackgroundTransparency=1,Text="v",TextColor3=th.txtM,
		Font=th.fontB,TextSize=12,ZIndex=21,Parent=wrap})

	-- Separator line (KOD uses simple lines under dropdowns)
	U.new("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),
		BackgroundColor3=th.border,BorderSizePixel=0,ZIndex=20,Parent=wrap})

	local panel=U.new("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,0),
		BackgroundColor3=th.bgAlt,BorderSizePixel=0,ClipsDescendants=true,ZIndex=25,Parent=wrap})
	U.corner(panel,th.r); U.stroke(panel,th.borderL,1)

	local iScroll=U.new("ScrollingFrame",{Size=UDim2.new(1,-8,1,-4),
		Position=UDim2.new(0,4,0,4),BackgroundTransparency=1,BorderSizePixel=0,
		ScrollBarThickness=2,ScrollBarImageColor3=th.accent,
		CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,
		ZIndex=26,Parent=panel})
	U.list(iScroll,nil,2)

	local iBtns={}
	local function updateSel()
		if multi then
			local n=0; for _,v in pairs(sel) do if v then n+=1 end end
			selL.Text=n==0 and "0 sel." or n.." sel."
		else selL.Text=sel or "Elegir" end
	end
	local function rebuild()
		for _,b in ipairs(iBtns) do b:Destroy() end; iBtns={}
		for _,item in ipairs(items) do
			local s=tostring(item)
			local act=multi and sel[item] or (sel==item)
			local row2=U.new("TextButton",{Size=UDim2.new(1,0,0,26),
				BackgroundColor3=act and th.btnP or th.card,
				BorderSizePixel=0,Text=s,
				TextColor3=act and Color3.new(1,1,1) or th.txt1,
				Font=th.font,TextSize=11,AutoButtonColor=false,ZIndex=27,Parent=iScroll})
			U.corner(row2,UDim.new(0,3))
			row2.MouseEnter:Connect(function()
				if not(multi and sel[item] or sel==item) then U.tw(row2,U.F,{BackgroundColor3=th.cardHov}) end
			end)
			row2.MouseLeave:Connect(function()
				local a=multi and sel[item] or sel==item
				U.tw(row2,U.F,{BackgroundColor3=a and th.btnP or th.card})
			end)
			row2.MouseButton1Click:Connect(function()
				if multi then
					sel[item]=not sel[item]
					row2.BackgroundColor3=sel[item] and th.btnP or th.card
					row2.TextColor3=sel[item] and Color3.new(1,1,1) or th.txt1
				else
					sel=item
					for _,b in ipairs(iBtns) do b.BackgroundColor3=th.card; b.TextColor3=th.txt1 end
					row2.BackgroundColor3=th.btnP; row2.TextColor3=Color3.new(1,1,1)
				end
				updateSel()
				if o.Callback then
					if multi then
						local l={}; for k,v in pairs(sel) do if v then table.insert(l,k) end end
						pcall(o.Callback,l)
					else pcall(o.Callback,sel) end
				end
			end)
			table.insert(iBtns,row2)
		end
	end
	rebuild()

	local panH=math.min(#items*28+6,170)
	local hitB=U.new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text="",ZIndex=22,Parent=wrap})
	hitB.MouseButton1Click:Connect(function()
		open=not open
		local ph=open and panH or 0
		U.tw(panel,U.M,{Size=UDim2.new(1,0,0,ph)})
		U.tw(wrap,U.M,{Size=UDim2.new(1,0,0,open and 42+ph or 42)})
	end)
	updateSel()
	return {Instance=wrap,
		GetValue=function()
			if multi then local l={}; for k,v in pairs(sel) do if v then table.insert(l,k) end end; return l end
			return sel
		end,
		SetValue=function(v) sel=v; updateSel() end}
end

-- ── Keybind ───────────────────────────────────────────────────────────────────
function E:Keybind(o)
	o=o or{}; local th=self.theme
	local key=o.Default or Enum.KeyCode.Unknown; local listening=false
	local row=rowCard(th,self.cont,42)
	U.new("TextLabel",{Size=UDim2.new(1,-100,0,42),Position=UDim2.new(0,0,0,0),
		BackgroundTransparency=1,Text=o.Text or "Tecla",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=12,Parent=row})
	local badge=U.new("TextButton",{Size=UDim2.new(0,82,0,26),Position=UDim2.new(1,-84,0.5,-13),
		BackgroundColor3=th.btnS,BorderSizePixel=0,
		Text=key==Enum.KeyCode.Unknown and "Ninguna" or key.Name,
		TextColor3=th.txtA,Font=th.fontB,TextSize=10,
		AutoButtonColor=false,ZIndex=12,Parent=row})
	U.corner(badge,th.r); U.stroke(badge,th.inBd,1)
	badge.MouseButton1Click:Connect(function()
		listening=true; badge.Text="..."; badge.TextColor3=th.accent
		U.tw(badge,U.F,{BackgroundColor3=th.btnSH})
	end)
	UIS.InputBegan:Connect(function(i,p)
		if p then return end
		if listening then
			listening=false; key=i.KeyCode; badge.Text=key.Name
			badge.TextColor3=th.txtA; U.tw(badge,U.F,{BackgroundColor3=th.btnS})
			if o.Callback then pcall(o.Callback,key) end
		elseif i.KeyCode==key then
			if o.Callback then pcall(o.Callback,key) end
		end
	end)
	return {Instance=row, GetValue=function() return key end, SetValue=function(k) key=k; badge.Text=k.Name end}
end

-- ── ColorPicker ───────────────────────────────────────────────────────────────
function E:ColorPicker(o)
	o=o or{}; local th=self.theme
	local col=o.Default or Color3.fromRGB(204,20,20)
	local h,s,v=Color3.toHSV(col); h=h*360; local open=false

	local wrap=U.new("Frame",{Size=UDim2.new(1,0,0,42),
		BackgroundTransparency=1,ClipsDescendants=false,ZIndex=20,Parent=self.cont})

	U.new("TextLabel",{Size=UDim2.new(1,-54,0,42),Position=UDim2.new(0,0,0,0),
		BackgroundTransparency=1,Text=o.Text or "Color",TextColor3=th.txt1,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=21,Parent=wrap})
	local prev=U.new("Frame",{Size=UDim2.new(0,28,0,20),Position=UDim2.new(1,-32,0.5,-10),
		BackgroundColor3=col,BorderSizePixel=0,ZIndex=21,Parent=wrap})
	U.corner(prev,th.r); U.stroke(prev,th.borderL,1)

	local panel=U.new("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,2),
		BackgroundColor3=th.card,BorderSizePixel=0,ClipsDescendants=true,ZIndex=25,Parent=wrap})
	U.corner(panel,th.r); U.stroke(panel,th.border,1)

	local sva=U.new("Frame",{Size=UDim2.new(1,-10,0,86),Position=UDim2.new(0,5,0,5),
		BackgroundColor3=Color3.fromHSV(h/360,1,1),BorderSizePixel=0,
		ClipsDescendants=true,ZIndex=26,Parent=panel})
	U.corner(sva,th.r)
	U.new("UIGradient",{
		Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)}),
		Parent=sva})
	local bov=U.new("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),ZIndex=27,Parent=sva})
	U.new("UIGradient",{
		Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),
		Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}),
		Parent=bov})
	local svK=U.new("Frame",{Size=UDim2.new(0,9,0,9),Position=UDim2.new(s,-4,1-v,-4),
		BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=29,Parent=sva})
	U.corner(svK,UDim.new(1,0)); U.stroke(svK,Color3.new(0,0,0),1)
	local svH=U.new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=30,Parent=sva})

	local hBar=U.new("Frame",{Size=UDim2.new(1,-10,0,10),Position=UDim2.new(0,5,0,95),
		BackgroundColor3=Color3.fromRGB(128,128,128),BorderSizePixel=0,ZIndex=26,Parent=panel})
	U.corner(hBar,UDim.new(1,0))
	local hK2={}; for i=0,1,1/6 do table.insert(hK2,ColorSequenceKeypoint.new(i,Color3.fromHSV(i,1,1))) end
	table.insert(hK2,ColorSequenceKeypoint.new(1,Color3.fromHSV(1,1,1)))
	U.new("UIGradient",{Color=ColorSequence.new(hK2),Parent=hBar})
	local hKnob=U.new("Frame",{Size=UDim2.new(0,7,0,14),Position=UDim2.new(h/360,-3,0.5,-7),
		BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=27,Parent=hBar})
	U.corner(hKnob,UDim.new(0,3)); U.stroke(hKnob,Color3.new(0,0,0),1)
	local hHit=U.new("TextButton",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,-10),
		BackgroundTransparency=1,Text="",ZIndex=28,Parent=hBar})

	local hexF=U.new("Frame",{Size=UDim2.new(1,-10,0,20),Position=UDim2.new(0,5,0,110),
		BackgroundColor3=th.inBg,ZIndex=26,Parent=panel})
	U.corner(hexF,th.r); U.stroke(hexF,th.inBd,1)
	local hexL=U.new("TextLabel",{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,6,0,0),
		BackgroundTransparency=1,Text=U.hex(col),TextColor3=th.txtA,
		Font=th.fontM,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=27,Parent=hexF})

	local function upd()
		col=Color3.fromHSV(h/360,s,v); prev.BackgroundColor3=col
		sva.BackgroundColor3=Color3.fromHSV(h/360,1,1)
		svK.Position=UDim2.new(s,-4,1-v,-4); hKnob.Position=UDim2.new(h/360,-3,0.5,-7)
		hexL.Text=U.hex(col)
		if o.Callback then pcall(o.Callback,col) end
	end

	local svDrag=false; svH.MouseButton1Down:Connect(function() svDrag=true end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then svDrag=false end
	end)
	UIS.InputChanged:Connect(function(i)
		if not svDrag then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local as=sva.AbsoluteSize; if as.X==0 or as.Y==0 then return end
		s=U.clamp((i.Position.X-sva.AbsolutePosition.X)/as.X,0,1)
		v=1-U.clamp((i.Position.Y-sva.AbsolutePosition.Y)/as.Y,0,1); upd()
	end)
	local hueDrag=false; hHit.MouseButton1Down:Connect(function() hueDrag=true end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then hueDrag=false end
	end)
	UIS.InputChanged:Connect(function(i)
		if not hueDrag then return end
		if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
		local a=hBar.AbsoluteSize.X; if a==0 then return end
		h=U.clamp((i.Position.X-hBar.AbsolutePosition.X)/a,0,1)*360; upd()
	end)

	local hitP=U.new("TextButton",{Size=UDim2.new(0,36,0,28),Position=UDim2.new(1,-38,0.5,-14),
		BackgroundTransparency=1,Text="",ZIndex=22,Parent=wrap})
	hitP.MouseButton1Click:Connect(function()
		open=not open; local ph=open and 136 or 0
		U.tw(panel,U.M,{Size=UDim2.new(1,0,0,ph)})
		U.tw(wrap,U.M,{Size=UDim2.new(1,0,0,open and 42+ph+2 or 42)})
	end)
	return {Instance=wrap, GetValue=function() return col end,
		SetValue=function(nc) col=nc; h,s,v=Color3.toHSV(nc); h=h*360; upd() end}
end

-- ── Label ─────────────────────────────────────────────────────────────────────
function E:Label(o)
	o=o or{}; local th=self.theme
	local row=rowCard(th,self.cont,28)
	local lbl=U.new("TextLabel",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),
		BackgroundTransparency=1,Text=o.Text or "",TextColor3=th.txt2,Font=th.font,
		TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,RichText=true,ZIndex=12,Parent=row})
	return {Instance=row, GetValue=function() return lbl.Text end, SetValue=function(v) lbl.Text=v end}
end

-- ── Paragraph ─────────────────────────────────────────────────────────────────
function E:Paragraph(o)
	o=o or{}; local th=self.theme
	local row=rowCard(th,self.cont,0,true)
	local lay=Instance.new("UIListLayout")
	lay.SortOrder=Enum.SortOrder.LayoutOrder; lay.Padding=UDim.new(0,3); lay.Parent=row
	if o.Title then
		U.new("TextLabel",{Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,
			Text=o.Title,TextColor3=th.txtA,Font=th.fontB,TextSize=11,
			TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1,ZIndex=12,Parent=row})
	end
	local body=U.new("TextLabel",{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,
		Text=o.Text or "",TextColor3=th.txt2,Font=th.font,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,
		AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=2,RichText=true,ZIndex=12,Parent=row})
	return {Instance=row, GetValue=function() return body.Text end, SetValue=function(v) body.Text=v end}
end

-- ── Divider ───────────────────────────────────────────────────────────────────
function E:Divider(o)
	o=o or{}; local th=self.theme
	local hasTxt=o.Text and o.Text~=""
	local f=U.new("Frame",{Size=UDim2.new(1,0,0,hasTxt and 22 or 10),
		BackgroundTransparency=1,ZIndex=10,Parent=self.cont})
	U.new("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),
		BackgroundColor3=th.divider,BorderSizePixel=0,ZIndex=10,Parent=f})
	if hasTxt then
		U.new("TextLabel",{Size=UDim2.new(0,0,1,0),Position=UDim2.new(0,0,0,0),
			BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.X,
			Text=o.Text,TextColor3=th.txtM,Font=th.fontB,TextSize=9,ZIndex=11,Parent=f})
	end
	return f
end

-- ─── Notifications ────────────────────────────────────────────────────────────
local Notif={}; Notif.__index=Notif

function Notif.new(sg, th)
	local self=setmetatable({},Notif); self.th=th; self.n=0
	self.cont=U.new("Frame",{Name="Toasts",Size=UDim2.new(0,290,1,-20),
		Position=UDim2.new(1,-300,0,10),BackgroundTransparency=1,ZIndex=500,Parent=sg})
	U.list(self.cont,nil,8)
	U.pad(self.cont,10,0,0,0)
	return self
end

function Notif:push(o)
	o=o or{}; local th=self.th; self.n+=1
	local title=o.Title or "Info"; local body=o.Content or ""
	local dur=o.Duration or 5; local ntype=o.Type or "Info"
	local colors={Info=th.accent,Success=th.online,Warning=Color3.fromRGB(255,185,40),Error=Color3.fromRGB(215,55,55)}
	local ac=colors[ntype] or th.accent

	local c=U.new("Frame",{Name="Toast"..self.n,Size=UDim2.new(1,0,0,64),
		BackgroundColor3=th.notifBg,BorderSizePixel=0,ZIndex=501,Parent=self.cont})
	U.corner(c,th.r); U.stroke(c,th.border,1)

	local bar=U.new("Frame",{Size=UDim2.new(0,3,1,-10),Position=UDim2.new(0,0,0,5),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=502,Parent=c})
	U.corner(bar,UDim.new(1,0))

	local prog=U.new("Frame",{Size=UDim2.new(1,-3,0,2),Position=UDim2.new(0,3,1,-2),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=502,Parent=c})

	local badge=U.new("Frame",{Size=UDim2.new(0,46,0,14),Position=UDim2.new(1,-54,0,8),
		BackgroundColor3=ac,BorderSizePixel=0,ZIndex=502,Parent=c})
	U.corner(badge,UDim.new(0,3))
	U.new("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text=ntype:upper(),TextColor3=Color3.new(1,1,1),Font=th.fontB,TextSize=8,ZIndex=503,Parent=badge})

	U.new("TextLabel",{Size=UDim2.new(1,-20,0,18),Position=UDim2.new(0,14,0,8),
		BackgroundTransparency=1,Text=title,TextColor3=th.txt1,Font=th.fontB,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left,ZIndex=502,Parent=c})
	U.new("TextLabel",{Size=UDim2.new(1,-20,0,28),Position=UDim2.new(0,14,0,28),
		BackgroundTransparency=1,Text=body,TextColor3=th.txt2,Font=th.font,TextSize=10,
		TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=502,Parent=c})

	c.Position=UDim2.new(1,10,0,0)
	U.tw(c,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)})
	U.tw(prog,TweenInfo.new(dur,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,2)})

	task.delay(dur,function()
		if not c or not c.Parent then return end
		U.tw(c,TweenInfo.new(0.22,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Size=UDim2.new(1,0,0,0)})
		task.delay(0.25,function() if c and c.Parent then c:Destroy() end end)
	end)
	return c
end

-- ─── Config ───────────────────────────────────────────────────────────────────
local Cfg={}; Cfg.__index=Cfg

function Cfg.new(lib) local self=setmetatable({},Cfg); self.lib=lib; return self end

function Cfg:fromURL(url)
	local ok,raw=pcall(function() return HS:GetAsync(url) end)
	if not ok then warn("[BloodLib] Config URL failed: "..tostring(raw)); return false end
	return self:_apply(raw)
end

function Cfg:fromJSON(s) return self:_apply(s) end

function Cfg:_apply(raw)
	local ok,d=pcall(function() return HS:JSONDecode(raw) end)
	if not ok then warn("[BloodLib] Config JSON invalid"); return false end
	if d.Theme then self.lib:setTheme(d.Theme) end
	if d.Settings then for k,v in pairs(d.Settings) do self.lib.cfg[k]=v end end
	return true
end

function Cfg:export()
	local d={Theme=self.lib.themeName,Settings=self.lib.cfg}
	local ok,j=pcall(function() return HS:JSONEncode(d) end)
	return ok and j or "{}"
end

-- ─── Library (Entry Point) ────────────────────────────────────────────────────
local Library={}; Library.__index=Library

function Library.new(opts)
	opts=opts or{}
	local self=setmetatable({},Library)
	self.themeName = opts.Theme or "Blood"
	self.theme     = T.get(self.themeName)
	self.cfg       = {}
	self.tabs      = {}
	self.activeTab = nil
	self.ver       = "1.0"

	self.win = Win.new({
		Title    = opts.Title    or "BLOOD LIBRARY",
		Logo     = opts.Logo     or "rbxassetid://72559578724301",
		Subtitle = opts.Subtitle or "BLOOD HUB",
		Size     = opts.Size,
		Draggable= opts.Draggable,
	}, self.theme, self)

	self.notif = Notif.new(self.win.sg, self.theme)
	self.cfgM  = Cfg.new(self)
	self.WindowInstance = self.win
	return self
end

-- ── Tab creation ──────────────────────────────────────────────────────────────
function Library:tab(opts)
	opts=opts or{}
	local th      = self.theme
	local W       = self.win
	local name    = opts.Name     or "Tab"
	local icon    = opts.Icon     or ""
	local order   = opts.Order    or #self.tabs+1
	local sub     = opts.Subtitle or ""
	local enabled = opts.Enabled~=false
	local first   = #self.tabs==0

	-- ── Sidebar button (KOD style: full red bg when active) ──────────────────
	local btn=U.new("Frame",{Name="Btn_"..name,Size=UDim2.new(1,0,0,36),
		BackgroundColor3=first and th.tabA or th.tabI,BorderSizePixel=0,
		LayoutOrder=order,ZIndex=5,Parent=W.tabScroll})
	U.corner(btn,th.r)

	local xo=icon~="" and 30 or 12
	if icon~="" then
		U.new("ImageLabel",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,10,0.5,-8),
			BackgroundTransparency=1,Image=icon,
			ImageColor3=first and Color3.new(1,1,1) or th.tabTxtI,ZIndex=6,Parent=btn})
	end
	local bLbl=U.new("TextLabel",{Size=UDim2.new(1,-(xo+6),1,0),Position=UDim2.new(0,xo,0,0),
		BackgroundTransparency=1,Text=name,
		TextColor3=first and th.tabTxt or th.tabTxtI,
		Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=btn})

	-- ── Content frame: 2-column grid ─────────────────────────────────────────
	local cf=U.new("Frame",{Name="CF_"..name,
		Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
		BackgroundTransparency=1,Visible=first,ZIndex=5,Parent=W.cs})
	U.pad(cf,10,10,14,10)

	-- Two columns side by side
	local grid=U.new("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
		BackgroundTransparency=1,ZIndex=5,Parent=cf})
	local gridL=Instance.new("UIListLayout")
	gridL.FillDirection=Enum.FillDirection.Horizontal
	gridL.HorizontalAlignment=Enum.HorizontalAlignment.Left
	gridL.VerticalAlignment=Enum.VerticalAlignment.Top
	gridL.Padding=UDim.new(0,8)
	gridL.SortOrder=Enum.SortOrder.LayoutOrder
	gridL.Parent=grid

	local colL=U.new("Frame",{Name="ColL",Size=UDim2.new(0.5,-4,0,0),
		AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,
		LayoutOrder=1,ZIndex=5,Parent=grid})
	U.list(colL,nil,8)

	local colR=U.new("Frame",{Name="ColR",Size=UDim2.new(0.5,-4,0,0),
		AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,
		LayoutOrder=2,ZIndex=5,Parent=grid})
	U.list(colR,nil,8)

	-- Auto-update canvas size when content changes
	for _,col in ipairs({colL,colR}) do
		local ll=col:FindFirstChildOfClass("UIListLayout")
		if ll then
			ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if self.activeTab and self.activeTab.cf==cf then
					local maxH=math.max(colL.AbsoluteSize.Y,colR.AbsoluteSize.Y)
					W.cs.CanvasSize=UDim2.new(0,0,0,maxH+24+20)
				end
			end)
		end
	end

	local tabObj={name=name,icon=icon,sub=sub,order=order,enabled=enabled,
		cf=cf,btn=btn,lbl=bLbl,colL=colL,colR=colR,lib=self,theme=th,
		_nextCol="left"}

	-- Hit button
	local hitB=U.new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
		Text="",ZIndex=7,Parent=btn})
	hitB.MouseEnter:Connect(function()
		if self.activeTab==tabObj then return end
		U.tw(btn,U.F,{BackgroundColor3=th.tabHov})
		U.tw(bLbl,U.F,{TextColor3=th.txt2})
	end)
	hitB.MouseLeave:Connect(function()
		if self.activeTab==tabObj then return end
		U.tw(btn,U.F,{BackgroundColor3=th.tabI})
		U.tw(bLbl,U.F,{TextColor3=th.tabTxtI})
	end)
	hitB.MouseButton1Click:Connect(function()
		if not tabObj.enabled then return end
		self:_select(tabObj)
	end)

	-- ── Section factory ───────────────────────────────────────────────────────
	-- Creates a titled, bordered section box in left or right column.
	-- Elements go inside. Matches KOD "Player / Combat / Info / Misc" boxes.
	function tabObj:Section(sopts)
		sopts=sopts or{}
		local sname=sopts.Name or ""
		local sicon=sopts.Icon or ""
		local col=sopts.Column=="right" and self.colR or self.colL

		local box=U.new("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
			BackgroundColor3=th.secBg,BorderSizePixel=0,ZIndex=8,Parent=col})
		U.corner(box,th.r); U.stroke(box,th.border,1)

		-- Section header bar
		local hdr=U.new("Frame",{Size=UDim2.new(1,0,0,28),BackgroundColor3=th.secHdr,
			BorderSizePixel=0,ZIndex=9,Parent=box})
		U.corner(hdr,th.r)
		-- Square off bottom corners of header
		U.new("Frame",{Size=UDim2.new(1,0,0,th.r.Offset),Position=UDim2.new(0,0,1,-th.r.Offset),
			BackgroundColor3=th.secHdr,BorderSizePixel=0,ZIndex=9,Parent=hdr})
		-- Separator under header
		U.new("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),
			BackgroundColor3=th.border,BorderSizePixel=0,ZIndex=9,Parent=hdr})

		local hx=sicon~="" and 26 or 8
		if sicon~="" then
			U.new("ImageLabel",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,8,0.5,-7),
				BackgroundTransparency=1,Image=sicon,ImageColor3=th.accent,ZIndex=10,Parent=hdr})
		end
		U.new("TextLabel",{Size=UDim2.new(1,-(hx+6),1,0),Position=UDim2.new(0,hx,0,0),
			BackgroundTransparency=1,Text=sname,TextColor3=th.secTxt,
			Font=th.fontB,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=10,Parent=hdr})

		-- Inner element list (padded, inside box below header)
		local inner=U.new("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,0,28),
			AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,ZIndex=8,Parent=box})
		U.list(inner,nil,0)
		U.pad(inner,8,10,10,10)

		-- Each element row inside gets a bottom separator (KOD style)
		local secObj={cont=inner,theme=th,lib=self.lib}
		setmetatable(secObj,{__index=E})

		-- Wrap element methods to add a separator line after each element
		local function addEl(fn, o2)
			local el=fn(secObj,o2)
			-- Light separator between rows
			local sep=U.new("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.border,
				BorderSizePixel=0,ZIndex=9,Parent=inner})
			return el
		end

		local sWrap={}
		function sWrap:Toggle(o2)      return addEl(E.Toggle,o2) end
		function sWrap:Slider(o2)      return addEl(E.Slider,o2) end
		function sWrap:Button(o2)      return addEl(E.Button,o2) end
		function sWrap:Textbox(o2)     return addEl(E.Textbox,o2) end
		function sWrap:Keybind(o2)     return addEl(E.Keybind,o2) end
		function sWrap:ColorPicker(o2) return addEl(E.ColorPicker,o2) end
		function sWrap:Label(o2)       return addEl(E.Label,o2) end
		function sWrap:Paragraph(o2)   return addEl(E.Paragraph,o2) end
		function sWrap:Divider(o2)     secObj:Divider(o2) end

		return sWrap
	end

	-- Direct element methods (added to full width, to left column by default)
	local function mkECtx(targetCol)
		local ctx={cont=targetCol,theme=th,lib=tabObj.lib}
		setmetatable(ctx,{__index=E})
		return ctx
	end

	function tabObj:Toggle(o)      return mkECtx(self.colL):Toggle(o) end
	function tabObj:Slider(o)      return mkECtx(self.colL):Slider(o) end
	function tabObj:Button(o)      return mkECtx(self.colL):Button(o) end
	function tabObj:Textbox(o)     return mkECtx(self.colL):Textbox(o) end
	function tabObj:Keybind(o)     return mkECtx(self.colL):Keybind(o) end
	function tabObj:ColorPicker(o) return mkECtx(self.colL):ColorPicker(o) end
	function tabObj:Label(o)       return mkECtx(self.colL):Label(o) end
	function tabObj:Paragraph(o)   return mkECtx(self.colL):Paragraph(o) end
	function tabObj:Divider(o)     mkECtx(self.colL):Divider(o) end

	function tabObj:setEnabled(en)
		tabObj.enabled=en
		btn.BackgroundTransparency=en and 0 or 0.5
		bLbl.TextTransparency=en and 0 or 0.5
	end

	table.insert(self.tabs,tabObj)
	if first then
		self.activeTab=tabObj
		W:setTitle(name,sub)
		task.defer(function()
			local maxH=math.max(colL.AbsoluteSize.Y,colR.AbsoluteSize.Y)
			W.cs.CanvasSize=UDim2.new(0,0,0,maxH+24+20)
		end)
	end
	return tabObj
end

Library.CreateTab = Library.tab

-- ── Tab select ────────────────────────────────────────────────────────────────
function Library:_select(t)
	local th=self.theme
	local W=self.win; W.cs.CanvasPosition=Vector2.new(0,0)

	for _,tab in ipairs(self.tabs) do
		tab.cf.Visible=false
		U.tw(tab.btn,U.F,{BackgroundColor3=th.tabI})
		U.tw(tab.lbl,U.F,{TextColor3=th.tabTxtI})
		local img=tab.btn:FindFirstChildOfClass("ImageLabel")
		if img then U.tw(img,U.F,{ImageColor3=th.tabTxtI}) end
	end
	self.activeTab=t; t.cf.Visible=true
	U.tw(t.btn,U.F,{BackgroundColor3=th.tabA})
	U.tw(t.lbl,U.F,{TextColor3=th.tabTxt})
	local img=t.btn:FindFirstChildOfClass("ImageLabel")
	if img then U.tw(img,U.F,{ImageColor3=Color3.new(1,1,1)}) end

	W:setTitle(t.name,t.sub or "")
	task.defer(function()
		local cL=t.colL; local cR=t.colR
		local maxH=math.max(cL and cL.AbsoluteSize.Y or 0, cR and cR.AbsoluteSize.Y or 0)
		W.cs.CanvasSize=UDim2.new(0,0,0,maxH+44)
	end)
end

Library.SelectTab=function(self,t) self:_select(t) end

-- ── Theme ─────────────────────────────────────────────────────────────────────
function Library:setTheme(n)
	if type(n)=="string" then self.themeName=n; self.theme=T.get(n)
	else self.theme=T.merge(T.Blood,n); self.themeName="Custom" end
end

Library.SetTheme=Library.setTheme

-- ── Notify ────────────────────────────────────────────────────────────────────
function Library:Notify(o) return self.notif:push(o) end

-- ── Config ────────────────────────────────────────────────────────────────────
function Library:LoadConfig(s)
	if s:find("://") then return self.cfgM:fromURL(s) end
	return self.cfgM:fromJSON(s)
end
function Library:ExportConfig() return self.cfgM:export() end

-- ── Settings ──────────────────────────────────────────────────────────────────
function Library:SaveSetting(k,v) self.cfg[k]=v; U.save("BloodLib",k,v) end
function Library:LoadSetting(k)
	local v=U.load("BloodLib",k); if v~=nil then self.cfg[k]=v end; return v
end

-- ── Misc ──────────────────────────────────────────────────────────────────────
function Library:SetScale(s) self.win.main.Size=UDim2.new(0,780*s,0,530*s) end
function Library:SetVisible(v) self.win:setVisible(v) end
function Library:Close() self.win:close() end

function Library:CheckUpdate(url,cur)
	local ok,raw=pcall(function() return HS:GetAsync(url) end); if not ok then return end
	local ok2,d=pcall(function() return HS:JSONDecode(raw) end)
	if ok2 and d.Version and d.Version>cur then
		self:Notify({Title="Actualizacion disponible",Content="v"..d.Version.." lista",Type="Info",Duration=8})
	end
end

return Library
