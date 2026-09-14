-- ========================================================
-- [ LATINA HUB - FIXED & UPDATED FLUENT UI ]
-- ========================================================

local CUSTOM_IMAGE_ID = "rbxassetid://100104680190424"

-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [ 1. INTRO BANNER ]
task.spawn(function()
    pcall(function()
        if CoreGui:FindFirstChild("LATINA_IntroBanner") then
            CoreGui.LATINA_IntroBanner:Destroy()
        end
        
        local IntroGui = Instance.new("ScreenGui")
        IntroGui.Name = "LATINA_IntroBanner"
        IntroGui.Parent = CoreGui
        IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        local Backdrop = Instance.new("Frame")
        Backdrop.Parent = IntroGui
        Backdrop.Size = UDim2.new(1, 0, 1, 0)
        Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Backdrop.BackgroundTransparency = 1
        
        local IntroImage = Instance.new("ImageLabel")
        IntroImage.Parent = IntroGui
        IntroImage.AnchorPoint = Vector2.new(0.5, 0.5)
        IntroImage.Position = UDim2.new(0.5, 0, 0.43, 0)
        IntroImage.Size = UDim2.new(0, 0, 0, 0)
        IntroImage.BackgroundTransparency = 1
        IntroImage.Image = CUSTOM_IMAGE_ID
        IntroImage.ImageTransparency = 1
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.15, 0)
        UICorner.Parent = IntroImage
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = IntroImage
        UIStroke.Color = Color3.fromRGB(255, 50, 50)
        UIStroke.Thickness = 4
        
        TweenService:Create(Backdrop, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.5}):Play()
        
        local introTween = TweenService:Create(IntroImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 300, 0, 300),
            ImageTransparency = 0
        })
        introTween:Play()
        
        task.delay(3, function()
            local outTween = TweenService:Create(IntroImage, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                ImageTransparency = 1
            })
            local fadeBackdrop = TweenService:Create(Backdrop, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
            
            outTween:Play()
            fadeBackdrop:Play()
            
            outTween.Completed:Connect(function()
                IntroGui:Destroy()
            end)
        end)
    end)
end)

-- [ 2. LOAD FLUENT UI LIBRARY ]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [ 3. AUDIO PLAYBACK ]
task.spawn(function()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://70687053615562"
        sound.Volume = 4
        sound.Parent = workspace
        SoundService:PlayLocalSound(sound)
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end)

-- [ 4. CREATE WINDOW ]
local Window = Fluent:CreateWindow({
    Title = "LATINA HUB",
    SubTitle = "by UNKNOWN",
    TabWidth = 130,
    Size = UDim2.fromOffset(480, 340),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [ 5. TABS SETUP ]
local Tabs = {
    Main = Window:AddTab({ Title = "Steal an Egg", Icon = "target" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Utilities = Window:AddTab({ Title = "Utilities", Icon = "tool" }),
    Discord = Window:AddTab({ Title = "Discord", Icon = "message-square" }),
    Owner = Window:AddTab({ Title = "Owner", Icon = "user" })
}

-- ========================================================
-- [ MAIN TAB: STEAL AN EGG (SLOTS) ]
-- ========================================================
Tabs.Main:AddParagraph({
    Title = "🔓 Keyless Scripts (10 Slots)",
    Content = "Click slot button below to execute."
})

for i = 1, 10 do
    Tabs.Main:AddButton({
        Title = "Keyless Script Slot " .. i,
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("(put your keyless script " .. i .. " here)"))()
            end)
        end
    })
end

Tabs.Main:AddParagraph({
    Title = "🔑 Key System Scripts (10 Slots)",
    Content = "Click slot button below to execute."
})

for i = 1, 10 do
    Tabs.Main:AddButton({
        Title = "Key System Script Slot " .. i,
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("(put your key system script " .. i .. " here)"))()
            end)
        end
    })
end

-- ========================================================
-- [ VISUALS TAB ]
-- ========================================================

