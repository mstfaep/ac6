for i, v in pairs(game:GetDescendants()) do
if v.ClassName == "RemoteEvent" and v.Name == "VehicleSoundsEvent" then
local remote = v
remote:FireServer("newSound", "", workspace, "rbxassetid://1839246711", 1, 5000, true)
remote:FireServer("playSound", "")
end
end 
