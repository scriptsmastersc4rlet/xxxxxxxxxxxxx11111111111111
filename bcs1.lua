-- Fake Trade Script usando o sistema real de TradeAPI do Adopt Me
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- Configuração
local fakeTraderName = "FakeTrader123" -- Nome que aparecerá

-- Carrega o sistema de trade real
local Loads = require(game.ReplicatedStorage.Fsys).load
local RouterClient = Loads("RouterClient")
local SendTrade = RouterClient.get("TradeAPI/SendTradeRequest")
local AddPetRemote = RouterClient.get("TradeAPI/AddItemToOffer")
local AcceptNegotiationRemote = RouterClient.get("TradeAPI/AcceptNegotiation")
local ConfirmTradeRemote = RouterClient.get("TradeAPI/ConfirmTrade")
local TradeAPI = RouterClient.get("TradeAPI/GetInfo")
local SettingsRemote = RouterClient.get("SettingsAPI/SetSetting")

-- Função para criar um jogador falso na lista de jogadores (apenas visual)
local function createFakePlayerInList()
    -- Esta parte simula a visualização do jogador na interface do jogo
    -- Nota: Isso é apenas visual, não cria um jogador real no servidor
    
    local playerGui = plr:WaitForChild("PlayerGui")
    
    -- Tenta encontrar a lista de jogadores na interface
    local function findPlayersFrame()
        if playerGui:FindFirstChild("SocialApp") then
            return playerGui.SocialApp
        end
        if playerGui:FindFirstChild("FriendsApp") then
            return playerGui.FriendsApp
        end
        return nil
    end
    
    -- Cria uma notificação fake de trade recebido
    game.StarterGui:SetCore("SendNotification", {
        Title = "Trade Request",
        Text = fakeTraderName .. " wants to trade with you!",
        Duration = 5,
        Icon = "rbxassetid://0"
    })
end

-- Função para iniciar o fake trade
local function startFakeTrade()
    print("[FAKE TRADE] Iniciando trade fake com " .. fakeTraderName)
    
    -- Configura para aceitar trades de todos (se necessário)
    SettingsRemote:FireServer("trade_requests", 1)
    
    -- Cria a ilusão de que recebeu um trade request
    createFakePlayerInList()
    
    -- Simula o processo de trade usando o sistema real
    -- Primeiro, vamos tentar obter informações do trade atual
    local tradeInfo = TradeAPI:InvokeServer()
    
    if tradeInfo then
        print("[FAKE TRADE] Sistema de trade carregado")
        
        -- Cria uma interface fake que parece com a real
        local playerGui = plr:WaitForChild("PlayerGui")
        
        -- Simula a abertura da janela de trade
        wait(2)
        
        -- Notificação de trade iniciado
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Started",
            Text = "Trading with " .. fakeTraderName,
            Duration = 3
        })
        
        -- Aqui você pode simular adicionar itens fake
        -- Nota: Não podemos usar AddPetRemote com UIDs falsos sem causar erro
        
        -- Simula o processo de aceitação
        wait(3)
        
        -- Tenta aceitar a negociação (pode falhar, mas é parte da simulação)
        pcall(function()
            AcceptNegotiationRemote:FireServer()
        end)
        
        -- Simula confirmação
        wait(2)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Confirmed",
            Text = fakeTraderName .. " confirmed the trade!",
            Duration = 3
        })
        
        -- Tenta confirmar (pode falhar)
        pcall(function()
            ConfirmTradeRemote:FireServer()
        end)
        
        wait(2)
        
        -- Mensagem final
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Complete!",
            Text = "Successfully traded with " .. fakeTraderName .. "!",
            Duration = 5
        })
        
        print("[FAKE TRADE] Trade fake completado!")
        
    else
        warn("[FAKE TRADE] Não foi possível acessar o sistema de trade")
    end
end

