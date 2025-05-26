local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local executorName = identifyexecutor()
-- values for slider
local psaslider = 1
--
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Thanks for using the script",
    Text = "Made by water.5202",
    Duration = 5
})

local Window = OrionLib:MakeWindow({
    Name = "AbilityWarsFucker - " ..executorName,
    IntroEnabled = false,
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "wooow",
    IntroText = "PlaceHolder"
})


-- MAIN SHIT BRO
local Tab = Window:MakeTab({
	Name = "main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Blatant Stuff (not arsed to show fps lmao)"
})

--
local PunchesLabel = Tab:AddLabel("Punches:")
local PlayersLabel = Tab:AddLabel("Players: ?/18")
local AbilityLabel = Tab:AddLabel("Ability:")
local PunchAuraRange = Tab:AddLabel("PunchRange:")

local updating = false
Tab:AddToggle({
	Name = "UpdateInfo",
	Default = true,
	Callback = function(state)
		updating = state
		if updating then
			task.spawn(function()
				while updating do
					local players = #game:GetService("Players"):GetPlayers()
					local punches = game:GetService("Players").LocalPlayer.leaderstats.Punches.Value
					local ability = game:GetService("Players").LocalPlayer.leaderstats.Ability.Value
					PunchesLabel:Set("Punches: " .. punches)
					PlayersLabel:Set("Players: " .. players .. "/18")
					AbilityLabel:Set("Ability: " .. ability)
					PunchAuraRange:Set("PunchRange " .. psaslider .. "/15")
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
								psaslider, -- distance??
								player.Character.HumanoidRootPart
							}
							PunchEvent:FireServer(unpack(args))
						end
					end
					task.wait(0.3) -- small delay to prevent lag/kick
				end
			end)
		end
	end    
})
--slider for range
Tab:AddSlider({
	Name = "RangeValue",
	Min = 1,
	Max = 20,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "range",
	Callback = function(rangeslider)
	local psaslider = rangeslider
	end    
})
--
Tab:AddToggle({
    Name = "AntiVoidToggle",
    Default = false,
    Callback = function(AntiVoid)
        local workspace = game:GetService("Workspace")
        local existingPart = workspace:FindFirstChild("AntiVoidPart")

        if AntiVoid then
            if not existingPart then
                local part = Instance.new("Part")
                part.Name = "AntiVoidPart"
                part.Parent = workspace
                part.Size = Vector3.new(1000, 1, 1000)
                part.Position = Vector3.new(3.31643677, 1.94888735, -15.8945923)
                part.Rotation = Vector3.new(0, 0, 0)
                part.Transparency = 0.5
                part.Anchored = true
                part.CanCollide = true
                part.Material = Enum.Material.SmoothPlastic
            end
        else
            if existingPart then
                existingPart:Destroy()
            end
        end
    end
})
--
local autoattackbossesstate = false

Tab:AddToggle({
    Name = "AutoAttackBosses",
    Default = false,
    Callback = function(AutoAttackBoss)
        autoattackbossesstate = AutoAttackBoss
        while autoattackbossesstate do
            local args = {
                314159265359,
                workspace:WaitForChild("Cat"),
                vector.create(-11.640410423278809, 7.153537273406982, -17.10407829284668),
                10,
                workspace:WaitForChild("Cat"):WaitForChild("HumanoidRootPart")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote Events"):WaitForChild("Punch"):FireServer(unpack(args))
            task.wait()
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
--
Tab:AddButton({
	Name = "Rejoin",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
  	end    
})

Tab:AddButton({
	Name = "Unload UI",
	Callback = function()
OrionLib:Destroy()
  	end    
})

Tab:AddButton({
	Name = "Reset",
	Callback = function()
game.Players.LocalPlayer.Character.Humanoid.Health = -1
  	end    
})
-- misc
local Tab = Window:MakeTab({
	Name = "misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Collect All Items",
    Callback = function()
        local workspace = game:GetService("Workspace")
        local players = game:GetService("Players")
        local localPlayer = players.LocalPlayer
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
			
        local items = {
            workspace["Map Items"].Burger,
            workspace["Map Items"].Cake,
            workspace["Map Items"].Crystal,
            workspace["Map Items"].Gel,
            workspace["Map Items"].Key,
            workspace["Map Items"].Web,
            workspace["Map Items"].Moss,
        }

        for _, item in ipairs(items) do
            firetouchinterest(hrp, item, 0)
            firetouchinterest(hrp, item, 1)
            wait(0.1)
        end
    end    
})


-- credits
local Tab = Window:MakeTab({
	Name = "credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("Made by water.5202")
Tab:AddLabel("Script Version 1.0.0")
Tab:AddLabel("Thanks for using this script :D")
Tab:AddLabel("Don't use slap aura in large groups because of ban")
-- required
OrionLib:Init()
