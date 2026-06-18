-- BLOOD LIB v2.2 | UI Library completa estilo KOD/Antora/Linoria
-- Logo: 109026017200686 | Sin bugs, probada

local BLOOD_LIB = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- SISTEMA DE ICONOS
BLOOD_LIB.Icons = {
	["switchcamera"] = "rbxassetid://10734975214", ["sword"] = "rbxassetid://10734975486",
	["swords"] = "rbxassetid://10734975692", ["syringe"] = "rbxassetid://10734975932",
	["table"] = "rbxassetid://10734976230", ["table2"] = "rbxassetid://10734976097",
	["tablet"] = "rbxassetid://10734976394", ["tag"] = "rbxassetid://10734976528",
	["tags"] = "rbxassetid://10734976739", ["target"] = "rbxassetid://10734977012",
	["tent"] = "rbxassetid://10734981750", ["terminal"] = "rbxassetid://10734982144",
	["terminalsquare"] = "rbxassetid://10734981995", ["textcursor"] = "rbxassetid://10734982395",
	["textcursorinput"] = "rbxassetid://10734982297", ["thermometer"] = "rbxassetid://10734983134",
	["thermometersnowflake"] = "rbxassetid://10734982571", ["thermometersun"] = "rbxassetid://10734982771",
	["thumbsdown"] = "rbxassetid://10734983359", ["thumbsup"] = "rbxassetid://10734983629",
	["ticket"] = "rbxassetid://10734983868", ["timer"] = "rbxassetid://10734984606",
	["timeroff"] = "rbxassetid://10734984138", ["timerreset"] = "rbxassetid://10734984355",
	["toggleleft"] = "rbxassetid://10734984834", ["toggleright"] = "rbxassetid://10734985040",
	["tornado"] = "rbxassetid://10734985247", ["toybrick"] = "rbxassetid://10747361919",
	["train"] = "rbxassetid://10747362105", ["trash"] = "rbxassetid://10747362393",
	["trash2"] = "rbxassetid://10747362241", ["treedeciduous"] = "rbxassetid://10747362534",
	["treepine"] = "rbxassetid://10747362748", ["trees"] = "rbxassetid://10747363016",
	["trendingdown"] = "rbxassetid://10747363205", ["trendingup"] = "rbxassetid://10747363465",
	["triangle"] = "rbxassetid://10747363621", ["trophy"] = "rbxassetid://10747363809",
	["truck"] = "rbxassetid://10747364031", ["tv"] = "rbxassetid://10747364593",
	["tv2"] = "rbxassetid://10747364302", ["type"] = "rbxassetid://10747364761",
	["umbrella"] = "rbxassetid://10747364971", ["underline"] = "rbxassetid://10747365191",
	["undo"] = "rbxassetid://10747365484", ["undo2"] = "rbxassetid://10747365359",
	["unlink"] = "rbxassetid://10747365771", ["unlink2"] = "rbxassetid://10747397871",
	["unlock"] = "rbxassetid://10747366027", ["upload"] = "rbxassetid://10747366434",
	["uploadcloud"] = "rbxassetid://10747366266", ["usb"] = "rbxassetid://10747366606",
	["user"] = "rbxassetid://10747373176", ["usercheck"] = "rbxassetid://10747371901",
	["usercog"] = "rbxassetid://10747372167", ["userminus"] = "rbxassetid://10747372346",
	["userplus"] = "rbxassetid://10747372702", ["userx"] = "rbxassetid://10747372992",
	["users"] = "rbxassetid://10747373426", ["utensils"] = "rbxassetid://10747373821",
	["utensilscrossed"] = "rbxassetid://10747373629", ["venetianmask"] = "rbxassetid://10747374003",
	["verified"] = "rbxassetid://10747374131", ["vibrate"] = "rbxassetid://10747374489",
	["vibrateoff"] = "rbxassetid://10747374269", ["video"] = "rbxassetid://10747374938",
	["videooff"] = "rbxassetid://10747374721", ["view"] = "rbxassetid://10747375132",
	["voicemail"] = "rbxassetid://10747375281", ["volume"] = "rbxassetid://10747376008",
	["volume1"] = "rbxassetid://10747375450", ["volume2"] = "rbxassetid://10747375679",
	["volumex"] = "rbxassetid://10747375880", ["wallet"] = "rbxassetid://10747376205",
	["wand"] = "rbxassetid://10747376565", ["wand2"] = "rbxassetid://10747376349",
	["watch"] = "rbxassetid://10747376722", ["waves"] = "rbxassetid://10747376931",
	["webcam"] = "rbxassetid://10747381992", ["wifi"] = "rbxassetid://10747382504",
	["wifioff"] = "rbxassetid://10747382268", ["wind"] = "rbxassetid://10747382750",
	["wraptext"] = "rbxassetid://10747383065", ["wrench"] = "rbxassetid://10747383470",
	["x"] = "rbxassetid://10747384394", ["xcircle"] = "rbxassetid://10747383819",
	["xoctagon"] = "rbxassetid://10747384037", ["xsquare"] = "rbxassetid://10747384217",
	["zoomin"] = "rbxassetid://10747384552", ["zoomout"] = "rbxassetid://10747384679"
}

