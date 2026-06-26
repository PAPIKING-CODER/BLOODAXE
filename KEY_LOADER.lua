local Config = {
    ServiceId = "YOUR_SERVICE_ID",
    SecretKey = "YOUR_SECRET_KEY",
    DiscordLink = "https://discord.gg/yourdiscord",
    GetKeyLink = "https://platoboost.com/getkey",
    MainScript = function()
        print("✅ Platoboost - Script principal cargado")
    end,
    SoundIDs = {
        Open = "rbxassetid://9118823107",
        Click = "rbxassetid://12222225",
        Success = "rbxassetid://6026984224",
        Error = "rbxassetid://138186576"
    }
}

local Services = {
    Players = game:GetService("Players"),
    Tween = game:GetService("TweenService"),
    Sound = game:GetService("SoundService"),
    UserInput = game:GetService("UserInputService"),
    Debris = game:GetService("Debris"),
    Run = game:GetService("RunService"),
    Http = game:GetService("HttpService")
}

local LocalPlayer = Services.Players.LocalPlayer
if not LocalPlayer then error("No se pudo obtener el jugador local") end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function PlaySound(id, volume, pitch)
    if not id or id == "" then
        warn("⚠️ Sound ID vacío")
        return
    end
    volume = volume or 0.5
    pitch = pitch or 1
    local success, err = pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = id
        sound.Volume = volume
        sound.Pitch = pitch
        sound.Parent = Services.Sound
        sound:Play()
        Services.Debris:AddItem(sound, sound.TimeLength + 0.5)
    end)
    if not success then
        warn("❌ Error reproduciendo sonido (" .. id .. "): " .. tostring(err))
    end
end

local Platoboost = {
    copyLink = function()
        if copyLink then
            return copyLink()
        else
            setclipboard(Config.GetKeyLink)
            return Config.GetKeyLink
        end
    end,
    verifyKey = function(key)
        if verifyKey then
            return verifyKey(key)
        else
            local url = "https://api.platoboost.com/v1/verify?serviceId=" .. Config.ServiceId .. "&secret=" .. Config.SecretKey .. "&key=" .. key
            local success, result = pcall(function()
                return Services.Http:GetAsync(url)
            end)
            if not success then return {success = false, message = "Connection error"} end
            local data
            local decodeSuccess = pcall(function()
                data = Services.Http:JSONDecode(result)
            end)
            if not decodeSuccess or not data then return {success = false, message = "Invalid response"} end
            return data
        end
    end
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlatoboostKeySystem"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Glow = Instance.new("Frame")
Glow.Size = UDim2.new(0, 300, 0, 240)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.ZIndex = 0
Glow.Parent = ScreenGui

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Color = Color3.fromRGB(255, 255, 255)
GlowStroke.Thickness = 2
GlowStroke.Transparency = 0.8
GlowStroke.Parent = Glow

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 20)
GlowCorner.Parent = Glow

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 1
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -20)
ContentFrame.Position = UDim2.new(0, 10, 0, 10)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ContentFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundTransparency = 1
Header.LayoutOrder = 1
Header.Parent = ContentFrame

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 24, 0, 24)
Logo.Position = UDim2.new(0.5, 0, 0, 2)
Logo.AnchorPoint = Vector2.new(0.5, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://6031094667"
Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
Logo.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 18)
Title.Position = UDim2.new(0, 0, 0, 26)
Title.BackgroundTransparency = 1
Title.Text = "PLATOBOOST KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 10)
Subtitle.Position = UDim2.new(0, 0, 0, 44)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Verification"
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.TextSize = 8
Subtitle.Font = Enum.Font.Gotham
Subtitle.Parent = Header

local KeyBoxFrame = Instance.new("Frame")
KeyBoxFrame.Size = UDim2.new(0, 240, 0, 32)
KeyBoxFrame.BackgroundTransparency = 1
KeyBoxFrame.LayoutOrder = 2
KeyBoxFrame.Parent = ContentFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, 0, 1, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Paste your key here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyBox.Text = ""
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyBoxFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 6)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = Color3.fromRGB(255, 255, 255)
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Transparency = 0.5
KeyBoxStroke.Parent = KeyBox

