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

-- required
OrionLib:Init()
