-- MEGA SIMPLE FAKE TRADE
local plr = game.Players.LocalPlayer

-- Notificação inicial
game.StarterGui:SetCore("SendNotification", {
    Title = "Fake Trade Script",
    Text = "Carregado com sucesso!",
    Duration = 5
})

print("=== FAKE TRADE SCRIPT ===")
print("Digite no chat: /simular")

-- Comando no chat
plr.Chatted:Connect(function(msg)
    if msg:lower() == "/simular" then
        print("Iniciando simulação de trade...")
        
        -- Passo 1
        game.StarterGui:SetCore("SendNotification", {
            Title = "Step 1/4",
            Text = "Recebendo trade request...",
            Duration = 2
        })
        wait(2)
        
        -- Passo 2
        game.StarterGui:SetCore("SendNotification", {
            Title = "Step 2/4",
            Text = "Abrindo janela de trade...",
            Duration = 2
        })
        wait(2)
        
        -- Passo 3
        game.StarterGui:SetCore("SendNotification", {
            Title = "Step 3/4",
            Text = "Trocando itens...",
            Duration = 2
        })
        wait(2)
        
        -- Passo 4
        game.StarterGui:SetCore("SendNotification", {
            Title = "Step 4/4",
            Text = "Trade completado!",
            Duration = 5
        })
        
        print("Simulação completada!")
    end
end)

print("Script pronto! Digite /simular no chat")