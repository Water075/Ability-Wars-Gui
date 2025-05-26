local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "AbilityWarsFucker", HidePremium = false, SaveConfig = false, ConfigFolder = "wooow",IntroText = "loading sexy script :3"})

-- MAIN SHIT BRO
local Tab = Window:MakeTab({
	Name = "main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Blatant Stuff (Admins are somewhat active be careful)"
})

--
local PunchesLabel = Tab:AddLabel("Punches:")

local updating = false
Tab:AddToggle({
	Name = "UpdatePunches",
	Default = false,
	Callback = function(state)
		updating = state
		if updating then
			task.spawn(function()
				while updating do
					local punches = game:GetService("Players").LocalPlayer.leaderstats.Punches.Value
					PunchesLabel:Set("Punches: " .. punches)
					task.wait(1)
				end
			end)
		end
	end
})
-- toggle2 for auto entering arena
local autoEnter = false

Tab:AddToggle({
	Name = "AutoEnterArena",
	Default = false,
	Callback = function(state)
		autoEnter = state
		if autoEnter then
			task.spawn(function()
				while autoEnter do
					local player = game.Players.LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					local rootPart = character:WaitForChild("HumanoidRootPart")
					local portal = workspace:WaitForChild("Portals"):WaitForChild("Arena Frame"):WaitForChild("Portal")

					firetouchinterest(rootPart, portal, 0)
					task.wait(0.1)
					firetouchinterest(rootPart, portal, 1)
					task.wait(1)
				end
			end)
		end
	end
})
--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PunchEvent = ReplicatedStorage:WaitForChild("Remote Events"):WaitForChild("Punch")

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local args = {
            314159265359,
            player.Character,
            Vector3.new(126.53208923339844, 7.153537273406982, -28.148670196533203), -- Replace with relevant position
            2.064666748046875, -- Some hit power?
            player.Character["HumanoidRootPart"]
        }
        PunchEvent:FireServer(unpack(args))
    end
end

-- required
OrionLib:Init()
