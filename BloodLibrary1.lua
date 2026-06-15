-- Blood Library v5.0
-- Framework de UI para Roblox â€” sin contenido predefinido.
-- Uso: local Lib = loadstring(game:HttpGet("URL"))()

if getgenv().BloodLib then pcall(function() getgenv().BloodLib:Destroy() end) end

cloneref = cloneref or function(o) return o end

local Players          = cloneref(game:GetService("Players"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService     = cloneref(game:GetService("TweenService"))
local HttpService      = cloneref(game:GetService("HttpService"))
local CoreGui          = cloneref(game:GetService("CoreGui"))
gethui = gethui or function() return CoreGui end
local LP = Players.LocalPlayer

-- â”€â”€â”€ Iconos Lucide â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Icons = {
        ["home"]="rbxassetid://10723407389",["settings"]="rbxassetid://10709810948",
        ["cog"]="rbxassetid://10709810948",["user"]="rbxassetid://10723550978",
        ["users"]="rbxassetid://10723551083",["shield"]="rbxassetid://10723540195",
        ["shieldcheck"]="rbxassetid://10723540049",["sword"]="rbxassetid://10723547726",
        ["swords"]="rbxassetid://10723547883",["crosshair"]="rbxassetid://10709818534",
        ["target"]="rbxassetid://10723548259",["zap"]="rbxassetid://10723554694",
        ["flame"]="rbxassetid://10723376114",["star"]="rbxassetid://10723546388",
        ["heart"]="rbxassetid://10723406885",["eye"]="rbxassetid://10723346959",
        ["eyeoff"]="rbxassetid://10723346871",["globe"]="rbxassetid://10723404337",
        ["compass"]="rbxassetid://10709811445",["activity"]="rbxassetid://10709752035",
        ["alerttriangle"]="rbxassetid://10709753149",["alertcircle"]="rbxassetid://10709752996",
        ["info"]="rbxassetid://10723415903",["helpcircle"]="rbxassetid://10723406988",
        ["checkcircle"]="rbxassetid://10709790387",["check"]="rbxassetid://10709790644",
        ["x"]="rbxassetid://10723553393",["plus"]="rbxassetid://10723526862",
        ["minus"]="rbxassetid://10723521534",["refresh"]="rbxassetid://10723530027",
        ["download"]="rbxassetid://10723344270",["upload"]="rbxassetid://10723552116",
        ["save"]="rbxassetid://10723535018",["folder"]="rbxassetid://10723387563",
        ["folderopen"]="rbxassetid://10723386277",["file"]="rbxassetid://10723374641",
        ["filetext"]="rbxassetid://10723367380",["edit"]="rbxassetid://10734883598",
        ["edit2"]="rbxassetid://10723344885",["trash"]="rbxassetid://10723549558",
        ["trash2"]="rbxassetid://10723549696",["copy"]="rbxassetid://10709812159",
        ["clipboard"]="rbxassetid://10709799288",["lock"]="rbxassetid://10723434711",
        ["unlock"]="rbxassetid://10723551847",["key"]="rbxassetid://10723416652",
        ["cpu"]="rbxassetid://10709813383",["monitor"]="rbxassetid://10723521855",
        ["smartphone"]="rbxassetid://10723541894",["wifi"]="rbxassetid://10723552817",
        ["wifioff"]="rbxassetid://10723552716",["bluetooth"]="rbxassetid://10709776655",
        ["camera"]="rbxassetid://10709789686",["video"]="rbxassetid://10723552337",
        ["mic"]="rbxassetid://10723521349",["volume"]="rbxassetid://10723552490",
        ["volumex"]="rbxassetid://10723552644",["music"]="rbxassetid://10723522170",
        ["headphones"]="rbxassetid://10723406165",["gamepad"]="rbxassetid://10723395457",
        ["gamepad2"]="rbxassetid://10723395215",["joystick"]="rbxassetid://10723416527",
        ["flag"]="rbxassetid://10723375890",["gift"]="rbxassetid://10723396402",
        ["award"]="rbxassetid://10709769406",["crown"]="rbxassetid://10709818626",
        ["gem"]="rbxassetid://10723396000",["diamond"]="rbxassetid://10709819149",
        ["coins"]="rbxassetid://10709811110",["banknote"]="rbxassetid://10709770178",
        ["tag"]="rbxassetid://10723548076",["box"]="rbxassetid://10709782497",
        ["layers"]="rbxassetid://10723424505",["grid"]="rbxassetid://10723404936",
        ["list"]="rbxassetid://10723433811",["layoutdashboard"]="rbxassetid://10723424646",
        ["barchart"]="rbxassetid://10709773755",["linechart"]="rbxassetid://10723426393",
        ["gauge"]="rbxassetid://10723395708",["cloud"]="rbxassetid://10709806740",
        ["sun"]="rbxassetid://10723547595",["moon"]="rbxassetid://10723521699",
        ["bug"]="rbxassetid://10709782845",["terminal"]="rbxassetid://10723548620",
        ["code"]="rbxassetid://10709810463",["database"]="rbxassetid://10709818996",
        ["server"]="rbxassetid://10723539440",["share"]="rbxassetid://10723539671",
        ["link"]="rbxassetid://10723426722",["search"]="rbxassetid://10723535152",
        ["filter"]="rbxassetid://10723375128",["sliders"]="rbxassetid://10723541614",
        ["trendingup"]="rbxassetid://10723549370",["trendingdown"]="rbxassetid://10723549230",
        ["arrowup"]="rbxassetid://10709768939",["arrowdown"]="rbxassetid://10709767827",
        ["arrowleft"]="rbxassetid://10709768114",["arrowright"]="rbxassetid://10709768347",
        ["chevronup"]="rbxassetid://10709791523",["chevrondown"]="rbxassetid://10709790948",
        ["chevronleft"]="rbxassetid://10709791281",["chevronright"]="rbxassetid://10709791437",
        ["maximize"]="rbxassetid://10723520876",["minimize"]="rbxassetid://10723521442",
        ["power"]="rbxassetid://10723526731",["poweroff"]="rbxassetid://10723526806",
        ["play"]="rbxassetid://10723526497",["pause"]="rbxassetid://10723524430",
        ["stop"]="rbxassetid://10723547329",["bell"]="rbxassetid://10709775704",
        ["belloff"]="rbxassetid://10709775320",["mail"]="rbxassetid://10734885430",
        ["message"]="rbxassetid://10723520971",["send"]="rbxassetid://10723539210",
        ["calendar"]="rbxassetid://10709789505",["clock"]="rbxassetid://10709805144",
        ["timer"]="rbxassetid://10723549001",["history"]="rbxassetid://10723407335",
        ["hourglass"]="rbxassetid://10723407498",["bookmark"]="rbxassetid://10709782154",
        ["thumbsup"]="rbxassetid://10723548979",["thumbsdown"]="rbxassetid://10723548903",
        ["smile"]="rbxassetid://10723541839",["frown"]="rbxassetid://10723394681",
        ["ghost"]="rbxassetid://10723396107",["skull"]="rbxassetid://10723541438",
        ["bomb"]="rbxassetid://10709781460",["hammer"]="rbxassetid://10723405360",
        ["wrench"]="rbxassetid://10723553293",["tool"]="rbxassetid://10723549128",
        ["scissors"]="rbxassetid://10723535098",["axe"]="rbxassetid://10709769508",
        ["anchor"]="rbxassetid://10709761530",["magnet"]="rbxassetid://10723435069",
        ["feather"]="rbxassetid://10723354671",["leaf"]="rbxassetid://10723425539",
        ["tree"]="rbxassetid://10723549321",["mountain"]="rbxassetid://10723521990",
        ["bike"]="rbxassetid://10709775894",["car"]="rbxassetid://10709789810",
        ["plane"]="rbxassetid://10723526119",["rocket"]="rbxassetid://10723532628",
        ["navigation"]="rbxassetid://10723522244",["locate"]="rbxassetid://10723434557",
        ["fingerprint"]="rbxassetid://10723375250",["binary"]="rbxassetid://10709776050",
        ["infinity"]="rbxassetid://10723415766",["hash"]="rbxassetid://10723405975",
        ["person"]="rbxassetid://10723550978",["menu"]="rbxassetid://10723521207",
        ["command"]="rbxassetid://10709811365",["lightbulb"]="rbxassetid://10723425852",
        ["lamp"]="rbxassetid://10723417513",["building"]="rbxassetid://10709783051",
        ["factory"]="rbxassetid://10723347051",["misc"]="rbxassetid://10723522023",
        ["more"]="rbxassetid://10723524027",["dots"]="rbxassetid://10723524027",
        ["percent"]="rbxassetid://10723525432",["dollarsign"]="rbxassetid://10723343958",
        ["contact"]="rbxassetid://10709811834",["package"]="rbxassetid://10723524268",
        ["robot"]="rbxassetid://10709782230",["bot"]="rbxassetid://10709782230",
}

-- â”€â”€â”€ Temas â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Themes = {
        Red    = Color3.fromRGB(185, 0,   0),
        Blue   = Color3.fromRGB(0,   100, 220),
        Purple = Color3.fromRGB(140, 0,   255),
        Green  = Color3.fromRGB(0,   155, 60),
        Orange = Color3.fromRGB(220, 105, 0),
        Pink   = Color3.fromRGB(210, 0,   140),
        Cyan   = Color3.fromRGB(0,   170, 200),
        White  = Color3.fromRGB(200, 200, 200),
}

-- â”€â”€â”€ Paleta dinÃ¡mica â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local C = {
        BG        = Color3.fromRGB(11,11,11),
        Sidebar   = Color3.fromRGB(16,16,16),
        Header    = Color3.fromRGB(13,13,13),
        Section   = Color3.fromRGB(18,18,18),
        Hover     = Color3.fromRGB(26,26,26),
        Text      = Color3.fromRGB(238,238,238),
        TextSub   = Color3.fromRGB(148,148,148),
        TextDim   = Color3.fromRGB(72,72,72),
        ToggleOff = Color3.fromRGB(50,50,50),
        SliderBG  = Color3.fromRGB(36,36,36),
        Success   = Color3.fromRGB(0,170,60),
        Warning   = Color3.fromRGB(220,148,0),
        Error     = Color3.fromRGB(210,28,28),
        -- accent (calculados desde base)
        Accent    = Color3.fromRGB(185,0,0),
        AccentHov = Color3.fromRGB(210,22,22),
        AccentDrk = Color3.fromRGB(92,0,0),
        Border    = Color3.fromRGB(42,7,7),
}

local function recalcAccent(base)
        C.Accent    = base
        C.AccentHov = base:Lerp(Color3.new(1,1,1), 0.14)
        C.AccentDrk = base:Lerp(Color3.new(0,0,0), 0.50)
        C.Border    = base:Lerp(Color3.new(0,0,0), 0.74)
end

-- Registro de objetos acento para re-colorear en SetTheme
local _acReg = {} -- {obj, prop, kind}  kind: "accent"|"accentHov"|"accentDrk"|"border"

-- Registro de elementos con Flag para sincronizar al cambiar perfil
local _flagReg = {} -- {flag, setter, default}
local function regFlag(flag, setter, default)
        if not flag then return end
        for _,e in ipairs(_flagReg) do
                if e.flag==flag then e.setter=setter; return end
        end
        table.insert(_flagReg, {flag=flag, setter=setter, default=default})
end

local function regA(obj, prop, kind)
        table.insert(_acReg, {o=obj, p=prop, k=kind or "accent"})
        obj[prop] = (kind=="accentHov" and C.AccentHov) or (kind=="accentDrk" and C.AccentDrk) or (kind=="border" and C.Border) or C.Accent
        return obj
end

-- â”€â”€â”€ Assets â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local A = {
        toggleBG   = "rbxassetid://18772190202",
        toggleHead = "rbxassetid://18772309008",
        sliderBar  = "rbxassetid://18772615246",
        sliderHead = "rbxassetid://18772834246",
        dropArrow  = "rbxassetid://18865373378",
        libIcon    = "rbxassetid://72559578724301",
        shadow     = "rbxassetid://6014261993",
        closeIcon  = "rbxassetid://9886659671",
        minIcon    = "rbxassetid://9886659505",
        btnSlice   = "rbxassetid://9386394468",
        searchIcon = Icons["search"] or "",
}

-- â”€â”€â”€ Helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function tw(o,p,t,s,d)
        TweenService:Create(o,TweenInfo.new(t or 0.18,s or Enum.EasingStyle.Quart,d or Enum.EasingDirection.Out),p):Play()
end
local function corner(p,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 6) c.Parent=p return c end
local function stroke(p,col,th) local s=Instance.new("UIStroke") s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Color=col or C.Border s.Thickness=th or 1 s.Parent=p return s end
local function pad(p,t,r,b,l) local u=Instance.new("UIPadding") u.PaddingTop=UDim.new(0,t or 0) u.PaddingRight=UDim.new(0,r or 0) u.PaddingBottom=UDim.new(0,b or 0) u.PaddingLeft=UDim.new(0,l or 0) u.Parent=p end
local function frm(par,bg,sz,pos,props)
        local f=Instance.new("Frame") f.BackgroundColor3=bg or Color3.new() f.BackgroundTransparency=bg==nil and 1 or 0 f.BorderSizePixel=0
        f.Size=sz or UDim2.new(1,0,1,0) f.Position=pos or UDim2.new()
        if props then for k,v in pairs(props) do pcall(function() f[k]=v end) end end f.Parent=par return f
end
local function lbl(par,txt,sz,col,font,props)
        local l=Instance.new("TextLabel") l.Text=txt or "" l.TextSize=sz or 13 l.TextColor3=col or C.Text l.Font=font or Enum.Font.Gotham
        l.BackgroundTransparency=1 l.BorderSizePixel=0 l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Center l.RichText=true
        if props then for k,v in pairs(props) do pcall(function() l[k]=v end) end end l.Parent=par return l
end
local function img(par,id,col,sz,pos,props)
        local i=Instance.new("ImageLabel") i.Image=id or "" i.ImageColor3=col or Color3.new(1,1,1) i.BackgroundTransparency=1 i.BorderSizePixel=0
        i.Size=sz or UDim2.fromOffset(16,16) i.Position=pos or UDim2.new()
        if props then for k,v in pairs(props) do pcall(function() i[k]=v end) end end i.Parent=par return i
end
local function btn(par,props)
        local b=Instance.new("TextButton") b.Text="" b.BackgroundTransparency=1 b.BorderSizePixel=0 b.AutoButtonColor=false b.Font=Enum.Font.Gotham b.TextSize=13
        if props then for k,v in pairs(props) do pcall(function() b[k]=v end) end end b.Parent=par return b
end
local function shadow(par)
        return img(par,A.shadow,Color3.new(0,0,0),UDim2.new(1,60,1,60),UDim2.new(0,-30,0,-30),{ZIndex=0,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ImageTransparency=0.6})
end
local function divLine(par,yOff)
        local d=frm(par,C.Border,UDim2.new(1,-18,0,1),UDim2.new(0,9,0,yOff or 0))
        d.BackgroundTransparency=0.45 return d
end
local function getIcon(k)
        if not k then return nil end
        if k:find("rbxassetid://") then return k end
        return Icons[k:lower()]
end

-- â”€â”€â”€ Sistema de Notificaciones v2 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local nGui = Instance.new("ScreenGui")
nGui.Name = "BloodNotifs"; nGui.ResetOnSpawn = false
nGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; nGui.DisplayOrder = 2147483647
pcall(function() nGui.Parent = gethui() end)
if not nGui.Parent then nGui.Parent = LP:WaitForChild("PlayerGui") end

-- Config global de notificaciones
local NConfig = {
        Position   = "bottom-right", -- "top-right"|"top-left"|"bottom-right"|"bottom-left"|"top-center"|"bottom-center"
        MaxVisible = 5,              -- mÃ¡ximo de notifs visibles al mismo tiempo
        Width      = 300,
        Padding    = 10,
}
local _nQueue   = {}  -- cola de notificaciones pendientes
local _nActive  = 0   -- cuÃ¡ntas estÃ¡n visibles ahora

-- Calcula posiciÃ³n y direcciÃ³n del holder segÃºn NConfig.Position
local function calcHolderProps()
        local p, w, pad2 = NConfig.Position, NConfig.Width, NConfig.Padding
        local ancX, ancY, posX, posY, listVAlign, listHAlign
        if     p == "top-right"     then ancX,ancY=1,0; posX=UDim2.new(1,-(w+pad2),0,0);         listVAlign=Enum.VerticalAlignment.Top
        elseif p == "top-left"      then ancX,ancY=0,0; posX=UDim2.new(0,pad2,0,0);              listVAlign=Enum.VerticalAlignment.Top
        elseif p == "bottom-left"   then ancX,ancY=0,1; posX=UDim2.new(0,pad2,1,0);              listVAlign=Enum.VerticalAlignment.Bottom
        elseif p == "top-center"    then ancX,ancY=0.5,0; posX=UDim2.new(0.5,-(w//2),0,0);       listVAlign=Enum.VerticalAlignment.Top
        elseif p == "bottom-center" then ancX,ancY=0.5,1; posX=UDim2.new(0.5,-(w//2),1,0);       listVAlign=Enum.VerticalAlignment.Bottom
        else                              ancX,ancY=1,1; posX=UDim2.new(1,-(w+pad2),1,0);         listVAlign=Enum.VerticalAlignment.Bottom
        end
        return posX, UDim2.new(0,w,1,0), Vector2.new(ancX,ancY), listVAlign
end

local nPos, nSz, nAnc, nVAlign = calcHolderProps()
local nHolder = frm(nGui, nil, nSz, nPos, {AnchorPoint=nAnc})
pad(nHolder, NConfig.Padding, 0, NConfig.Padding, 0)
local nList = Instance.new("UIListLayout")
nList.SortOrder = Enum.SortOrder.LayoutOrder
nList.VerticalAlignment = nVAlign
nList.Padding = UDim.new(0,6)
nList.Parent = nHolder

local function dismissCard(card, onDone)
        tw(card, {Size=UDim2.new(1,0,0,0), BackgroundTransparency=1}, 0.2,
                Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.delay(0.22, function()
                pcall(function() card:Destroy() end)
                _nActive = math.max(0, _nActive - 1)
                if onDone then pcall(onDone) end
        end)
end

local function spawnCard(o)
        if _nActive >= NConfig.MaxVisible then
                -- descartar la mÃ¡s antigua (primer hijo Frame)
                for _,ch in ipairs(nHolder:GetChildren()) do
                        if ch:IsA("Frame") then dismissCard(ch); break end
                end
        end
        _nActive = _nActive + 1

        local ac = (o.Type=="success" and C.Success) or (o.Type=="warning" and C.Warning)
                    or (o.Type=="error" and C.Error) or o.Color or C.Accent
        local dur = tonumber(o.Duration) or 5
        local ic  = o.Icon or
                    (o.Type=="success" and Icons["checkcircle"])  or
                    (o.Type=="warning" and Icons["alerttriangle"]) or
                    (o.Type=="error"   and Icons["alertcircle"])   or Icons["bell"]

        -- Altura base: tÃ­tulo+texto; mÃ¡s alta si hay botones de acciÃ³n
        local hasActions = o.Actions and #o.Actions > 0
        local baseH = (o.Text and o.Text~="" and 60 or 44)
        local cardH = hasActions and (baseH + 36) or baseH

        local card = frm(nHolder, Color3.fromRGB(14,14,14),
                UDim2.new(1,0,0,0), nil,
                {ClipsDescendants=true, LayoutOrder=-math.floor(tick()*1000)})
        corner(card,9)
        local sk = stroke(card, ac, 1); sk.Transparency = 0.45

        -- Barra lateral de color
        local sideBar = frm(card, ac, UDim2.new(0,3,1,0))

        -- Icono
        img(card, ic, ac, UDim2.fromOffset(17,17), UDim2.new(0,12,0,12))

        -- BotÃ³n X para cerrar
        local closeB = btn(card, {Size=UDim2.fromOffset(18,18), Position=UDim2.new(1,-22,0,5), ZIndex=6})
        img(closeB, A.closeIcon, C.TextDim, UDim2.fromOffset(10,10), UDim2.new(0.5,-5,0.5,-5))
        closeB.MouseEnter:Connect(function() tw(closeB:FindFirstChildWhichIsA("ImageLabel"),{ImageColor3=C.Text},0.1) end)
        closeB.MouseLeave:Connect(function() tw(closeB:FindFirstChildWhichIsA("ImageLabel"),{ImageColor3=C.TextDim},0.1) end)
        closeB.MouseButton1Click:Connect(function() dismissCard(card) end)

        -- TÃ­tulo
        lbl(card, o.Title or "Blood", 13, C.Text, Enum.Font.GothamBold,
                {Size=UDim2.new(1,-54,0,16), Position=UDim2.new(0,34,0,8)})

        -- Texto (solo si existe)
        if o.Text and o.Text ~= "" then
                lbl(card, tostring(o.Text), 11, C.TextSub, nil,
                        {Size=UDim2.new(1,-54,0,14), Position=UDim2.new(0,34,0,26), TextWrapped=true,
                         TextTruncate=Enum.TextTruncate.None})
        end

        -- Botones de acciÃ³n (ej: {"Deshacer", fn}, {"Ver mÃ¡s", fn})
        if hasActions then
                local actRow = frm(card, nil, UDim2.new(1,-14,0,28), UDim2.new(0,7,0,baseH+4), {BackgroundTransparency=1})
                local actList = Instance.new("UIListLayout"); actList.FillDirection=Enum.FillDirection.Horizontal
                actList.Padding=UDim.new(0,6); actList.VerticalAlignment=Enum.VerticalAlignment.Center; actList.Parent=actRow
                for _,act in ipairs(o.Actions) do
                        local aLabel = type(act)=="table" and act[1] or tostring(act)
                        local aCb    = type(act)=="table" and act[2] or function() end
                        local aB = Instance.new("ImageButton")
                        aB.Image=A.btnSlice; aB.ScaleType=Enum.ScaleType.Slice; aB.SliceCenter=Rect.new(4,4,12,12)
                        aB.ImageColor3=ac; aB.BackgroundColor3=ac
                        aB.BackgroundTransparency=0; aB.BorderSizePixel=0; aB.AutoButtonColor=false
                        aB.Size=UDim2.new(0,0,1,0); aB.AutomaticSize=Enum.AutomaticSize.X
                        aB.Parent=actRow; corner(aB,5)
                        local aTxt=lbl(aB, aLabel, 11, Color3.new(1,1,1), Enum.Font.GothamSemibold,
                                {Size=UDim2.new(0,0,1,0), AutomaticSize=Enum.AutomaticSize.X,
                                 TextXAlignment=Enum.TextXAlignment.Center})
                        pad(aB,0,10,0,10)
                        aB.MouseEnter:Connect(function() tw(aB,{ImageColor3=ac:Lerp(Color3.new(1,1,1),0.15),BackgroundColor3=ac:Lerp(Color3.new(1,1,1),0.15)},0.1) end)
                        aB.MouseLeave:Connect(function() tw(aB,{ImageColor3=ac,BackgroundColor3=ac},0.1) end)
                        aB.MouseButton1Click:Connect(function()
                                pcall(aCb); dismissCard(card)
                        end)
                end
        end

        -- Barra de progreso
        local bar = frm(card, ac, UDim2.new(1,0,0,2), UDim2.new(0,0,1,-2))
        bar.BackgroundTransparency = 0.3

        -- Animar entrada
        tw(card, {Size=UDim2.new(1,0,0,cardH)}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        -- Barra de progreso
        tw(bar, {Size=UDim2.new(0,0,0,2)}, dur, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        -- Auto-dismiss
        task.delay(dur, function()
                dismissCard(card)
        end)

        return card
end

local function Notify(o)
        task.spawn(spawnCard, o)
end

-- â”€â”€â”€ LibrerÃ­a principal â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Lib = {}
Lib.__index  = Lib
Lib.Icons    = Icons
Lib.Themes   = Themes
Lib.Flags    = {}
Lib.Version  = "5.0"
Lib.ConfigFolder = "BloodLibrary"

Lib.Notify  = function(_,o)     Notify(o) end
Lib.Success = function(_,t,x,d) Notify({Title=t,Text=x,Duration=d,Type="success"}) end
Lib.Warning = function(_,t,x,d) Notify({Title=t,Text=x,Duration=d,Type="warning"}) end
Lib.Error   = function(_,t,x,d) Notify({Title=t,Text=x,Duration=d,Type="error"})   end

-- SetTheme â€” cambia el acento de toda la UI en tiempo real
function Lib:SetTheme(t)
        local base
        if type(t)=="string" then base=Themes[t] or Themes.Red
        elseif typeof(t)=="Color3" then base=t
        else return end
        recalcAccent(base)
        for _,e in ipairs(_acReg) do
                pcall(function()
                        e.o[e.p] = (e.k=="accentHov" and C.AccentHov) or (e.k=="accentDrk" and C.AccentDrk) or (e.k=="border" and C.Border) or C.Accent
                end)
        end
end

function Lib:GetThemes() return Themes end
function Lib:AddTheme(name,col) Themes[name]=col end

function Lib:SaveConfig(name)
        pcall(function()
                if not isfolder(self.ConfigFolder) then makefolder(self.ConfigFolder) end
                writefile(self.ConfigFolder.."/"..tostring(name or "default")..".json",HttpService:JSONEncode(self.Flags))
        end)
end
function Lib:LoadConfig(name)
        pcall(function()
                local path=self.ConfigFolder.."/"..tostring(name or "default")..".json"
                if isfile(path) then
                        local d=HttpService:JSONDecode(readfile(path))
                        for k,v in pairs(d) do self.Flags[k]=v end
                end
        end)
end

-- â”€â”€â”€ Auto-guardado â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
Lib._autoSaveThread = nil
Lib._autoSaveActive = false

function Lib:EnableAutoSave(o)
        o = o or {}
        local file     = tostring(o.File     or "autosave")
        local interval = tonumber(o.Interval or 30)
        local silent   = o.Silent ~= false   -- notificaciÃ³n de guardado (default: silencioso al guardar, pero sÃ­ al cargar)
        local folder   = o.Folder or self.ConfigFolder
        local onLoad   = o.OnLoad or function() end
        local onSave   = o.OnSave or function() end
        local path     = folder.."/"..file..".json"

        -- Auto-carga al iniciar si el archivo existe
        local loaded = false
        pcall(function()
                if isfile(path) then
                        local d = HttpService:JSONDecode(readfile(path))
                        for k,v in pairs(d) do self.Flags[k]=v end
                        loaded = true
                end
        end)
        if loaded then
                if not o.Silent then
                        Notify({Title="Config cargada",Text="Auto-guardado '"..file.."' restaurado.",Type="success",Duration=3})
                end
                pcall(onLoad, file)
        end

        -- Detener cualquier loop anterior
        self:DisableAutoSave()
        self._autoSaveActive = true

        -- Loop de guardado
        self._autoSaveThread = task.spawn(function()
                local saveCount = 0
                while self._autoSaveActive do
                        task.wait(interval)
                        if not self._autoSaveActive then break end
                        local ok = pcall(function()
                                if not isfolder(folder) then makefolder(folder) end
                                writefile(path, HttpService:JSONEncode(self.Flags))
                        end)
                        if ok then
                                saveCount = saveCount + 1
                                if o.Verbose then
                                        Notify({Title="Auto-guardado",Text="Config '"..file.."' guardada. ("..saveCount.."x)",Type="success",Duration=2})
                                end
                                pcall(onSave, file, saveCount)
                        end
                end
        end)

        -- Guardar tambiÃ©n al salir del juego
        game:BindToClose(function()
                if self._autoSaveActive then
                        pcall(function()
                                if not isfolder(folder) then makefolder(folder) end
                                writefile(path, HttpService:JSONEncode(self.Flags))
                        end)
                end
        end)

        return self
end

function Lib:DisableAutoSave()
        self._autoSaveActive = false
        if self._autoSaveThread then
                pcall(function() task.cancel(self._autoSaveThread) end)
                self._autoSaveThread = nil
        end
end

function Lib:IsAutoSaving()
        return self._autoSaveActive
end

-- â”€â”€â”€ Sistema de Perfiles â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
Lib._activeProfile  = nil
Lib._profileFolder  = "BloodLibrary/Profiles"
Lib._profileChanged = nil  -- callback

local function profilePath(folder, name)
        return folder.."/"..name..".json"
end

function Lib:SetProfileFolder(f)
        self._profileFolder = f
end

function Lib:ListProfiles()
        local out = {}
        pcall(function()
                if not isfolder(self._profileFolder) then makefolder(self._profileFolder) end
                for _,f in ipairs(listfiles(self._profileFolder)) do
                        local n = f:match("([^/\\]+)%.json$")
                        if n then table.insert(out, n) end
                end
        end)
        return out
end

function Lib:SaveProfile(name)
        name = tostring(name or self._activeProfile or "Perfil A"):gsub("[^%w_%-]","_")
        pcall(function()
                if not isfolder(self._profileFolder) then makefolder(self._profileFolder) end
                writefile(profilePath(self._profileFolder, name), HttpService:JSONEncode(self.Flags))
        end)
end

function Lib:LoadProfile(name)
        name = tostring(name):gsub("[^%w_%-]","_")
        local loaded = false
        pcall(function()
                local path = profilePath(self._profileFolder, name)
                if isfile(path) then
                        local d = HttpService:JSONDecode(readfile(path))
                        for k,v in pairs(d) do self.Flags[k]=v end
                        loaded = true
                end
        end)
        return loaded
end

function Lib:DeleteProfile(name)
        name = tostring(name):gsub("[^%w_%-]","_")
        pcall(function() delfile(profilePath(self._profileFolder, name)) end)
end

-- SetProfile: guarda el perfil actual, carga el nuevo y actualiza toda la UI
function Lib:SetProfile(name, silent)
        name = tostring(name):gsub("[^%w_%-]","_")
        -- guardar perfil anterior si existe
        if self._activeProfile then
                self:SaveProfile(self._activeProfile)
        end
        self._activeProfile = name
        -- crear perfil vacÃ­o si no existe
        local existed = self:LoadProfile(name)
        if not existed then
                -- inicializar con los defaults de cada flag registrado
                for _,e in ipairs(_flagReg) do
                        if self.Flags[e.flag]==nil then self.Flags[e.flag]=e.default end
                end
        end
        -- sincronizar todos los elementos de UI con los nuevos valores
        for _,e in ipairs(_flagReg) do
                local v = self.Flags[e.flag]
                if v~=nil then pcall(e.setter, v) end
        end
        if not silent then
                Notify({Title="Perfil cargado", Text="Perfil '"..name.."' activo.", Type="success", Duration=2.5})
        end
        if self._profileChanged then pcall(self._profileChanged, name) end
end

function Lib:GetProfile()
        return self._activeProfile
end

function Lib:OnProfileChanged(fn)
        self._profileChanged = fn
end

-- â”€â”€â”€ CreateWindow â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
function Lib:CreateWindow(o)
        o=o or {}
        local win={_tabs={},_active=nil,_visible=true,_key=o.ToggleKey or Enum.KeyCode.RightShift}
        local WSZ=o.Size or UDim2.fromOffset(790,500)

        local gui=Instance.new("ScreenGui") gui.Name=o.Name or "BloodLibrary" gui.ResetOnSpawn=false gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling gui.DisplayOrder=2147483646
        pcall(function() gui.Parent=gethui() end)
        if not gui.Parent then gui.Parent=LP:WaitForChild("PlayerGui") end
        win._gui=gui

        -- Base
        local base=frm(gui,C.BG,WSZ,o.Position or UDim2.fromScale(0.5,0.5),{AnchorPoint=Vector2.new(0.5,0.5),ClipsDescendants=false})
        corner(base,10)
        local baseSk=stroke(base,C.Border,1); regA(baseSk,"Color","border")
        shadow(base)
        base.Size=UDim2.new(WSZ.X.Scale,WSZ.X.Offset,0,0); base.BackgroundTransparency=1

        -- â”€â”€ Sidebar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        local sb=frm(base,C.Sidebar,UDim2.new(0,170,1,0)); sb.ClipsDescendants=true; corner(sb,10)
        frm(sb,C.Sidebar,UDim2.new(0,10,1,0),UDim2.new(1,-10,0,0))
        frm(sb,C.Border,UDim2.new(0,1,1,0),UDim2.new(1,-1,0,0))

        local sbH=frm(sb,Color3.fromRGB(12,12,12),UDim2.new(1,0,0,78))
        frm(sbH,C.Border,UDim2.new(1,0,0,1),UDim2.new(0,0,1,-1))

        local logoBox=frm(sbH,C.Accent,UDim2.fromOffset(40,40),UDim2.new(0,12,0,12)); corner(logoBox,9)
        regA(logoBox,"BackgroundColor3")
        img(logoBox,A.libIcon,Color3.new(1,1,1),UDim2.new(1,-6,1,-6),UDim2.new(0,3,0,3),{ScaleType=Enum.ScaleType.Fit})

        lbl(sbH,o.Title or "Blood Library",13,C.Text,Enum.Font.GothamBold,{Size=UDim2.new(1,-64,0,18),Position=UDim2.new(0,60,0,14)})
        lbl(sbH,o.Subtitle or "v"..Lib.Version,11,C.TextSub,nil,{Size=UDim2.new(1,-64,0,14),Position=UDim2.new(0,60,0,36)})

        -- Tabs scroll en sidebar
        local tabSc=Instance.new("ScrollingFrame"); tabSc.BackgroundTransparency=1; tabSc.BorderSizePixel=0
        tabSc.Size=UDim2.new(1,0,1,-78); tabSc.Position=UDim2.new(0,0,0,78)
        tabSc.CanvasSize=UDim2.new(0,0,0,0); tabSc.AutomaticCanvasSize=Enum.AutomaticSize.Y
        tabSc.ScrollBarThickness=2; tabSc.ElasticBehavior=Enum.ElasticBehavior.Never; tabSc.Parent=sb
        local tabScSk=Instance.new("UIScrollBarImageLabel",tabSc) pcall(function() tabSc.ScrollBarImageColor3=C.AccentDrk end)
        pad(tabSc,6,8,6,8)
        local tabList=Instance.new("UIListLayout"); tabList.SortOrder=Enum.SortOrder.LayoutOrder; tabList.Padding=UDim.new(0,2); tabList.Parent=tabSc

        -- Footer sidebar
        local sbFoot=frm(sb,Color3.fromRGB(12,12,12),UDim2.new(1,0,0,46),UDim2.new(0,0,1,-46))
        frm(sbFoot,C.Border,UDim2.new(1,0,0,1))
        local dotOn=frm(sbFoot,C.Success,UDim2.fromOffset(8,8),UDim2.new(0,12,0.5,-4)); corner(dotOn,4)
        lbl(sbFoot,LP.DisplayName or LP.Name,12,C.Text,Enum.Font.GothamSemibold,{Size=UDim2.new(1,-26,0,16),Position=UDim2.new(0,26,0,6)})
        lbl(sbFoot,"Conectado",10,C.TextSub,nil,{Size=UDim2.new(1,-26,0,12),Position=UDim2.new(0,26,0,24)})

        -- â”€â”€ Header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        local hdr=frm(base,C.Header,UDim2.new(1,-170,0,48),UDim2.new(0,170,0,0))
        frm(hdr,C.Border,UDim2.new(1,0,0,1),UDim2.new(0,0,1,-1))
        local hTabName=lbl(hdr,"",16,C.Text,Enum.Font.GothamBold,{Size=UDim2.new(0,200,1,0),Position=UDim2.new(0,14,0,0)})

        -- Search
        local srchF=frm(hdr,Color3.fromRGB(18,18,18),UDim2.fromOffset(168,28),UDim2.new(1,-290,0.5,-14)); corner(srchF,6); stroke(srchF,C.Border,1)
        img(srchF,A.searchIcon,C.TextDim,UDim2.fromOffset(12,12),UDim2.new(0,7,0.5,-6))
        local srchBox=Instance.new("TextBox"); srchBox.PlaceholderText="Buscar..." srchBox.Text="" srchBox.TextSize=11 srchBox.Font=Enum.Font.Gotham srchBox.TextColor3=C.Text srchBox.PlaceholderColor3=C.TextDim srchBox.BackgroundTransparency=1 srchBox.BorderSizePixel=0 srchBox.Size=UDim2.new(1,-26,1,0) srchBox.Position=UDim2.new(0,24,0,0) srchBox.ClearTextOnFocus=false srchBox.Parent=srchF

        -- BotÃ³n Minimizar
        local minF=frm(hdr,Color3.fromRGB(20,20,20),UDim2.fromOffset(32,32),UDim2.new(1,-76,0.5,-16)); corner(minF,7); stroke(minF,C.Border,1)
        img(minF,A.minIcon,C.TextSub,UDim2.fromOffset(14,14),UDim2.new(0.5,-7,0.5,-7))
        local minHit=btn(minF,{Size=UDim2.new(1,0,1,0),ZIndex=5})
        minHit.MouseEnter:Connect(function() tw(minF,{BackgroundColor3=Color3.fromRGB(30,30,30)},0.1) end)
        minHit.MouseLeave:Connect(function() tw(minF,{BackgroundColor3=Color3.fromRGB(20,20,20)},0.1) end)

        -- BotÃ³n Cerrar
        local closeF=frm(hdr,C.Accent,UDim2.fromOffset(32,32),UDim2.new(1,-36,0.5,-16)); corner(closeF,7)
        regA(closeF,"BackgroundColor3")
        img(closeF,A.closeIcon,Color3.new(1,1,1),UDim2.fromOffset(14,14),UDim2.new(0.5,-7,0.5,-7))
        local closeHit=btn(closeF,{Size=UDim2.new(1,0,1,0),ZIndex=5})
        closeHit.MouseEnter:Connect(function() tw(closeF,{BackgroundColor3=C.AccentHov},0.1) end)
        closeHit.MouseLeave:Connect(function() tw(closeF,{BackgroundColor3=C.Accent},0.1) end)
        closeHit.MouseButton1Click:Connect(function()
                tw(base,{Size=UDim2.new(WSZ.X.Scale,WSZ.X.Offset,0,0),BackgroundTransparency=1},0.22)
                task.wait(0.25); pcall(function() gui:Destroy() end)
        end)

        -- Ãrea de contenido
        local content=frm(base,nil,UDim2.new(1,-180,1,-58),UDim2.new(0,175,0,53))

        -- â”€â”€ BotÃ³n flotante (reabrir) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        local fBtn=frm(gui,C.Accent,UDim2.fromOffset(46,46),UDim2.new(0,12,0.5,-23)); fBtn.Visible=false; corner(fBtn,12)
        regA(fBtn,"BackgroundColor3"); shadow(fBtn)
        img(fBtn,A.libIcon,Color3.new(1,1,1),UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4),{ScaleType=Enum.ScaleType.Fit})
        local fHit=btn(fBtn,{Size=UDim2.new(1,0,1,0),ZIndex=5})
        fHit.MouseEnter:Connect(function() tw(fBtn,{BackgroundColor3=C.AccentHov},0.12) end)
        fHit.MouseLeave:Connect(function() tw(fBtn,{BackgroundColor3=C.Accent},0.12) end)

        do -- drag floatBtn
                local fd,fs,fp=false
                fBtn.InputBegan:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fd=true; fs=i.Position; fp=fBtn.Position end
                end)
                UserInputService.InputChanged:Connect(function(i)
                        if fd and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                                local d=i.Position-fs; fBtn.Position=UDim2.new(fp.X.Scale,fp.X.Offset+d.X,fp.Y.Scale,fp.Y.Offset+d.Y)
                        end
                end)
                UserInputService.InputEnded:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fd=false end
                end)
        end
        fHit.MouseButton1Click:Connect(function()
                win._mini=false; base.Visible=true; fBtn.Visible=false
                tw(base,{Size=WSZ,BackgroundTransparency=0},0.28)
        end)

        minHit.MouseButton1Click:Connect(function()
                win._mini=not win._mini
                if win._mini then
                        tw(base,{Size=UDim2.new(WSZ.X.Scale,WSZ.X.Offset,0,0),BackgroundTransparency=1},0.22)
                        task.wait(0.25); base.Visible=false; fBtn.Visible=true
                else
                        base.Visible=true; fBtn.Visible=false
                        tw(base,{Size=WSZ,BackgroundTransparency=0},0.28)
                end
        end)

        do -- drag window
                local dd,ds,dp=false
                hdr.InputBegan:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dd=true; ds=i.Position; dp=base.Position end
                end)
                UserInputService.InputChanged:Connect(function(i)
                        if dd and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                                local d=i.Position-ds; base.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
                        end
                end)
                UserInputService.InputEnded:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dd=false end
                end)
        end

        UserInputService.InputBegan:Connect(function(i,gp)
                if gp then return end
                if i.KeyCode==win._key then
                        win._visible=not win._visible
                        if win._visible then base.Visible=true; fBtn.Visible=false; tw(base,{BackgroundTransparency=0,Size=WSZ},0.22)
                        else tw(base,{BackgroundTransparency=1,Size=UDim2.new(WSZ.X.Scale,WSZ.X.Offset,0,0)},0.18); task.wait(0.2); base.Visible=false end
                end
        end)

        task.defer(function() tw(base,{Size=WSZ,BackgroundTransparency=0},0.35) end)

        function win:Destroy()
                tw(base,{Size=UDim2.new(WSZ.X.Scale,WSZ.X.Offset,0,0),BackgroundTransparency=1},0.22)
                task.wait(0.25); pcall(function() gui:Destroy() end); pcall(function() fBtn:Destroy() end)
        end

        -- â”€â”€ AddTab â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        function win:AddTab(o2)    return self:CreateTab(o2) end
        function win:CreateTab(o2)
                o2=o2 or {}
                local tab={_sections={},_elements={},_order=#win._tabs+1}

                local tBtn=frm(tabSc,Color3.fromRGB(22,22,22),UDim2.new(1,0,0,38),nil,{BackgroundTransparency=1,LayoutOrder=tab._order})
                corner(tBtn,7)
                local tBar=frm(tBtn,C.Accent,UDim2.new(0,3,0.5,0),UDim2.new(0,0,0.25,0)); tBar.BackgroundTransparency=1; corner(tBar,2)

                local iconId=getIcon(o2.Icon)
                local tIcImg=nil; local tIcTxt=nil
                if iconId then
                        tIcImg=img(tBtn,iconId,C.TextSub,UDim2.fromOffset(16,16),UDim2.new(0,10,0.5,-8))
                else
                        tIcTxt=lbl(tBtn,o2.Icon or "",14,C.TextSub,nil,{Size=UDim2.fromOffset(20,38),Position=UDim2.new(0,8,0,0),TextXAlignment=Enum.TextXAlignment.Center})
                end
                local tTitle=lbl(tBtn,o2.Title or "Tab",13,C.TextSub,nil,{Size=UDim2.new(1,-36,1,0),Position=UDim2.new(0,34,0,0)})
                local tHit=btn(tBtn,{Size=UDim2.new(1,0,1,0),ZIndex=5})

                local tSc=Instance.new("ScrollingFrame"); tSc.BackgroundTransparency=1; tSc.BorderSizePixel=0
                tSc.Size=UDim2.new(1,0,1,0); tSc.CanvasSize=UDim2.new(0,0,0,0); tSc.AutomaticCanvasSize=Enum.AutomaticSize.Y
                tSc.ScrollBarThickness=3; tSc.ElasticBehavior=Enum.ElasticBehavior.Never; tSc.Visible=false; tSc.Parent=content
                pcall(function() tSc.ScrollBarImageColor3=C.AccentDrk end)
                pad(tSc,6,8,10,8)
                local tLay=Instance.new("UIListLayout"); tLay.SortOrder=Enum.SortOrder.LayoutOrder; tLay.Padding=UDim.new(0,8)
                tLay.FillDirection=Enum.FillDirection.Horizontal; tLay.Wraps=true
                tLay.HorizontalAlignment=Enum.HorizontalAlignment.Left; tLay.VerticalAlignment=Enum.VerticalAlignment.Top
                tLay.Parent=tSc

                tab._btn=tBtn; tab._scroll=tSc; tab._bar=tBar; tab._title=tTitle; tab._IcImg=tIcImg; tab._IcTxt=tIcTxt

                local function activate()
                        for _,t2 in ipairs(win._tabs) do
                                tw(t2._btn,{BackgroundTransparency=1},0.12); tw(t2._bar,{BackgroundTransparency=1},0.12)
                                t2._title.TextColor3=C.TextSub; t2._title.Font=Enum.Font.Gotham
                                if t2._IcImg then tw(t2._IcImg,{ImageColor3=C.TextSub},0.12) end
                                if t2._IcTxt then t2._IcTxt.TextColor3=C.TextSub end
                                t2._scroll.Visible=false
                        end
                        tw(tBtn,{BackgroundTransparency=0.88},0.12); tw(tBar,{BackgroundTransparency=0},0.12)
                        tTitle.TextColor3=C.Accent; tTitle.Font=Enum.Font.GothamSemibold
                        if tIcImg then tw(tIcImg,{ImageColor3=C.Accent},0.12) end
                        if tIcTxt then tIcTxt.TextColor3=C.Accent end
                        tSc.Visible=true; win._active=tab; hTabName.Text=o2.Title or ""
                end

                tHit.MouseButton1Click:Connect(activate)
                tHit.MouseEnter:Connect(function() if win._active~=tab then tw(tBtn,{BackgroundTransparency=0.94},0.1) end end)
                tHit.MouseLeave:Connect(function() if win._active~=tab then tw(tBtn,{BackgroundTransparency=1},0.1) end end)
                table.insert(win._tabs,tab)
                if #win._tabs==1 then activate() end

                srchBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local q=srchBox.Text:lower()
                        for _,el in ipairs(tab._elements) do
                                if el._row then el._row.Visible=q=="" or (el._name or ""):lower():find(q,1,true)~=nil end
                        end
                end)

                -- â”€â”€ CreateSection â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                function tab:AddSection(o3)    return self:CreateSection(o3) end
                function tab:CreateSection(o3)
                        o3=o3 or {}
                        local sec={_elements={},_order=#tab._sections+1}
                        local secW=o3.Width or 1
                        local xOff=(secW<1) and -4 or 0

                        local secF=frm(tSc,Color3.fromRGB(18,18,18),UDim2.new(secW,xOff,0,0),nil,{AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=sec._order,ClipsDescendants=false})
                        corner(secF,8)
                        local secSk=stroke(secF,C.Border,1); secSk.Transparency=0.4; regA(secSk,"Color","border")

                        local sHead=frm(secF,Color3.fromRGB(15,15,15),UDim2.new(1,0,0,32)); corner(sHead,8)
                        frm(sHead,Color3.fromRGB(15,15,15),UDim2.new(1,0,0,8),UDim2.new(0,0,1,-8))
                        frm(secF,C.Border,UDim2.new(1,-14,0,1),UDim2.new(0,7,0,31),{BackgroundTransparency=0.5})

                        local sIconId=getIcon(o3.Icon)
                        local sTitleX=18
                        if sIconId then
                                local si=img(sHead,sIconId,C.Accent,UDim2.fromOffset(14,14),UDim2.new(0,10,0.5,-7))
                                regA(si,"ImageColor3"); sTitleX=30
                        else
                                local sBar=frm(sHead,C.Accent,UDim2.new(0,3,0.45,0),UDim2.new(0,10,0.275,0)); corner(sBar,2); regA(sBar,"BackgroundColor3")
                        end
                        local sTitleLbl=lbl(sHead,o3.Title or "SecciÃ³n",12,C.Accent,Enum.Font.GothamSemibold,{Size=UDim2.new(1,-sTitleX-4,1,0),Position=UDim2.new(0,sTitleX,0,0)})
                        regA(sTitleLbl,"TextColor3")

                        local secC=frm(secF,nil,UDim2.new(1,0,0,0),UDim2.new(0,0,0,32),{AutomaticSize=Enum.AutomaticSize.Y})
                        local secLay=Instance.new("UIListLayout"); secLay.SortOrder=Enum.SortOrder.LayoutOrder; secLay.Padding=UDim.new(0,0); secLay.Parent=secC
                        sec._frame=secF; sec._content=secC
                        table.insert(tab._sections,sec)

                        local eIdx=0
                        local function nOrd() eIdx=eIdx+1; return eIdx end

                        local function rowBase(name,h)
                                h=h or 42
                                local row=frm(secC,C.Hover,UDim2.new(1,0,0,h),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                divLine(row,h-1)
                                lbl(row,name or "",13,C.Text,nil,{Size=UDim2.new(0.54,-10,0,h),Position=UDim2.new(0,13,0,0)})
                                row.MouseEnter:Connect(function() tw(row,{BackgroundTransparency=0.9},0.1) end)
                                row.MouseLeave:Connect(function() tw(row,{BackgroundTransparency=1},0.1) end)
                                return row
                        end

                        -- â”€â”€ Button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddButton(o4)    return self:CreateButton(o4) end
                        function sec:CreateButton(o4)
                                o4=o4 or {}; local el={_name=o4.Name}; local cb=o4.Callback or function() end
                                local rH=o4.Description and 52 or 42
                                local row=frm(secC,C.Hover,UDim2.new(1,0,0,rH),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=row; divLine(row,rH-1)
                                lbl(row,o4.Name or "",13,C.Text,nil,{Size=UDim2.new(0.5,-10,0,20),Position=UDim2.new(0,13,0,o4.Description and 7 or 0),TextYAlignment=o4.Description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center})
                                if o4.Description then lbl(row,o4.Description,11,C.TextSub,nil,{Size=UDim2.new(0.5,-10,0,14),Position=UDim2.new(0,13,0,26)}) end
                                local eb=Instance.new("ImageButton"); eb.Image=A.btnSlice; eb.ScaleType=Enum.ScaleType.Slice; eb.SliceCenter=Rect.new(4,4,12,12)
                                eb.ImageColor3=C.Accent; eb.BackgroundColor3=C.Accent; eb.BackgroundTransparency=0; eb.BorderSizePixel=0; eb.AutoButtonColor=false
                                eb.Size=UDim2.fromOffset(88,28); eb.Position=UDim2.new(1,-100,0.5,-14); eb.Parent=row; corner(eb,6)
                                regA(eb,"ImageColor3"); regA(eb,"BackgroundColor3")
                                lbl(eb,o4.ButtonText or "Ejecutar",12,Color3.new(1,1,1),Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center})
                                eb.MouseEnter:Connect(function() tw(eb,{ImageColor3=C.AccentHov,BackgroundColor3=C.AccentHov},0.1) end)
                                eb.MouseLeave:Connect(function() tw(eb,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.1) end)
                                eb.MouseButton1Click:Connect(function()
                                        tw(eb,{ImageColor3=C.AccentDrk,BackgroundColor3=C.AccentDrk},0.07); task.wait(0.1)
                                        tw(eb,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.15); pcall(cb)
                                end)
                                row.MouseEnter:Connect(function() tw(row,{BackgroundTransparency=0.9},0.1) end)
                                row.MouseLeave:Connect(function() tw(row,{BackgroundTransparency=1},0.1) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:SetText(t) eb:FindFirstChildWhichIsA("TextLabel").Text=t end
                                function el:SetCallback(f) cb=f end
                                return el
                        end

                        -- â”€â”€ Toggle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddToggle(o4)    return self:CreateToggle(o4) end
                        function sec:CreateToggle(o4)
                                o4=o4 or {}; local el={_name=o4.Name}; local val=o4.Default==true; local cb=o4.Callback or function() end
                                local rH=o4.Description and 52 or 42
                                local row=frm(secC,C.Hover,UDim2.new(1,0,0,rH),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=row; divLine(row,rH-1)
                                lbl(row,o4.Name or "",13,C.Text,nil,{Size=UDim2.new(0.64,-10,0,20),Position=UDim2.new(0,13,0,o4.Description and 7 or 0),TextYAlignment=o4.Description and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center})
                                if o4.Description then lbl(row,o4.Description,11,C.TextSub,nil,{Size=UDim2.new(0.64,-10,0,14),Position=UDim2.new(0,13,0,26)}) end
                                local tW=frm(row,nil,UDim2.fromOffset(44,24),UDim2.new(1,-56,0.5,-12))
                                local tBG=img(tW,A.toggleBG,val and C.Accent or C.ToggleOff,UDim2.new(1,0,1,0))
                                local tKn=img(tW,A.toggleHead,Color3.new(1,1,1),UDim2.fromOffset(20,20),val and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10))
                                if o4.Flag and Lib.Flags[o4.Flag]~=nil then
                                        val=Lib.Flags[o4.Flag]; tBG.ImageColor3=val and C.Accent or C.ToggleOff
                                        tKn.Position=val and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10)
                                end
                                local function setVal(v,silent)
                                        val=v; tw(tBG,{ImageColor3=v and C.Accent or C.ToggleOff},0.16)
                                        tw(tKn,{Position=v and UDim2.new(1,-21,0.5,-10) or UDim2.new(0,1,0.5,-10)},0.16)
                                        if o4.Flag then Lib.Flags[o4.Flag]=v end
                                        if not silent then pcall(cb,v) end
                                end
                                -- Registrar para SetTheme y para cambio de perfil
                                table.insert(_acReg,{o=tBG,p="ImageColor3",k="accent",_toggleRef=true,_getVal=function() return val end})
                                if o4.Flag then regFlag(o4.Flag, function(v) setVal(v,true) end, o4.Default==true) end
                                local hit=btn(row,{Size=UDim2.new(1,0,1,0),ZIndex=5}); hit.MouseButton1Click:Connect(function() setVal(not val) end)
                                row.MouseEnter:Connect(function() tw(row,{BackgroundTransparency=0.9},0.1) end)
                                row.MouseLeave:Connect(function() tw(row,{BackgroundTransparency=1},0.1) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Set(v)      setVal(v)  end
                                function el:Get()      return val  end
                                function el:OnChange(f) cb=f       end
                                return el
                        end

                        -- â”€â”€ Slider â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddSlider(o4)
                                o4=o4 or {}; local el={_name=o4.Name}
                                local sMin=o4.Min or 0; local sMax=o4.Max or 100; local step=o4.Step or 1
                                local val=math.clamp(o4.Default or sMin,sMin,sMax); local cb=o4.Callback or function() end
                                local rH=o4.Description and 60 or 50
                                local row=frm(secC,C.Hover,UDim2.new(1,0,0,rH),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=row; divLine(row,rH-1)
                                lbl(row,o4.Name or "",13,C.Text,nil,{Size=UDim2.new(0.7,-10,0,18),Position=UDim2.new(0,13,0,8)})
                                if o4.Description then lbl(row,o4.Description,11,C.TextSub,nil,{Size=UDim2.new(0.7,-10,0,14),Position=UDim2.new(0,13,0,24)}) end
                                local vLbl=lbl(row,tostring(val),12,C.Accent,Enum.Font.GothamSemibold,{Size=UDim2.new(0.3,-12,0,18),Position=UDim2.new(0.7,0,0,8),TextXAlignment=Enum.TextXAlignment.Right})
                                regA(vLbl,"TextColor3")
                                local tY=o4.Description and 44 or 34
                                local trBG=img(row,A.sliderBar,C.SliderBG,UDim2.new(1,-26,0,6),UDim2.new(0,13,0,tY))
                                local p0=(val-sMin)/math.max(sMax-sMin,0.001)
                                local trFill=img(row,A.sliderBar,C.Accent,UDim2.new(p0,0,0,6),UDim2.new(0,13,0,tY))
                                regA(trFill,"ImageColor3")
                                local knob=img(row,A.sliderHead,Color3.new(1,1,1),UDim2.fromOffset(14,14),UDim2.new(p0,13+p0*(-26)-7,0,tY-4))
                                local sl=false
                                local function upSlide(px)
                                        local ax=trBG.AbsolutePosition.X; local sw=trBG.AbsoluteSize.X
                                        local p=math.clamp((px-ax)/sw,0,1)
                                        val=math.floor((sMin+p*(sMax-sMin))/step+0.5)*step; val=math.clamp(val,sMin,sMax)
                                        p=(val-sMin)/math.max(sMax-sMin,0.001)
                                        trFill.Size=UDim2.new(p,0,0,6); knob.Position=UDim2.new(p,13+p*(-26)-7,0,tY-4)
                                        vLbl.Text=tostring(val); if o4.Flag then Lib.Flags[o4.Flag]=val end; pcall(cb,val)
                                end
                                if o4.Flag then regFlag(o4.Flag, function(v)
                                        val=math.clamp(tonumber(v) or sMin,sMin,sMax)
                                        local p=(val-sMin)/math.max(sMax-sMin,0.001)
                                        trFill.Size=UDim2.new(p,0,0,6); knob.Position=UDim2.new(p,13+p*(-26)-7,0,tY-4)
                                        vLbl.Text=tostring(val); if o4.Flag then Lib.Flags[o4.Flag]=val end; pcall(cb,val)
                                end, o4.Default) end
                                trBG.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sl=true; upSlide(i.Position.X) end end)
                                UserInputService.InputChanged:Connect(function(i) if sl and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then upSlide(i.Position.X) end end)
                                UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sl=false end end)
                                row.MouseEnter:Connect(function() tw(row,{BackgroundTransparency=0.9},0.1) end)
                                row.MouseLeave:Connect(function() tw(row,{BackgroundTransparency=1},0.1) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Set(v) upSlide(trBG.AbsolutePosition.X+(v-sMin)/math.max(sMax-sMin,0.001)*trBG.AbsoluteSize.X) end
                                function el:Get()  return val end
                                function el:OnChange(f) cb=f end
                                return el
                        end

                        -- â”€â”€ Dropdown â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddDropdown(o4)    return self:CreateDropdown(o4) end
                        function sec:CreateDropdown(o4)
                                o4=o4 or {}; local el={_name=o4.Name}
                                local opts=o4.Options or {}; local sel=o4.Default or opts[1] or ""
                                local open=false; local cb=o4.Callback or function() end
                                local wrap=frm(secC,C.Hover,UDim2.new(1,0,0,42),nil,{BackgroundTransparency=1,LayoutOrder=nOrd(),ClipsDescendants=false})
                                el._row=wrap; divLine(wrap,41)
                                lbl(wrap,o4.Name or "",13,C.Text,nil,{Size=UDim2.new(0.44,-10,1,0),Position=UDim2.new(0,13,0,0)})
                                local dF=frm(wrap,Color3.fromRGB(18,18,18),UDim2.new(0.5,-12,0,28),UDim2.new(0.5,0,0.5,-14)); corner(dF,6); stroke(dF,C.Border,1)
                                local selLbl=lbl(dF,sel,12,C.Accent,nil,{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,7,0,0)}); regA(selLbl,"TextColor3")
                                local arrI=img(dF,A.dropArrow,C.TextSub,UDim2.fromOffset(11,11),UDim2.new(1,-16,0.5,-5.5))
                                local menu=frm(wrap,Color3.fromRGB(18,18,18),UDim2.new(0.5,-12,0,0),UDim2.new(0.5,0,0,44),{ClipsDescendants=true,ZIndex=20}); corner(menu,6); stroke(menu,C.Border,1)
                                local mList=Instance.new("UIListLayout"); mList.SortOrder=Enum.SortOrder.LayoutOrder; mList.Parent=menu
                                local optBtns={}
                                local function rebuild()
                                        for _,b2 in ipairs(optBtns) do b2:Destroy() end; optBtns={}
                                        for i,op in ipairs(opts) do
                                                local ob=btn(menu,{BackgroundColor3=Color3.fromRGB(24,24,24),BackgroundTransparency=1,Size=UDim2.new(1,0,0,28),LayoutOrder=i,ZIndex=21})
                                                lbl(ob,op,12,C.Text,nil,{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),ZIndex=21})
                                                ob.MouseEnter:Connect(function() tw(ob,{BackgroundTransparency=0.86},0.1) end)
                                                ob.MouseLeave:Connect(function() tw(ob,{BackgroundTransparency=1},0.1) end)
                                                ob.MouseButton1Click:Connect(function()
                                                        sel=op; selLbl.Text=op; open=false
                                                        tw(menu,{Size=UDim2.new(0.5,-12,0,0)},0.16); tw(arrI,{Rotation=0},0.16)
                                                        if o4.Flag then Lib.Flags[o4.Flag]=op end; pcall(cb,op)
                                                        if o4.Flag then regFlag(o4.Flag, function(v) sel=v; selLbl.Text=v; Lib.Flags[o4.Flag]=v; pcall(cb,v) end, o4.Default) end
                                                end)
                                                table.insert(optBtns,ob)
                                        end
                                end
                                rebuild()
                                local dHit=btn(dF,{Size=UDim2.new(1,0,1,0),ZIndex=22})
                                dHit.MouseButton1Click:Connect(function()
                                        open=not open
                                        tw(menu,{Size=UDim2.new(0.5,-12,0,open and math.min(#opts*28,160) or 0)},0.16)
                                        tw(arrI,{Rotation=open and 180 or 0},0.16)
                                end)
                                wrap.MouseEnter:Connect(function() tw(wrap,{BackgroundTransparency=0.9},0.1) end)
                                wrap.MouseLeave:Connect(function() tw(wrap,{BackgroundTransparency=1},0.1) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Add(op)     table.insert(opts,op); rebuild() end
                                function el:Remove(op)  for i,v in ipairs(opts) do if v==op then table.remove(opts,i) break end end rebuild() end
                                function el:Set(v)      sel=v; selLbl.Text=v end
                                function el:Get()       return sel end
                                function el:OnChange(f) cb=f end
                                return el
                        end

                        -- â”€â”€ Textbox â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddTextbox(o4)
                                o4=o4 or {}; local el={_name=o4.Name}; local cb=o4.Callback or function() end
                                local row=rowBase(o4.Name or ""); el._row=row
                                local box=Instance.new("TextBox"); box.PlaceholderText=o4.Placeholder or "Escribe aquÃ­..."; box.Text=o4.Default or ""
                                box.TextSize=12; box.Font=Enum.Font.Gotham; box.TextColor3=C.Text; box.PlaceholderColor3=C.TextDim
                                box.BackgroundColor3=Color3.fromRGB(18,18,18); box.BackgroundTransparency=0; box.BorderSizePixel=0
                                box.Size=UDim2.new(0.42,-10,0,26); box.Position=UDim2.new(0.58,0,0.5,-13); box.ClearTextOnFocus=false; box.Parent=row
                                corner(box,6); pad(box,4,8,4,8); stroke(box,C.Border,1)
                                box.Focused:Connect(function() tw(box,{BackgroundColor3=Color3.fromRGB(25,25,25)},0.12) end)
                                box.FocusLost:Connect(function(e) tw(box,{BackgroundColor3=Color3.fromRGB(18,18,18)},0.12); pcall(cb,box.Text,e) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Set(v)      box.Text=tostring(v) end
                                function el:Get()       return box.Text end
                                function el:OnChange(f) cb=f end
                                return el
                        end

                        -- â”€â”€ Label â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddLabel(o4)
                                o4=o4 or {}; local el={_name=o4.Text}
                                local rH=o4.Right and 42 or 34
                                local row=frm(secC,nil,UDim2.new(1,0,0,rH),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=row; divLine(row,rH-1)
                                local l2=lbl(row,o4.Text or "",13,o4.Color or C.TextSub,nil,{Size=UDim2.new(0.54,-10,1,0),Position=UDim2.new(0,13,0,0)})
                                if o4.Right then
                                        lbl(row,tostring(o4.Right),12,o4.RightColor or C.Accent,Enum.Font.GothamSemibold,{Size=UDim2.new(0.46,-14,1,0),Position=UDim2.new(0.54,0,0,0),TextXAlignment=Enum.TextXAlignment.Right})
                                end
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Set(t) l2.Text=t end
                                function el:Get()  return l2.Text end
                                return el
                        end

                        -- â”€â”€ Paragraph â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddParagraph(o4)
                                o4=o4 or {}; local el={_name=o4.Title}
                                local w2=frm(secC,nil,UDim2.new(1,0,0,0),nil,{AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=w2
                                lbl(w2,o4.Title or "",13,C.Text,Enum.Font.GothamBold,{Size=UDim2.new(1,-22,0,20),Position=UDim2.new(0,13,0,6)})
                                lbl(w2,o4.Content or "",12,C.TextSub,nil,{Size=UDim2.new(1,-22,0,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.new(0,13,0,28),TextWrapped=true})
                                divLine(w2,0)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                return el
                        end

                        -- â”€â”€ Divider â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddDivider()
                                local el={_name="___div"}
                                local w2=frm(secC,nil,UDim2.new(1,0,0,14),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                el._row=w2; frm(w2,C.Border,UDim2.new(1,-20,0,1),UDim2.new(0,10,0.5,0))
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                return el
                        end

                        -- â”€â”€ Keybind â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddKeybind(o4)
                                o4=o4 or {}; local el={_name=o4.Name}; local curKey=o4.Default or Enum.KeyCode.Unknown
                                local listening=false; local cb=o4.Callback or function() end
                                local row=rowBase(o4.Name or ""); el._row=row
                                local kF=frm(row,Color3.fromRGB(18,18,18),UDim2.fromOffset(106,26),UDim2.new(1,-118,0.5,-13)); corner(kF,6); stroke(kF,C.Border,1)
                                local kLbl=lbl(kF,curKey.Name,11,C.Accent,Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center}); regA(kLbl,"TextColor3")
                                local kHit=btn(kF,{Size=UDim2.new(1,0,1,0),ZIndex=5})
                                kHit.MouseButton1Click:Connect(function()
                                        if listening then return end; listening=true; kLbl.Text="..."; kLbl.TextColor3=C.Warning
                                        local conn; conn=UserInputService.InputBegan:Connect(function(i,gp)
                                                if gp then return end
                                                if i.UserInputType==Enum.UserInputType.Keyboard then
                                                        curKey=i.KeyCode; kLbl.Text=i.KeyCode.Name; kLbl.TextColor3=C.Accent; listening=false; conn:Disconnect()
                                                end
                                        end)
                                end)
                                UserInputService.InputBegan:Connect(function(i,gp) if gp then return end if i.KeyCode==curKey then pcall(cb,curKey) end end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Get()       return curKey end
                                function el:Set(k)      curKey=k; kLbl.Text=k.Name end
                                function el:OnChange(f) cb=f end
                                return el
                        end

                        -- â”€â”€ ColorPicker â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddColorPicker(o4)
                                o4=o4 or {}; local el={_name=o4.Name}; local col=o4.Default or C.Accent
                                local open2=false; local cb=o4.Callback or function() end
                                local wrap=frm(secC,C.Hover,UDim2.new(1,0,0,42),nil,{BackgroundTransparency=1,LayoutOrder=nOrd(),ClipsDescendants=false})
                                el._row=wrap; divLine(wrap,41)
                                lbl(wrap,o4.Name or "",13,C.Text,nil,{Size=UDim2.new(0.6,-10,1,0),Position=UDim2.new(0,13,0,0)})
                                local prev=frm(wrap,col,UDim2.fromOffset(40,22),UDim2.new(1,-52,0.5,-11)); corner(prev,6); stroke(prev,C.Border,1)
                                local picker=frm(wrap,Color3.fromRGB(18,18,18),UDim2.new(1,-22,0,0),UDim2.new(0,11,0,44),{ClipsDescendants=true,ZIndex=15}); corner(picker,8); stroke(picker,C.Border,1)
                                local rv,gv,bv={col.R*255},{col.G*255},{col.B*255}
                                local function mkCh(nm,ref,sv,yp)
                                        local ch=frm(picker,nil,UDim2.new(1,0,0,28),UDim2.new(0,0,0,yp),{ZIndex=16})
                                        lbl(ch,nm,10,C.TextSub,Enum.Font.GothamBold,{Size=UDim2.fromOffset(14,28),Position=UDim2.new(0,8,0,0),TextXAlignment=Enum.TextXAlignment.Center,ZIndex=16})
                                        local tB=frm(ch,C.SliderBG,UDim2.new(1,-86,0,4),UDim2.new(0,24,0.5,-2),{ZIndex=16}); corner(tB,2)
                                        local tFi=frm(tB,C.Accent,UDim2.new(sv/255,0,1,0),nil,{ZIndex=16}); corner(tFi,2)
                                        local tKn=frm(tB,Color3.new(1,1,1),UDim2.fromOffset(10,10),UDim2.new(sv/255,0,0.5,-5),{ZIndex=17}); corner(tKn,5)
                                        local nb=Instance.new("TextBox"); nb.Text=tostring(math.floor(sv)); nb.TextSize=11; nb.Font=Enum.Font.Gotham; nb.TextColor3=C.Text; nb.BackgroundColor3=Color3.fromRGB(14,14,14); nb.BackgroundTransparency=0; nb.BorderSizePixel=0; nb.Size=UDim2.fromOffset(38,20); nb.Position=UDim2.new(1,-46,0.5,-10); nb.ZIndex=16; corner(nb,4); nb.Parent=ch
                                        local sd=false
                                        tB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sd=true end end)
                                        UserInputService.InputChanged:Connect(function(i)
                                                if sd and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                                                        local p=math.clamp((i.Position.X-tB.AbsolutePosition.X)/tB.AbsoluteSize.X,0,1)
                                                        tFi.Size=UDim2.new(p,0,1,0); tKn.Position=UDim2.new(p,0,0.5,-5); ref[1]=math.floor(p*255); nb.Text=tostring(ref[1])
                                                        col=Color3.fromRGB(rv[1],gv[1],bv[1]); prev.BackgroundColor3=col; pcall(cb,col)
                                                end
                                        end)
                                        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sd=false end end)
                                end
                                mkCh("R",rv,rv[1],6); mkCh("G",gv,gv[1],36); mkCh("B",bv,bv[1],66)
                                local pH=btn(prev,{Size=UDim2.new(1,0,1,0),ZIndex=5})
                                pH.MouseButton1Click:Connect(function() open2=not open2; tw(picker,{Size=UDim2.new(1,-22,0,open2 and 100 or 0)},0.18) end)
                                wrap.MouseEnter:Connect(function() tw(wrap,{BackgroundTransparency=0.9},0.1) end)
                                wrap.MouseLeave:Connect(function() tw(wrap,{BackgroundTransparency=1},0.1) end)
                                table.insert(tab._elements,el); table.insert(sec._elements,el)
                                function el:Get()       return col end
                                function el:Set(c)      col=c; prev.BackgroundColor3=c end
                                function el:OnChange(f) cb=f end
                                return el
                        end

                        -- â”€â”€ ConfigManager â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddConfigManager(o4)
                                o4 = o4 or {}
                                local folder = o4.Folder or Lib.ConfigFolder
                                local onLoad = o4.OnLoad or function() end
                                local onSave = o4.OnSave or function() end

                                -- â”€â”€ Fila: input + botÃ³n guardar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                                local saveRow = frm(secC, C.Hover, UDim2.new(1,0,0,46), nil, {BackgroundTransparency=1, LayoutOrder=nOrd()})
                                divLine(saveRow, 45)
                                lbl(saveRow, "Nombre", 13, C.Text, nil, {Size=UDim2.new(0,56,1,0), Position=UDim2.new(0,13,0,0)})

                                local nameBox = Instance.new("TextBox")
                                nameBox.PlaceholderText = "mi_config"
                                nameBox.Text = "" nameBox.TextSize = 11 nameBox.Font = Enum.Font.Gotham
                                nameBox.TextColor3 = C.Text nameBox.PlaceholderColor3 = C.TextDim
                                nameBox.BackgroundColor3 = Color3.fromRGB(18,18,18) nameBox.BackgroundTransparency = 0
                                nameBox.BorderSizePixel = 0 nameBox.ClearTextOnFocus = false
                                nameBox.Size = UDim2.new(1,-178,0,26) nameBox.Position = UDim2.new(0,74,0.5,-13)
                                nameBox.Parent = saveRow; corner(nameBox,6); pad(nameBox,4,8,4,8); stroke(nameBox, C.Border, 1)
                                nameBox.Focused:Connect(function() tw(nameBox,{BackgroundColor3=Color3.fromRGB(25,25,25)},0.12) end)
                                nameBox.FocusLost:Connect(function() tw(nameBox,{BackgroundColor3=Color3.fromRGB(18,18,18)},0.12) end)

                                local listHolder   -- declarado adelante
                                local function refreshList()
                                        if not listHolder then return end
                                        for _,ch in ipairs(listHolder:GetChildren()) do
                                                if ch:IsA("Frame") then ch:Destroy() end
                                        end
                                        local files = {}
                                        pcall(function()
                                                if not isfolder(folder) then makefolder(folder) end
                                                files = listfiles(folder)
                                        end)
                                        if #files == 0 then
                                                local noFiles = frm(listHolder, nil, UDim2.new(1,0,0,34), nil, {BackgroundTransparency=1, LayoutOrder=1})
                                                lbl(noFiles, "Sin configs guardadas", 12, C.TextDim, nil, {
                                                        Size=UDim2.new(1,0,1,0), Position=UDim2.new(0,13,0,0),
                                                })
                                                return
                                        end
                                        local rowIdx = 0
                                        for _, fpath in ipairs(files) do
                                                if fpath:find("%.json$") then
                                                        rowIdx = rowIdx + 1
                                                        local fname = fpath:match("([^/\\]+)%.json$") or fpath
                                                        local cfgRow = frm(listHolder, C.Hover, UDim2.new(1,0,0,38), nil, {BackgroundTransparency=1, LayoutOrder=rowIdx})
                                                        cfgRow.MouseEnter:Connect(function() tw(cfgRow,{BackgroundTransparency=0.9},0.1) end)
                                                        cfgRow.MouseLeave:Connect(function() tw(cfgRow,{BackgroundTransparency=1},0.1) end)
                                                        divLine(cfgRow, 37)

                                                        local fileIcon = img(cfgRow, Icons["file"] or "", C.TextSub, UDim2.fromOffset(13,13), UDim2.new(0,13,0.5,-6.5))
                                                        lbl(cfgRow, fname, 12, C.Text, nil, {
                                                                Size=UDim2.new(1,-180,1,0), Position=UDim2.new(0,32,0,0),
                                                                TextTruncate=Enum.TextTruncate.AtEnd,
                                                        })

                                                        -- BotÃ³n Cargar
                                                        local loadB = Instance.new("ImageButton")
                                                        loadB.Image = A.btnSlice loadB.ScaleType = Enum.ScaleType.Slice loadB.SliceCenter = Rect.new(4,4,12,12)
                                                        loadB.ImageColor3 = Color3.fromRGB(30,90,30) loadB.BackgroundColor3 = Color3.fromRGB(30,90,30)
                                                        loadB.BackgroundTransparency = 0 loadB.BorderSizePixel = 0 loadB.AutoButtonColor = false
                                                        loadB.Size = UDim2.fromOffset(60,24) loadB.Position = UDim2.new(1,-142,0.5,-12) loadB.Parent = cfgRow
                                                        corner(loadB,5)
                                                        lbl(loadB,"Cargar",11,Color3.new(1,1,1),Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center})
                                                        loadB.MouseEnter:Connect(function() tw(loadB,{ImageColor3=Color3.fromRGB(40,120,40),BackgroundColor3=Color3.fromRGB(40,120,40)},0.1) end)
                                                        loadB.MouseLeave:Connect(function() tw(loadB,{ImageColor3=Color3.fromRGB(30,90,30),BackgroundColor3=Color3.fromRGB(30,90,30)},0.1) end)
                                                        loadB.MouseButton1Click:Connect(function()
                                                                pcall(function()
                                                                        local data = HttpService:JSONDecode(readfile(fpath))
                                                                        for k,v in pairs(data) do Lib.Flags[k]=v end
                                                                        nameBox.Text = fname
                                                                end)
                                                                Notify({Title="Config cargada",Text=fname,Type="success",Duration=3})
                                                                pcall(onLoad, fname)
                                                        end)

                                                        -- BotÃ³n Borrar
                                                        local delB = Instance.new("ImageButton")
                                                        delB.Image = A.btnSlice delB.ScaleType = Enum.ScaleType.Slice delB.SliceCenter = Rect.new(4,4,12,12)
                                                        delB.ImageColor3 = Color3.fromRGB(100,18,18) delB.BackgroundColor3 = Color3.fromRGB(100,18,18)
                                                        delB.BackgroundTransparency = 0 delB.BorderSizePixel = 0 delB.AutoButtonColor = false
                                                        delB.Size = UDim2.fromOffset(60,24) delB.Position = UDim2.new(1,-74,0.5,-12) delB.Parent = cfgRow
                                                        corner(delB,5)
                                                        lbl(delB,"Borrar",11,Color3.new(1,1,1),Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center})
                                                        delB.MouseEnter:Connect(function() tw(delB,{ImageColor3=C.Error,BackgroundColor3=C.Error},0.1) end)
                                                        delB.MouseLeave:Connect(function() tw(delB,{ImageColor3=Color3.fromRGB(100,18,18),BackgroundColor3=Color3.fromRGB(100,18,18)},0.1) end)
                                                        delB.MouseButton1Click:Connect(function()
                                                                pcall(function() delfile(fpath) end)
                                                                Notify({Title="Config borrada",Text=fname,Type="warning",Duration=3})
                                                                refreshList()
                                                        end)
                                                end
                                        end
                                        if rowIdx == 0 then
                                                local noFiles = frm(listHolder, nil, UDim2.new(1,0,0,34), nil, {BackgroundTransparency=1, LayoutOrder=1})
                                                lbl(noFiles, "Sin configs guardadas", 12, C.TextDim, nil, {Size=UDim2.new(1,0,1,0), Position=UDim2.new(0,13,0,0)})
                                        end
                                end

                                -- BotÃ³n Guardar
                                local saveB = Instance.new("ImageButton")
                                saveB.Image = A.btnSlice saveB.ScaleType = Enum.ScaleType.Slice saveB.SliceCenter = Rect.new(4,4,12,12)
                                saveB.ImageColor3 = C.Accent saveB.BackgroundColor3 = C.Accent
                                saveB.BackgroundTransparency = 0 saveB.BorderSizePixel = 0 saveB.AutoButtonColor = false
                                saveB.Size = UDim2.fromOffset(72,26) saveB.Position = UDim2.new(1,-84,0.5,-13) saveB.Parent = saveRow
                                corner(saveB,6)
                                regA(saveB,"ImageColor3"); regA(saveB,"BackgroundColor3")
                                lbl(saveB,"Guardar",12,Color3.new(1,1,1),Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center})
                                saveB.MouseEnter:Connect(function() tw(saveB,{ImageColor3=C.AccentHov,BackgroundColor3=C.AccentHov},0.1) end)
                                saveB.MouseLeave:Connect(function() tw(saveB,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.1) end)
                                saveB.MouseButton1Click:Connect(function()
                                        local name = nameBox.Text ~= "" and nameBox.Text or "default"
                                        name = name:gsub("[^%w_%-]","_")
                                        pcall(function()
                                                if not isfolder(folder) then makefolder(folder) end
                                                writefile(folder.."/"..name..".json", HttpService:JSONEncode(Lib.Flags))
                                        end)
                                        tw(saveB,{ImageColor3=C.AccentDrk,BackgroundColor3=C.AccentDrk},0.07)
                                        task.wait(0.1); tw(saveB,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.15)
                                        Notify({Title="Config guardada",Text=name,Type="success",Duration=3})
                                        refreshList(); pcall(onSave,name)
                                end)

                                -- â”€â”€ Lista de configs â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                                local listWrap = frm(secC, nil, UDim2.new(1,0,0,0), nil, {AutomaticSize=Enum.AutomaticSize.Y, LayoutOrder=nOrd(), BackgroundTransparency=1})
                                listHolder = listWrap
                                local listLayout = Instance.new("UIListLayout"); listLayout.SortOrder=Enum.SortOrder.LayoutOrder; listLayout.Padding=UDim.new(0,0); listLayout.Parent=listWrap

                                saveRow.MouseEnter:Connect(function() tw(saveRow,{BackgroundTransparency=0.9},0.1) end)
                                saveRow.MouseLeave:Connect(function() tw(saveRow,{BackgroundTransparency=1},0.1) end)

                                refreshList()
                                return {Refresh = refreshList}
                        end

                        -- â”€â”€ ProfileSelector â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        function sec:AddProfileSelector(o4)
                                o4 = o4 or {}
                                local profiles = o4.Profiles or {"Perfil_A","Perfil_B","Perfil_C"}
                                local pfolder  = o4.Folder or Lib._profileFolder
                                Lib._profileFolder = pfolder

                                -- Fila: selector de perfil activo
                                local selRow = frm(secC,C.Hover,UDim2.new(1,0,0,46),nil,{BackgroundTransparency=1,LayoutOrder=nOrd()})
                                selRow.MouseEnter:Connect(function() tw(selRow,{BackgroundTransparency=0.9},0.1) end)
                                selRow.MouseLeave:Connect(function() tw(selRow,{BackgroundTransparency=1},0.1) end)
                                divLine(selRow,45)
                                lbl(selRow,"Perfil",13,C.Text,nil,{Size=UDim2.new(0,50,1,0),Position=UDim2.new(0,13,0,0)})

                                -- mini dropdown de perfiles
                                local curProf = o4.Default or profiles[1] or "Perfil_A"
                                local pdOpen  = false
                                local pdF = frm(selRow,Color3.fromRGB(18,18,18),UDim2.new(1,-170,0,28),UDim2.new(0,68,0.5,-14)); corner(pdF,6); stroke(pdF,C.Border,1)
                                local pdLbl = lbl(pdF,curProf,12,C.Accent,nil,{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,7,0,0)}); regA(pdLbl,"TextColor3")
                                local pdArr = img(pdF,A.dropArrow,C.TextSub,UDim2.fromOffset(11,11),UDim2.new(1,-16,0.5,-5.5))
                                local pdMenu = frm(selRow,Color3.fromRGB(18,18,18),UDim2.new(1,-170,0,0),UDim2.new(0,68,0,48),{ClipsDescendants=true,ZIndex=20}); corner(pdMenu,6); stroke(pdMenu,C.Border,1)
                                local pdList = Instance.new("UIListLayout"); pdList.SortOrder=Enum.SortOrder.LayoutOrder; pdList.Parent=pdMenu

                                local function buildProfileMenu()
                                        for _,ch in ipairs(pdMenu:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
                                        -- combinar perfiles predefinidos + los que existan en disco
                                        local seen = {}
                                        local allP = {}
                                        for _,p in ipairs(profiles) do if not seen[p] then seen[p]=true; table.insert(allP,p) end end
                                        for _,p in ipairs(Lib:ListProfiles()) do if not seen[p] then seen[p]=true; table.insert(allP,p) end end
                                        for i,pname in ipairs(allP) do
                                                local ob=btn(pdMenu,{BackgroundColor3=Color3.fromRGB(24,24,24),BackgroundTransparency=1,Size=UDim2.new(1,0,0,28),LayoutOrder=i,ZIndex=21})
                                                lbl(ob,pname,12,pname==curProf and C.Accent or C.Text,nil,{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),ZIndex=21})
                                                ob.MouseEnter:Connect(function() tw(ob,{BackgroundTransparency=0.86},0.1) end)
                                                ob.MouseLeave:Connect(function() tw(ob,{BackgroundTransparency=1},0.1) end)
                                                ob.MouseButton1Click:Connect(function()
                                                        curProf=pname; pdLbl.Text=pname; pdOpen=false
                                                        tw(pdMenu,{Size=UDim2.new(1,-170,0,0)},0.16); tw(pdArr,{Rotation=0},0.16)
                                                        Lib:SetProfile(pname)
                                                        buildProfileMenu()
                                                end)
                                        end
                                end
                                buildProfileMenu()

                                local pdHit=btn(pdF,{Size=UDim2.new(1,0,1,0),ZIndex=22})
                                pdHit.MouseButton1Click:Connect(function()
                                        pdOpen=not pdOpen
                                        local h=0; for _,c in ipairs(pdMenu:GetChildren()) do if c:IsA("TextButton") then h=h+28 end end
                                        tw(pdMenu,{Size=UDim2.new(1,-170,0,pdOpen and math.min(h,140) or 0)},0.16)
                                        tw(pdArr,{Rotation=pdOpen and 180 or 0},0.16)
                                end)

                                -- BotÃ³n Guardar perfil actual
                                local saveP = Instance.new("ImageButton")
                                saveP.Image=A.btnSlice; saveP.ScaleType=Enum.ScaleType.Slice; saveP.SliceCenter=Rect.new(4,4,12,12)
                                saveP.ImageColor3=C.Accent; saveP.BackgroundColor3=C.Accent
                                saveP.BackgroundTransparency=0; saveP.BorderSizePixel=0; saveP.AutoButtonColor=false
                                saveP.Size=UDim2.fromOffset(64,26); saveP.Position=UDim2.new(1,-76,0.5,-13); saveP.Parent=selRow
                                corner(saveP,5); regA(saveP,"ImageColor3"); regA(saveP,"BackgroundColor3")
                                lbl(saveP,"Guardar",11,Color3.new(1,1,1),Enum.Font.GothamSemibold,{Size=UDim2.new(1,0,1,0),TextXAlignment=Enum.TextXAlignment.Center})
                                saveP.MouseEnter:Connect(function() tw(saveP,{ImageColor3=C.AccentHov,BackgroundColor3=C.AccentHov},0.1) end)
                                saveP.MouseLeave:Connect(function() tw(saveP,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.1) end)
                                saveP.MouseButton1Click:Connect(function()
                                        tw(saveP,{ImageColor3=C.AccentDrk,BackgroundColor3=C.AccentDrk},0.07)
                                        task.wait(0.1); tw(saveP,{ImageColor3=C.Accent,BackgroundColor3=C.Accent},0.15)
                                        Lib:SaveProfile(curProf)
                                        Notify({Title="Perfil guardado",Text="'"..curProf.."' guardado.",Type="success",Duration=2.5})
                                end)

                                -- Activar perfil inicial silenciosamente
                                task.defer(function() Lib:SetProfile(curProf, true) end)
                                if o4.OnChange then Lib:OnProfileChanged(o4.OnChange) end

                                return {
                                        GetProfile  = function() return curProf end,
                                        SetProfile  = function(_, n) curProf=n; pdLbl.Text=n; Lib:SetProfile(n) end,
                                        Refresh     = buildProfileMenu,
                                }
                        end

                        return sec
                end -- CreateSection

                -- â”€â”€ AddConfigTab â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                function win:AddConfigTab(o2)
                        o2 = o2 or {}
                        local folder = o2.Folder or Lib.ConfigFolder
                        local tab = self:CreateTab({
                                Title = o2.Title or "Configs",
                                Icon  = o2.Icon  or "folder",
                        })

                        -- SecciÃ³n de perfiles (si se pide)
                        if o2.Profiles ~= false then
                                local pSec = tab:CreateSection({Title="Perfiles", Icon="users", Width=1})
                                pSec:AddProfileSelector({
                                        Profiles  = o2.Profiles or {"Perfil_A","Perfil_B","Perfil_C"},
                                        Folder    = folder.."/Profiles",
                                        Default   = (o2.Profiles and o2.Profiles[1]) or "Perfil_A",
                                        OnChange  = o2.OnProfileChange,
                                })
                        end

                        -- SecciÃ³n de configs manuales
                        local cSec = tab:CreateSection({
                                Title = o2.SectionTitle or "Configs guardadas",
                                Icon  = "save",
                                Width = 1,
                        })
                        local mgr = cSec:AddConfigManager({
                                Folder = folder,
                                OnLoad = o2.OnLoad,
                                OnSave = o2.OnSave,
                        })

                        -- SecciÃ³n de temas (opcional)
                        if o2.Theme then
                                local tSec = tab:CreateSection({Title="Tema", Icon="sliders", Width=1})
                                local themeNames = {}
                                for k in pairs(Lib.Themes) do table.insert(themeNames, k) end
                                table.sort(themeNames)
                                tSec:AddDropdown({
                                        Name = "Color de acento",
                                        Description = "Cambia el tema de la librerÃ­a.",
                                        Options = themeNames,
                                        Default = themeNames[1],
                                        Callback = function(v) Lib:SetTheme(v) end,
                                })
                        end
                        return tab, mgr
                end

                return tab
        end -- CreateTab

        getgenv().BloodLib=win
        return win
end

-- Actualizar SetTheme para manejar correctamente los toggles activos
local _origSetTheme = Lib.SetTheme
Lib.SetTheme = function(self, t)
        _origSetTheme(self, t)
        -- Toggles: solo re-colorear si estÃ¡n activos (val=true)
        for _,e in ipairs(_acReg) do
                if e._toggleRef then
                        pcall(function()
                                if e._getVal() then e.o[e.p]=C.Accent
                                else e.o[e.p]=C.ToggleOff end
                        end)
                end
        end
end

return Lib
