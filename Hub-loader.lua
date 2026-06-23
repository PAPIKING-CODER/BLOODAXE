local Fluent = loadstring(game:HttpGet("https://github.com/StyearX/Fluent-Modded/releases/download/Fluent/FluentPro"))()

local Window = Fluent:CreateWindow({
    Title       = "KOD HUB",
    SubTitle    = "Muscle Legends",
    TabWidth    = 160,
    Size        = UDim2.fromOffset(550, 520),
    Acrylic     = true,
    Theme       = "AMOLED",
    MinimizeKey = Enum.KeyCode.LeftControl,
    Search      = true,
    Icon        = "93235288337374",
    Avatar      = game.Players.LocalPlayer.UserId
})

local ScriptsTab = Window:AddTab({ Title = "Scripts", Icon = "solar/home-bold" })
local SocialTab = Window:AddTab({ Title = "Redes", Icon = "solar/share-bold" })

local Scripts = {
    { Name = "KOD HUB MUSCLE LEGENDS", URL = "https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODSCRIPT.lua" },
    { Name = "Anti AFK", URL = "https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODAFK.lua" },
    { Name = "FPS + Ping Counter", URL = "https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODFPSCOUNT.lua" },
    { Name = "Kill Counter UI", URL = "https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KILL-COUNTER-UI.lua" }
}

local function ExecuteAndClose(scriptURL, scriptName)
    local success, err = pcall(function()
        loadstring(game:HttpGet(scriptURL))()
    end)
    if success then
        print(scriptName .. " executed.")
    else
        warn("Error: " .. tostring(err))
    end
    Window:Destroy()
end

ScriptsTab:AddParagraph({
    Title = "Bienvenido",
    Content = "Selecciona un script para ejecutarlo. La interfaz se cerrará automáticamente."
})

ScriptsTab:AddDivider()

for _, v in pairs(Scripts) do
    ScriptsTab:AddButton({
        Title = v.Name,
        Description = "Ejecutar " .. v.Name,
        Callback = function()
            ExecuteAndClose(v.URL, v.Name)
        end
    })
end

SocialTab:AddParagraph({
    Title = "Redes Sociales",
    Content = "Conéctate con nosotros en nuestras plataformas oficiales."
})

SocialTab:AddDivider()

SocialTab:AddButton({
    Title = "Discord",
    Description = "https://discord.gg/hh79adY9f2",
    Callback = function()
        setclipboard("https://discord.gg/hh79adY9f2")
        Fluent:Notify({
            Title = "Discord",
            Content = "Enlace copiado al portapapeles",
            Duration = 3
        })
    end
})

SocialTab:AddButton({
    Title = "YouTube",
    Description = "Canal oficial (próximamente)",
    Callback = function()
        Fluent:Notify({
            Title = "YouTube",
            Content = "Próximamente disponible",
            Duration = 3
        })
    end
})

SocialTab:AddLabel("Gracias por usar KOD HUB")

Fluent.ThemeManager:SetAccentColor(Color3.fromRGB(255, 0, 0))

Fluent:Notify({
    Title = "KOD HUB",
    Content = "Cargado correctamente",
    Duration = 3
})