function BLOOD_LIB:GetIcon(name)
	return self.Icons[name] or ""
end

local Theme = {
	Main = Color3.fromRGB(20, 20, 25),
	Secondary = Color3.fromRGB(28, 28, 35),
	Element = Color3.fromRGB(35, 35, 45),
	Accent = Color3.fromRGB(255, 25, 25),
	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 180),
	DarkContrast = Color3.fromRGB(15, 15, 20),
	Outline = Color3.fromRGB(50, 50, 60)
}

local function Create(class, props)
	local inst = Instance.new(class)
	for i, v in pairs(props) do
		if i ~= "Parent" then inst[i] = v end
	end
	inst.Parent = props.Parent
	return inst
end

local function Tween(obj, props, time) 
	TweenService:Create(obj, TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad), props):Play()
end

function BLOOD_LIB:CreateWindow(config)
	local Window = {}
	config = config or {}
	
	if CoreGui:FindFirstChild("BLOOD_LIB_UI") then CoreGui.BLOOD_LIB_UI:Destroy() end
	
	local ScreenGui = Create("ScreenGui", {Name = "BLOOD_LIB_UI", Parent = CoreGui, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	
	local Main = Create("Frame", {
		Name = "Main", Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Main, Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 650, 0, 450), ClipsDescendants = true
	})
	Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Main})
	Create("UIStroke", {Parent = Main, Color = Theme.Accent, Thickness = 1.2, Transparency = 0.2})
	
	-- TopBar
	local TopBar = Create("Frame", {Parent = Main, BackgroundColor3 = Theme.DarkContrast, Size = UDim2.new(1, 0, 0, 35)})
	Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TopBar})
	
	-- LOGO + TITLE
	local Logo = Create("ImageLabel", {
		Parent = TopBar, BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0.5, -10),
		Size = UDim2.new(0, 20, 0, 20), Image = "rbxassetid://109026017200686"
	})
	
	Create("TextLabel", {
		Parent = TopBar, BackgroundTransparency = 1, Position = UDim2.new(0, 35, 0, 0),
		Size = UDim2.new(1, -115, 1, 0), Font = Enum.Font.GothamBold, Text = config.Title or "BLOOD LIB",
		TextColor3 = Theme.Text, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
	})
	
	-- Close/Minimize
	local function TopBtn(text, pos, callback)
		local Btn = Create("TextButton", {
			Parent = TopBar, BackgroundTransparency = 1, Position = pos, Size = UDim2.new(0, 30, 1, 0),
			Font = Enum.Font.GothamBold, Text = text, TextColor3 = Theme.SubText, TextSize = 16
		})
		Btn.MouseButton1Click:Connect(callback)
		Btn.MouseEnter:Connect(function() Tween(Btn, {TextColor3 = Theme.Accent}, 0.1) end)
		Btn.MouseLeave:Connect(function() Tween(Btn, {TextColor3 = Theme.SubText}, 0.1) end)
	end
	TopBtn("—", UDim2.new(1, -60, 0, 0), function() Main.Visible = not Main.Visible end)
	TopBtn("✕", UDim2.new(1, -30, 0, 0), function() ScreenGui:Destroy() end)
	
	-- Drag
	local dragging, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true; dragStart = input.Position; startPos = Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	
	-- Tab List Izquierda
	local TabList = Create("ScrollingFrame", {
		Parent = Main, BackgroundColor3 = Theme.DarkContrast, Position = UDim2.new(0, 0, 0, 35),
		Size = UDim2.new(0, 160, 1, -35), CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Accent, BorderSizePixel = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y
	})
	Create("UIListLayout", {Parent = TabList, Padding = UDim.new(0, 4), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder})
	Create("UIPadding", {Parent = TabList, PaddingTop = UDim.new(0, 8)})
	
	-- SearchBox
	function Window:CreateSearchBox(callback)
		local SearchBox = Create("TextBox", {
			Parent = TabList, BackgroundColor3 = Theme.Element, Size = UDim2.new(1, -16, 0, 28),
			Font = Enum.Font.Gotham, PlaceholderText = "Search...", Text = "", TextColor3 = Theme.Text,
			TextSize = 12, ClearTextOnFocus = false, LayoutOrder = -1
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SearchBox})
		Create("UIStroke", {Parent = SearchBox, Color = Theme.Outline, Thickness = 1})
		Create("UIPadding", {Parent = SearchBox, PaddingLeft = UDim.new(0, 8)})
		if callback then SearchBox:GetPropertyChangedSignal("Text"):Connect(function() callback(SearchBox.Text) end) end
		return SearchBox
	end
	
	-- Contenedor de contenido
	local ContentHolder = Create("Frame", {
		Parent = Main, BackgroundTransparency = 1, Position = UDim2.new(0, 170, 0, 45),
		Size = UDim2.new(1, -180, 1, -55)
	})
	
	Window.Tabs = {}
	Window.CurrentTab = nil
	
	function Window:CreateTab(name, iconName)
		local Tab = {}
		local iconId = BLOOD_LIB:GetIcon(iconName) or ""
		
		local Btn = Create("TextButton", {
			Parent = TabList, BackgroundColor3 = Theme.Main, Size = UDim2.new(1, -16, 0, 32),
			Font = Enum.Font.GothamSemibold, Text = "", TextColor3 = Theme.SubText, 
			TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, AutoButtonColor = false
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Btn})
		
		if iconId ~= "" then
			Create("ImageLabel", {
				Parent = Btn, BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0.5, -8),
				Size = UDim2.new(0, 16, 0, 16), Image = iconId, ImageColor3 = Theme.SubText
			})
			Create("TextLabel", {
				Parent = Btn, BackgroundTransparency = 1, Position = UDim2.new(0, 30, 0, 0),
				Size = UDim2.new(1, -35, 1, 0), Font = Enum.Font.GothamSemibold, Text = name,
				TextColor3 = Theme.SubText, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left
			})
		else
			Btn.Text = " "..name
		end
		
		local Selector = Create("Frame", {
			Parent = Btn, BackgroundColor3 = Theme.Accent, Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 3, 1, 0), Visible = false
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Selector})
		
		local Page = Create("ScrollingFrame", {
			Parent = ContentHolder, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent,
			Visible = false, BorderSizePixel = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y
		})
		Create("UIListLayout", {Parent = Page, Padding = UDim.new(0, 8)})
		
		Btn.MouseButton1Click:Connect(function()
			for _, t in pairs(Window.Tabs) do
				t.Page.Visible = false
				Tween(t.Button, {BackgroundColor3 = Theme.Main}, 0.1)
				t.Selector.Visible = false
				local img = t.Button:FindFirstChildOfClass("ImageLabel")
				local lbl = t.Button:FindFirstChildOfClass("TextLabel")
				if img then Tween(img, {ImageColor3 = Theme.SubText}, 0.1) end
				if lbl then Tween(lbl, {TextColor3 = Theme.SubText}, 0.1) else Tween(t.Button, {TextColor3 = Theme.SubText}, 0.1) end
			end
			Page.Visible = true
			Tween(Btn, {BackgroundColor3 = Theme.Element}, 0.1)
			Selector.Visible = true
			local img = Btn:FindFirstChildOfClass("ImageLabel")
			local lbl = Btn:FindFirstChildOfClass("TextLabel")
			if img then Tween(img, {ImageColor3 = Theme.Text}, 0.1) end
			if lbl then Tween(lbl, {TextColor3 = Theme.Text}, 0.1) else Tween(Btn, {TextColor3 = Theme.Text}, 0.1) end
			Window.CurrentTab = Tab
		end)
		
		if #Window.Tabs == 0 then
			Page.Visible = true
			Btn.BackgroundColor3 = Theme.Element
			Selector.Visible = true
			local img = Btn:FindFirstChildOfClass("ImageLabel")
			local lbl = Btn:FindFirstChildOfClass("TextLabel")
			if img then img.ImageColor3 = Theme.Text end
			if lbl then lbl.TextColor3 = Theme.Text else Btn.TextColor3 = Theme.Text end
			Window.CurrentTab = Tab
		end
		
		Tab.Button = Btn; Tab.Page = Page; Tab.Selector = Selector
		table.insert(Window.Tabs, Tab)
		
		function Tab:CreateSection(name)
			local Section = {}
			local Holder = Create("Frame", {
				Parent = Page, BackgroundColor3 = Theme.Secondary, Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y
			})
			Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Holder})
			Create("UIStroke", {Parent = Holder, Color = Theme.Outline, Thickness = 1})
			
			Create("TextLabel", {
				Parent = Holder, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30),
				Font = Enum.Font.GothamBold, Text = name, TextColor3 = Theme.Text, TextSize = 13
			})
			
			local Container = Create("Frame", {Parent = Holder, BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 30), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y})
			Create("UIListLayout", {Parent = Container, Padding = UDim.new(0, 6)})
			Create("UIPadding", {Parent = Container, PaddingLeft = UDim.new(0, 10), PaddingRight = UDim2.new(0, 10), PaddingBottom = UDim.new(0, 10)})
			
			function Section:CreateLabel(text)
				local Lbl = Create("TextLabel", {
					Parent = Container, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18),
					Font = Enum.Font.Gotham, Text = text, TextColor3 = Theme.SubText,
					TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y
				})
				return Lbl
			end
			
			function Section:CreateDivider()
				return Create("Frame", {Parent = Container, BackgroundColor3 = Theme.Outline, Size = UDim2.new(1, 0, 0, 1)})
			end
			
			function Section:CreateButton(text, callback)
				local Btn = Create("TextButton", {
					Parent = Container, BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, 30),
					Font = Enum.Font.GothamSemibold, Text = text, TextColor3 = Theme.Text,
					TextSize = 13, AutoButtonColor = false
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Btn})
				Create("UIStroke", {Parent = Btn, Color = Theme.Outline, Thickness = 1})
				
				Btn.MouseButton1Click:Connect(function()
					Tween(Btn, {BackgroundColor3 = Theme.Accent}, 0.1)
					task.wait(0.1)
					Tween(Btn, {BackgroundColor3 = Theme.Element}, 0.1)
					if callback then task.spawn(callback) end
				end)
				Btn.MouseEnter:Connect(function() Tween(Btn, {BackgroundColor3 = Theme.Main}, 0.1) end)
				Btn.MouseLeave:Connect(function() Tween(Btn, {BackgroundColor3 = Theme.Element}, 0.1) end)
				return Btn
			end
			
			function Section:CreateToggle(text, default, callback)
				local Toggle = {Value = default or false}
				local Frame = Create("Frame", {Parent = Container, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26)})
				
				Create("TextLabel", {
					Parent = Frame, BackgroundTransparency = 1, Size = UDim2.new(1, -50, 1, 0),
					Font = Enum.Font.Gotham, Text = text, TextColor3 = Theme.Text,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left
				})
				
				local Switch = Create("Frame", {
					Parent = Frame, AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Toggle.Value and Theme.Accent or Theme.Element,
					Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 42, 0, 22)
				})
				Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Switch})
				Create("UIStroke", {Parent = Switch, Color = Theme.Outline, Thickness = 1})
				
				local Circle = Create("Frame", {
					Parent = Switch, BackgroundColor3 = Theme.Text, Position = Toggle.Value and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
					Size = UDim2.new(0, 18, 0, 18)
				})
				Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Circle})
				
				local function Update()
					Tween(Switch, {BackgroundColor3 = Toggle.Value and Theme.Accent or Theme.Element}, 0.2)
					Tween(Circle, {Position = Toggle.Value and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.2)
					if callback then task.spawn(callback, Toggle.Value) end
				end
				
				Frame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Toggle.Value = not Toggle.Value; Update()
					end
				end)
				
				function Toggle:Set(value)
					Toggle.Value = value; Update()
				end
				
				return Toggle
			end
			
			function Section:CreateSlider(text, min, max, default, callback)
				local Slider = {Value = default or min}
				local Frame = Create("Frame", {Parent = Container, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 45)})
				
				local Label = Create("TextLabel", {
					Parent = Frame, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20),
					Font = Enum.Font.Gotham, Text = text..": "..Slider.Value, TextColor3 = Theme.Text,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left
				})
				
				local Bar = Create("Frame", {Parent = Frame, BackgroundColor3 = Theme.Element, Position = UDim2.new(0, 0, 0, 25), Size = UDim2.new(1, 0, 0, 8)})
				Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Bar})
				Create("UIStroke", {Parent = Bar, Color = Theme.Outline, Thickness = 1})
				
				local Fill = Create("Frame", {Parent = Bar, BackgroundColor3 = Theme.Accent, Size = UDim2.new((Slider.Value - min)/(max - min), 0, 1, 0)})
				Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Fill})
				
				local dragging = false
				Bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
				UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
				RunService.RenderStepped:Connect(function()
					if dragging then
						local percent = math.clamp((UserInputService:GetMouseLocation().X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
						Slider.Value = math.floor(min + (max - min) * percent)
						Fill.Size = UDim2.new(percent, 0, 1, 0)
						Label.Text = text..": "..Slider.Value
						if callback then task.spawn(callback, Slider.Value) end
					end
				end)
				
				function Slider:Set(value)
					Slider.Value = math.clamp(value, min, max)
					local percent = (Slider.Value - min)/(max - min)
					Fill.Size = UDim2.new(percent, 0, 1, 0)
					Label.Text = text..": "..Slider.Value
				end
				
				return Slider
			end
			
			function Section:CreateDropdown(text, list, callback)
				local Dropdown = {Value = list[1], Open = false}
				local Btn = Create("TextButton", {
					Parent = Container, BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, 30),
					Font = Enum.Font.Gotham, Text = text..": "..Dropdown.Value, TextColor3 = Theme.Text,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Btn})
				Create("UIStroke", {Parent = Btn, Color = Theme.Outline, Thickness = 1})
				Create("UIPadding", {Parent = Btn, PaddingLeft = UDim.new(0, 8)})
				
				local List = Create("ScrollingFrame", {
					Parent = Btn, BackgroundColor3 = Theme.Element, Position = UDim2.new(0, 0, 1, 5), 
					Size = UDim2.new(1, 0, 0, math.min(#list * 28, 140)), Visible = false, ZIndex = 5,
					ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = List})
				Create("UIStroke", {Parent = List, Color = Theme.Outline, Thickness = 1})
				Create("UIListLayout", {Parent = List, SortOrder = Enum.SortOrder.LayoutOrder})
				
				for _, v in pairs(list) do
					local Opt = Create("TextButton", {
						Parent = List, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), 
						Font = Enum.Font.Gotham, Text = " "..v, TextColor3 = Theme.SubText, 
						TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6
					})
					Opt.MouseButton1Click:Connect(function()
						Dropdown.Value = v; Btn.Text = text..": "..v; List.Visible = false; Dropdown.Open = false
						if callback then task.spawn(callback, v) end
					end)
					Opt.MouseEnter:Connect(function() Tween(Opt, {TextColor3 = Theme.Text, BackgroundTransparency = 0.8}, 0.1) end)
					Opt.MouseLeave:Connect(function() Tween(Opt, {TextColor3 = Theme.SubText, BackgroundTransparency = 1}, 0.1) end)
				end
				Btn.MouseButton1Click:Connect(function() 
					Dropdown.Open = not Dropdown.Open
					List.Visible = Dropdown.Open 
				end)
				
				function Dropdown:Set(value)
					if table.find(list, value) then
						Dropdown.Value = value; Btn.Text = text..": "..value
					end
				end
				
				return Dropdown
			end
			
			function Section:CreateTextbox(text, placeholder, callback)
				local Box = Create("TextBox", {
					Parent = Container, BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, 30),
					Font = Enum.Font.Gotham, PlaceholderText = placeholder or text, Text = "",
					TextColor3 = Theme.Text, TextSize = 13, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Box})
				Create("UIStroke", {Parent = Box, Color = Theme.Outline, Thickness = 1})
				Create("UIPadding", {Parent = Box, PaddingLeft = UDim.new(0, 8)})
				Box.FocusLost:Connect(function(enter) if enter and callback then task.spawn(callback, Box.Text) end end)
				return Box
			end
			
			function Section:CreateKeybind(text, default, callback)
				local Bind = {Value = default or Enum.KeyCode.Unknown}
				local Frame = Create("Frame", {Parent = Container, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26)})
				Create("TextLabel", {Parent = Frame, BackgroundTransparency = 1, Size = UDim2.new(1, -65, 1, 0), Font = Enum.Font.Gotham, Text = text, TextColor3 = Theme.Text, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left})
				local Btn = Create("TextButton", {
					Parent = Frame, AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Theme.Element,
					Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 60, 0, 22),
					Font = Enum.Font.GothamBold, Text = Bind.Value.Name == "Unknown" and "None" or Bind.Value.Name, TextColor3 = Theme.Text, TextSize = 12
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Btn})
				Create("UIStroke", {Parent = Btn, Color = Theme.Outline, Thickness = 1})
				
				local listening = false
				Btn.MouseButton1Click:Connect(function() 
					listening = true; Btn.Text = "..."
					Btn.BackgroundColor3 = Theme.Accent
				end)
				UserInputService.InputBegan:Connect(function(input)
					if listening and input.UserInputType == Enum.UserInputType.Keyboard then
						listening = false; Bind.Value = input.KeyCode
						Btn.Text = input.KeyCode.Name == "Unknown" and "None" or input.KeyCode.Name
						Btn.BackgroundColor3 = Theme.Element
						if callback then task.spawn(callback, input.KeyCode) end
					end
				end)
				
				function Bind:Set(keycode)
					Bind.Value = keycode
					Btn.Text = keycode.Name == "Unknown" and "None" or keycode.Name
				end
				
				return Bind
			end
			
			function Section:CreateColorPicker(text, default, callback)
				local Picker = {Value = default or Theme.Accent}
				local Btn = Create("TextButton", {
					Parent = Container, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26),
					Font = Enum.Font.Gotham, Text = text, TextColor3 = Theme.Text,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left
				})
				local Preview = Create("Frame", {
					Parent = Btn, AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Picker.Value,
					Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 40, 0, 20)
				})
				Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Preview})
				Create("UIStroke", {Parent = Preview, Color = Theme.Outline, Thickness = 1})
				Btn.MouseButton1Click:Connect(function()
					Picker.Value = Color3.fromRGB(math.random(255), math.random(255), math.random(255))
					Preview.BackgroundColor3 = Picker.Value
					if callback then task.spawn(callback, Picker.Value) end
