for i, v in pairs(game:GetDescendants()) do
if v.ClassName == "RemoteEvent" and v.Name == "AC6_FE_Sounds" then
local remote = v
remote:FireServer("newSound", "", workspace, "rbxassetid://96044784019038", 1, 5000, true)
remote:FireServer("playSound", "")
end
end 