-- =====================================================
-- 1. CONFIGURACIÓN DE PLATOBOOST (Tus datos)
-- =====================================================
local serviceId = "25968" 
local secretKey = "db2033b5-5632-4620-8092-a10a5cee72ab"     
local useNonce = true                         

-- =====================================================
-- 2. SERVICIOS DE ROBOX
-- =====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- 3. FUNCIÓN DE VERIFICACIÓN CON PLATOBOOST
-- =====================================================
local function VerifyPlatoboost(key)
	local url = "https://platoboost.com/api/v1/check"
	
	local requestData = {
		service = serviceId,
		secret = secretKey,
		key = key
	}
	
	if useNonce then
		requestData.nonce = os.time()
	end

	local success, response = pcall(function()
		return HttpService:RequestAsync({
			Url = url,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode(requestData)
		})
	end)

	if success and response.StatusCode == 200 then
		local decodedResponse = HttpService:JSONDecode(response.Body)
		if decodedResponse.status == "success" then
			return true 
		end
	end
	
	return false 
end

-- =====================================================
-- 4. CARGAR TU LIBRERÍA DE INTERFAZ GRÁFICA
-- =====================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/UwURaww/-ZumHub-Script-/refs/heads/main/Key%20system%20main.lua.txt"))()

-- =====================================================
-- 5. CREAR LA VENTANA CON TU LIBRERÍA
-- =====================================================
-- ⚠️ ATENCIÓN: Si tu librería usa nombres diferentes (ej: CreateMain, AddTextBox), 
-- cambia las siguientes líneas para que coincidan con tu librería.

local Window = Library:CreateWindow({
    Title = "Sistema de Verificación",
    Theme = "Dark" -- Puedes cambiar el tema si tu librería lo permite
})

local Section = Window:CreateSection({
    Title = "Introduce tu Key"
})

-- Crear el cuadro de texto para escribir la Key
local KeyInput = Section:CreateTextBox({
    Placeholder = "Pega tu Key aquí...",
    Text = "",
    Label = "Key"
})

-- Crear el botón de verificar
local VerifyButton = Section:CreateButton({
    Label = "Verificar Key",
    Callback = function()
        -- Cambiamos el texto del botón mientras verifica
        VerifyButton:SetLabel("Verificando...") 
        
        local enteredKey = KeyInput:GetText()
        local isValid = VerifyPlatoboost(enteredKey)
        
        if isValid then
            -- === KEY CORRECTA ===
            VerifyButton:SetLabel("¡VÁLIDA!")
            task.wait(0.5)
            
            -- Cerramos la interfaz gráfica (si tu librería tiene un método para cerrarla)
            Window:Destroy() 
            
            print("¡Verificación exitosa! Cargando KODSCRIPT...")
            
            -- === CARGAMOS EL SCRIPT QUE ME DISTE ===
            local loadSuccess, loadError = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/PAPIKING-CODER/BLOODAXE/refs/heads/main/KODSCRIPT.lua"))()
            end)
            
            if not loadSuccess then
                warn("Error al cargar el KODSCRIPT: " .. tostring(loadError))
            end
            
        else
            -- === KEY INCORRECTA ===
            VerifyButton:SetLabel("Key Incorrecta")
            task.wait(1.5)
            VerifyButton:SetLabel("Verificar Key")
            KeyInput:SetText("")
        end
    end
})