-- FOV Slider
local FovSlider = Tabs.Visuals:AddSlider("FOV的书", {
    Title = "🔍 Custom Field of View (FOV)",
    Description = "Adjust camera field of view",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        pcall(function()
            Camera.FieldOfView = Value
        end)
    end
})

-- Reset FOV Button
Tabs.Visuals:AddButton({
    Title = "🔄 Reset FOV (70)",
    Description = "Restore default camera field of view.",
    Callback = function()
        pcall(function()
            Camera.FieldOfView = 70
            FovSlider:SetValue(70)
            Fluent:Notify({ Title = "Visuals", Content = "FOV reset to default (70).", Duration = 2 })
        end)
    end
})

-- Fullbright Button
Tabs.Visuals:AddButton({
    Title = "💡 Toggle Fullbright",
    Description = "Removes all darkness in the world.",
    Callback = function()
        pcall(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Fluent:Notify({ Title = "Visuals", Content = "Fullbright Enabled!", Duration = 2 })
        end)
    end
})

-- ESP to World Eggs (Map Eggs ESP)
Tabs.Visuals:AddButton({
    Title = "🥚 ESP to World Eggs",
    Description = "Highlight eggs spawned around the world map.",
    Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (string.lower(obj.Name):find("egg")) then
                    if not obj:FindFirstChild("EggHighlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "EggHighlight"
                        hl.FillColor = Color3.fromRGB(255, 165, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = obj
                        count = count + 1
                    else
                        obj.EggHighlight:Destroy()
                    end
                end
            end
            Fluent:Notify({ Title = "Egg ESP", Content = "Toggled World Eggs ESP (" .. count .. " found)", Duration = 3 })
        end)
    end
})

-- ESP to Placed Eggs (Eggs on Plot)
Tabs.Visuals:AddButton({
    Title = "🏠 ESP to Placed Eggs (On Plot)",
    Description = "Highlight eggs placed inside plots/bases.",
    Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and (string.lower(obj.Name):find("egg") or string.lower(obj.Name):find("placed")) then
                    if not obj:FindFirstChild("PlotEggHighlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "PlotEggHighlight"
                        hl.FillColor = Color3.fromRGB(0, 255, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = obj
                        count = count + 1
                    else
                        obj.PlotEggHighlight:Destroy()
                    end
                end
            end
            Fluent:Notify({ Title = "Plot Eggs ESP", Content = "Toggled Plot Eggs ESP (" .. count .. " found)", Duration = 3 })
        end)
    end
})

-- ========================================================
-- [ UTILITIES TAB ]
-- ========================================================
local fpsConnection = nil
Tabs.Utilities:AddButton({
    Title = "📊 Toggle FPS/MS Counter",
    Callback = function()
        pcall(function()
            if CoreGui:FindFirstChild("LATINA_FPS_MS") then
                if fpsConnection then fpsConnection:Disconnect() end
                CoreGui.LATINA_FPS_MS:Destroy()
                Fluent:Notify({ Title = "HUD Display", Content = "Counter hidden.", Duration = 2 })
            else
                local StatsGui = Instance.new("ScreenGui")
                StatsGui.Name = "LATINA_FPS_MS"
                StatsGui.Parent = CoreGui
                StatsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                
                local StatsFrame = Instance.new("Frame")
                StatsFrame.Parent = StatsGui
                StatsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                StatsFrame.BorderSizePixel = 0
                StatsFrame.Position = UDim2.new(0.02, 0, 0.05, 0)
                StatsFrame.Size = UDim2.new(0, 160, 0, 40)
                StatsFrame.Active = true
                
                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0.2, 0)
                Corner.Parent = StatsFrame
                
                local Stroke = Instance.new("UIStroke")
                Stroke.Parent = StatsFrame
                Stroke.Color = Color3.fromRGB(255, 50, 50)
                Stroke.Thickness = 2
                
                local StatsText = Instance.new("TextLabel")
                StatsText.Name = "StatsLabel"
                StatsText.Parent = StatsFrame
                StatsText.BackgroundTransparency = 1
                StatsText.Size = UDim2.new(1, 0, 1, 0)
                StatsText.Font = Enum.Font.GothamBold
                StatsText.TextColor3 = Color3.fromRGB(255, 255, 255)
                StatsText.TextSize = 13
                StatsText.Text = "FPS: 0 | MS: 0ms"
                
                local lastUpdate = tick()
                local frameCount = 0
                
                fpsConnection = RunService.RenderStepped:Connect(function()
                    frameCount = frameCount + 1
                    local now = tick()
                    if now - lastUpdate >= 1 then
                        local currentFPS = math.floor(frameCount / (now - lastUpdate))
                        frameCount = 0
                        lastUpdate = now
                        
                        local ping = 0
                        pcall(function()
                            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                        end)
                        
                        StatsText.Text = string.format("FPS: %d | MS: %dms", currentFPS, ping)
                    end
                end)
                
                Fluent:Notify({ Title = "HUD Display", Content = "Counter active.", Duration = 2 })
            end
        end)
    end
})

Tabs.Utilities:AddButton({
    Title = "🔄 Rejoin Server",
    Callback = function()
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end
})

Tabs.Utilities:AddButton({
    Title = "🌐 Low Server Finder",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Low-Server-Finder-GUI-30660"))()
        end)
    end
})

