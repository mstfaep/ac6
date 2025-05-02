--[[
    FE AC6 Music Exploit v2.0
    Gelişmiş versiyon:
    - Daha güvenilir remote bulma
    - Hata yönetimi iyileştirildi
    - Ek güvenlik önlemleri
    - Daha fazla özelleştirme seçeneği
    - Optimize edilmiş performans
]]

local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

-- Yapılandırma ayarları
local config = {
    DefaultVolume = 1,
    DefaultPitch = 1,
    DefaultLoop = true,
    SoundParent = game:GetService("TestService"), -- Workspace'te siliniyorsa değiştirin
    NotificationDuration = 5,
    UIAccentColor = Color3.fromRGB(100, 150, 255),
    UIBackgroundColor = Color3.fromRGB(40, 40, 45),
    UITextColor = Color3.fromRGB(255, 255, 255),
    RemoteNames = {"AC6_FE_Sounds", "AC6SoundSystem", "FESoundSystem", "SoundRemote"} -- Olası remote isimleri
}

-- UI kütüphanesi (optimize edilmiş versiyon)
local function LoadNotificationLibrary()
    local success, lib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
    end)
    
    if success then
        return lib
    else
        -- Fallback basit bildirim sistemi
        local fallbackLib = {}
        function fallbackLib:SendNotification(title, text, duration)
            duration = duration or config.NotificationDuration
            local message = Instance.new("Message", CoreGui)
            message.Text = title .. ": " .. text
            task.delay(duration, function()
                message:Destroy()
            end)
        end
        return fallbackLib
    end
end

local NotificationLibrary = LoadNotificationLibrary()

-- Rastgele isim üretici (daha iyi bir versiyon)
local function GenerateRandomName()
    return HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 12)
end

-- Remote bulucu (daha kapsamlı)
local function FindRemote()
    for _, remoteName in ipairs(config.RemoteNames) do
        for _, parent in ipairs({replicatedStorage, workspace, player.PlayerScripts}) do
            local remote = parent:FindFirstChild(remoteName)
            if remote and remote:IsA("RemoteEvent") then
                return remote
            end
            
            -- Descendant arama (daha yavaş ama kapsamlı)
            for _, descendant in ipairs(parent:GetDescendants()) do
                if descendant:IsA("RemoteEvent") and table.find(config.RemoteNames, descendant.Name) then
                    return descendant
                end
            end
        end
    end
    return nil
end

-- Ses çalma fonksiyonu (yerel test için)
local function PlayLocalSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = 0.5
    sound.PlayOnRemove = true
    sound.Parent = workspace
    sound:Destroy()
end

-- Remote kontrol fonksiyonu
local function IsRemoteValid(remote)
    return remote and remote:IsA("RemoteEvent") and remote.Parent ~= nil
end

-- Ana işlevler
local remote = FindRemote()
local randomName = GenerateRandomName()
local isRemoteConnected = IsRemoteValid(remote)

