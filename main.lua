local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local executorName = identifyexecutor()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Thanks for using the script",
    Text = "Made by water.5202",
    Duration = 5 -- duration in seconds
})

local Window = OrionLib:MakeWindow({
    Name = "AbilityWarsFucker - " ..executorName,
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "wooow",
    IntroText = "loading sexy script :3"
})


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
local PlayersLabel = Tab:AddLabel("Players:")

local updating = false
Tab:AddToggle({
	Name = "UpdatePunches",
	Default = false,
	Callback = function(state)
		updating = state
		if updating then
			task.spawn(function()
				while updating do
					local players = game:GetService("Players"):GetPlayers()
					local punches = game:GetService("Players").LocalPlayer.leaderstats.Punches.Value
					PunchesLabel:Set("Punches: " .. punches)
					PlayersLabel:Set("Players: " .. players)
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
local psa = false

Tab:AddToggle({
	Name = "PunchAura",
	Default = false,
	Callback = function(punchara)
		psa = punchara
		if psa then
			task.spawn(function()
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local Players = game:GetService("Players")
				local LocalPlayer = Players.LocalPlayer
				local PunchEvent = ReplicatedStorage:WaitForChild("Remote Events"):WaitForChild("Punch")

				while psa do
					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
							local args = {
								314159265359,
								player.Character,
								player.Character.HumanoidRootPart.Position,
								2.064666748046875,
								player.Character.HumanoidRootPart
							}
							PunchEvent:FireServer(unpack(args))
						end
					end
					task.wait(0.5) -- small delay to prevent lag/kick
				end
			end)
		end
	end    
})
--
local Section = Tab:AddSection({
	Name = "Utility"
})

Tab:AddButton({
	Name = "Kick Yourself",
	Callback = function()
			local player = game.Players.LocalPlayer
			game:GetService("Players").LocalPlayer:Kick("Kicked "..player.Name)
  	end    
})

Tab:AddButton({
	Name = "IY",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  	end    
})

-- required
OrionLib:Init()