-- Versão ALTERNATIVA: Usando os remotes hasheados (como no seu script original)
local function startFakeTradeHashed()
    print("[FAKE TRADE] Usando método hashed...")
    
    -- Encontra os remotes hasheados (como no seu script)
    local hashes = {}
    for _, v in pairs(getgc()) do
        if type(v) == "function" and debug.getinfo(v).name == "get_remote_from_cache" then
            local upvalues = debug.getupvalues(v)
            if type(upvalues[1]) == "table" then
                for key, value in pairs(upvalues[1]) do
                    hashes[key] = value
                end
            end
        end
    end
    
    -- Função para usar os remotes hasheados
    local function hashedAPI(remoteName, ...)
        local remote = hashes[remoteName]
        if not remote then return nil end

        if remote:IsA("RemoteFunction") then
            return remote:InvokeServer(...)
        elseif remote:IsA("RemoteEvent") then
            remote:FireServer(...)
        end
    end
    
    -- Simula receber um trade request
    game.StarterGui:SetCore("SendNotification", {
        Title = "Trade Request",
        Text = fakeTraderName .. " sent you a trade request!",
        Duration = 5
    })
    
    wait(2)
    
    -- Tenta simular um trade (nota: sem um jogador real, isso pode falhar)
    local success, message = pcall(function()
        -- Primeiro precisamos do UID de algum item do nosso inventário
        local data = hashedAPI("DataAPI/GetAllServerData")
        if data and data[plr.Name] then
            local inventory = data[plr.Name].inventory
            
            -- Procura um item para "adicionar" ao trade
            for category, list in pairs(inventory) do
                for uid, itemData in pairs(list) do
                    -- Tenta adicionar um item (isso falhará sem trade ativo)
                    hashedAPI("TradeAPI/AddItemToOffer", uid)
                    print("[FAKE TRADE] Tentando adicionar item UID:", uid)
                    return true
                end
            end
        end
        return false
    end)
    
    if success then
        print("[FAKE TRADE] Processo iniciado com sucesso")
        
        -- Simula etapas do trade
        for i = 1, 3 do
            wait(1)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Trading...",
                Text = "Step " .. i .. "/3 with " .. fakeTraderName,
                Duration = 2
            })
        end
        
        -- Mensagem final
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Fake Complete!",
            Text = "You traded with " .. fakeTraderName,
            Duration = 5
        })
    else
        warn("[FAKE TRADE] Não foi possível simular o trade")
    end
end

-- Interface para o usuário
local function createControlPanel()
    local playerGui = plr:WaitForChild("PlayerGui")
    
    -- Remove UI existente
    if playerGui:FindFirstChild("FakeTradeControl") then
        playerGui.FakeTradeControl:Destroy()
    end
    
    -- Cria a UI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FakeTradeControl"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.Text = "FAKE TRADE CONTROLS"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.Parent = mainFrame
    
    -- Campo para nome do trader
    local nameFrame = Instance.new("Frame")
    nameFrame.Size = UDim2.new(0.8, 0, 0, 30)
    nameFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
    nameFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    nameFrame.BorderSizePixel = 0
    nameFrame.Parent = mainFrame
    
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(1, 0, 1, 0)
    nameBox.BackgroundTransparency = 1
    nameBox.Text = fakeTraderName
    nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBox.Font = Enum.Font.SourceSans
    nameBox.TextSize = 14
    nameBox.PlaceholderText = "Enter fake trader name"
    nameBox.Parent = nameFrame
    
    -- Botão para iniciar trade normal
    local btnNormal = Instance.new("TextButton")
    btnNormal.Size = UDim2.new(0.8, 0, 0, 35)
    btnNormal.Position = UDim2.new(0.1, 0, 0.5, 0)
    btnNormal.Text = "START NORMAL FAKE TRADE"
    btnNormal.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    btnNormal.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnNormal.Font = Enum.Font.SourceSansBold
    btnNormal.TextSize = 14
    btnNormal.Parent = mainFrame
    
    -- Botão para iniciar trade com método hashed
    local btnHashed = Instance.new("TextButton")
    btnHashed.Size = UDim2.new(0.8, 0, 0, 35)
    btnHashed.Position = UDim2.new(0.1, 0, 0.7, 0)
    btnHashed.Text = "START HASHED FAKE TRADE"
    btnHashed.BackgroundColor3 = Color3.fromRGB(215, 80, 0)
    btnHashed.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnHashed.Font = Enum.Font.SourceSansBold
    btnHashed.TextSize = 14
    btnHashed.Parent = mainFrame
    
    -- Botão de fechar
    local btnClose = Instance.new("TextButton")
    btnClose.Size = UDim2.new(0, 30, 0, 30)
    btnClose.Position = UDim2.new(0.9, -30, 0, 5)
    btnClose.Text = "X"
    btnClose.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btnClose.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnClose.Font = Enum.Font.SourceSansBold
    btnClose.TextSize = 16
    btnClose.Parent = mainFrame
    
    -- Conexões dos botões
    btnNormal.MouseButton1Click:Connect(function()
        fakeTraderName = nameBox.Text
        startFakeTrade()
    end)
    
    btnHashed.MouseButton1Click:Connect(function()
        fakeTraderName = nameBox.Text
        startFakeTradeHashed()
    end)
    
    btnClose.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    mainFrame.Parent = screenGui
    screenGui.Parent = playerGui
    
    -- Permite arrastar
    local dragging = false
    local dragInput, dragStart, startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
end

-- Inicialização
wait(3)
createControlPanel()

print("Fake Trade Script carregado!")
print("Use o painel de controle para iniciar um trade fake")
print("OBS: Este script simula um trade mas não envia itens reais")