local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1517224537245089802/bpolcuJSaDOnWzM4gntFqoEioxvPsnCyF_3eSgkQqybmegoGnqPIJAoKtkJzgelaH93P"

local function sendPremiumLog()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local playerName = LocalPlayer.DisplayName or LocalPlayer.Name
    
    local embed = {
        title = "🖤 KOD SYSTEM • EXECUTION LOG",
        description = "📌 **Script successfully loaded in Muscle Legends!**",
        color = 0xF39C12,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        thumbnail = {
            url = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"
        },
        fields = {
            { name = "👤 Player Info", value = string.format("**Username:** `%s`\n**Display Name:** `%s`\n**User ID:** `%s`\n**Account Age:** `%s`", LocalPlayer.Name, LocalPlayer.DisplayName, LocalPlayer.UserId, LocalPlayer.AccountAge), inline = true },
            { name = "🎮 Game Info", value = string.format("**Game:** `%s`\n**Place ID:** `%s`\n**Server ID:** `%s`", game.Name, game.PlaceId, game.JobId), inline = true },
            { name = "⚙️ Status", value = "**Status:** `🟢 Loaded`\n**Version:** `v1.0`\n**Ping:** `" .. math.floor(pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end) and Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0) .. " ms`", inline = true },
            { name = "🕒 Time", value = "**Date:** `" .. os.date("%Y-%m-%d %H:%M:%S") .. "`", inline = false }
        },
        footer = { text = "KOD SECURITY LOGS • System Monitoring" }
    }
    
    local payload = { embeds = { embed } }
    local json = HttpService:JSONEncode(payload)
    local headers = { ["Content-Type"] = "application/json" }
    
    local request = syn and syn.request or http_request or (function() return {Success=false} end)
    
    pcall(function()
        request({
            Url = DISCORD_WEBHOOK,
            Method = "POST",
            Headers = headers,
            Body = json
        })
    end)
end
task.spawn(sendPremiumLog)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/BLOOD-LIBRARY"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Player = LocalPlayer

getgenv().InfiniteJump = false
getgenv().AutoSpinWheel = false
getgenv().AutoWeight = false
getgenv().AutoPushups = false
getgenv().AutoHandstands = false
getgenv().AutoSitups = false
getgenv().fastHitActive = false
getgenv().FastTools = false
getgenv().whitelistedPlayers = {}
getgenv().blacklistedPlayers = {}
getgenv().deathRingRange = 20
getgenv().deathRingEnabled = false
getgenv().killAll = false
getgenv().killBlacklistedOnly = false
getgenv().AutoFarming = false
getgenv().TargetRebirths = 0
getgenv().infiniteRebirthActive = false
getgenv().targetRebirthActive = false
getgenv().AutoSize1 = false
getgenv().AutoSize2 = false
getgenv().AutoTeleportKing = false
getgenv().AutoJoinBrawl = false
getgenv().AutoWinBrawl = false
getgenv().AutoDailySpin = false
getgenv().autoEatEgg = false
getgenv().autoEatEgg60 = false
getgenv().AutoEvolvePet = false
getgenv().AutoEquipPet = false
getgenv().AutoHatchPet = false
getgenv().AutoHatchAura = false
getgenv().AutoUpgradeUltimate = false
getgenv().AutoAcceptQuests = false
getgenv().AutoClaimQuests = false
getgenv().AutoShake = false
getgenv().autoEatAll = false
getgenv().autoClearInv = false
getgenv().AutoTool = false
getgenv().AutoExercise = false
getgenv().AutoSlam = false
getgenv().AutoFollow = false
getgenv().GodMode = false
getgenv().AutoSetSize = false
getgenv().AutoSetSpeed = false
getgenv().UserSize = 2
getgenv().UserSpeed = 120
getgenv().RepsPerTick = 1
getgenv()._FastRep = false
getgenv()._AutoRepFarmMode1 = false
getgenv()._AutoRepFarmMode2 = false
getgenv().SpamPacks = false
getgenv().SpyTarget = nil
getgenv().SelectedTool = "Weight"
getgenv().SelectedPet = "Neon Guardian"
getgenv().SelectedAura = "Blue Aura"
getgenv().SelectedUlt = "+1 Daily Spin"
getgenv().EvolvePet = "Blue Birdie"
getgenv().KillPet = "Wild Wizard"
getgenv().ComboTool = "Pushups"
getgenv().TradeTarget = nil
getgenv().TradePet = "Neon Guardian"

local function setupAntiAFK()
    return Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end
setupAntiAFK()

local function removePortals()
    for _, portal in pairs(game:GetDescendants()) do
        if portal.Name == "RobloxForwardPortals" then portal:Destroy() end
    end
    if getgenv().AdRemovalConnection then getgenv().AdRemovalConnection:Disconnect() end
    getgenv().AdRemovalConnection = game.DescendantAdded:Connect(function(desc)
        if desc.Name == "RobloxForwardPortals" then desc:Destroy() end
    end)
end
removePortals()

local blockedFrames = {"strengthFrame","durabilityFrame","agilityFrame","evilKarmaFrame","goodKarmaFrame"}
for _, name in ipairs(blockedFrames) do
    local frame = ReplicatedStorage:FindFirstChild(name)
    if frame and frame:IsA("GuiObject") then frame.Visible = false end
end
ReplicatedStorage.ChildAdded:Connect(function(child)
    if table.find(blockedFrames, child.Name) and child:IsA("GuiObject") then child.Visible = false end
end)

local function formatNumber(num)
    if num >= 1e15 then return string.format("%.2fQa", num/1e15)
    elseif num >= 1e12 then return string.format("%.2fT", num/1e12)
    elseif num >= 1e9 then return string.format("%.2fB", num/1e9)
    elseif num >= 1e6 then return string.format("%.2fM", num/1e6)
    elseif num >= 1e3 then return string.format("%.2fK", num/1e3)
    else return string.format("%.0f", num) end
end

local Window, frame = Library:AddWindow("KOD HUB || BY KING © || WELCOME - "..Player.DisplayName, {
    main_color = Color3.fromRGB(255, 165, 0),
    title_bar = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 165, 0) },
    background = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(20, 20, 20) },
    min_size = Vector2.new(470, 470),
    can_resize = true,
    toggle_key = Enum.KeyCode.RightShift,
    title_bar_transparency = 0,
    background_transparency = 0,
})

-- ============================================
-- 🏠 TAB 1: MAIN
-- ============================================
local MainTab = Window:AddTab("🏠 MAIN")
MainTab:AddLabel("═══════════════════════════════")
MainTab:AddLabel("⚙️ Configurations")

