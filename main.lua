

local toolModule = {}

function toolModule.help()
	print("createNewTool(Tool to add, Text for the tool, function to do when the player clicks while it is equipped")
end

function toolModule.createNewTool(Tool, Text, onClicked)
	

	
	local anim = Instance.new("Animation", game.Players.LocalPlayer.Character.Humanoid)
	anim.Name = "epicGamer"
	anim.AnimationId = "rbxassetid://9982427158"
	local lighterAnimLoaded = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
	-- few checks
	if Tool:IsA("Tool") then
		print("is tool")
		-- perfect! we can get started!
		local handle = Tool:FindFirstChild("Handle")
		if handle then
			Tool.Parent = game.Players.LocalPlayer.Backpack
				print("has handle")
			-- Weld everything
			handle.Anchored = false
			handle.CanCollide = false
			Tool.CanBeDropped = false
			for counter, part in pairs (Tool:GetDescendants()) do
				if part ~= handle and part:IsA("BasePart") then
					local Weld = Instance.new("WeldConstraint", part)
					Weld.Name = "ToolModuleWeld"
					Weld.Part0 = handle
					Weld.Part1 = part 
					part.Anchored = false
					part.CanCollide = false
				end
			end

			local debounce = false
			if Text ~= nil then
				for counter, item in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.Hotbar:GetChildren()) do
					if item:IsA("TextButton") then
						item.Tool:GetPropertyChangedSignal("Image"):Connect(function()
							-- we have our tool, change text
							if debounce == false then
								debounce = true
								local textLabel = Instance.new("TextLabel", item)
								textLabel.Size = UDim2.fromScale(1,1)
								textLabel.BackgroundTransparency = 1
								textLabel.Position = UDim2.new(0,0,0,0)
								textLabel.TextScaled = true 
								textLabel.TextColor3 = Color3.fromRGB(255,255,255)
								textLabel.Text = Text
							end
						end)
					end
				end
			end
			Tool.TextureId = math.random()
			

			if onClicked ~= nil then
				Tool.Activated:Connect(onClicked)
			end

			Tool.Equipped:Connect(function()
				lighterAnimLoaded:Play()
			end)
			Tool.Unequipped:Connect(function()
				lighterAnimLoaded:Stop()
			end)
			
		else
			-- Tool has no handle!
			error("TOOLMODULE -- Tool has no Handle part.")
		end
	else
		error("TOOLMODULE -- Tool Value is not a Tool! Make sure it is a tool")
	end

end

return toolModule
