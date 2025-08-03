-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SliderFrame = Instance.new("Frame")
local SliderBar = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")

-- Настройка главной рамки
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 100)
UICorner.Parent = Frame

-- Заголовок
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Text = "Скорость: 16"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Слайдер
SliderFrame.Parent = Frame
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
SliderFrame.Size = UDim2.new(0.9, 0, 0.25, 0)
UICorner:Clone().Parent = SliderFrame

SliderBar.Parent = SliderFrame
SliderBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderBar.Size = UDim2.new(0, 0, 1, 0)

SliderButton.Parent = SliderFrame
SliderButton.BackgroundTransparency = 1
SliderButton.Size = UDim2.new(1, 0, 1, 0)
SliderButton.Text = ""

-- Логика изменения скорости
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local maxSpeed = 50

SliderButton.MouseButton1Down:Connect(function(x)
    local moveConn
    moveConn = game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
            SliderBar.Size = UDim2.new(relativeX, 0, 1, 0)
            local speed = math.floor(relativeX * maxSpeed)
            humanoid.WalkSpeed = speed
            Title.Text = "Скорость: " .. speed
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            moveConn:Disconnect()
        end
    end)
end)
