if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 8260276694 then
	game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Error!",
    Text = "Script was intended to be loaded in ability wars, script aborted.",
    Duration = 5
})
    return
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local executorName = identifyexecutor()
local PUNCHAURARANGE = 3 -- default

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Thanks for using the script",
    Text = "Made by water.5202",
    Duration = 5
})

local Window = OrionLib:MakeWindow({
    Name = "AbilityWars - " ..executorName,
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
	Name = "Blatant Stuff"
})
--
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Ability Wars",
    Text = "Loading script be patient!",
    Duration = 5
})
--
local PunchesLabel = Tab:AddLabel("Punches:")
local PlayersLabel = Tab:AddLabel("Players: ?/18")
local AbilityLabel = Tab:AddLabel("Ability:")
local HealthLabel = Tab:AddLabel("Health:")
local ServerAgeLabel = Tab:AddLabel("PlaceHolder")

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
					local player = game.Players.LocalPlayer

					local punches = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Punches")
					local ability = player.leaderstats and player.leaderstats:FindFirstChild("Ability")
					local serverage = game:GetService("Players").LocalPlayer.PlayerGui.Settings.Main.Age.Text
							
					local punchesVal = punches and punches.Value or "N/A"
					local abilityVal = ability and ability.Value or "N/A"

					local healthText = "Health: N/A"
					local character = player.Character
					if character then
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						if humanoid then
							healthText = "Health: " .. math.floor(humanoid.Health) .. "/100"
						end
					end

					PunchesLabel:Set("Punches: " .. punchesVal)
					PlayersLabel:Set("Players: " .. players .. "/18")
					AbilityLabel:Set("Ability: " .. abilityVal)
					ServerAgeLabel:Set(serverage)
					HealthLabel:Set(healthText)

					task.wait(0.4)
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

Tab:AddSlider({
	Name = "PunchAuraRange",
	Min = 0,
	Max = 15,
	Default = 3,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(thevlaue)
PUNCHAURARANGE = thevlaue
	end    
})

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
								PUNCHAURARANGE, -- distance??
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

        local function waitForChildWithTimeout(parent, childName, timeout)
            local timer = 0
            local interval = 0.1
            while not parent:FindFirstChild(childName) and timer < timeout do
                task.wait(interval)
                timer = timer + interval
            end
            return parent:FindFirstChild(childName)
        end

        -- Run this in a coroutine so it can loop independently
        task.spawn(function()
            while autoattackbossesstate do
                local cat = workspace:FindFirstChild("Cat")
                local treeLord = workspace:FindFirstChild("Tree Lord")

                -- Try to attack Cat if it's available
                if cat then
                    local catHRP = cat:FindFirstChild("HumanoidRootPart")
                    if catHRP then
                        local args1 = {
                            314159265359,
                            cat,
                            Vector3.new(-11.640410423278809, 7.153537273406982, -17.10407829284668),
                            100,
                            catHRP
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Remote Events"):WaitForChild("Punch"):FireServer(unpack(args1))
                    end
                end

                -- Try to attack Tree Lord if it's available
                if treeLord then
                    local treeLordRightLeg = treeLord:FindFirstChild("Right Leg")
                    if treeLordRightLeg then
                        local args2 = {
                            314159265359,
                            treeLord,
                            Vector3.new(0.21670854091644287, 7.1301350593566895, 3.293504238128662),
                            100,
                            treeLordRightLeg
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Remote Events"):WaitForChild("Punch"):FireServer(unpack(args2))
                    end
                end

                task.wait()
            end
        end)
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
	Name = "Get Kick ability",
	Callback = function()
local cd = workspace["Shop Items"]["Gain Kick"].ClickDetector
fireclickdetector(cd)
  	end    
})


local Section = Tab:AddSection({
	Name = "badges"
})

-- -19.3448524, 20.9534607, 113.651253, 0.99984771
Tab:AddButton({
    Name = "Teleport to Brewing Place",
    Callback = function()
        local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(-19.3448524, 20.9534607, 113.651253)
			end
    end
})
--
Tab:AddButton({
    Name = "Teleport to Portal Mastery Area ",
    Callback = function()
        local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(990.469788, 65.876236, 29967.1836)
			end
    end
})
--
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
	    workspace["Map Items"].Pizza["Pizza Hitbox"],
        }

        for _, item in ipairs(items) do
            firetouchinterest(hrp, item, 0)
            firetouchinterest(hrp, item, 1)
            wait(0.1)
        end
    end    
})

Tab:AddButton({
	Name = "Teleport for mushroom badge",
	Callback = function()
		local teleportPosition = Vector3.new(140.185455, 7.77817154, -143.69104) -- fuckass game changes it now and then so like this is somewhat pointless
		local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

		if hrp then
			local currentpos = hrp.CFrame
			hrp.CFrame = CFrame.new(teleportPosition)
			wait(0.7)
			hrp.CFrame = currentpos
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