MainTab:AddTextBox("📏 Size (Number)", function(text)
    local v = tonumber(text)
    if v and v > 0 then getgenv().UserSize = v end
end)
MainTab:AddSwitch("🔁 Activate Size", function(state)
    getgenv().AutoSetSize = state
    if state then task.spawn(function()
        while getgenv().AutoSetSize do
            pcall(function() ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", getgenv().UserSize or 2) end)
            task.wait(0.1)
        end
    end) end
end)

MainTab:AddTextBox("🏃 Speed (Number)", function(text)
    local v = tonumber(text)
    if v and v > 0 then getgenv().UserSpeed = v end
end)
MainTab:AddSwitch("🔁 Activate Speed", function(state)
    getgenv().AutoSetSpeed = state
    if state then task.spawn(function()
        while getgenv().AutoSetSpeed do
            pcall(function() ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSpeed", getgenv().UserSpeed or 120) end)
            task.wait(0.1)
        end
    end) end
end)

MainTab:AddLabel("═══════════════════════════════")
MainTab:AddLabel("🛡️ Protection")
MainTab:AddSwitch("Anti Fling", function(state)
    if state then
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(100000, 0, 100000)
            bv.Velocity = Vector3.new(0,0,0)
            bv.P = 1250
            bv.Parent = char.HumanoidRootPart
            getgenv().AntiFlingBV = bv
        end
    else
        if getgenv().AntiFlingBV then getgenv().AntiFlingBV:Destroy() end
    end
end):Set(true)

MainTab:AddSwitch("Lock Position", function(state)
    if state then
        local pos = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.CFrame
        if pos then
            getgenv().LockConnection = RunService.Heartbeat:Connect(function()
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = pos
                end
            end)
        end
    else
        if getgenv().LockConnection then getgenv().LockConnection:Disconnect(); getgenv().LockConnection = nil end
    end
end)

MainTab:AddLabel("═══════════════════════════════")
MainTab:AddLabel("🐾 Pets")
MainTab:AddSwitch("Show My Pets", function(state)
    if Player:FindFirstChild("hidePets") then Player.hidePets.Value = not state end
end)
MainTab:AddSwitch("Show Other Pets", function(state)
    if Player:FindFirstChild("showOtherPetsOn") then Player.showOtherPetsOn.Value = state end
end)

MainTab:AddLabel("═══════════════════════════════")
MainTab:AddLabel("♾️ Misc")
MainTab:AddSwitch("Infinite Jump", function(state)
    getgenv().InfiniteJump = state
    if state then
        getgenv().InfiniteJumpConn = UserInputService.JumpRequest:Connect(function()
            if getgenv().InfiniteJump then
                local char = Player.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char.Humanoid:ChangeState("Jumping")
                end
            end
        end)
    else
        if getgenv().InfiniteJumpConn then getgenv().InfiniteJumpConn:Disconnect() end
    end
end)

local waterParts = {}
local partSize = 2048
local totalDistance = 50000
local startPos = Vector3.new(-2, -9.5, -2)
task.spawn(function()
    local n = math.ceil(totalDistance/partSize)
    for x = 0, n-1 do
        for z = 0, n-1 do
            local function add(pos, name)
                local p = Instance.new("Part")
                p.Size = Vector3.new(partSize, 1, partSize)
                p.Position = pos
                p.Anchored = true
                p.Transparency = 1
                p.CanCollide = true
                p.Name = name
                p.Parent = Workspace
                table.insert(waterParts, p)
            end
            add(startPos + Vector3.new(x*partSize,0,z*partSize), "p"..x.."_"..z)
            add(startPos + Vector3.new(-x*partSize,0,z*partSize), "p"..x.."_"..z)
            add(startPos + Vector3.new(-x*partSize,0,-z*partSize), "p"..x.."_"..z)
            add(startPos + Vector3.new(x*partSize,0,-z*partSize), "p"..x.."_"..z)
        end
    end
end)
MainTab:AddSwitch("🌊 Walk on Water", function(state)
    for _, p in ipairs(waterParts) do if p and p.Parent then p.CanCollide = state end end
end):Set(true)

MainTab:AddSwitch("🎡 Auto Spin Fortune Wheel", function(state)
    getgenv().AutoSpinWheel = state
    if state then task.spawn(function()
        while getgenv().AutoSpinWheel do
            pcall(function()
                local wheel = ReplicatedStorage:FindFirstChild("fortuneWheelChances")
                if wheel then
                    local remote = ReplicatedStorage.rEvents.openFortuneWheelRemote
                    if remote then remote:InvokeServer("openFortuneWheel", wheel["Fortune Wheel"]) end
                end
            end)
            task.wait(1)
        end
    end) end
end)

MainTab:AddSwitch("🎁 Auto Daily Spin", function(state)
    getgenv().AutoDailySpin = state
    if state then task.spawn(function()
        while getgenv().AutoDailySpin do
            pcall(function() ReplicatedStorage.rEvents.spinDailyRemote:InvokeServer("spin") end)
            task.wait(1)
        end
    end) end
end)

MainTab:AddLabel("═══════════════════════════════")
local timeDropdown = MainTab:AddDropdown("🌅 Change Time", function(sel)
    if sel == "Day" then Lighting.ClockTime = 12
    elseif sel == "Night" then Lighting.ClockTime = 0
    elseif sel == "Midnight" then Lighting.ClockTime = 6 end
end)
timeDropdown:Add("Day"); timeDropdown:Add("Night"); timeDropdown:Add("Midnight")

MainTab:AddButton("🔄 Reset Everything", function()
    getgenv().AutoSetSize = false; getgenv().AutoSetSpeed = false; getgenv().InfiniteJump = false
    getgenv().AutoSpinWheel = false; getgenv().AutoDailySpin = false
    local char = Player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
    end
    if getgenv().AntiFlingBV then getgenv().AntiFlingBV:Destroy() end
    if getgenv().LockConnection then getgenv().LockConnection:Disconnect(); getgenv().LockConnection = nil end
    for _, p in ipairs(waterParts) do if p and p.Parent then p.CanCollide = false end end
    Lighting.ClockTime = 12
end)

-- ============================================
-- ⚡ TAB 2: FARM
-- ============================================
local FarmTab = Window:AddTab("⚡ FARM")
FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("📊 Stat Tracker - Farming")

local timeLabelFarm = FarmTab:AddLabel("⏱️ Time: 0d 0h 0m 0s - Inactive")
timeLabelFarm.TextSize = 17
local paceStrengthLabel = FarmTab:AddLabel("💪 Strength Pace: 0 / Hour | 0 / Day | 0 / Week")
paceStrengthLabel.TextSize = 17
local statsStrengthLabel = FarmTab:AddLabel("💪 Strength: 0 | Gained: 0")
statsStrengthLabel.TextSize = 17

local leaderstats = Player:WaitForChild("leaderstats")
local strengthStat = leaderstats:WaitForChild("Strength")
local durabilityStat = Player:WaitForChild("Durability")

local isFarmingRunning = false
local farmStartTime = 0
local farmPausedElapsed = 0
local farmInitialStrength = strengthStat.Value
local farmStrengthHistory = {}
local farmCalcInterval = 10
local farmLastCalcTime = 0

local function updateFarmStats()
    local currentTime = tick()
    local currentStrength = strengthStat.Value
    local currentDurability = durabilityStat.Value
    statsStrengthLabel.Text = "💪 Strength: " .. formatNumber(currentStrength) .. " | Gained: " .. formatNumber(currentStrength - farmInitialStrength)
    if isFarmingRunning then
        local elapsed = farmPausedElapsed + (currentTime - farmStartTime)
        local days = math.floor(elapsed / 86400); local hours = math.floor((elapsed % 86400) / 3600); local minutes = math.floor((elapsed % 3600) / 60); local seconds = math.floor(elapsed % 60)
        timeLabelFarm.Text = "⏱️ Time: "..days.."d "..hours.."h "..minutes.."m "..seconds.."s - Running"
        table.insert(farmStrengthHistory, {time = currentTime, value = currentStrength})
        while #farmStrengthHistory > 0 and currentTime - farmStrengthHistory[1].time > farmCalcInterval do table.remove(farmStrengthHistory, 1) end
        if currentTime - farmLastCalcTime >= farmCalcInterval then
            farmLastCalcTime = currentTime
            if #farmStrengthHistory >= 2 then
                local delta = farmStrengthHistory[#farmStrengthHistory].value - farmStrengthHistory[1].value
                local perSecond = delta / farmCalcInterval
                local perHour = perSecond * 3600; local perDay = perSecond * 86400; local perWeek = perSecond * 604800
                paceStrengthLabel.Text = "💪 Strength Pace: "..formatNumber(perHour).."/Hour | "..formatNumber(perDay).."/Day | "..formatNumber(perWeek).."/Week"
            end
        end
    else
        if farmStartTime > 0 then
            local p = farmPausedElapsed
            timeLabelFarm.Text = "⏱️ Time: "..math.floor(p/86400).."d "..math.floor((p%86400)/3600).."h "..math.floor((p%3600)/60).."m "..math.floor(p%60).."s - Paused"
        end
    end
end
task.spawn(function() while true do updateFarmStats(); task.wait(0.1) end end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("⚡ Fast Farming")
FarmTab:AddSwitch("Fast Strength 250ms", function(state)
    getgenv()._AutoRepFarmMode1 = state
    if state and not isFarmingRunning then
        isFarmingRunning = true; farmStartTime = tick()
        farmInitialStrength = strengthStat.Value; farmStrengthHistory = {}; farmLastCalcTime = tick()
    elseif not state and not getgenv()._AutoRepFarmMode2 and not getgenv()._FastRep and isFarmingRunning then
        isFarmingRunning = false; farmPausedElapsed = farmPausedElapsed + (tick() - farmStartTime)
    end
end)
FarmTab:AddSwitch("Fast Strength 150ms", function(state)
    getgenv()._AutoRepFarmMode2 = state
    if state and not isFarmingRunning then
        isFarmingRunning = true; farmStartTime = tick()
        farmInitialStrength = strengthStat.Value; farmStrengthHistory = {}; farmLastCalcTime = tick()
    elseif not state and not getgenv()._AutoRepFarmMode1 and not getgenv()._FastRep and isFarmingRunning then
        isFarmingRunning = false; farmPausedElapsed = farmPausedElapsed + (tick() - farmStartTime)
    end
end)
FarmTab:AddTextBox("🔢 Rep Speed", function(text)
    local num = tonumber(text)
    if num and num > 0 then getgenv().RepsPerTick = math.floor(num) end
end, {placeholder = "1"})
FarmTab:AddSwitch("Fast Rep", function(state)
    getgenv()._FastRep = state
    if state then
        if not isFarmingRunning then
            isFarmingRunning = true; farmStartTime = tick()
            farmInitialStrength = strengthStat.Value; farmStrengthHistory = {}; farmLastCalcTime = tick()
        end
        local rpt = getgenv().RepsPerTick or 1
        task.spawn(function()
            while getgenv()._FastRep do
                local st = tick()
                while tick() - st < 0.75 and getgenv()._FastRep do
                    for i = 1, rpt do Player.muscleEvent:FireServer("rep") end
                    task.wait(0.02)
                end
                while getgenv()._FastRep and (pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end) or 0) >= 350 do task.wait(1) end
            end
        end)
    else
        if not getgenv()._AutoRepFarmMode1 and not getgenv()._AutoRepFarmMode2 and isFarmingRunning then
            isFarmingRunning = false; farmPausedElapsed = farmPausedElapsed + (tick() - farmStartTime)
        end
    end
end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("🤖 Automatics")
FarmTab:AddSwitch("🥚 Auto Eat Egg (30 min)", function(state)
    getgenv().autoEatEgg = state
    if state then task.spawn(function() while getgenv().autoEatEgg do
        local egg = Player.Backpack:FindFirstChild("Protein Egg")
        if egg then egg.Parent = Player.Character; pcall(function() egg:Activate() end) end
        task.wait(1800)
    end end) end
end)
FarmTab:AddSwitch("🥚 Auto Eat Egg (60 min)", function(state)
    getgenv().autoEatEgg60 = state
    if state then task.spawn(function() while getgenv().autoEatEgg60 do
        local egg = Player.Backpack:FindFirstChild("Protein Egg")
        if egg then egg.Parent = Player.Character; pcall(function() egg:Activate() end) end
        task.wait(3600)
    end end) end
end)
FarmTab:AddSwitch("🍹 Auto Shake (15 min)", function(state)
    getgenv().AutoShake = state
    if state then task.spawn(function() while getgenv().AutoShake do
        local tool = Player.Character:FindFirstChild("Tropical Shake") or Player.Backpack:FindFirstChild("Tropical Shake")
        if tool then Player.muscleEvent:FireServer("tropicalShake", tool) end
        task.wait(900)
    end end) end
end)
FarmTab:AddSwitch("🍽️ Auto Eat All Boosts", function(state)
    getgenv().autoEatAll = state
    if state then task.spawn(function() while getgenv().autoEatAll do
        local items = {"Tropical Shake","Energy Shake","Protein Bar","TOUGH Bar","Protein Shake","ULTRA Shake","Energy Bar"}
        for _, name in ipairs(items) do
            local tool = Player.Character:FindFirstChild(name) or Player.Backpack:FindFirstChild(name)
            if tool then
                local event = name:gsub("%s+",""):lower()
                local parts = {}
                for w in event:gmatch("%S+") do table.insert(parts, w) end
                for i = 2, #parts do parts[i] = parts[i]:sub(1,1):upper()..parts[i]:sub(2) end
                Player.muscleEvent:FireServer(table.concat(parts), tool)
            end
        end
        task.wait(0.5)
    end end) end
end)

local QuestFolder = FarmTab:AddFolder("📋 Auto Quests")
QuestFolder:AddSwitch("Auto Accept Quests", function(state)
    getgenv().AutoAcceptQuests = state
    if state then task.spawn(function() while getgenv().AutoAcceptQuests do
        pcall(function() ReplicatedStorage.rEvents.questRemote:InvokeServer("acceptQuest", 1) end)
        task.wait(1)
    end end) end
end)
QuestFolder:AddSwitch("Auto Claim Rewards", function(state)
    getgenv().AutoClaimQuests = state
    if state then task.spawn(function() while getgenv().AutoClaimQuests do
        pcall(function() ReplicatedStorage.rEvents.questRemote:InvokeServer("claimRewards") end)
        task.wait(1)
    end end) end
end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("🛠️ Tools")
local toolOptions = {"Weight","Pushups","Situps","Handstands","Punch","Ground Slam","Stomp"}
local toolDropdown = FarmTab:AddDropdown("Select Tool", function(sel) getgenv().SelectedTool = sel end)
for _, v in ipairs(toolOptions) do toolDropdown:Add(v) end
FarmTab:AddSwitch("Auto Use Tool", function(state)
    getgenv().AutoTool = state
    if state then task.spawn(function() while getgenv().AutoTool do
        local toolName = getgenv().SelectedTool
        local char = Player.Character; local backpack = Player.Backpack
        if toolName == "Punch" then
            local punch = backpack:FindFirstChild("Punch")
            if punch and char then punch.Parent = char; if punch:FindFirstChild("attackTime") then punch.attackTime.Value = 0 end end
            Player.muscleEvent:FireServer("punch","rightHand"); Player.muscleEvent:FireServer("punch","leftHand")
        elseif toolName == "Ground Slam" then
            local gs = backpack:FindFirstChild("Ground Slam")
            if gs and char then gs.Parent = char; if gs:FindFirstChild("attackTime") then gs.attackTime.Value = 0 end end
            Player.muscleEvent:FireServer("slam")
        elseif toolName == "Stomp" then
            local stomp = backpack:FindFirstChild("Stomp")
            if stomp and char then stomp.Parent = char; if stomp:FindFirstChild("attackTime") then stomp.attackTime.Value = 0 end end
            Player.muscleEvent:FireServer("stomp")
        else
            local tool = backpack:FindFirstChild(toolName)
            if tool and char then char.Humanoid:EquipTool(tool); Player.muscleEvent:FireServer("rep") end
        end
        task.wait(0.1)
    end end) end
end)
FarmTab:AddSwitch("Fast Tools (Instant)", function(state)
    getgenv().FastTools = state
    local settings = {{"Punch","attackTime",0,0.35},{"Ground Slam","attackTime",0,6},{"Stomp","attackTime",0,7},{"Handstands","repTime",0,1},{"Pushups","repTime",0,1},{"Weight","repTime",0,1},{"Situps","repTime",0,1}}
    for _, s in ipairs(settings) do
        local tool = Player.Backpack:FindFirstChild(s[1])
        if tool and tool:FindFirstChild(s[2]) then tool[s[2]].Value = state and s[3] or s[4] end
    end
end)

local comboFolder = FarmTab:AddFolder("🔄 Combo Tool + Jungle Rock")
local comboOptions = {"Pushups","Situps","Handstands","Weight"}
local comboDropdown = comboFolder:AddDropdown("Select Combo Tool", function(sel) getgenv().ComboTool = sel end)
for _, v in ipairs(comboOptions) do comboDropdown:Add(v) end
comboFolder:AddSwitch("Activate Combo (Tool + Auto Punch)", function(state)
    getgenv().AutoComboTool = state
    if state then
        task.spawn(function()
            while getgenv().AutoComboTool do
                local toolName = getgenv().ComboTool
                local tool = Player.Backpack:FindFirstChild(toolName)
                if tool and Player.Character then Player.Character.Humanoid:EquipTool(tool) end
                Player.muscleEvent:FireServer("rep")
                pcall(function()
                    local rock = Workspace.machinesFolder:FindFirstChild("Ancient Jungle Rock")
                    if rock and Player.Character and Player.Character:FindFirstChild("LeftHand") then
                        firetouchinterest(rock.Rock, Player.Character.LeftHand, 0)
                        task.wait(0.0001)
                        firetouchinterest(rock.Rock, Player.Character.LeftHand, 1)
                        local punch = Player.Backpack:FindFirstChild("Punch")
                        if punch then Player.Character.Humanoid:EquipTool(punch) end
                        Player.muscleEvent:FireServer("punch","rightHand"); Player.muscleEvent:FireServer("punch","leftHand")
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("🏋️ Actions")
FarmTab:AddButton("🐉 Equip 8 Swift Samurai", function()
    local petsFolder = Player:FindFirstChild("petsFolder")
    if not petsFolder then return end
    for _, folder in pairs(petsFolder:GetChildren()) do if folder:IsA("Folder") then for _, pet in pairs(folder:GetChildren()) do ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet) end end end
    task.wait(0.1)
    local eq = 0
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                if pet.Name == "Swift Samurai" then
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet); eq = eq + 1
                    if eq >= 8 then return end
                end
            end
        end
    end
end)
FarmTab:AddButton("Jungle Squat", function()
    local char = Player.Character; if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(-8371.4336, 6.7981, 2858.8853)
        task.wait(0.2); local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end
end)
FarmTab:AddButton("Jungle Lift", function()
    local char = Player.Character; if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(-8652.8672, 29.2667, 2089.2617)
        task.wait(0.2); local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end
end)
FarmTab:AddButton("Gamepass AutoLift", function()
    local gp = ReplicatedStorage.gamepassIds
    for _, g in pairs(gp:GetChildren()) do
        local val = Instance.new("IntValue"); val.Name = g.Name; val.Value = g.Value; val.Parent = Player.ownedGamepasses
    end
end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("⚡ Optimization")
FarmTab:AddSwitch("Hide All Frames", function(bool)
    local rSto = ReplicatedStorage
    for _, obj in pairs(rSto:GetChildren()) do if obj.Name:match("Frame$") then obj.Visible = not bool end end
end)
FarmTab:AddButton("Anti Lag (Low Graphics)", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled = false end
    end
    Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.Brightness = 0
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if not (v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid"))) then v.Reflectance = 0 end
        end
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then v.Enabled = false end
    end
    StarterGui:SetCore("SendNotification", {Title = "Anti Lag Activado", Text = "Optimización aplicada!", Duration = 5})
end)
FarmTab:AddButton("Full Optimization", function()
    local playerGui = Player:WaitForChild("PlayerGui")
    for _, gui in pairs(playerGui:GetChildren()) do if gui:IsA("ScreenGui") then gui:Destroy() end end
    local function darkenSky()
        for _, v in pairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"; darkSky.SkyboxBk = "rbxassetid://0"; darkSky.SkyboxDn = "rbxassetid://0"; darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"; darkSky.SkyboxRt = "rbxassetid://0"; darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = Lighting
        Lighting.Brightness = 0; Lighting.ClockTime = 0; Lighting.TimeOfDay = "00:00:00"
        Lighting.OutdoorAmbient = Color3.new(0,0,0); Lighting.Ambient = Color3.new(0,0,0)
        Lighting.FogColor = Color3.new(0,0,0); Lighting.FogEnd = 100
        task.spawn(function() while true do wait(5); if not Lighting:FindFirstChild("DarkSky") then darkSky:Clone().Parent = Lighting end; Lighting.Brightness = 0; Lighting.ClockTime = 0; Lighting.OutdoorAmbient = Color3.new(0,0,0); Lighting.Ambient = Color3.new(0,0,0); Lighting.FogColor = Color3.new(0,0,0); Lighting.FogEnd = 100 end end)
    end
    local function removeParticleEffects() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") then obj:Destroy() end end end
    local function removeLightSources() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then obj:Destroy() end end end
    removeParticleEffects(); removeLightSources(); darkenSky()
end)

FarmTab:AddLabel("═══════════════════════════════")
FarmTab:AddLabel("🪨 Rocks")
local rockList = {{"Tiny Island Rock",0},{"Starter Island Rock",100},{"Legend Beach Rock",5000},{"Frost Gym Rock",150000},{"Mythical Gym Rock",400000},{"Eternal Gym Rock",750000},{"Legend Gym Rock",1000000},{"Muscle King Gym Rock",5000000},{"Ancient Jungle Rock",10000000}}
local rockDropdown = FarmTab:AddDropdown("Select Rock", function(sel) getgenv().SelectedRock = sel end)
for _, r in ipairs(rockList) do rockDropdown:Add(r[1]) end
FarmTab:AddSwitch("Auto Farm Rock", function(state)
    getgenv().RockFarmRunning = state
    if state then task.spawn(function() while getgenv().RockFarmRunning do
        local rockName = getgenv().SelectedRock
        local requiredDur = 0
        for _, r in ipairs(rockList) do if r[1] == rockName then requiredDur = r[2] break end end
        if Player.Durability.Value >= requiredDur then
            for _, obj in pairs(Workspace.machinesFolder:GetDescendants()) do
                if obj.Name == "neededDurability" and obj.Value == requiredDur then
                    local rock = obj.Parent and obj.Parent:FindFirstChild("Rock")
                    if rock and Player.Character then
                        local lh = Player.Character:FindFirstChild("LeftHand"); local rh = Player.Character:FindFirstChild("RightHand")
                        if lh and rh then
                            firetouchinterest(rock, rh, 0); firetouchinterest(rock, rh, 1)
                            firetouchinterest(rock, lh, 0); firetouchinterest(rock, lh, 1)
                            local punch = Player.Backpack:FindFirstChild("Punch")
                            if punch and Player.Character then Player.Character.Humanoid:EquipTool(punch) end
                            Player.muscleEvent:FireServer("punch","rightHand"); Player.muscleEvent:FireServer("punch","leftHand")
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end end) end
end)

-- ============================================
-- 🔄 TAB 3: REBIRTH
-- ============================================
local RebirthTab = Window:AddTab("🔄 REBIRTH")
RebirthTab:AddLabel("═══════════════════════════════")
RebirthTab:AddLabel("📊 Stat Tracker - Rebirths")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")
local isRebirthingRunning = false
local rebirthStartTime = 0
local rebirthPausedElapsed = 0
local rebirthInitialValue = rebirthsStat.Value
local rebirthHistory = {}
local lastRebirthTime = tick()
local lastRebirthValue = rebirthsStat.Value
local timeLabelRebirth = RebirthTab:AddLabel("⏱️ Time: 0d 0h 0m 0s - Inactive")
timeLabelRebirth.TextSize = 17
local paceLabelRebirth = RebirthTab:AddLabel("📈 Pace: 0 / Hour | 0 / Day | 0 / Week")
paceLabelRebirth.TextSize = 17
local statsRebirthLabel = RebirthTab:AddLabel("🔄 Rebirths: 0 | Gained: 0")
statsRebirthLabel.TextSize = 17

local function updateRebirthStats()
    local currentTime = tick()
    local currentRebirths = rebirthsStat.Value
    statsRebirthLabel.Text = "🔄 Rebirths: "..formatNumber(currentRebirths).." | Gained: "..formatNumber(currentRebirths - rebirthInitialValue)
    if isRebirthingRunning then
        local elapsed = rebirthPausedElapsed + (currentTime - rebirthStartTime)
        local days = math.floor(elapsed / 86400); local hours = math.floor((elapsed % 86400) / 3600); local minutes = math.floor((elapsed % 3600) / 60); local seconds = math.floor(elapsed % 60)
        timeLabelRebirth.Text = "⏱️ Time: "..days.."d "..hours.."h "..minutes.."m "..seconds.."s - Running"
        if currentRebirths > lastRebirthValue then
            local gained = currentRebirths - lastRebirthValue
            local timeDiff = currentTime - lastRebirthTime
            if timeDiff > 0 and gained > 0 then
                local avgTime = timeDiff / gained
                local paceHour = 3600 / avgTime; local paceDay = 86400 / avgTime; local paceWeek = 604800 / avgTime
                paceLabelRebirth.Text = "📈 Pace: "..formatNumber(paceHour).."/Hour | "..formatNumber(paceDay).."/Day | "..formatNumber(paceWeek).."/Week"
                table.insert(rebirthHistory, paceHour)
                if #rebirthHistory > 20 then table.remove(rebirthHistory, 1) end
            end
            lastRebirthTime = currentTime; lastRebirthValue = currentRebirths
        end
    else
        if rebirthStartTime > 0 then
            local p = rebirthPausedElapsed
            timeLabelRebirth.Text = "⏱️ Time: "..math.floor(p/86400).."d "..math.floor((p%86400)/3600).."h "..math.floor((p%3600)/60).."m "..math.floor(p%60).."s - Paused"
        end
    end
end
task.spawn(function() while true do updateRebirthStats(); task.wait(0.1) end end)
rebirthsStat.Changed:Connect(updateRebirthStats)

RebirthTab:AddLabel("═══════════════════════════════")
RebirthTab:AddLabel("⚡ Fast Rebirth")
RebirthTab:AddSwitch("Fast Rebirth", function(state)
    getgenv().AutoFarming = state
    if state then
        if not isRebirthingRunning then
            isRebirthingRunning = true; rebirthStartTime = tick(); rebirthInitialValue = rebirthsStat.Value; rebirthHistory = {}
            lastRebirthTime = tick(); lastRebirthValue = rebirthsStat.Value
        end
        task.spawn(function()
            while getgenv().AutoFarming do
                local requiredStrength = 10000 + (5000 * Player.leaderstats.Rebirths.Value)
                local golden = Player:FindFirstChild("ultimatesFolder") and Player.ultimatesFolder:FindFirstChild("Golden Rebirth")
                if golden and golden.Value >= 1 and golden.Value <= 5 then requiredStrength = requiredStrength * (1 - golden.Value * 0.1) end
                requiredStrength = math.floor(requiredStrength)
                local petsFolder = Player:FindFirstChild("petsFolder")
                if petsFolder then
                    for _, folder in pairs(petsFolder:GetChildren()) do if folder:IsA("Folder") then for _, pet in pairs(folder:GetChildren()) do ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet) end end end
                    task.wait(0.1)
                    for _, pet in pairs(petsFolder.Unique:GetChildren()) do if pet.Name == "Swift Samurai" then ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet) end end
                end
                while Player.leaderstats.Strength.Value < requiredStrength and getgenv().AutoFarming do
                    for _ = 1, 10 do Player.muscleEvent:FireServer("rep") end
                    task.wait()
                end
                if not getgenv().AutoFarming then break end
                if petsFolder then
                    for _, folder in pairs(petsFolder:GetChildren()) do if folder:IsA("Folder") then for _, pet in pairs(folder:GetChildren()) do ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet) end end end
                    task.wait(0.1)
                    for _, pet in pairs(petsFolder.Unique:GetChildren()) do if pet.Name == "Tribal Overlord" then ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet) end end
                end
                local oldRebirths = Player.leaderstats.Rebirths.Value
                repeat
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    task.wait(0.1)
                until Player.leaderstats.Rebirths.Value > oldRebirths or not getgenv().AutoFarming
            end
            isRebirthingRunning = false; rebirthPausedElapsed = rebirthPausedElapsed + (tick() - rebirthStartTime)
        end)
    else
        getgenv().AutoFarming = false; isRebirthingRunning = false
        rebirthPausedElapsed = rebirthPausedElapsed + (tick() - rebirthStartTime)
    end
end)

RebirthTab:AddLabel("═══════════════════════════════")
local rebirthFolder = RebirthTab:AddFolder("Rebirth Without Packs")
rebirthFolder:AddTextBox("🎯 Target Rebirths", function(text)
    getgenv().TargetRebirths = tonumber(text) or 0
end, {clear = false})
rebirthFolder:AddSwitch("Start (Target)", function(state)
    getgenv().targetRebirthActive = state
    if state then task.spawn(function() while getgenv().targetRebirthActive do
        local cur = Player.leaderstats.Rebirths.Value
        if cur >= getgenv().TargetRebirths then getgenv().targetRebirthActive = false; break end
        pcall(function() ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest") end)
        task.wait(0.1)
    end end) end
end)
rebirthFolder:AddSwitch("Auto Rebirth (Infinite)", function(state)
    getgenv().infiniteRebirthActive = state
    if state then task.spawn(function() while getgenv().infiniteRebirthActive do
        pcall(function() ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest") end)
        task.wait(0.1)
    end end) end
end)
rebirthFolder:AddSwitch("Auto Teleport to Muscle King", function(state)
    getgenv().AutoTeleportKing = state
    if state then task.spawn(function() while getgenv().AutoTeleportKing do
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
        end
        task.wait(0.1)
    end end) end
end)
rebirthFolder:AddSwitch("Auto Size 1", function(state)
    getgenv().AutoSize1 = state
    if state then task.spawn(function() while getgenv().AutoSize1 do
        pcall(function() ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1) end)
        task.wait(0.1)
    end end) end
end)
rebirthFolder:AddSwitch("Auto Size 2", function(state)
    getgenv().AutoSize2 = state
    if state then task.spawn(function() while getgenv().AutoSize2 do
        pcall(function() ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2) end)
        task.wait(1)
    end end) end
end)
rebirthFolder:AddButton("🛡️ Anti Rebirth (Block Requests)", function()
    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            if self.Name == "rebirthRemote" and args[1] == "rebirthRequest" then return end
            return oldNamecall(self, unpack(args))
        end)
        StarterGui:SetCore("SendNotification", {Title = "Anti Rebirth", Text = "Rebirth protection enabled!", Duration = 3})
    end)
end)

-- ============================================
-- 📊 TAB 4: STATS
-- ============================================
local StatsTab = Window:AddTab("📊 STATS")
StatsTab:AddLabel("═══════════════════════════════")
StatsTab:AddLabel("📈 Stats Gained")

local strStat = Player.leaderstats:WaitForChild("Strength")
local durStat = Player:WaitForChild("Durability")
local initStr = strStat.Value; local initDur = durStat.Value
local strLbl = StatsTab:AddLabel("💪 Strength: 0 | Gained: 0"); strLbl.TextSize = 17
local durLbl = StatsTab:AddLabel("🛡️ Durability: 0 | Gained: 0"); durLbl.TextSize = 17
task.spawn(function() while true do
    local curStr = strStat.Value; local curDur = durStat.Value
    strLbl.Text = "💪 Strength: "..formatNumber(curStr).." | Gained: "..formatNumber(curStr - initStr)
    durLbl.Text = "🛡️ Durability: "..formatNumber(curDur).." | Gained: "..formatNumber(curDur - initDur)
    task.wait(0.5)
end end)

StatsTab:AddLabel("═══════════════════════════════")
StatsTab:AddLabel("🔍 Player Spy & Advanced Stats")

local playerOptions = {}
for _, p in ipairs(Players:GetPlayers()) do if p ~= Player then table.insert(playerOptions, p.Name) end end
local spyDropdown = StatsTab:AddDropdown("Select Player", function(sel) getgenv().SpyTarget = sel end)
for _, name in ipairs(playerOptions) do spyDropdown:Add(name) end

local spyLbl = StatsTab:AddLabel("📊 Stats: N/A"); spyLbl.TextSize = 17
local enemyHealthLabel = StatsTab:AddLabel("❤️ Enemy Health: N/A"); enemyHealthLabel.TextSize = 17
local playerDamageLabel = StatsTab:AddLabel("⚔️ Your Damage: N/A"); playerDamageLabel.TextSize = 17
local hitsToKillLabel = StatsTab:AddLabel("💥 Hits to Kill: N/A"); hitsToKillLabel.TextSize = 17

local function calculateEnemyHealth(targetPlayer)
    if not targetPlayer then return 0 end
    local baseDura = 0
    local durabilityStat = targetPlayer:FindFirstChild("Durability") or (targetPlayer:FindFirstChild("leaderstats") and targetPlayer.leaderstats:FindFirstChild("Durability"))
    if durabilityStat then baseDura = durabilityStat.Value end
    local totalMultiplier = 1
    local ultFolder = targetPlayer:FindFirstChild("ultimatesFolder")
    if ultFolder then
        local infernalHealth = ultFolder:FindFirstChild("Infernal Health")
        if infernalHealth then totalMultiplier = totalMultiplier + 0.15 * (infernalHealth.Value or 0) end
    end
    local backpack = targetPlayer:FindFirstChild("Backpack")
    if backpack then
        local equippedPets = backpack:FindFirstChild("EquippedPets") or backpack:FindFirstChild("equippedPets")
        if equippedPets then
            for _, pet in ipairs(equippedPets:GetChildren()) do
                if string.lower(tostring(pet)):match("mighty") and string.lower(tostring(pet)):match("monster") then
                    totalMultiplier = totalMultiplier + 0.5; break
                end
            end
        end
    end
    return baseDura * totalMultiplier
end
local function calculateLocalPlayerDamage()
    local strengthStat = nil
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then strengthStat = leaderstats:FindFirstChild("Strength") end
    if not strengthStat then return 0 end
    local baseDamage = strengthStat.Value * 0.0667
    local totalMultiplier = 1
    local ultFolder = Player:FindFirstChild("ultimatesFolder")
    if ultFolder then
        local demonDamage = ultFolder:FindFirstChild("Demon Damage")
        if demonDamage then totalMultiplier = totalMultiplier + math.min(0.1 * (demonDamage.Value or 0), 0.5) end
    end
    local backpack = Player:FindFirstChild("Backpack")
    if backpack then
        local equippedPets = backpack:FindFirstChild("EquippedPets") or backpack:FindFirstChild("equippedPets")
        if equippedPets then
            for _, pet in ipairs(equippedPets:GetChildren()) do
                if string.lower(tostring(pet)):match("wild") and string.lower(tostring(pet)):match("wizard") then
                    totalMultiplier = totalMultiplier + 0.5; break
                end
            end
        end
    end
    return baseDamage * totalMultiplier
end

task.spawn(function() while true do
    local target = Players:FindFirstChild(getgenv().SpyTarget)
    if target then
        local ls = target:FindFirstChild("leaderstats")
        if ls then
            local str = ls:FindFirstChild("Strength"); local reb = ls:FindFirstChild("Rebirths")
            local text = string.format("💪 %s | 🔄 %s", str and formatNumber(str.Value) or "?", reb and formatNumber(reb.Value) or "?")
            spyLbl.Text = "📊 Stats: "..text
        end
        local enemyHealth = calculateEnemyHealth(target)
        local playerDamage = calculateLocalPlayerDamage()
        local hitsToKill = playerDamage > 0 and math.ceil(enemyHealth / playerDamage) or "∞"
        if hitsToKill > 50 then hitsToKill = "∞" end
        enemyHealthLabel.Text = "❤️ Enemy Health: "..formatNumber(enemyHealth)
        playerDamageLabel.Text = "⚔️ Your Damage: "..formatNumber(playerDamage)
        hitsToKillLabel.Text = "💥 Hits to Kill: "..tostring(hitsToKill)
    else
        spyLbl.Text = "📊 Stats: N/A"; enemyHealthLabel.Text = "❤️ Enemy Health: N/A"; playerDamageLabel.Text = "⚔️ Your Damage: N/A"; hitsToKillLabel.Text = "💥 Hits to Kill: N/A"
    end
    task.wait(1)
end end)

-- ============================================
-- 💀 TAB 5: KILL
-- ============================================
local KillTab = Window:AddTab("💀 KILL")
KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("🔄 Spam Packs")
KillTab:AddSwitch("Spam Packs (Mighty Monster ↔ Wild Wizard)", function(state)
    getgenv().SpamPacks = state
    if state then
        task.spawn(function()
            local function equipPacks(petName)
                local petsFolder = Player:FindFirstChild("petsFolder")
                if not petsFolder then return end
                for _, folder in pairs(petsFolder:GetChildren()) do if folder:IsA("Folder") then for _, pet in pairs(folder:GetChildren()) do ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet) end end end
                task.wait(0.1)
                local eq = 0
                for _, pet in pairs(petsFolder.Unique:GetChildren()) do
                    if pet.Name == petName then
                        ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet); eq = eq + 1
                        if eq >= 8 then break end
                        task.wait(0.05)
                    end
                end
            end
            while getgenv().SpamPacks do
                equipPacks("Mighty Monster"); task.wait(2)
                if not getgenv().SpamPacks then break end
                equipPacks("Wild Wizard"); task.wait(2)
            end
        end)
    end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("🐾 Select Pet")
local petDrop = KillTab:AddDropdown("Select Pet (Damage/Durability)", function(sel) getgenv().KillPet = sel end)
petDrop:Add("Wild Wizard"); petDrop:Add("Mighty Monster")

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("😇 Auto Karma")
KillTab:AddSwitch("Auto Good Karma", function(state)
    if state then task.spawn(function() while state do
        local char = Player.Character
        if char then
            local rh = char:FindFirstChild("RightHand"); local lh = char:FindFirstChild("LeftHand")
            if rh and lh then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= Player then
                        local ek = target:FindFirstChild("evilKarma"); local gk = target:FindFirstChild("goodKarma")
                        if ek and gk and ek.Value > gk.Value then
                            local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                            if root then firetouchinterest(rh, root, 1); firetouchinterest(lh, root, 1); firetouchinterest(rh, root, 0); firetouchinterest(lh, root, 0) end
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end end) end
end)
KillTab:AddSwitch("Auto Bad Karma", function(state)
    if state then task.spawn(function() while state do
        local char = Player.Character
        if char then
            local rh = char:FindFirstChild("RightHand"); local lh = char:FindFirstChild("LeftHand")
            if rh and lh then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= Player then
                        local ek = target:FindFirstChild("evilKarma"); local gk = target:FindFirstChild("goodKarma")
                        if ek and gk and gk.Value > ek.Value then
                            local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                            if root then firetouchinterest(rh, root, 1); firetouchinterest(lh, root, 1); firetouchinterest(rh, root, 0); firetouchinterest(lh, root, 0) end
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end end) end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("🛡️ Whitelist / Blacklist")
local wlAdd = KillTab:AddDropdown("Add to Whitelist", function(sel) if sel and not table.find(getgenv().whitelistedPlayers, sel) then table.insert(getgenv().whitelistedPlayers, sel) end end)
local wlRem = KillTab:AddDropdown("Remove from Whitelist", function(sel) for i, v in ipairs(getgenv().whitelistedPlayers) do if v == sel then table.remove(getgenv().whitelistedPlayers, i) break end end end)
local blAdd = KillTab:AddDropdown("Add to Blacklist", function(sel) if sel and not table.find(getgenv().blacklistedPlayers, sel) then table.insert(getgenv().blacklistedPlayers, sel) end end)
for _, name in ipairs(playerOptions) do wlAdd:Add(name); wlRem:Add(name); blAdd:Add(name) end
KillTab:AddSwitch("Auto Whitelist Friends", function(state)
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Player and p:IsFriendsWith(Player.UserId) then
                if not table.find(getgenv().whitelistedPlayers, p.Name) then table.insert(getgenv().whitelistedPlayers, p.Name) end
            end
        end
    end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("☠️ Auto Kill")
KillTab:AddSwitch("Kill Everyone", function(state)
    getgenv().killAll = state
    if state then
        if not getgenv().killAllConn then
            getgenv().killAllConn = RunService.Heartbeat:Connect(function()
                if getgenv().killAll then
                    for _, target in ipairs(Players:GetPlayers()) do
                        if target ~= Player and not table.find(getgenv().whitelistedPlayers, target.Name) then
                            local char = Player.Character
                            if char then
                                local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                                if root then
                                    local rh = char:FindFirstChild("RightHand"); local lh = char:FindFirstChild("LeftHand")
                                    if rh and lh then firetouchinterest(rh, root, 1); firetouchinterest(lh, root, 1); firetouchinterest(rh, root, 0); firetouchinterest(lh, root, 0) end
                                end
                            end
                        end
                    end
                end
            end)
        end
    else
        if getgenv().killAllConn then getgenv().killAllConn:Disconnect(); getgenv().killAllConn = nil end
    end
end)
KillTab:AddSwitch("Kill Blacklist", function(state)
    getgenv().killBlacklistedOnly = state
    if state then
        if not getgenv().killBlacklistConn then
            getgenv().killBlacklistConn = RunService.Heartbeat:Connect(function()
                if getgenv().killBlacklistedOnly then
                    for _, target in ipairs(Players:GetPlayers()) do
                        if target ~= Player and table.find(getgenv().blacklistedPlayers, target.Name) then
                            local char = Player.Character
                            if char then
                                local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                                if root then
                                    local rh = char:FindFirstChild("RightHand"); local lh = char:FindFirstChild("LeftHand")
                                    if rh and lh then firetouchinterest(rh, root, 1); firetouchinterest(lh, root, 1); firetouchinterest(rh, root, 0); firetouchinterest(lh, root, 0) end
                                end
                            end
                        end
                    end
                end
            end)
        end
    else
        if getgenv().killBlacklistConn then getgenv().killBlacklistConn:Disconnect(); getgenv().killBlacklistConn = nil end
    end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("🎯 Death Ring")
KillTab:AddTextBox("Range (1-140)", function(text)
    local r = tonumber(text); if r then getgenv().deathRingRange = math.clamp(r, 1, 140) end
end, {placeholder = "20"})
KillTab:AddSwitch("Activate Death Ring", function(state)
    getgenv().deathRingEnabled = state
    if state then
        if not getgenv().deathRingConn then
            getgenv().deathRingConn = RunService.Heartbeat:Connect(function()
                if getgenv().deathRingEnabled then
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local myPos = char.HumanoidRootPart.Position
                        for _, target in ipairs(Players:GetPlayers()) do
                            if target ~= Player and not table.find(getgenv().whitelistedPlayers, target.Name) then
                                local tChar = target.Character
                                if tChar and tChar:FindFirstChild("HumanoidRootPart") then
                                    if (myPos - tChar.HumanoidRootPart.Position).Magnitude <= getgenv().deathRingRange then
                                        local rh = char:FindFirstChild("RightHand"); local lh = char:FindFirstChild("LeftHand")
                                        if rh and lh then firetouchinterest(rh, tChar.HumanoidRootPart, 1); firetouchinterest(lh, tChar.HumanoidRootPart, 1); firetouchinterest(rh, tChar.HumanoidRootPart, 0); firetouchinterest(lh, tChar.HumanoidRootPart, 0) end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    else
        if getgenv().deathRingConn then getgenv().deathRingConn:Disconnect(); getgenv().deathRingConn = nil end
    end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("⚡ Auto Brawl")
KillTab:AddSwitch("Auto Join Brawl", function(state)
    getgenv().AutoJoinBrawl = state
    if state then task.spawn(function() while getgenv().AutoJoinBrawl do
        pcall(function() ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl") end)
        task.wait(0.1)
    end end) end
end)
KillTab:AddSwitch("Auto Win Brawl", function(state)
    getgenv().AutoWinBrawl = state
    if state then task.spawn(function() while getgenv().AutoWinBrawl do
        local char = Player.Character
        if char then
            local punch = char:FindFirstChild("Punch") or Player.Backpack:FindFirstChild("Punch")
            if punch then if punch.Parent ~= char then punch.Parent = char end end
            Player.muscleEvent:FireServer("punch","rightHand"); Player.muscleEvent:FireServer("punch","leftHand")
        end
        task.wait(0.05)
    end end) end
end)
KillTab:AddSwitch("God Mode (Spam Join)", function(state)
    getgenv().GodMode = state
    if state then task.spawn(function() while getgenv().GodMode do
        pcall(function() ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl") end)
        task.wait()
    end end) end
end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("🫵 Combos & Animations")
KillTab:AddButton("Remove Punch Animation", function()
    local blocked = { ["rbxassetid://3638729053"] = true, ["rbxassetid://3638767427"] = true }
    local function setupBlock()
        local char = Player.Character; if not char or not char:FindFirstChild("Humanoid") then return end
        local hum = char.Humanoid
        for _, track in pairs(hum:GetPlayingAnimationTracks()) do
            if track.Animation then
                local id = track.Animation.AnimationId; local name = track.Name:lower()
                if blocked[id] or name:match("punch") or name:match("attack") or name:match("right") then track:Stop() end
            end
        end
        if not getgenv().AnimBlockConn then
            getgenv().AnimBlockConn = hum.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local id = track.Animation.AnimationId; local name = track.Name:lower()
                    if blocked[id] or name:match("punch") or name:match("attack") or name:match("right") then track:Stop() end
                end
            end)
        end
    end
    setupBlock()
    local function processTool(tool)
        if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
            if not tool:GetAttribute("ActivatedOverride") then
                tool:SetAttribute("ActivatedOverride", true)
                if not getgenv().ToolConn then getgenv().ToolConn = {} end
                getgenv().ToolConn[tool] = tool.Activated:Connect(function()
                    task.wait(0.05); local char = Player.Character
                    if char and char:FindFirstChild("Humanoid") then
                        for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                            if track.Animation then
                                local id = track.Animation.AnimationId; local name = track.Name:lower()
                                if blocked[id] or name:match("punch") or name:match("attack") or name:match("right") then track:Stop() end
                            end
                        end
                    end
                end)
            end
        end
    end
    for _, tool in pairs(Player.Backpack:GetChildren()) do processTool(tool) end
    local char = Player.Character; if char then for _, tool in pairs(char:GetChildren()) do if tool:IsA("Tool") then processTool(tool) end end end
    if not getgenv().BackpackAddedConn then getgenv().BackpackAddedConn = Player.Backpack.ChildAdded:Connect(function(child) if child:IsA("Tool") then task.wait(0.1); processTool(child) end end) end
    if not getgenv().CharacterAddedConn then getgenv().CharacterAddedConn = Player.CharacterAdded:Connect(function(newChar) task.wait(1); setupBlock(); if getgenv().CharacterToolAddedConn then getgenv().CharacterToolAddedConn:Disconnect() end; getgenv().CharacterToolAddedConn = newChar.ChildAdded:Connect(function(child) if child:IsA("Tool") then task.wait(0.1); processTool(child) end end) end) end
end)
KillTab:AddSwitch("NaN + Egg Combo", function(state)
    if state then
        ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0/0)
        task.spawn(function() while state do
            local char = Player.Character
            if char then
                local egg = Player.Backpack:FindFirstChild("Protein Egg")
                if egg and not char:FindFirstChild("Protein Egg") then egg.Parent = char end
                Player.muscleEvent:FireServer("punch","rightHand"); Player.muscleEvent:FireServer("punch","leftHand")
            end
            task.wait(0.1)
        end end)
    end
end)
KillTab:AddButton("Disable Eggs", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/244ihssp/IlIIS/refs/heads/main/1"))() end)

KillTab:AddLabel("═══════════════════════════════")
KillTab:AddLabel("👣 Follow & Slam")
KillTab:AddSwitch("Auto Follow Player (Spy)", function(state)
    getgenv().AutoFollow = state
    if state then task.spawn(function() while getgenv().AutoFollow do
        local target = Players:FindFirstChild(getgenv().SpyTarget)
        if target and target.Character then
            local myChar = Player.Character
            if myChar then
                local myHRP = myChar:FindFirstChild("HumanoidRootPart")
                local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                if myHRP and targetHRP then
                    myHRP.CFrame = CFrame.new(targetHRP.Position - (targetHRP.CFrame.LookVector * 3), targetHRP.Position)
                end
            end
        end
        task.wait(0.01)
    end end) end
end)
KillTab:AddSwitch("Auto Ground Slam", function(state)
    getgenv().AutoSlam = state
    if state then task.spawn(function() while getgenv().AutoSlam do
        local gs = Player.Backpack:FindFirstChild("Ground Slam") or (Player.Character and Player.Character:FindFirstChild("Ground Slam"))
        if gs then
            if gs.Parent == Player.Backpack then gs.Parent = Player.Character end
            if gs:FindFirstChild("attackTime") then gs.attackTime.Value = 0 end
            Player.muscleEvent:FireServer("slam"); gs:Activate()
        end
        task.wait(0.1)
    end end) end
end)
KillTab:AddButton("🌊 Freeze Water", function()
    local positions = {
        Vector3.new(11, -9, 78), Vector3.new(-110, -9, -999), Vector3.new(-110, -9, 1999),
        Vector3.new(-110, -9, -1999), Vector3.new(-110, -9, 2999), Vector3.new(-110, -9, -3999),
        Vector3.new(-110, -9, 4999), Vector3.new(-110, -9, -5999), Vector3.new(-110, -9, -6999),
        Vector3.new(-110, -9, -7999), Vector3.new(-110, -9, -8999), Vector3.new(-110, -9, -9999),
        Vector3.new(-110, -9, -10999), Vector3.new(-110, -9, -11999), Vector3.new(-110, -9, -12999),
        Vector3.new(-110, -9, -13999), Vector3.new(-110, -9, -14999), Vector3.new(-110, -9, -15999),
        Vector3.new(-110, -9, -16999), Vector3.new(-110, -9, -17999), Vector3.new(-110, -9, -18999),
        Vector3.new(-110, -9, -19999), Vector3.new(-110, -9, -20999), Vector3.new(-110, -9, -21999),
        Vector3.new(-110, -9, -22999), Vector3.new(-110, -9, -23999)
    }
    for _, pos in ipairs(positions) do
        local p = Instance.new("Part")
        p.Size = Vector3.new(10000, 0, 10000)
        p.Position = pos
        p.Anchored = true
        p.Parent = Workspace
    end
end)
KillTab:AddButton("📏 Size NaN", function() ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0/0) end)

-- ============================================
-- 🚀 TAB 6: TELEPORT
-- ============================================
local TeleportTab = Window:AddTab("🚀 TELEPORT")
TeleportTab:AddLabel("═══════════════════════════════")
local tps = {{"Spawn", CFrame.new(2,8,115)}, {"Secret Area", CFrame.new(1947,2,6191)}, {"Tiny Island", CFrame.new(-34,7,1903)}, {"Frozen Island", CFrame.new(-2600.00244,3.67686558,-403.884369)}, {"Mythical Island", CFrame.new(2255,7,1071)}, {"Hell Island", CFrame.new(-6768,7,-1287)}, {"Legend Island", CFrame.new(4604,991,-3887)}, {"Muscle King", CFrame.new(-8646,17,-5738)}, {"Jungle Island", CFrame.new(-8659,6,2384)}, {"Brawl Lava", CFrame.new(4471,119,-8836)}, {"Brawl Desert", CFrame.new(960,17,-7398)}, {"Brawl Regular", CFrame.new(-1849,20,-6335)}}
for _, tp in ipairs(tps) do TeleportTab:AddButton(tp[1], function() local char = Player.Character; if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = tp[2] end end) end

-- ============================================
-- 🐾 TAB 7: PETS
-- ============================================
local PetsTab = Window:AddTab("🐾 PETS")
PetsTab:AddLabel("═══════════════════════════════")
PetsTab:AddLabel("🥚 Buy Pets")
local petDrop = PetsTab:AddDropdown("Select PET", function(sel) getgenv().SelectedPet = sel end)
local petList = {"Neon Guardian","Blue Birdie","Blue Bunny","Blue Firecaster","Blue Pheonix","Crimson Falcon","Cybernetic Showdown Dragon","Dark Golem","Dark Legends Manticore","Dark Vampy","Darkstar Hunter","Eternal Strike Leviathan","Frostwave Legends Penguin","Gold Warrior","Golden Pheonix","Golden Viking","Green Butterfly","Green Firecaster","Infernal Dragon","Lightning Strike Phantom","Magic Butterfly","Muscle Sensei","Orange Hedgehog","Orange Pegasus","Phantom Genesis Dragon","Purple Dragon","Purple Falcon","Red Dragon","Red Firecaster","Red Kitty","Silver Dog","Ultimate Supernova Pegasus","Ultra Birdie","White Pegasus","White Pheonix","Yellow Butterfly"}
for _, v in ipairs(petList) do petDrop:Add(v) end
PetsTab:AddSwitch("Auto Buy PET", function(state)
    getgenv().AutoHatchPet = state
    if state then task.spawn(function() while getgenv().AutoHatchPet do
        local pet = ReplicatedStorage.cPetShopFolder:FindFirstChild(getgenv().SelectedPet)
        if pet then pcall(function() ReplicatedStorage.cPetShopRemote:InvokeServer(pet) end) end
        task.wait(0.1)
    end end) end
end)

PetsTab:AddLabel("═══════════════════════════════")
PetsTab:AddLabel("🌀 Buy Auras")
local auraDrop = PetsTab:AddDropdown("Select AURA", function(sel) getgenv().SelectedAura = sel end)
local auraList = {"Astral Electro","Azure Tundra","Blue Aura","Dark Electro","Dark Lightning","Dark Storm","Electro","Enchanted Mirage","Entropic Blast","Eternal Megastrike","Grand Supernova","Green Aura","Inferno","Lightning","Muscle King","Power Lightning","Purple Aura","Purple Nova","Red Aura","Supernova","Ultra Inferno","Ultra Mirage","Unstable Mirage","Yellow Aura"}
for _, v in ipairs(auraList) do auraDrop:Add(v) end
PetsTab:AddSwitch("Auto Buy AURA", function(state)
    getgenv().AutoHatchAura = state
    if state then task.spawn(function() while getgenv().AutoHatchAura do
        local aura = ReplicatedStorage.cPetShopFolder:FindFirstChild(getgenv().SelectedAura)
        if aura then pcall(function() ReplicatedStorage.cPetShopRemote:InvokeServer(aura) end) end
        task.wait(0.1)
    end end) end
end)

PetsTab:AddLabel("═══════════════════════════════")
PetsTab:AddLabel("⚡ Ultimates")
local ultDrop = PetsTab:AddDropdown("Select ULTIMATE", function(sel) getgenv().SelectedUlt = sel end)
local ultList = {"+1 Daily Spin","+1 Pet Slot","+10 Item Capacity","+5% Rep Speed","Demon Damage","Galaxy Gains","Golden Rebirth","Jungle Swift","Muscle Mind","x2 Chest Rewards","x2 Quest Rewards"}
for _, v in ipairs(ultList) do ultDrop:Add(v) end
PetsTab:AddSwitch("Auto Buy ULTIMATE", function(state)
    getgenv().AutoUpgradeUltimate = state
    if state then task.spawn(function() while getgenv().AutoUpgradeUltimate do
        pcall(function() ReplicatedStorage.rEvents.ultimatesRemote:InvokeServer("upgradeUltimate", getgenv().SelectedUlt) end)
        task.wait(0.2)
    end end) end
end)

PetsTab:AddLabel("═══════════════════════════════")
PetsTab:AddLabel("🔄 Auto Evolve & Equip")
local evoDrop = PetsTab:AddDropdown("Select PET to Evolve", function(sel) getgenv().EvolvePet = sel end)
local evoList = {"Blue Birdie","Orange Hedgehog","Red Kitty","Blue Bunny","Silver Dog","Dark Vampy","Dark Golem","Green Butterfly","Yellow Butterfly","Crimson Falcon","Purple Dragon","Orange Pegasus","Purple Falcon","Red Dragon","White Pegasus","Blue Pheonix","Blue Firecaster","Golden Pheonix","Red Firecaster","Green Firecaster","White Pheonix","Infernal Dragon","Ultra Birdie","Magic Butterfly","Aether Spirit Bunny"}
for _, v in ipairs(evoList) do evoDrop:Add(v) end
PetsTab:AddSwitch("Auto Evolve PET", function(state)
    getgenv().AutoEvolvePet = state
    if state then task.spawn(function() while getgenv().AutoEvolvePet and getgenv().EvolvePet ~= "" do
        pcall(function() ReplicatedStorage.cPetShopRemote:InvokeServer("evolvePet", getgenv().EvolvePet) end)
        task.wait(0.5)
    end end) end
end)
PetsTab:AddSwitch("Auto Equip Selected PET", function(state)
    getgenv().AutoEquipPet = state
    if state then task.spawn(function() while getgenv().AutoEquipPet and getgenv().SelectedPet ~= "" do
        local petName = getgenv().SelectedPet:match("^(.-)%s*%(") or getgenv().SelectedPet
        local petsFolder = Player:FindFirstChild("petsFolder")
        if petsFolder then
            for _, folder in pairs(petsFolder:GetChildren()) do
                if folder:IsA("Folder") then for _, pet in pairs(folder:GetChildren()) do ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet) end end
            end
            task.wait(0.1)
            for _, pet in pairs(petsFolder.Unique:GetChildren()) do
                if pet.Name == petName then ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet) end
            end
        end
        task.wait(1)
    end end) end
end)

PetsTab:AddLabel("═══════════════════════════════")
PetsTab:AddLabel("🤝 Auto Trade")
local tradePetDrop = PetsTab:AddDropdown("Select PET to Trade", function(sel) getgenv().TradePet = sel end)
for _, v in ipairs(petList) do tradePetDrop:Add(v) end
local tradeTargetDrop = PetsTab:AddDropdown("Player to Trade", function(sel) getgenv().TradeTarget = sel end)
for _, name in ipairs(playerOptions) do tradeTargetDrop:Add(name) end
PetsTab:AddSwitch("Auto Trade (every 5s)", function(state)
    getgenv().AutoTrade = state
    if state then task.spawn(function() while getgenv().AutoTrade and getgenv().TradeTarget and getgenv().TradePet ~= "" do
        local target = Players:FindFirstChild(getgenv().TradeTarget)
        if target then
            pcall(function()
                local tradeRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("tradeRemote")
                if tradeRemote then tradeRemote:InvokeServer("tradeRequest", target, getgenv().TradePet) end
            end)
        end
        task.wait(5)
    end end) end
end)
PetsTab:AddButton("Trade Now", function()
    local target = Players:FindFirstChild(getgenv().TradeTarget)
    if target and getgenv().TradePet ~= "" then
        pcall(function()
            local tradeRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("tradeRemote")
            if tradeRemote then tradeRemote:InvokeServer("tradeRequest", target, getgenv().TradePet) end
        end)
    end
end)

-- ============================================
-- 🎁 TAB 8: GIFT
-- ============================================
local GiftTab = Window:AddTab("🎁 GIFT")
GiftTab:AddLabel("═══════════════════════════════")
GiftTab:AddLabel("🥚 Gift Protein Eggs")
local proteinEggLabel = GiftTab:AddLabel("🥚 Eggs: 0")
local selectedEggPlayer = nil
local eggCount = 0
local eggGiftDropdown = GiftTab:AddDropdown("Player to Gift Eggs", function(sel) selectedEggPlayer = sel end)
for _, name in ipairs(playerOptions) do eggGiftDropdown:Add(name) end
GiftTab:AddTextBox("Amount of Eggs", function(text) eggCount = tonumber(text) or 0 end)
GiftTab:AddButton("Gift Eggs", function()
    if selectedEggPlayer and eggCount > 0 then
        local target = Players:FindFirstChild(selectedEggPlayer)
        if target then for _ = 1, eggCount do
            local egg = Player.consumablesFolder:FindFirstChild("Protein Egg")
            if egg then pcall(function() ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", target, egg) end) end
            task.wait(0.1)
        end end
    end
end)
GiftTab:AddLabel("═══════════════════════════════")
GiftTab:AddLabel("🍹 Gift Tropical Shakes")
local tropicalShakeLabel = GiftTab:AddLabel("🍹 Shakes: 0")
local selectedShakePlayer = nil
local shakeCount = 0
local shakeGiftDropdown = GiftTab:AddDropdown("Player to Gift Shakes", function(sel) selectedShakePlayer = sel end)
for _, name in ipairs(playerOptions) do shakeGiftDropdown:Add(name) end
GiftTab:AddTextBox("Amount of Shakes", function(text) shakeCount = tonumber(text) or 0 end)
GiftTab:AddButton("Gift Shakes", function()
    if selectedShakePlayer and shakeCount > 0 then
        local target = Players:FindFirstChild(selectedShakePlayer)
        if target then for _ = 1, shakeCount do
            local shake = Player.consumablesFolder:FindFirstChild("Tropical Shake")
            if shake then pcall(function() ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", target, shake) end) end
            task.wait(0.1)
        end end
    end
end)
task.spawn(function() while true do
    local eggs = 0; local shakes = 0
    local bp = Player.Backpack
    if bp then for _, item in ipairs(bp:GetChildren()) do
        if item.Name == "Protein Egg" then eggs = eggs + 1
        elseif item.Name == "Tropical Shake" or item.Name == "Piñas" then shakes = shakes + 1 end
    end end
    proteinEggLabel.Text = "🥚 Eggs: "..eggs; tropicalShakeLabel.Text = "🍹 Shakes: "..shakes
    task.wait(0.5)
end end)
GiftTab:AddSwitch("Auto Clear Inventory (Eat All)", function(state)
    getgenv().autoClearInv = state
    if state then task.spawn(function() while getgenv().autoClearInv do
        local items = {"Protein Egg","Tropical Shake","Energy Shake","Protein Bar","TOUGH Bar","Protein Shake","ULTRA Shake","Energy Bar"}
        for _, name in ipairs(items) do
            local item = Player.Backpack:FindFirstChild(name) or Player.Character:FindFirstChild(name)
            if item then item.Parent = Player.Character; pcall(function() item:Activate() end) end
        end
        task.wait(2)
    end end) end
end)

-- ============================================
-- 🧮 TAB 9: CALCULATOR
-- ============================================
local CalcTab = Window:AddTab("🧮 CALCULATOR")
CalcTab:AddLabel("═══════════════════════════════")
CalcTab:AddLabel("💪 Damage Calculator (Packs)")

local baseStrength = 0
local function calcFormat(val)
    if val >= 1e15 then return string.format("%.3f Qa", val/1e15)
    elseif val >= 1e12 then return string.format("%.2f T", val/1e12)
    elseif val >= 1e9 then return string.format("%.2f B", val/1e9)
    else return tostring(math.floor(val)) end
end
CalcTab:AddTextBox("Base Strength (e.g., 1.27Qa, 500B)", function(text)
    local unidades = { ["T"] = 1e12, ["Q"] = 1e15, ["B"] = 1e9 }
    text = text:upper()
    for u, m in pairs(unidades) do
        if text:find(u) then
            local num = tonumber(text:match("(%d+%.?%d*)"))
            if num then baseStrength = num * m; return end
        end
    end
    baseStrength = tonumber(text:match("(%d+%.?%d*)")) or 0
end)
local damLbls = {}
for i = 1, 8 do damLbls[i] = CalcTab:AddLabel(string.format("%d pack(s): -", i)) end
CalcTab:AddButton("Calculate Damage", function()
    if baseStrength <= 0 then return end
    local adjusted = baseStrength * 0.10
    local increment = 0.335
    for pack = 1, 8 do
        local mult = 1 + (pack * increment)
        local val = adjusted * mult
        damLbls[pack].Text = string.format("%d pack(s): %s", pack, calcFormat(val))
    end
end)

CalcTab:AddLabel("═══════════════════════════════")
CalcTab:AddLabel("🛡️ Durability Calculator (Packs)")
local baseDura = 0
CalcTab:AddTextBox("Base Durability (e.g., 1.27Qa, 500B)", function(text)
    local unidades = { ["T"] = 1e12, ["Q"] = 1e15, ["B"] = 1e9 }
    text = text:upper()
    for u, m in pairs(unidades) do
        if text:find(u) then
            local num = tonumber(text:match("(%d+%.?%d*)"))
            if num then baseDura = num * m; return end
        end
    end
    baseDura = tonumber(text:match("(%d+%.?%d*)")) or 0
end)
local durLbls = {}
for i = 1, 8 do durLbls[i] = CalcTab:AddLabel(string.format("%d pack(s): -", i)) end
CalcTab:AddButton("Calculate Durability", function()
    if baseDura <= 0 then return end
    local increment = 0.335
    local extra = 1.5
    for pack = 1, 8 do
        local mult = 1 + (pack * increment)
        local val = baseDura * mult * extra
        durLbls[pack].Text = string.format("%d pack(s): %s", pack, calcFormat(val))
    end
end)

-- ============================================
-- ⚙️ TAB 10: MISC
-- ============================================
local MiscTab = Window:AddTab("⚙️ MISC")
MiscTab:AddLabel("═══════════════════════════════")
MiscTab:AddLabel("🛡️ Utilities")
MiscTab:AddButton("Anti AFK (Re-apply)", function() setupAntiAFK() end)
MiscTab:AddButton("Remove Portals", function() removePortals() end)

MiscTab:AddLabel("═══════════════════════════════")
MiscTab:AddLabel("⚡ Optimization")
MiscTab:AddButton("Anti Lag (Low Graphics)", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled = false end
    end
    Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.Brightness = 0
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if not (v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid"))) then v.Reflectance = 0 end
        end
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then v.Enabled = false end
    end
    StarterGui:SetCore("SendNotification", {Title = "Anti Lag Activado", Text = "Optimización aplicada!", Duration = 5})
end)
MiscTab:AddButton("Full Optimization", function()
    local playerGui = Player:WaitForChild("PlayerGui")
    for _, gui in pairs(playerGui:GetChildren()) do if gui:IsA("ScreenGui") then gui:Destroy() end end
    local function darkenSky()
        for _, v in pairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"; darkSky.SkyboxBk = "rbxassetid://0"; darkSky.SkyboxDn = "rbxassetid://0"; darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"; darkSky.SkyboxRt = "rbxassetid://0"; darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = Lighting
        Lighting.Brightness = 0; Lighting.ClockTime = 0; Lighting.TimeOfDay = "00:00:00"
        Lighting.OutdoorAmbient = Color3.new(0,0,0); Lighting.Ambient = Color3.new(0,0,0)
        Lighting.FogColor = Color3.new(0,0,0); Lighting.FogEnd = 100
        task.spawn(function() while true do wait(5); if not Lighting:FindFirstChild("DarkSky") then darkSky:Clone().Parent = Lighting end; Lighting.Brightness = 0; Lighting.ClockTime = 0; Lighting.OutdoorAmbient = Color3.new(0,0,0); Lighting.Ambient = Color3.new(0,0,0); Lighting.FogColor = Color3.new(0,0,0); Lighting.FogEnd = 100 end end)
    end
    local function removeParticleEffects() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") then obj:Destroy() end end end
    local function removeLightSources() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then obj:Destroy() end end end
    removeParticleEffects(); removeLightSources(); darkenSky()
end)
MiscTab:AddButton("Rejoin Server", function()
    local success, result = pcall(function() return TeleportService:TeleportToPlaceInstance(game.PlaceId, nil, Player) end)
    if not success then TeleportService:Teleport(game.PlaceId, Player) end
end)

-- ============================================
-- 📜 TAB 11: CREDITS
-- ============================================
local CreditsTab = Window:AddTab("📜 CREDITS")
CreditsTab:AddLabel("═══════════════════════════════")
CreditsTab:AddLabel("👑 KOD HUB").TextSize = 30
CreditsTab:AddLabel("Created by: KING")
CreditsTab:AddLabel("Version: v1.0")
CreditsTab:AddLabel("💬 Discord: https://discord.gg/hh79adY9f2")
CreditsTab:AddLabel("═══════════════════════════════")
CreditsTab:AddButton("📋 Copy Discord", function()
    local link = "https://discord.gg/hh79adY9f2"
    if setclipboard then setclipboard(link); StarterGui:SetCore("SendNotification", {Title = "✅ Link copied", Text = "Discord copied to clipboard", Duration = 3}) end
end)

print("🖤 KOD HUB loaded successfully. Welcome " .. Player.Name)