local VerifyFrame = Instance.new("Frame")
VerifyFrame.Size = UDim2.new(0, 180, 0, 32)
VerifyFrame.BackgroundTransparency = 1
VerifyFrame.LayoutOrder = 3
VerifyFrame.Parent = ContentFrame

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, 0, 1, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.BackgroundTransparency = 0.1
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 12
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.AutoButtonColor = false
VerifyBtn.Parent = VerifyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 6)
VerifyCorner.Parent = VerifyBtn

local VerifyStroke = Instance.new("UIStroke")
VerifyStroke.Color = Color3.fromRGB(255, 255, 255)
VerifyStroke.Thickness = 1.5
VerifyStroke.Transparency = 0.4
VerifyStroke.Parent = VerifyBtn

local ButtonRow = Instance.new("Frame")
ButtonRow.Size = UDim2.new(0, 240, 0, 28)
ButtonRow.BackgroundTransparency = 1
ButtonRow.LayoutOrder = 4
ButtonRow.Parent = ContentFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 110, 0, 28)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.BackgroundTransparency = 0.1
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 10
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonRow
local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn
local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Color = Color3.fromRGB(255, 255, 255)
GetKeyStroke.Thickness = 1
GetKeyStroke.Transparency = 0.4
GetKeyStroke.Parent = GetKeyBtn

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0, 110, 0, 28)
DiscordBtn.Position = UDim2.new(1, 0, 0, 0)
DiscordBtn.AnchorPoint = Vector2.new(1, 0)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.BackgroundTransparency = 0.1
DiscordBtn.Text = "DISCORD"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.TextSize = 10
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.AutoButtonColor = false
DiscordBtn.Parent = ButtonRow
local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBtn
local DiscordStroke = Instance.new("UIStroke")
DiscordStroke.Color = Color3.fromRGB(255, 255, 255)
DiscordStroke.Thickness = 1
DiscordStroke.Transparency = 0.4
DiscordStroke.Parent = DiscordBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 16)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.LayoutOrder = 5
StatusLabel.Parent = ContentFrame

local ParticleContainer = Instance.new("Frame")
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ZIndex = 0
ParticleContainer.Parent = MainFrame

local particles = {}
local function SpawnParticle()
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    p.BackgroundTransparency = 0.7
    p.BorderSizePixel = 0
    p.ZIndex = 0
    p.Parent = ParticleContainer
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = p

    local sx = math.random() * 0.9 + 0.05
    local sy = math.random() * 0.9 + 0.05
    p.Position = UDim2.new(sx, 0, sy, 0)

    local dur = math.random(8, 16)
    local ex = math.random() * 0.9 + 0.05
    local ey = math.random() * 0.9 + 0.05

    local tween = Services.Tween:Create(p, TweenInfo.new(dur, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(ex, 0, ey, 0)})
    tween:Play()
    table.insert(particles, p)

    tween.Completed:Connect(function()
        p:Destroy()
        for i, v in ipairs(particles) do if v == p then table.remove(particles, i) break end end
    end)
end

task.spawn(function()
    while MainFrame.Parent do
        if #particles < 12 then SpawnParticle() end
        task.wait(0.6)
    end
end)