Tabs.Utilities:AddButton({
    Title = "🛡️ Safe Anti AFK",
    Callback = function()
        pcall(function()
            local GC = getconnections or get_connections
            if GC then
                for _, connection in pairs(GC(LocalPlayer.Idled)) do
                    if connection.Disable then
                        connection:Disable()
                    elseif connection.Disconnect then
                        connection:Disconnect()
                    end
                end
            else
                LocalPlayer.Idled:Connect(function() end)
            end
            Fluent:Notify({ Title = "Anti AFK", Content = "Safe Anti-AFK Enabled!", Duration = 3 })
        end)
    end
})

-- ========================================================
-- [ DISCORD TAB ]
-- ========================================================
Tabs.Discord:AddButton({
    Title = "Copy Discord Invite Link",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/yourinvite")
            Fluent:Notify({ Title = "Discord", Content = "Invite link copied!", Duration = 3 })
        end)
    end
})

-- ========================================================
-- [ OWNER TAB ]
-- ========================================================
Tabs.Owner:AddParagraph({
    Title = "Hub Information",
    Content = "Hub Name: LATINA HUB\nOwner / Creator: UNKNOWN\nFeatures: FOV Slider, Reset FOV, World Eggs ESP, Plot Eggs ESP"
})

-- [ 6. FLOATING TOGGLE BUTTON (CIRCLE IMAGE) ]
task.spawn(function()
    pcall(function()
        if CoreGui:FindFirstChild("LATINA_ToggleGui") then
            CoreGui.LATINA_ToggleGui:Destroy()
        end

        local ToggleGui = Instance.new("ScreenGui")
        ToggleGui.Name = "LATINA_ToggleGui"
        ToggleGui.Parent = CoreGui
        ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local ToggleBtn = Instance.new("ImageButton")
        ToggleBtn.Parent = ToggleGui
        ToggleBtn.Position = UDim2.new(0.02, 0, 0.35, 0)
        ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
        ToggleBtn.Image = CUSTOM_IMAGE_ID
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        ToggleBtn.Active = true

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(1, 0)
        Corner.Parent = ToggleBtn

        local Stroke = Instance.new("UIStroke")
        Stroke.Parent = ToggleBtn
        Stroke.Color = Color3.fromRGB(255, 0, 0)
        Stroke.Thickness = 2.5

        local dragging, dragInput, dragStart, startPos
        ToggleBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = ToggleBtn.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        ToggleBtn.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        ToggleBtn.MouseButton1Click:Connect(function()
            Window:Minimize()
        end)
    end)
end)

Fluent:Notify({
    Title = "LATINA HUB",
    Content = "Updated successfully with Egg ESP & Reset FOV!",
    Duration = 3
})
