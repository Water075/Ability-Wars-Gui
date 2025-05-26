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
Tab:AddToggle({
	Name = "AutoEnterArena",
	Default = false,
	Callback = function(coolassenter)
		while coolassenter == true do
				local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local portal = workspace.Portals["Arena Frame"].Portal

firetouchinterest(rootPart, portal, 0)
task.wait(0.1)
firetouchinterest(rootPart, portal, 1)
			end
	end    
})

--[[
Name = <string> - The name of the toggle.
Default = <bool> - The default value of the toggle.
Callback = <function> - The function of the toggle.
]]
--

-- required
OrionLib:Init()
