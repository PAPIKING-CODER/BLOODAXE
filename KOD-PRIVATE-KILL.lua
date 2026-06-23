local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local displayName = LP.DisplayName or LP.Name

local WHITELIST_URL = "https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/Whitelist.json"

local function isWhitelisted(username)
	local success, result = pcall(function()
		return game:HttpGet(WHITELIST_URL)
	end)
	if success and result then
		local data = HttpService:JSONDecode(result)
		if type(data) == "table" and type(data.whitelist) == "table" then
			for _, name in ipairs(data.whitelist) do
				if tostring(name):lower() == username:lower() then
					return true
				end
			end
		end
	end
	return false
end

if not isWhitelisted(LP.Name) then
	LP:Kick([[❌ NOT WHITELISTED
Join our Discord to get access.
💰 Script Price: 500 Robux
🔗 Discord: https://discord.gg/hh79adY9f2]])
	return
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/BLOOD-LIBRARY"))()
if not Library then return end

local Window = Library:AddWindow("KOD PRIVATE KILLS || BY KING || WELCOME - " .. displayName, {
	main_color = Color3.fromRGB(255, 120, 0),
	secondary_color = Color3.fromRGB(0, 0, 0),
	background = Color3.fromRGB(0, 0, 0),
	title_bar = {Color3.fromRGB(255, 120, 0), Color3.fromRGB(200, 80, 0)},
	min_size = Vector2.new(435, 600),
	can_resize = true,
	toggle_key = Enum.KeyCode.RightShift,
})

local KillsTab = Window:AddTab("💀 KILLS")
local MiscTab = Window:AddTab("⚙️ MISC")
local CreditsTab = Window:AddTab("💎 CREDIT")

local function createToggle(tab, text, callback)
	if tab.AddToggle then return tab:AddToggle(text, callback) end
	if tab.CreateToggle then return tab:CreateToggle(text, {Default = false}, callback) end
	if tab.AddSwitch then return tab:AddSwitch(text, callback) end
	return nil
end

local function createButton(tab, text, callback)
	if tab.AddButton then return tab:AddButton(text, callback) end
	if tab.CreateButton then return tab:CreateButton(text, callback) end
	return nil
end

local function createDropdown(tab, text, list, callback)
	if tab.AddDropdown then return tab:AddDropdown(text, list, callback) end
	if tab.CreateDropdown then return tab:CreateDropdown(text, list, {Default = list[1]}, callback) end
	return nil
end

local function createTextBox(tab, text, callback, placeholder)
	if tab.AddTextBox then return tab:AddTextBox(text, callback) end
	if tab.CreateInput then return tab:CreateInput(text, {Placeholder = placeholder or ""}, callback) end
	return nil
end

local function createLabel(tab, text)
	if tab.AddLabel then return tab:AddLabel(text) end
	if tab.CreateLabel then return tab:CreateLabel(text) end
	return nil
end

local whitelist = {}
local blacklist = {}

createLabel(KillsTab, "WHITELIST & BLACKLIST")
createDropdown(KillsTab, "Add to Whitelist", {}, function(name)
	if name and not table.find(whitelist, name) then table.insert(whitelist, name) end
end)
createDropdown(KillsTab, "Add to Blacklist", {}, function(name)
	if name and not table.find(blacklist, name) then table.insert(blacklist, name) end
end)
createButton(KillsTab, "Clear Whitelist", function() whitelist = {} end)
createButton(KillsTab, "Clear Blacklist", function() blacklist = {} end)

local function updatePlayerLists()
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then table.insert(names, p.Name) end
	end
	return names
end
task.spawn(function()
	while true do
		local names = updatePlayerLists()
		for _, dropdown in ipairs({1,2}) do end
		task.wait(5)
	end
end)

local auraRadius = 30
createTextBox(KillsTab, "Kill Aura Radius (1-150)", function(val)
	auraRadius = math.clamp(tonumber(val) or 30, 1, 150)
end, "30")

createToggle(KillsTab, "Kill All (Non-Whitelisted)", function(state)
	_G.autoKillAll = state
	while _G.autoKillAll do
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP and not table.find(whitelist, p.Name) then
				local char = p.Character
				if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
					local punch = LP.Backpack:FindFirstChild("Punch")
					if punch then punch.Parent = LP.Character end
					local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
					if rh and lh then
						firetouchinterest(rh, char.HumanoidRootPart, 1)
						firetouchinterest(lh, char.HumanoidRootPart, 1)
						firetouchinterest(rh, char.HumanoidRootPart, 0)
						firetouchinterest(lh, char.HumanoidRootPart, 0)
					end
				end
			end
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "Kill Aura (Visual Ring)", function(state)
	_G.killAura = state
	if state then
		local ring = Instance.new("Part")
		ring.Shape = Enum.PartType.Cylinder
		ring.Material = Enum.Material.Neon
		ring.Color = Color3.fromRGB(255, 80, 0)
		ring.Transparency = 0.6
		ring.Anchored = true
		ring.CanCollide = false
		ring.Size = Vector3.new(0.2, auraRadius * 2, auraRadius * 2)
		ring.Parent = workspace
		_G._ringPart = ring
		task.spawn(function()
			while _G.killAura do
				local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
				if ring and myPos then
					ring.CFrame = myPos.CFrame * CFrame.Angles(0, 0, math.rad(90))
				end
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= LP and not table.find(whitelist, p.Name) and not table.find(blacklist, p.Name) then
						local targetRoot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
						if myPos and targetRoot and (myPos.Position - targetRoot.Position).Magnitude <= auraRadius then
							local punch = LP.Backpack:FindFirstChild("Punch")
							if punch then punch.Parent = LP.Character end
							local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
							if rh and lh then
								firetouchinterest(rh, targetRoot, 1)
								firetouchinterest(lh, targetRoot, 1)
								firetouchinterest(rh, targetRoot, 0)
								firetouchinterest(lh, targetRoot, 0)
							end
						end
					end
				end
				task.wait(0.05)
			end
			if _G._ringPart then _G._ringPart:Destroy(); _G._ringPart = nil end
		end)
	end
end)

local targetPlayer = ""
createDropdown(KillsTab, "Target Player", {}, function(name)
	targetPlayer = name
end)

createToggle(KillsTab, "Kill Specific Target", function(state)
	_G.killTarget = state
	while _G.killTarget and targetPlayer ~= "" do
		local p = Players:FindFirstChild(targetPlayer)
		if p and p ~= LP then
			local char = p.Character
			if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
				local punch = LP.Backpack:FindFirstChild("Punch")
				if punch then punch.Parent = LP.Character end
				local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
				if rh and lh then
					firetouchinterest(rh, char.HumanoidRootPart, 1)
					firetouchinterest(lh, char.HumanoidRootPart, 1)
					firetouchinterest(rh, char.HumanoidRootPart, 0)
					firetouchinterest(lh, char.HumanoidRootPart, 0)
				end
			end
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "Kill Blacklist Only", function(state)
	_G.killBlacklist = state
	while _G.killBlacklist do
		for _, name in ipairs(blacklist) do
			local p = Players:FindFirstChild(name)
			if p and p ~= LP then
				local char = p.Character
				if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
					local punch = LP.Backpack:FindFirstChild("Punch")
					if punch then punch.Parent = LP.Character end
					local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
					if rh and lh then
						firetouchinterest(rh, char.HumanoidRootPart, 1)
						firetouchinterest(lh, char.HumanoidRootPart, 1)
						firetouchinterest(rh, char.HumanoidRootPart, 0)
						firetouchinterest(lh, char.HumanoidRootPart, 0)
					end
				end
			end
		end
		task.wait(0.1)
	end
end)

createButton(KillsTab, "Remove Punch Animations", function()
	local blocked = {["rbxassetid://3638729053"]=true, ["rbxassetid://3638767427"]=true}
	local char = LP.Character
	if char and char:FindFirstChild("Humanoid") then
		_G.AnimBlockConnection = char.Humanoid.AnimationPlayed:Connect(function(track)
			if track.Animation then
				local id = track.Animation.AnimationId
				if blocked[id] or track.Name:lower():match("punch") or track.Name:lower():match("attack") then
					track:Stop()
				end
			end
		end)
		_G.BackpackAddedConnection = LP.Backpack.ChildAdded:Connect(function(child)
			if child:IsA("Tool") and LP.Character then
				_G.ToolConnections = _G.ToolConnections or {}
				_G.ToolConnections[child] = child.Activated:Connect(function()
					task.wait(0.05)
					local h = LP.Character and LP.Character:FindFirstChild("Humanoid")
					if h then
						for _, track in pairs(h:GetPlayingAnimationTracks()) do
							local a = track.Animation
							if a and (blocked[a.AnimationId] or track.Name:lower():match("punch")) then
								track:Stop()
							end
						end
					end
				end)
			end
		end)
	end
end)

createButton(KillsTab, "Recover Punch Animations", function()
	if _G.AnimBlockConnection then _G.AnimBlockConnection:Disconnect(); _G.AnimBlockConnection = nil end
	if _G.BackpackAddedConnection then _G.BackpackAddedConnection:Disconnect(); _G.BackpackAddedConnection = nil end
	if _G.ToolConnections then
		for _, conn in pairs(_G.ToolConnections) do if conn then conn:Disconnect() end end
		_G.ToolConnections = nil
	end
end)

createToggle(KillsTab, "Auto Equip Punch", function(state)
	_G.autoEquipPunch = state
	while _G.autoEquipPunch do
		local punch = LP.Backpack:FindFirstChild("Punch")
		if punch and LP.Character and not LP.Character:FindFirstChild("Punch") then
			punch.Parent = LP.Character
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "Auto Punch", function(state)
	_G.autoPunch = state
	while _G.autoPunch do
		local punch = LP.Backpack:FindFirstChild("Punch") or (LP.Character and LP.Character:FindFirstChild("Punch"))
		if punch then
			if punch.Parent ~= LP.Character then punch.Parent = LP.Character end
			punch:Activate()
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "Fast Punch", function(state)
	_G.fastPunch = state
	while _G.fastPunch do
		local punch = LP.Backpack:FindFirstChild("Punch")
		if punch then
			punch.Parent = LP.Character
			if punch:FindFirstChild("attackTime") then punch.attackTime.Value = 0 end
			LP.muscleEvent:FireServer("punch", "rightHand")
			LP.muscleEvent:FireServer("punch", "leftHand")
		end
		task.wait(0.05)
	end
end)

createToggle(KillsTab, "Auto Punch No Anim", function(state)
	_G.autoPunchNoAnim = state
	while _G.autoPunchNoAnim do
		local punch = LP.Backpack:FindFirstChild("Punch") or (LP.Character and LP.Character:FindFirstChild("Punch"))
		if punch then
			if punch.Parent ~= LP.Character then punch.Parent = LP.Character end
			LP.muscleEvent:FireServer("punch", "rightHand")
			LP.muscleEvent:FireServer("punch", "leftHand")
		end
		task.wait(0.01)
	end
end)

createToggle(KillsTab, "Auto Good Karma", function(state)
	_G.autoGoodKarma = state
	while _G.autoGoodKarma do
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP then
				local ek, gk = p:FindFirstChild("evilKarma"), p:FindFirstChild("goodKarma")
				if ek and gk and ek.Value > gk.Value then
					local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
					if root then
						local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
						if rh and lh then
							firetouchinterest(rh, root, 1)
							firetouchinterest(lh, root, 1)
							firetouchinterest(rh, root, 0)
							firetouchinterest(lh, root, 0)
						end
					end
				end
			end
		end
		task.wait(0.05)
	end
end)

createToggle(KillsTab, "Auto Bad Karma", function(state)
	_G.autoBadKarma = state
	while _G.autoBadKarma do
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP then
				local ek, gk = p:FindFirstChild("evilKarma"), p:FindFirstChild("goodKarma")
				if ek and gk and gk.Value > ek.Value then
					local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
					if root then
						local rh, lh = LP.Character:FindFirstChild("RightHand"), LP.Character:FindFirstChild("LeftHand")
						if rh and lh then
							firetouchinterest(rh, root, 1)
							firetouchinterest(lh, root, 1)
							firetouchinterest(rh, root, 0)
							firetouchinterest(lh, root, 0)
						end
					end
				end
			end
		end
		task.wait(0.05)
	end
end)

createToggle(KillsTab, "God Mode", function(state)
	_G.godMode = state
	while _G.godMode do
		pcall(function() ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl") end)
		task.wait()
	end
end)

createToggle(KillsTab, "Auto Slams", function(state)
	_G.autoSlam = state
	while _G.autoSlam do
		local gs = LP.Backpack:FindFirstChild("Ground Slam") or (LP.Character and LP.Character:FindFirstChild("Ground Slam"))
		if gs then
			if gs.Parent == LP.Backpack then gs.Parent = LP.Character end
			if gs:FindFirstChild("attackTime") then gs.attackTime.Value = 0 end
			LP.muscleEvent:FireServer("slam")
			gs:Activate()
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "Damage with Godmode", function(state)
	_G.dmgGodmode = state
	while _G.dmgGodmode do
		local gs = LP.Backpack:FindFirstChild("Ground Slam") or (LP.Character and LP.Character:FindFirstChild("Ground Slam"))
		if gs then
			if gs.Parent == LP.Backpack then gs.Parent = LP.Character end
			if gs:FindFirstChild("attackTime") then gs.attackTime.Value = 0 end
			LP.muscleEvent:FireServer("slam")
			gs:Activate()
		end
		task.wait(0.1)
	end
end)

createToggle(KillsTab, "NaN Combo", function(state)
	_G.nanCombo = state
	if state then
		ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0/0)
		task.spawn(function()
			while _G.nanCombo do
				local egg = LP.Backpack:FindFirstChild("Protein Egg")
				if egg and LP.Character and not LP.Character:FindFirstChild("Protein Egg") then
					egg.Parent = LP.Character
				end
				local punch = LP.Backpack:FindFirstChild("Punch") or (LP.Character and LP.Character:FindFirstChild("Punch"))
				if punch then
					if punch.Parent ~= LP.Character then punch.Parent = LP.Character end
					LP.muscleEvent:FireServer("punch", "rightHand")
					LP.muscleEvent:FireServer("punch", "leftHand")
				end
				task.wait(0.05)
			end
		end)
	end
end)

createButton(KillsTab, "Set Size NaN", function()
	ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0/0)
end)

createButton(KillsTab, "Freeze Water", function()
	local sz = 20000
	local positions = {
		Vector3.new(-8922, -9.8, -6233), Vector3.new(-1107, -9.8, -4127),
		Vector3.new(-2054, -9.4, -5135), Vector3.new(-3072, -9.6, -6136),
		Vector3.new(-4088, -9.4, -5125), Vector3.new(-5100, -9.2, -5128),
		Vector3.new(-6103, -9, -5590), Vector3.new(-7096, -9.8, -6403),
		Vector3.new(-9882, -9.6, -5228), Vector3.new(-8889, -9.4, -4767),
		Vector3.new(-7888, -9.2, -4648), Vector3.new(-6868, -9.9, -4124),
		Vector3.new(-5883, -9.7, -4073), Vector3.new(-9873, -9.2, -6775),
		Vector3.new(-8453, -9.2, -7212), Vector3.new(-7482, -9.8, -8082),
		Vector3.new(-6483, -9.2, -9055), Vector3.new(-6561, -9.8, -10038),
		Vector3.new(1009, -9.1, 1046), Vector3.new(2178, -9, 287)
	}
	for _, pos in ipairs(positions) do
		local p = Instance.new("Part")
		p.Size = Vector3.new(sz, 1, sz)
		p.Position = pos
		p.Anchored = true
		p.Transparency = 1
		p.CanCollide = true
		p.Parent = workspace
	end
end)

createButton(KillsTab, "Pegar Muerto", function()
	local urls = {
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack",
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack2",
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack3",
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack4",
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack5",
		"https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack6"
	}
	for _, url in ipairs(urls) do
		task.spawn(function()
			local s, r = pcall(game.HttpGet, game, url)
			if s then pcall(loadstring, r) end
		end)
	end
end)

createButton(KillsTab, "Disable Eggs", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/244ihssp/IlIIS/refs/heads/main/1"))()
end)

local targetSpy = ""
createDropdown(KillsTab, "Player to Spy/Follow", {}, function(name)
	targetSpy = name
end)

createToggle(KillsTab, "View Player", function(state)
	_G.spyMode = state
	if state then
		task.spawn(function()
			local cam = workspace.CurrentCamera
			cam.CameraSubject = LP.Character and LP.Character:FindFirstChild("Humanoid") or LP
			while _G.spyMode do
				local p = Players:FindFirstChild(targetSpy)
				if p and p.Character and p.Character:FindFirstChild("Humanoid") then
					cam.CameraSubject = p.Character.Humanoid
				end
				task.wait(0.1)
			end
			cam.CameraSubject = LP.Character and LP.Character:FindFirstChild("Humanoid") or LP
		end)
	end
end)

createToggle(KillsTab, "Follow Player", function(state)
	_G.followMode = state
	while _G.followMode do
		local p = Players:FindFirstChild(targetSpy)
		if p and p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
			if myRoot then
				myRoot.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
			end
		end
		task.wait(0.1)
	end
end)

createButton(KillsTab, "Stop Spy/Follow", function()
	_G.spyMode = false
	_G.followMode = false
	workspace.CurrentCamera.CameraSubject = LP.Character and LP.Character:FindFirstChild("Humanoid") or LP
end)

createToggle(KillsTab, "HP ESP", function(state)
	_G.hpEsp = state
	if state then
		local function short(n)
			n = tonumber(n) or 0
			if n >= 1e18 then return string.format("%.1fQi", n/1e18) end
			if n >= 1e15 then return string.format("%.1fQa", n/1e15) end
			if n >= 1e12 then return string.format("%.1fT", n/1e12) end
			if n >= 1e9 then return string.format("%.1fB", n/1e9) end
			if n >= 1e6 then return string.format("%.1fM", n/1e6) end
			if n >= 1e3 then return string.format("%.1fK", n/1e3) end
			return tostring(math.floor(n))
		end
		local function getVal(p, names)
			for _, v in pairs(p:GetDescendants()) do
				if v:IsA("ValueBase") then
					for _, n in pairs(names) do
						if v.Name == n then return v.Value end
					end
				end
			end
			return 0
		end
		local function addTag(plr)
			if plr == LP then return end
			local char = plr.Character or plr.CharacterAdded:Wait()
			local head = char:WaitForChild("Head")
			if head:FindFirstChild("ML_STATS") then head.ML_STATS:Destroy() end
			local tag = Instance.new("BillboardGui")
			tag.Name = "ML_STATS"
			tag.Adornee = head
			tag.Size = UDim2.new(0, 130, 0, 45)
			tag.StudsOffset = Vector3.new(0, 3.2, 0)
			tag.AlwaysOnTop = true
			tag.MaxDistance = 70
			tag.Parent = head
			local text = Instance.new("TextLabel")
			text.Size = UDim2.new(1, 0, 1, 0)
			text.BackgroundTransparency = 1
			text.Font = Enum.Font.GothamBold
			text.TextScaled = true
			text.TextWrapped = true
			text.TextColor3 = Color3.fromRGB(255, 220, 0)
			text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			text.TextStrokeTransparency = 0
			text.Parent = tag
			task.spawn(function()
				while char.Parent and _G.hpEsp do
					local st = getVal(plr, {"Strength", "strength"})
					local du = getVal(plr, {"Durability", "DurabilityStat", "durability"})
					text.Text = plr.Name .. "\n💪 " .. short(st) .. "  🛡 " .. short(du)
					task.wait(1)
				end
				if tag then tag:Destroy() end
			end)
		end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP then task.spawn(addTag, p) end
		end
		_G._espConn = Players.PlayerAdded:Connect(function(p)
			p.CharacterAdded:Connect(function()
				task.wait(2)
				if _G.hpEsp then addTag(p) end
			end)
		end)
	else
		if _G._espConn then _G._espConn:Disconnect(); _G._espConn = nil end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("ML_STATS") then
				p.Character.Head.ML_STATS:Destroy()
			end
		end
	end
end)

createButton(KillsTab, "Load Kill Counter UI", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KILL-COUNTER-UI.lua"))()
end)

createToggle(MiscTab, "Anti Fling", function(state)
	if state then
		local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(100000, 0, 100000)
			bv.Velocity = Vector3.new(0, 0, 0)
			bv.P = 1250
			bv.Parent = hrp
			_G._antikb = bv
		end
	else
		if _G._antikb then _G._antikb:Destroy(); _G._antikb = nil end
	end
end)

createToggle(MiscTab, "Anti Knockback", function(state)
	if state then
		local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(100000, 0, 100000)
			bv.Velocity = Vector3.new(0, 0, 0)
			bv.P = 1250
			bv.Parent = hrp
			_G._antikb2 = bv
		end
	else
		if _G._antikb2 then _G._antikb2:Destroy(); _G._antikb2 = nil end
	end
end)

createLabel(MiscTab, "ANTI AFK & PERFORMANCE")
createButton(MiscTab, "Load Anti AFK", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODAFK.lua"))()
end)
createButton(MiscTab, "Load FPS & Ping", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODFPSCOUNT.lua"))()
end)

createLabel(MiscTab, "SKY COLOR")
local skyDropdown = createDropdown(MiscTab, "Select Sky Color", {
	"Day", "Night", "Sunset", "Aurora", "Blood Moon", "Rainbow", "Dark Purple", "Neon Blue"
}, function(selection)
	local L = game:GetService("Lighting")
	if selection == "Day" then
		L.ClockTime = 12; L.Brightness = 2; L.Ambient = Color3.fromRGB(255,255,255)
	elseif selection == "Night" then
		L.ClockTime = 0; L.Brightness = 1; L.Ambient = Color3.fromRGB(40,40,40)
	elseif selection == "Sunset" then
		L.ClockTime = 18; L.Brightness = 1; L.Ambient = Color3.fromRGB(255,170,0)
	elseif selection == "Aurora" then
		L.ClockTime = 20; L.Brightness = 0.9; L.Ambient = Color3.fromRGB(0,255,120); L.OutdoorAmbient = Color3.fromRGB(0,120,255)
	elseif selection == "Blood Moon" then
		L.ClockTime = 0; L.Brightness = 0.5; L.Ambient = Color3.fromRGB(255,0,0)
	elseif selection == "Rainbow" then
		L.ClockTime = 12; L.Brightness = 3; L.Ambient = Color3.fromHSV(tick()%1,1,1)
	elseif selection == "Dark Purple" then
		L.ClockTime = 0; L.Brightness = 0.5; L.Ambient = Color3.fromRGB(100,0,150)
	elseif selection == "Neon Blue" then
		L.ClockTime = 0; L.Brightness = 0.8; L.Ambient = Color3.fromRGB(0,200,255)
	end
end)

createLabel(MiscTab, "MOVEMENT & UTILITY")
createToggle(MiscTab, "NoClip", function(state)
	if state then
		_G._noclipConn = RunService.Stepped:Connect(function()
			if LP.Character then
				for _, part in pairs(LP.Character:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			end
		end)
	else
		if _G._noclipConn then _G._noclipConn:Disconnect(); _G._noclipConn = nil end
	end
end)

createButton(MiscTab, "Rejoin Server", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

createButton(MiscTab, "Server Hop", function()
	local PlaceID = game.PlaceId
	local function getServer()
		local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
		for _, s in ipairs(servers.data) do
			if s.playing < s.maxPlayers then return s.id end
		end
	end
	local id = getServer()
	if id then
		game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, id, LP)
	end
end)

createLabel(CreditsTab, "━━━━━━━━━━━━━━━━━━━━━━━━")
createLabel(CreditsTab, "  KOD PVP SCRIPT BY KING  ")
createLabel(CreditsTab, "━━━━━━━━━━━━━━━━━━━━━━━━")
createLabel(CreditsTab, "OWNERs :")
createLabel(CreditsTab, "  • monarca")
createLabel(CreditsTab, "  • king")
createLabel(CreditsTab, "  • ghost")
createLabel(CreditsTab, "━━━━━━━━━━━━━━━━━━━━━━━━")
createLabel(CreditsTab, "ENJOI THE SCRIPT AND KILL NIGGAS")
createLabel(CreditsTab, "━━━━━━━━━━━━━━━━━━━━━━━━")

local discordLabel = createLabel(CreditsTab, "Discord: https://discord.gg/hh79adY9f2")
task.spawn(function()
	while true do
		for _, color in ipairs({
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 165, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(75, 0, 130)
		}) do
			discordLabel.TextColor3 = color
			task.wait(0.3)
		end
	end
end)

createButton(CreditsTab, "Copy Discord Link", function()
	setclipboard("https://discord.gg/hh79adY9f2")
end)

Window:SetTab(1)
