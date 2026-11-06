--[[
    DOG HUB V2.2 (CORRIGIDO & 100% OPERACIONAL)
    Mobile Interface
    Purple / Black
    Jogo: Steal an Egg
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local Purple = Color3.fromRGB(145, 65, 255)
local Dark = Color3.fromRGB(15, 12, 22)
local Panel = Color3.fromRGB(28, 22, 38)
local White = Color3.fromRGB(255, 255, 255)
local ButtonColor = Color3.fromRGB(55, 30, 85)

local GUI = Instance.new("ScreenGui")
GUI.Name = "DOG_HUB"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(350, 330)
Main.Position = UDim2.new(0.5, -175, 0.5, -165)
Main.BackgroundColor3 = Dark
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Outline = Instance.new("UIStroke")
Outline.Color = Purple
Outline.Thickness = 2
Outline.Parent = Main

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = Panel
Header.BorderSizePixel = 0
Header.Parent = Main

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.fromOffset(38, 38)
Logo.Position = UDim2.fromOffset(7, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://92959395828927"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -95, 1, 0)
Title.Position = UDim2.fromOffset(53, 0)
Title.BackgroundTransparency = 1
Title.Text = "DOG HUB"
Title.TextColor3 = White
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(32, 30)
Minimize.Position = UDim2.new(1, -38, 0, 9)
Minimize.BackgroundColor3 = Purple
Minimize.Text = "-"
Minimize.TextColor3 = White
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.Parent = Header

Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 7)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.fromOffset(5, 53)
Sidebar.Size = UDim2.new(0, 105, 1, -58)
Sidebar.BackgroundColor3 = Panel
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.Parent = Sidebar

-- CONTENT
local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.fromOffset(115, 53)
Content.Size = UDim2.new(1, -120, 1, -58)
Content.BackgroundColor3 = Panel
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Purple
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.Parent = Main

Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Content

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.PaddingLeft = UDim.new(0, 7)
Padding.PaddingRight = UDim.new(0, 7)
Padding.Parent = Content

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 20)
end)

local function Clear()
    for _, v in ipairs(Content:GetChildren()) do
        if v:IsA("GuiObject") and v ~= Layout and v ~= Padding then
            v:Destroy()
        end
    end
end

local function Label(text)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, 0, 0, 32)
    L.BackgroundColor3 = Dark
    L.Text = text
    L.TextColor3 = White
    L.Font = Enum.Font.GothamBold
    L.TextSize = 12
    L.Parent = Content

    Instance.new("UICorner", L).CornerRadius = UDim.new(0, 6)
    return L
end

local function Button(text, callback)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, 0, 0, 36)
    B.BackgroundColor3 = ButtonColor
    B.Text = text
    B.TextColor3 = White
    B.Font = Enum.Font.GothamBold
    B.TextSize = 12
    B.Parent = Content

    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
    B.Activated:Connect(callback or function() end)
    return B
end

-- ADAPTADO PARA TRANSMITIR O ESTADO (TRUE/FALSE) PARA O CÓDIGO
local function Toggle(text, callback)
    local enabled = false
    local B

    B = Button(text .. ": OFF", function()
        enabled = not enabled
        B.Text = text .. (enabled and ": ON" or ": OFF")
        B.BackgroundColor3 = enabled and Purple or ButtonColor
        if callback then
            callback(enabled)
        end
    end)

    return B
end

-- PAGE FUNCTIONS
local Functions = {}

Functions.Home = function()
    Clear()

    Label("DOG HUB - Version 2.2")
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

Functions.Player = function()
    Clear()

    Label("PLAYER")
    Toggle("Mostrar nome")
    Toggle("Notificações visuais")
    Toggle("Efeitos da interface")
end

-- CONFIGURAÇÃO DOS TRUQUES DO JOGO (STEAL AN EGG)
local instantStealActive = false
local autoStealActive = false

Functions.Main = function()
    Clear()

    Label("MAIN")
    
    -- Instant Steal: Coleta automática via simulação de toque (TouchInterest)
    Toggle("Instant Steal", function(state)
        instantStealActive = state
        if instantStealActive then
            task.spawn(function()
                while instantStealActive do
                    local char = Player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local eggsFolder = workspace:FindFirstChild("Eggs") or workspace
                    
                    if hrp then
                        for _, v in ipairs(eggsFolder:GetChildren()) do
                            if v:IsA("Model") or v:IsA("BasePart") then
                                if v.Name:lower():find("egg") and v:FindFirstChild("TouchInterest") then
                                    firetouchinterest(hrp, v, 0)
                                    task.wait()
                                    firetouchinterest(hrp, v, 1)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end)
    
    -- Auto Steal: Teletransporta você até a posição exata de cada ovo
    Toggle("Auto Steal", function(state)
        autoStealActive = state
        if autoStealActive then
            task.spawn(function()
                while autoStealActive do
                    local char = Player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local eggsFolder = workspace:FindFirstChild("Eggs") or workspace
                    
                    if hrp then
                        for _, v in ipairs(eggsFolder:GetChildren()) do
                            if v:IsA("Model") or v:IsA("BasePart") then
                                if v.Name:lower():find("egg") then
                                    pcall(function()
                                        hrp.CFrame = v:GetPivot()
                                    end)
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end)
end

Functions.Settings = function()
    Clear()

    Label("SETTINGS")
    Toggle("Modo compacto")
    Toggle("Animações visuais")
    Toggle("Efeitos de cor")

    Button("Salvar configurações", function()
        print("Configurações visuais salvas nesta sessão.")
    end)
end

Functions.Credits = function()
    Clear()

    Label("CREDITS")
    Label("DOG HUB")
    Label("Criador: DOG HUB Team")
    Label("Interface: Purple Edition")
    Label("Versão: 2.2")
    Label("Obrigado por utilizar!")
end

-- TABS INTERFACES
local Pages = {"Home", "Player", "Main", "Settings", "Credits"}
local TabButtons = {}

for _, name in ipairs(Pages) do
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, -10, 0, 37)
    B.BackgroundColor3 = Dark
    B.Text = name
    B.TextColor3 = White
    B.TextSize = 12
    B.Font = Enum.Font.GothamBold
    B.Parent = Sidebar

    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 7)
    TabButtons[#TabButtons + 1] = B

    B.Activated:Connect(function()
        for _, tab in ipairs(TabButtons) do
            tab.BackgroundColor3 = Dark
        end

        B.BackgroundColor3 = Purple
        Content.CanvasPosition = Vector2.new(0, 0)
        Functions[name]()
    end)
end

-- MINIMIZE
local minimized = false

Minimize.Activated:Connect(function()
    minimized = not minimized

    Sidebar.Visible = not minimized
    Content.Visible = not minimized

    Main.Size = minimized
        and UDim2.fromOffset(210, 48)
