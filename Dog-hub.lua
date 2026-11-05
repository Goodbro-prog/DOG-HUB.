

-- DOG HUB 🐶
-- Interface visual em Lua
-- Para uso em um projeto próprio no Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "DogHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "DogButton"
button.Size = UDim2.fromOffset(55, 55)
button.Position = UDim2.new(0, 20, 0.5, 0)
button.Text = "🐶"
button.TextSize = 30
button.BackgroundColor3 = Color3.fromRGB(90, 40, 150)
button.Parent = gui

local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.fromOffset(340, 280)
panel.Position = UDim2.new(0.5, -170, 0.5, -140)
panel.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
panel.Visible = false
panel.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "🐶 DOG HUB"
title.TextColor3 = Color3.fromRGB(200, 140, 255)
title.BackgroundTransparency = 1
title.TextSize = 24
title.Parent = panel

local tabs = {
    "HOME",
    "OVOS",
    "EVENTOS",
    "BRAINROTS",
    "PLAYER",
    "CONFIG"
}

for i, name in ipairs(tabs) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.fromOffset(100, 35)
    tab.Position = UDim2.fromOffset(
        15 + ((i - 1) % 3) * 105,
        65 + math.floor((i - 1) / 3) * 45
    )
    tab.Text = name
    tab.TextSize = 12
    tab.TextColor3 = Color3.new(1, 1, 1)
    tab.BackgroundColor3 = Color3.fromRGB(85, 35, 130)
    tab.Parent = panel
end

button.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
