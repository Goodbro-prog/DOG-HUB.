--[[
    DOG HUB
    Version: 1.1
    Mobile Interface
    Purple / Black
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local Purple = Color3.fromRGB(145, 65, 255)
local Dark = Color3.fromRGB(15, 12, 22)
local Panel = Color3.fromRGB(28, 22, 38)
local White = Color3.fromRGB(255, 255, 255)

local GUI = Instance.new("ScreenGui")
GUI.Name = "DOG_HUB"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(340, 310)
Main.Position = UDim2.new(0.5, -170, 0.5, -155)
Main.BackgroundColor3 = Dark
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local Outline = Instance.new("UIStroke", Main)
Outline.Color = Purple
Outline.Thickness = 2

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Panel
Header.Text = "🐶 DOG HUB"
Header.TextColor3 = White
Header.TextSize = 19
Header.Font = Enum.Font.GothamBold
Header.Parent = Main

Instance.new("UICorner", Header).CornerRadius =
    UDim.new(0, 10)

local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.fromOffset(115, 52)
Content.Size = UDim2.new(1, -125, 1, -62)
Content.BackgroundColor3 = Panel
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Purple
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Content

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.PaddingLeft = UDim.new(0, 7)
Padding.PaddingRight = UDim.new(0, 7)
Padding.Parent = Content

local function UpdateCanvas()
    Content.CanvasSize = UDim2.fromOffset(
        0, Layout.AbsoluteContentSize.Y + 20
    )
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize")
    :Connect(UpdateCanvas)

local function Label(text)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, 0, 0, 32)
    L.BackgroundColor3 = Dark
    L.Text = text
    L.TextColor3 = White
    L.Font = Enum.Font.GothamBold
    L.TextSize = 12
    L.Parent = Content

    Instance.new("UICorner", L).CornerRadius =
        UDim.new(0, 6)

    return L
end

local function Button(text, callback)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, 0, 0, 34)
    B.BackgroundColor3 = Color3.fromRGB(55, 30, 85)
    B.Text = text
    B.TextColor3 = White
    B.Font = Enum.Font.GothamBold
    B.TextSize = 12
    B.Parent = Content

    Instance.new("UICorner", B).CornerRadius =
        UDim.new(0, 6)

    B.MouseButton1Click:Connect(callback or function() end)

    return B
end

-- TOGGLE CORRIGIDO
local function Toggle(text, callback)
    local enabled = false
    local B

    B = Button(text .. ": OFF", function()
        enabled = not enabled

        B.Text = text .. (enabled and ": ON" or ": OFF")

        B.BackgroundColor3 = enabled and Purple or
            Color3.fromRGB(55, 30, 85)

        if callback then
            callback(enabled)
        end
    end)

    return B
end

local Pages = {
    "Home",
    "Player",
    "Main",
    "Settings",
    "Credits"
}

local function Clear()
    for _, v in ipairs(Content:GetChildren()) do
        if v:IsA("GuiObject")
        and v ~= Layout
        and v ~= Padding then
            v:Destroy()
        end
    end
end

local function Home()
    Label("HOME")
    Label("DOG HUB - Version 1.1")
    Label("Player: " .. Player.Name)

    local TimeLabel = Label("Tempo: 0 segundos")
    local FPSLabel = Label("FPS: Calculando...")

    local start = os.clock()
    local frames = 0
    local elapsed = 0

    local connection
    connection = RunService.RenderStepped:Connect(function(dt)
        if not TimeLabel.Parent then
            connection:Disconnect()
            return
        end

        frames += 1
        elapsed += dt

        if elapsed >= 1 then
            TimeLabel.Text = "Tempo: " ..
                math.floor(os.clock() - start) .. " segundos"

            FPSLabel.Text = "FPS: " .. frames

            frames = 0
            elapsed = 0
        end
    end)
end

local function PlayerPage()
    Label("PLAYER")

    Toggle("Infinite Jump - teste")
    Toggle("Speed Boost - teste")
    Label("Speed máximo configurável: 1000")
    Toggle("Invisibilidade - teste")
    Toggle("Hit Aura - teste")
    Toggle("Anti Hit Guard - teste")
end

local function MainPage()
    Label("MAIN")

    Toggle("Auto Steal - integração pendente")
    Toggle("Instant Steal - integração pendente")
    Toggle("Glide - teste")
    Toggle("Movimento normal")

    Label("Seleção de ovos")
    Button("Selecionar ovos - pendente")
    Toggle("Auto Steal selecionados")

    Label("Seleção de área")
    Button("Selecionar área - pendente")
end

local function Settings()
    Label("SETTINGS")

    Toggle("Anti Lag")
    Toggle("Otimização")

    Button("Server Hop - integração pendente")
    Button("Salvar configurações", function()
        print("Configurações da interface")
    end)
end

local function Credits()
    Label("CREDITS")
    Label("DOG HUB")
    Label("Criador: DOG HUB Team")
    Label("Interface: Purple Edition")
    Label("Versão: 1.1")
    Label("Obrigado por utilizar!")
end

local Functions = {
    Home = Home,
    Player = PlayerPage,
    Main = MainPage,
    Settings = Settings,
    Credits = Credits
}

local TabButtons = {}

for i, name in ipairs(Pages) do
    local B = Instance.new("TextButton")
    B.Size = UDim2.fromOffset(103, 37)
    B.Position = UDim2.fromOffset(6, 51 + (i-1)*43)
    B.BackgroundColor3 = Panel
    B.Text = name
    B.TextColor3 = White
    B.TextSize = 12
    B.Font = Enum.Font.GothamBold
    B.Parent = Main

    Instance.new("UICorner", B).CornerRadius =
        UDim.new(0, 7)

    TabButtons[#TabButtons + 1] = B

    B.MouseButton1Click:Connect(function()
        Clear()
        Content.CanvasPosition = Vector2.new(0, 0)
        Functions[name]()
    end)
end

-- Minimizar
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(35, 30)
Minimize.Position = UDim2.new(1, -40, 0, 5)
Minimize.BackgroundColor3 = Purple
Minimize.Text = "-"
Minimize.TextColor3 = White
Minimize.Parent = Main

local minimized = false

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    Content.Visible = not minimized

    for _, B in ipairs(TabButtons) do
        B.Visible = not minimized
    end

    Main.Size = minimized
        and UDim2.fromOffset(340, 45)
        or UDim2.fromOffset(340, 310)

    Minimize.Text = minimized and "+" or "-"
end)

-- Arrastar
local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

Home()

print("DOG HUB V1.1 carregado!")
