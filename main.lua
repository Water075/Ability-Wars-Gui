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
local Slaps = Tab:AddLabel("Slaps:")
Tab:AddToggle({
	Name = "UpdateSlaps",
	Default = false,
	Callback = function(thecoolestvalue)
		while thecoolestvalue do
			Slaps.Text = "Slaps: " .. game:GetService("Players").LocalPlayer.leaderstats.Punches.Value
			task.wait(1) -- Add a short wait to prevent freezing the game
		end
	end    
})
--

-- required
OrionLib:Init()
