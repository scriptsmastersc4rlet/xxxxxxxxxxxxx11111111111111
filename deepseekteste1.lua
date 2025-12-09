-- Fake Trade Script para Adopt Me
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")

-- Configuração
local fakeTraderName = "FakeTrader123" -- Nome do trader falso
local fakeItems = {
    {Name = "Shadow Dragon", Properties = {rideable = true, flyable = true, neon = true}, Value = 1000},
    {Name = "Bat Dragon", Properties = {rideable = true, neon = false}, Value = 800},
    {Name = "Giraffe", Properties = {rideable = true, flyable = false, neon = false}, Value = 650},
    {Name = "Frost Fury", Properties = {rideable = false, flyable = false, mega_neon = true}, Value = 350}
}

-- Função para converter propriedades em string
local function propertiesToString(props)
    local str = ""
    if props.rideable then str = str .. "Ride " end
    if props.flyable then str = str .. "Fly " end
    if props.mega_neon then
        str = str .. "Mega Neon"
    elseif props.neon then
        str = str .. "Neon"
    else
        str = str .. "Normal"
    end
    return str
end

-- Cria a interface de trade falsa
local function createFakeTradeUI()
    -- Remove UI existente se houver
    if playerGui:FindFirstChild("FakeTradeUI") then
        playerGui.FakeTradeUI:Destroy()
    end
    
    -- Cria a tela principal
    local fakeUI = Instance.new("ScreenGui")
    fakeUI.Name = "FakeTradeUI"
    fakeUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = fakeUI
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.Text = "TRADE COM " .. fakeTraderName
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = mainFrame
    
    -- Coluna do trader falso (esquerda)
    local traderColumn = Instance.new("Frame")
    traderColumn.Size = UDim2.new(0.45, 0, 0.8, 0)
    traderColumn.Position = UDim2.new(0.025, 0, 0.15, 0)
    traderColumn.BackgroundTransparency = 1
    traderColumn.Parent = mainFrame
    
    local traderLabel = Instance.new("TextLabel")
    traderLabel.Size = UDim2.new(1, 0, 0, 25)
    traderLabel.Text = fakeTraderName .. " está oferecendo:"
    traderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    traderLabel.Font = Enum.Font.SourceSans
    traderLabel.TextSize = 16
    traderLabel.BackgroundTransparency = 1
    traderLabel.Parent = traderColumn
    
    -- Lista de itens do trader
    local traderScrolling = Instance.new("ScrollingFrame")
    traderScrolling.Size = UDim2.new(1, 0, 1, -30)
    traderScrolling.Position = UDim2.new(0, 0, 0, 30)
    traderScrolling.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    traderScrolling.BorderSizePixel = 0
    traderScrolling.ScrollBarThickness = 5
    traderScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    traderScrolling.Parent = traderColumn
    
    -- Coluna do jogador (direita)
    local playerColumn = Instance.new("Frame")
    playerColumn.Size = UDim2.new(0.45, 0, 0.8, 0)
    playerColumn.Position = UDim2.new(0.525, 0, 0.15, 0)
    playerColumn.BackgroundTransparency = 1
    playerColumn.Parent = mainFrame
    
    local playerLabel = Instance.new("TextLabel")
    playerLabel.Size = UDim2.new(1, 0, 0, 25)
    playerLabel.Text = plr.Name .. " está oferecendo:"
    playerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    playerLabel.Font = Enum.Font.SourceSans
    playerLabel.TextSize = 16
    playerLabel.BackgroundTransparency = 1
    playerLabel.Parent = playerColumn
    
    -- Lista de itens do jogador (vazia inicialmente)
    local playerScrolling = Instance.new("ScrollingFrame")
    playerScrolling.Size = UDim2.new(1, 0, 1, -30)
    playerScrolling.Position = UDim2.new(0, 0, 0, 30)
    playerScrolling.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    playerScrolling.BorderSizePixel = 0
    playerScrolling.ScrollBarThickness = 5
    playerScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    playerScrolling.Parent = playerColumn
    
    -- Adiciona itens do trader falso
    local itemHeight = 70
    for i, item in ipairs(fakeItems) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, -10, 0, itemHeight)
        itemFrame.Position = UDim2.new(0, 5, 0, (i-1) * (itemHeight + 5))
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BorderSizePixel = 0
        itemFrame.Parent = traderScrolling
        
        local itemName = Instance.new("TextLabel")
        itemName.Size = UDim2.new(1, 0, 0.5, 0)
        itemName.Position = UDim2.new(0, 10, 0, 5)
        itemName.Text = item.Name
        itemName.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemName.Font = Enum.Font.SourceSansBold
        itemName.TextSize = 16
        itemName.TextXAlignment = Enum.TextXAlignment.Left
        itemName.BackgroundTransparency = 1
        itemName.Parent = itemFrame
        
        local itemProps = Instance.new("TextLabel")
        itemProps.Size = UDim2.new(1, 0, 0.5, 0)
        itemProps.Position = UDim2.new(0, 10, 0.5, 0)
        itemProps.Text = propertiesToString(item.Properties)
        itemProps.TextColor3 = Color3.fromRGB(200, 200, 100)
        itemProps.Font = Enum.Font.SourceSans
        itemProps.TextSize = 14
        itemProps.TextXAlignment = Enum.TextXAlignment.Left
        itemProps.BackgroundTransparency = 1
        itemProps.Parent = itemFrame
        
        local itemValue = Instance.new("TextLabel")
        itemValue.Size = UDim2.new(0.3, 0, 1, 0)
        itemValue.Position = UDim2.new(0.7, 0, 0, 0)
        itemValue.Text = "Value: " .. item.Value
        itemValue.TextColor3 = Color3.fromRGB(100, 255, 100)
        itemValue.Font = Enum.Font.SourceSansBold
        itemValue.TextSize = 14
        itemValue.BackgroundTransparency = 1
        itemValue.Parent = itemFrame
    end
    
    -- Botões de controle
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0, 50)
    buttonFrame.Position = UDim2.new(0, 0, 0.85, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = mainFrame
    
    -- Botão para adicionar itens (falso)
    local addButton = Instance.new("TextButton")
    addButton.Size = UDim2.new(0.2, 0, 0.8, 0)
    addButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    addButton.Text = "ADD ITEM"
    addButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    addButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    addButton.Font = Enum.Font.SourceSansBold
    addButton.TextSize = 16
    addButton.Parent = buttonFrame
    
    -- Botão de aceitar (falso)
    local acceptButton = Instance.new("TextButton")
    acceptButton.Size = UDim2.new(0.2, 0, 0.8, 0)
    acceptButton.Position = UDim2.new(0.4, 0, 0.1, 0)
    acceptButton.Text = "ACCEPT"
    acceptButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    acceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    acceptButton.Font = Enum.Font.SourceSansBold
    acceptButton.TextSize = 16
    acceptButton.Parent = buttonFrame
    
    -- Botão de cancelar
    local cancelButton = Instance.new("TextButton")
    cancelButton.Size = UDim2.new(0.2, 0, 0.8, 0)
    cancelButton.Position = UDim2.new(0.7, 0, 0.1, 0)
    cancelButton.Text = "CANCEL"
    cancelButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.Font = Enum.Font.SourceSansBold
    cancelButton.TextSize = 16
    cancelButton.Parent = buttonFrame
    
    -- Itens disponíveis para "adicionar" (inventário falso)
    local fakeInventory = {
        {Name = "Kitsune", Properties = {rideable = true, neon = false}, Value = 120},
        {Name = "Cerberus", Properties = {rideable = false, flyable = true, neon = false}, Value = 90},
        {Name = "Dragon", Properties = {rideable = false, flyable = false, mega_neon = false}, Value = 50},
        {Name = "Unicorn", Properties = {rideable = true, neon = true}, Value = 180}
    }
    
    local playerItems = {}
    
    -- Função para adicionar item (falso)
    addButton.MouseButton1Click:Connect(function()
        if #playerItems < 4 then -- Limite de 4 itens
            local randomItem = fakeInventory[math.random(1, #fakeInventory)]
            table.insert(playerItems, randomItem)
            
            -- Cria o item na lista
            local itemFrame = Instance.new("Frame")
            itemFrame.Size = UDim2.new(1, -10, 0, itemHeight)
            itemFrame.Position = UDim2.new(0, 5, 0, (#playerItems-1) * (itemHeight + 5))
            itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            itemFrame.BorderSizePixel = 0
            itemFrame.Parent = playerScrolling
            
            local itemName = Instance.new("TextLabel")
            itemName.Size = UDim2.new(1, 0, 0.5, 0)
            itemName.Position = UDim2.new(0, 10, 0, 5)
            itemName.Text = randomItem.Name
            itemName.TextColor3 = Color3.fromRGB(255, 255, 255)
            itemName.Font = Enum.Font.SourceSansBold
            itemName.TextSize = 16
            itemName.TextXAlignment = Enum.TextXAlignment.Left
            itemName.BackgroundTransparency = 1
            itemName.Parent = itemFrame
            
            local itemProps = Instance.new("TextLabel")
            itemProps.Size = UDim2.new(1, 0, 0.5, 0)
            itemProps.Position = UDim2.new(0, 10, 0.5, 0)
            itemProps.Text = propertiesToString(randomItem.Properties)
            itemProps.TextColor3 = Color3.fromRGB(200, 200, 100)
            itemProps.Font = Enum.Font.SourceSans
            itemProps.TextSize = 14
            itemProps.TextXAlignment = Enum.TextXAlignment.Left
            itemProps.BackgroundTransparency = 1
            itemProps.Parent = itemFrame
            
            local removeButton = Instance.new("TextButton")
            removeButton.Size = UDim2.new(0.2, 0, 0.6, 0)
            removeButton.Position = UDim2.new(0.75, 0, 0.2, 0)
            removeButton.Text = "REMOVE"
            removeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            removeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            removeButton.Font = Enum.Font.SourceSans
            removeButton.TextSize = 12
            removeButton.Parent = itemFrame
            
            removeButton.MouseButton1Click:Connect(function()
                itemFrame:Destroy()
                for i, item in ipairs(playerItems) do
                    if item == randomItem then
                        table.remove(playerItems, i)
                        break
                    end
                end
                
                -- Reorganiza os itens restantes
                local items = playerScrolling:GetChildren()
                for i, child in ipairs(items) do
                    if child:IsA("Frame") then
                        child.Position = UDim2.new(0, 5, 0, (i-1) * (itemHeight + 5))
                    end
                end
            end)
        end
    end)
    
    -- Função de aceitar (falso - simula confirmação)
    acceptButton.MouseButton1Click:Connect(function()
        acceptButton.Text = "CONFIRMING..."
        acceptButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        
        wait(1)
        
        -- Simula o trader aceitando
        local fakeAccept = Instance.new("TextLabel")
        fakeAccept.Size = UDim2.new(1, 0, 0, 30)
        fakeAccept.Position = UDim2.new(0, 0, -0.1, 0)
        fakeAccept.Text = fakeTraderName .. " aceitou a troca!"
        fakeAccept.TextColor3 = Color3.fromRGB(0, 255, 0)
        fakeAccept.Font = Enum.Font.SourceSansBold
        fakeAccept.TextSize = 18
        fakeAccept.BackgroundTransparency = 1
        fakeAccept.Parent = mainFrame
        
        wait(2)
        
        -- Mostra mensagem de sucesso (falsa)
        fakeAccept.Text = "Troca completada com sucesso!"
        
        wait(2)
        
        -- Fecha a interface
        fakeUI:Destroy()
        
        -- Notificação de sucesso
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Fake",
            Text = "Troca simulada com " .. fakeTraderName .. "!",
            Duration = 5
        })
    end)
    
    -- Função de cancelar
    cancelButton.MouseButton1Click:Connect(function()
        fakeUI:Destroy()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trade Cancelado",
            Text = "Trade fake cancelado.",
            Duration = 3
        })
    end)
    
    fakeUI.Parent = playerGui
    
    -- Permite arrastar a janela
    local dragging = false
    local dragInput, dragStart, startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
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

-- Cria um botão para iniciar o fake trade
local function createStarterButton()
    local starterUI = Instance.new("ScreenGui")
    starterUI.Name = "FakeTradeStarter"
    starterUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 40)
    button.Position = UDim2.new(0, 10, 0.5, -20)
    button.Text = "INICIAR FAKE TRADE"
    button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 14
    button.Parent = starterUI
    
    button.MouseButton1Click:Connect(function()
        createFakeTradeUI()
    end)
    
    starterUI.Parent = playerGui
    
    -- Permite arrastar o botão
    local dragging = false
    local dragInput, dragStart, startPos
    
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            button.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
end

-- Inicia o script
createStarterButton()

print("Fake Trade Script carregado! Clique no botão para iniciar uma trade fake.")