local function AnimateIn()
    MainFrame.Visible = true
    MainFrame.BackgroundTransparency = 1
    MainFrame.Size = UDim2.new(0, 260, 0, 200)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 20)

    local info = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Services.Tween:Create(MainFrame, info, {BackgroundTransparency = 0.2}):Play()
    Services.Tween:Create(MainFrame, info, {Size = UDim2.new(0, 280, 0, 220)}):Play()
    Services.Tween:Create(MainFrame, info, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    PlaySound(Config.SoundIDs.Open, 0.3, 1)
end

local function AnimateOut(callback)
    local info = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    Services.Tween:Create(MainFrame, info, {BackgroundTransparency = 1}):Play()
    Services.Tween:Create(MainFrame, info, {Size = UDim2.new(0, 260, 0, 200)}):Play()
    Services.Tween:Create(MainFrame, info, {Position = UDim2.new(0.5, 0, 0.5, 20)}):Play()
    task.wait(0.45)
    if callback then callback() end
    ScreenGui:Destroy()
end

local function SetupButton(btn, strokeObj, baseColor, hoverColor)
    btn.MouseEnter:Connect(function()
        Services.Tween:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
        Services.Tween:Create(btn, TweenInfo.new(0.15), {Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset * 1.03, btn.Size.Y.Scale, btn.Size.Y.Offset * 1.03)}):Play()
        if strokeObj then
            Services.Tween:Create(strokeObj, TweenInfo.new(0.15), {Transparency = 0}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        Services.Tween:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = baseColor}):Play()
        Services.Tween:Create(btn, TweenInfo.new(0.15), {Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset)}):Play()
        if strokeObj then
            Services.Tween:Create(strokeObj, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
        end
    end)
    btn.MouseButton1Down:Connect(function()
        Services.Tween:Create(btn, TweenInfo.new(0.05), {Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset * 0.95, btn.Size.Y.Scale, btn.Size.Y.Offset * 0.95)}):Play()
        PlaySound(Config.SoundIDs.Click, 0.3, 1.1)
    end)
    btn.MouseButton1Up:Connect(function()
        Services.Tween:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset)}):Play()
    end)
end

SetupButton(VerifyBtn, VerifyStroke, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
SetupButton(GetKeyBtn, GetKeyStroke, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
SetupButton(DiscordBtn, DiscordStroke, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 260, 0, 40)
NotifContainer.Position = UDim2.new(0.5, 0, 1, -10)
NotifContainer.AnchorPoint = Vector2.new(0.5, 1)
NotifContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
NotifContainer.BackgroundTransparency = 0.3
NotifContainer.BorderSizePixel = 0
NotifContainer.Visible = false
NotifContainer.ZIndex = 2
NotifContainer.Parent = ScreenGui
local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = NotifContainer
local NotifStroke = Instance.new("UIStroke")
NotifStroke.Color = Color3.fromRGB(255, 255, 255)
NotifStroke.Thickness = 1
NotifStroke.Transparency = 0.6
NotifStroke.Parent = NotifContainer

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -10, 1, 0)
NotifText.Position = UDim2.new(0, 5, 0, 0)
NotifText.BackgroundTransparency = 1
NotifText.Text = ""
NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText.TextSize = 12
NotifText.Font = Enum.Font.Gotham
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.Parent = NotifContainer

local notifQueue = {}
local isNotifShowing = false
local function ShowNotification(text, duration)
    duration = duration or 2.5
    table.insert(notifQueue, {text = text, duration = duration})
    if not isNotifShowing then
        isNotifShowing = true
        task.spawn(function()
            while #notifQueue > 0 do
                local data = table.remove(notifQueue, 1)
                NotifContainer.Visible = true
                NotifContainer.Position = UDim2.new(0.5, 0, 1, 30)
                NotifText.Text = data.text
                Services.Tween:Create(NotifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 1, -10)}):Play()
                task.wait(data.duration)
                Services.Tween:Create(NotifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1, 30)}):Play()
                task.wait(0.3)
                NotifContainer.Visible = false
            end
            isNotifShowing = false
        end)
    end
end

-- =========== LOCK VARIABLES ===========
local verifying = false
local copying = false
local discordCopying = false

-- =========== GLOW SYNC ===========
local function UpdateGlow()
    Glow.Position = MainFrame.Position
    Glow.Size = MainFrame.Size
    Glow.AnchorPoint = MainFrame.AnchorPoint
end

-- Sync glow whenever MainFrame changes (including tweens)
MainFrame:GetPropertyChangedSignal("Position"):Connect(UpdateGlow)
MainFrame:GetPropertyChangedSignal("Size"):Connect(UpdateGlow)
MainFrame:GetPropertyChangedSignal("AnchorPoint"):Connect(UpdateGlow)

local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        -- UpdateGlow is called by property change
    end
end)