-- UI oluşturma
local function CreateUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = GenerateRandomName()
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    mainFrame.BackgroundColor3 = config.UIBackgroundColor
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = gui

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = config.UIAccentColor
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Text = "FE AC6 Music Exploit v2.0"
    titleLabel.TextColor3 = config.UITextColor
    titleLabel.TextSize = 14
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = config.UITextColor
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = titleBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.Text = "_"
    minimizeButton.TextColor3 = config.UITextColor
    minimizeButton.BackgroundColor3 = config.UIAccentColor
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 14
    minimizeButton.Parent = titleBar

    -- Kontrol paneli
    local controlPanel = Instance.new("Frame")
    controlPanel.Size = UDim2.new(1, 0, 1, -30)
    controlPanel.Position = UDim2.new(0, 0, 0, 30)
    controlPanel.BackgroundTransparency = 1
    controlPanel.Parent = mainFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0, 30)
    textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
    textBox.PlaceholderText = "Enter Sound ID (e.g. 123456789)"
    textBox.Text = ""
    textBox.TextColor3 = config.UITextColor
    textBox.TextSize = 14
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    textBox.BorderSizePixel = 0
    textBox.Font = Enum.Font.Gotham
    textBox.ClearTextOnFocus = false
    textBox.Parent = controlPanel

    local playButton = Instance.new("TextButton")
    playButton.Size = UDim2.new(0.4, 0, 0, 35)
    playButton.Position = UDim2.new(0.3, 0, 0.3, 0)
    playButton.Text = "PLAY"
    playButton.TextColor3 = config.UITextColor
    playButton.BackgroundColor3 = config.UIAccentColor
    playButton.Font = Enum.Font.GothamBold
    playButton.TextSize = 16
    playButton.Parent = controlPanel

    local stopButton = Instance.new("TextButton")
    stopButton.Size = UDim2.new(0.4, 0, 0, 35)
    stopButton.Position = UDim2.new(0.3, 0, 0.45, 0)
    stopButton.Text = "STOP"
    stopButton.TextColor3 = config.UITextColor
    stopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    stopButton.Font = Enum.Font.GothamBold
    stopButton.TextSize = 16
    stopButton.Parent = controlPanel

    -- Ayarlar paneli
    local settingsPanel = Instance.new("Frame")
    settingsPanel.Size = UDim2.new(1, -20, 0, 80)
    settingsPanel.Position = UDim2.new(0, 10, 0.65, 0)
    settingsPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    settingsPanel.BorderSizePixel = 0
    settingsPanel.Parent = controlPanel

    local volumeLabel = Instance.new("TextLabel")
    volumeLabel.Size = UDim2.new(0.4, 0, 0, 20)
    volumeLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    volumeLabel.Text = "Volume:"
    volumeLabel.TextColor3 = config.UITextColor
    volumeLabel.TextSize = 12
    volumeLabel.BackgroundTransparency = 1
    volumeLabel.Font = Enum.Font.Gotham
    volumeLabel.TextXAlignment = Enum.TextXAlignment.Left
    volumeLabel.Parent = settingsPanel

    local volumeBox = Instance.new("TextBox")
    volumeBox.Size = UDim2.new(0.2, 0, 0, 20)
    volumeBox.Position = UDim2.new(0.45, 0, 0.1, 0)
    volumeBox.PlaceholderText = tostring(config.DefaultVolume)
    volumeBox.Text = ""
    volumeBox.TextColor3 = config.UITextColor
    volumeBox.TextSize = 12
    volumeBox.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    volumeBox.BorderSizePixel = 0
    volumeBox.Font = Enum.Font.Gotham
    volumeBox.Parent = settingsPanel

    local pitchLabel = Instance.new("TextLabel")
    pitchLabel.Size = UDim2.new(0.4, 0, 0, 20)
    pitchLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
    pitchLabel.Text = "Pitch:"
    pitchLabel.TextColor3 = config.UITextColor
    pitchLabel.TextSize = 12
    pitchLabel.BackgroundTransparency = 1
    pitchLabel.Font = Enum.Font.Gotham
    pitchLabel.TextXAlignment = Enum.TextXAlignment.Left
    pitchLabel.Parent = settingsPanel

    local pitchBox = Instance.new("TextBox")
    pitchBox.Size = UDim2.new(0.2, 0, 0, 20)
    pitchBox.Position = UDim2.new(0.45, 0, 0.4, 0)
    pitchBox.PlaceholderText = tostring(config.DefaultPitch)
    pitchBox.Text = ""
    pitchBox.TextColor3 = config.UITextColor
    pitchBox.TextSize = 12
    pitchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    pitchBox.BorderSizePixel = 0
    pitchBox.Font = Enum.Font.Gotham
    pitchBox.Parent = settingsPanel

    local loopLabel = Instance.new("TextLabel")
    loopLabel.Size = UDim2.new(0.4, 0, 0, 20)
    loopLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
    loopLabel.Text = "Loop:"
    loopLabel.TextColor3 = config.UITextColor
    loopLabel.TextSize = 12
    loopLabel.BackgroundTransparency = 1
    loopLabel.Font = Enum.Font.Gotham
    loopLabel.TextXAlignment = Enum.TextXAlignment.Left
    loopLabel.Parent = settingsPanel

    local loopButton = Instance.new("TextButton")
    loopButton.Size = UDim2.new(0.2, 0, 0, 20)
    loopButton.Position = UDim2.new(0.45, 0, 0.7, 0)
    loopButton.Text = config.DefaultLoop and "ON" : "OFF"
    loopButton.TextColor3 = config.DefaultLoop and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    loopButton.TextSize = 12
    loopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    loopButton.BorderSizePixel = 0
    loopButton.Font = Enum.Font.GothamBold
    loopButton.Parent = settingsPanel

    -- Durum göstergesi
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0.9, 0)
    statusLabel.Text = isRemoteConnected and "Status: CONNECTED" : "Status: DISCONNECTED"
    statusLabel.TextColor3 = isRemoteConnected and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
    statusLabel.TextSize = 12
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = controlPanel

    -- Animasyon değişkenleri
    local isMinimized = false
    local originalSize = mainFrame.Size
    local originalPosition = mainFrame.Position

    -- Fonksiyonlar
    local function ToggleMinimize()
        isMinimized = not isMinimized
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if isMinimized then
            originalSize = mainFrame.Size
            originalPosition = mainFrame.Position
            
            local tween = TweenService:Create(mainFrame, tweenInfo, {
                Size = UDim2.new(0, 200, 0, 30),
                Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset)
            })
            tween:Play()
            controlPanel.Visible = false
        else
            local tween = TweenService:Create(mainFrame, tweenInfo, {
                Size = originalSize,
                Position = originalPosition
            })
            tween:Play()
            controlPanel.Visible = true
        end
    end

    local function PlaySound()
        local soundId = textBox.Text
        local volume = tonumber(volumeBox.Text) or config.DefaultVolume
        local pitch = tonumber(pitchBox.Text) or config.DefaultPitch
        local loop = loopButton.Text == "ON"
        
        if not soundId or soundId == "" then
            NotificationLibrary:SendNotification("Error", "Please enter a sound ID", config.NotificationDuration)
            PlayLocalSound("9046949339") -- Error sound
            return
        end
        
        if not tonumber(soundId) then
            NotificationLibrary:SendNotification("Error", "Sound ID must be a number", config.NotificationDuration)
            PlayLocalSound("9046949339") -- Error sound
            return
        end
        
        local assetId = "rbxassetid://" .. soundId
        
        if isRemoteConnected and IsRemoteValid(remote) then
            local success, err = pcall(function()
                local args = {
                    [1] = "newSound",
                    [2] = randomName,
                    [3] = config.SoundParent,
                    [4] = assetId,
                    [5] = pitch,
                    [6] = volume,
                    [7] = loop
                }
                
                remote:FireServer(unpack(args))
                remote:FireServer("playSound", randomName)
                
                NotificationLibrary:SendNotification("Success", "Playing sound: " .. soundId, config.NotificationDuration)
                PlayLocalSound("156785206") -- Success sound
            end)
            
            if not success then
                isRemoteConnected = false
                statusLabel.Text = "Status: DISCONNECTED"
                statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                NotificationLibrary:SendNotification("Error", "Lost connection to remote", config.NotificationDuration)
                PlayLocalSound("9046949339") -- Error sound
            end
        else
            NotificationLibrary:SendNotification("Error", "Not connected to remote", config.NotificationDuration)
            PlayLocalSound("9046949339") -- Error sound
        end
    end

    local function StopSound()
        if isRemoteConnected and IsRemoteValid(remote) then
            local success, err = pcall(function()
                remote:FireServer("stopSound", randomName)
                NotificationLibrary:SendNotification("Info", "Sound stopped", config.NotificationDuration)
                PlayLocalSound("243152215") -- Stop sound
            end)
            
            if not success then
                isRemoteConnected = false
                statusLabel.Text = "Status: DISCONNECTED"
                statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            end
        else
            NotificationLibrary:SendNotification("Error", "Not connected to remote", config.NotificationDuration)
            PlayLocalSound("9046949339") -- Error sound
        end
    end

    local function ToggleLoop()
        local newState = loopButton.Text == "ON" and "OFF" or "ON"
        loopButton.Text = newState
        loopButton.TextColor3 = newState == "ON" and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        PlayLocalSound("145487017") -- Click sound
    end

    -- Bağlantılar
    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
        PlayLocalSound("243152215") -- Close sound
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        ToggleMinimize()
        PlayLocalSound("145487017") -- Click sound
    end)

    playButton.MouseButton1Click:Connect(PlaySound)
    stopButton.MouseButton1Click:Connect(StopSound)
    loopButton.MouseButton1Click:Connect(ToggleLoop)

    -- Başlangıç bildirimi
    if isRemoteConnected then
        PlayLocalSound("2084290015") -- Success sound
        NotificationLibrary:SendNotification("Success", "Connected to AC6 remote", config.NotificationDuration)
    else
        PlayLocalSound("9046949339") -- Error sound
        NotificationLibrary:SendNotification("Error", "Could not find AC6 remote", config.NotificationDuration)
    end

    return gui
end

-- UI oluştur
if isRemoteConnected or not isRemoteConnected then -- Hata ayıklama için her durumda UI göster
    CreateUI()
end

-- Oyun çıkışında temizlik
game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player and isRemoteConnected and IsRemoteValid(remote) then
        pcall(function()
            remote:FireServer("stopSound", randomName)
        end)
    end
end)