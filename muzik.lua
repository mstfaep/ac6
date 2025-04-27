local ScreenGui = Instance.new("ScreenGui")
local TextButton = Instance.new("TextButton")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local UICorner = Instance.new("UICorner")
local TextBox_2 = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

-- Properties

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

TextButton.Parent = ScreenGui
TextButton.BackgroundColor3 = Color3.new(0.152941, 0.152941, 0.152941)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.141853735, 0, 0.113053881, 0)
TextButton.Size = UDim2.new(0, 454, 0, 50)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "1925TEAM tarafından yapılmıştır"
TextButton.TextColor3 = Color3.new(1, 0, 0)
TextButton.TextSize = 40

Frame.Parent = TextButton
Frame.BackgroundColor3 = Color3.new(0.152941, 0.152941, 0.152941)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(-0.000721666787, 0, 0.999999702, 0)
Frame.Size = UDim2.new(0, 454, 0, 190)

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
TextBox.BorderColor3 = Color3.new(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.744273186, 0, 0.0581817627, 0)
TextBox.Size = UDim2.new(0, 109, 0, 50)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Oyundaki Açıkları Ara"
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(255, 255, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14
TextBox.TextWrapped = true

UICorner.Parent = TextBox

TextBox_2.Parent = Frame
TextBox_2.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
TextBox_2.BorderColor3 = Color3.new(0, 0, 0)
TextBox_2.BorderSizePixel = 0
TextBox_2.Position = UDim2.new(0.742070556, 0, 0.691196024, 0)
TextBox_2.Size = UDim2.new(0, 109, 0, 46)
TextBox_2.ClearTextOnFocus = false
TextBox_2.Font = Enum.Font.SourceSans
TextBox_2.Text = "https://discord.gg/SyYE6hsauF"
TextBox_2.TextColor3 = Color3.new(255, 0, 0)
TextBox_2.TextScaled = true
TextBox_2.TextSize = 74
TextBox_2.TextWrapped = true

UICorner_2.Parent = TextBox_2

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
ScrollingFrame.BorderColor3 = Color3.new(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(-0.000721666787, 0, 0.0390370004, 0)
ScrollingFrame.Size = UDim2.new(0, 328, 0, 181)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
ScrollingFrame.ScrollBarThickness = 0

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)

Frame_2.Parent = TextButton
Frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
Frame_2.BorderColor3 = Color3.new(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.0132158594, 0, 0.849999666, 0)
Frame_2.Size = UDim2.new(0, 441, 0, 7)

TextLabel.Parent = TextButton
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.724108875, 0, 2.24000025, 0)
TextLabel.Size = UDim2.new(0, 126, 0, 70)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Discord Sunucusuna katıldığından emin ol: "
TextLabel.TextColor3 = Color3.new(135, 206, 235)
TextLabel.TextScaled = true
TextLabel.TextSize = 34
TextLabel.TextWrapped = true

-- Scripts

local function XERU_fake_script() -- TextBox.LocalScript 
	local script = Instance.new('LocalScript', TextBox)

	local textBox = script.Parent
	local buttonsContainer = script.Parent.Parent.ScrollingFrame
	
	local function filterButtons(searchText)
	    for _, button in pairs(buttonsContainer:GetChildren()) do
	        if button:IsA("TextButton") then
	            if searchText == "" or button.Text:lower():find(searchText:lower()) then
	                button.Visible = true  
	            else
	                button.Visible = false  
	            end
	        end
	    end
	end
	
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
	    filterButtons(textBox.Text) 
	end)
	
end
coroutine.wrap(XERU_fake_script)()
local function UCFYWLV_fake_script() -- ScrollingFrame.LocalScript 
	local script = Instance.new('LocalScript', ScrollingFrame)

	local buttonSize = UDim2.new(0, 328, 0, 42)
	
	local function createButtonForRemote(remoteName)
	    local button = Instance.new("TextButton")
	    button.Size = buttonSize
	    button.Text = remoteName
	    button.Parent = script.Parent
	    button.TextColor3 = Color3.new(1, 1, 1)
	    button.BackgroundColor3 = Color3.new(0.231373, 0.231373, 0.231373)
	    button.Position = UDim2.new(0, 0, 0, (#script.Parent:GetChildren() - 1) * (buttonSize.Y.Offset + 5))
	
	    button.MouseButton1Click:Connect(function()
	
	        local remote = game:FindFirstChild(remoteName, true)
	        if remote and remote:IsA("RemoteEvent") then
	            remote:FireServer()
	        else
	            warn("RemoteEvent not found:", remoteName)
	        end
	    end)
	end
	
	local function searchRemoteEventsInAllParents(parent)
	    for _, obj in pairs(parent:GetChildren()) do
	        if obj:IsA("RemoteEvent") then
	            createButtonForRemote(obj.Name)  
	        end
	        searchRemoteEventsInAllParents(obj)  
	    end
	end
	
	searchRemoteEventsInAllParents(game)
	
end
coroutine.wrap(UCFYWLV_fake_script)()
local function ZUGGRX_fake_script() -- TextButton.Drag 
	local script = Instance.new('LocalScript', TextButton)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(ZUGGRX_fake_script)()