local function SetStatus(text, color, isError)
    StatusLabel.Text = text
    if color then
        Services.Tween:Create(StatusLabel, TweenInfo.new(0.2), {TextColor3 = color}):Play()
    end
    if isError then
        local origPos = KeyBox.Position
        for i = 1, 4 do
            Services.Tween:Create(KeyBox, TweenInfo.new(0.04), {Position = UDim2.new(0.5, (i%2==0 and -4 or 4), 0, 0)}):Play()
            task.wait(0.04)
        end
        Services.Tween:Create(KeyBox, TweenInfo.new(0.08), {Position = origPos}):Play()
    end
end

local function VerifyKey(key)
    if verifying then
        ShowNotification("⏳ Already verifying, please wait...", 1.5)
        return
    end
    if not key or key == "" then
        SetStatus("❌ Please enter a key", Color3.fromRGB(200, 200, 200), true)
        PlaySound(Config.SoundIDs.Error, 0.4, 1)
        ShowNotification("❌ Key cannot be empty", 2)
        return
    end

    verifying = true
    SetStatus("⏳ Verifying...", Color3.fromRGB(255, 255, 255))
    PlaySound(Config.SoundIDs.Click, 0.3, 1)

    local success, result = pcall(function()
        return Platoboost.verifyKey(key)
    end)

    if not success or not result then
        SetStatus("❌ Error", Color3.fromRGB(200, 200, 200), true)
        PlaySound(Config.SoundIDs.Error, 0.4, 1)
        ShowNotification("❌ Verification error", 2)
        verifying = false
        return
    end

    if result.success == true then
        SetStatus("✅ KEY VALID", Color3.fromRGB(255, 255, 255))
        PlaySound(Config.SoundIDs.Success, 0.5, 1)
        ShowNotification("✅ Key valid! Loading main script...", 2)

        Services.Tween:Create(KeyBoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(255, 255, 255), Thickness = 2.5}):Play()

        task.wait(1.0)
        verifying = false
        AnimateOut(function()
            if type(Config.MainScript) == "function" then
                Config.MainScript()
            elseif type(Config.MainScript) == "string" then
                loadstring(Config.MainScript)()
            end
        end)
    else
        SetStatus("❌ INVALID KEY", Color3.fromRGB(200, 200, 200), true)
        PlaySound(Config.SoundIDs.Error, 0.4, 1)
        KeyBox.Text = ""
        ShowNotification("❌ Invalid key. Try again.", 2)

        Services.Tween:Create(KeyBoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(200, 200, 200), Thickness = 2.5}):Play()
        task.delay(1.0, function()
            Services.Tween:Create(KeyBoxStroke, TweenInfo.new(0.4), {Color = Color3.fromRGB(255, 255, 255), Thickness = 1, Transparency = 0.5}):Play()
        end)
        verifying = false
    end
end

VerifyBtn.MouseButton1Click:Connect(function()
    VerifyKey(KeyBox.Text)
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    if copying then
        ShowNotification("⏳ Already copying...", 1.5)
        return
    end
    copying = true
    local success, err = pcall(function()
        local link = Platoboost.copyLink()
        setclipboard(link)
        SetStatus("📋 Link copied", Color3.fromRGB(255, 255, 255))
        PlaySound(Config.SoundIDs.Click, 0.3, 1)
        ShowNotification("📋 Get Key link copied to clipboard", 2)
    end)
    if not success then
        SetStatus("❌ Error copying link", Color3.fromRGB(200, 200, 200), true)
        ShowNotification("❌ Failed to copy link", 2)
    end
    copying = false
end)

DiscordBtn.MouseButton1Click:Connect(function()
    if discordCopying then
        ShowNotification("⏳ Already copying...", 1.5)
        return
    end
    discordCopying = true
    local success, err = pcall(function()
        setclipboard(Config.DiscordLink)
        SetStatus("📋 Discord copied", Color3.fromRGB(255, 255, 255))
        PlaySound(Config.SoundIDs.Click, 0.3, 1)
        ShowNotification("📋 Discord link copied to clipboard", 2)
    end)
    if not success then
        SetStatus("❌ Error copying Discord", Color3.fromRGB(200, 200, 200), true)
        ShowNotification("❌ Failed to copy Discord", 2)
    end
    discordCopying = false
end)

-- Initial glow sync
UpdateGlow()
AnimateIn()
