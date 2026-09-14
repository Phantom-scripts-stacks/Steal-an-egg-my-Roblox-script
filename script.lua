-- ========================================================
-- [ LATINA HUB - STABLE EXECUTION VERSION ]
-- ========================================================

local CUSTOM_IMAGE_ID = "rbxassetid://100104680190424"

-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

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
            Size = UDim2.new(0, 360, 0, 360),
            ImageTransparency = 0
        })
        introTween:Play()
        
        task.delay(3.5, function()
            local outTween = TweenService:Create(IntroImage, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                ImageTransparency = 1
            })
            local fadeBackdrop = TweenService:Create(Backdrop, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
            
            outTween:Play()
            fadeBackdrop:Play()
            
            outTween.Completed:Connect(function()
                IntroGui:Destroy()
            end)
        end)
    end)
end)

-- [ 2. STABLE UI LIBRARY LOADER ]
local WindUI do
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if success and result then
        WindUI = result
    else
        -- Fallback kung naay block sa raw link
        WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
    end
end

-- [ 3. AUDIO PLAYBACK ]
task.spawn(function()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://70687053615562"
        sound.Volume = 5
        sound.Parent = workspace
        SoundService:PlayLocalSound(sound)
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end)

-- [ 4. MAIN WINDOW ]
local Window = WindUI:CreateWindow({
    Title = "LATINA HUB",
    Icon = "circle",
    Author = "UNKNOWN",
    Folder = "LATINAHub",
    Size = UDim2.fromOffset(500, 360),
    Theme = "Dark",
    Acrylic = false
})

Window:ToggleTransparency(false)

-- [ 5. FLOATING TOGGLE BUTTON ]
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
        ToggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
        ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
        ToggleBtn.Image = CUSTOM_IMAGE_ID
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        ToggleBtn.Active = true

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(1, 0)
        Corner.Parent = ToggleBtn

        local Stroke = Instance.new("UIStroke")
        Stroke.Parent = ToggleBtn
        Stroke.Color = Color3.fromRGB(255, 0, 0)
        Stroke.Thickness = 3

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
            Window:Toggle()
        end)
    end)
end)

-- ========================================================
-- [ MAIN TAB: STEAL AN EGG ]
-- ========================================================
local MainTab = Window:Tab({
    Title = "Steal an Egg",
    Icon = "circle"
})

local KeylessSection = MainTab:Section({
    Title = "🔓 Keyless Scripts (10 Slots)",
    Opened = false
})

for i = 1, 10 do
    KeylessSection:Button({
        Title = "Keyless Script Slot " .. i,
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("(put your keyless script " .. i .. " here)"))()
            end)
        end
    })
end

local KeySystemSection = MainTab:Section({
    Title = "🔑 Key System Scripts (10 Slots)",
    Opened = false
})

for i = 1, 10 do
    KeySystemSection:Button({
        Title = "Key System Script Slot " .. i,
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("(put your key system script " .. i .. " here)"))()
            end)
        end
    })
end

-- ========================================================
-- [ UTILITIES TAB ]
-- ========================================================
local UtilsTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench"
})

local fpsConnection = nil
UtilsTab:Button({
    Title = "📊 Toggle FPS/MS Counter",
    Callback = function()
        pcall(function()
            if CoreGui:FindFirstChild("LATINA_FPS_MS") then
                if fpsConnection then fpsConnection:Disconnect() end
                CoreGui.LATINA_FPS_MS:Destroy()
                WindUI:Notify({
                    Title = "HUD Display",
                    Content = "FPS & MS Counter hidden.",
                    Duration = 2
                })
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
                
                local dragging, dragInput, dragStart, startPos
                StatsFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        dragStart = input.Position
                        startPos = StatsFrame.Position
                        
                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                            end
                        end)
                    end
                end)
                
                StatsFrame.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        dragInput = input
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input == dragInput and dragging then
                        local delta = input.Position - dragStart
                        StatsFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                    end
                end)
                
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
                
                WindUI:Notify({
                    Title = "HUD Display",
                    Content = "Live FPS & MS counter active.",
                    Duration = 2
                })
            end
        end)
    end
})

UtilsTab:Button({
    Title = "Server Finder",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Low-Server-Finder-GUI-30660"))()
        end)
    end
})

UtilsTab:Button({
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
            
            WindUI:Notify({
                Title = "Anti AFK",
                Content = "Safe Anti-AFK Enabled!",
                Duration = 3
            })
        end)
    end
})

-- ========================================================
-- [ DISCORD TAB ]
-- ========================================================
local DiscordTab = Window:Tab({
    Title = "Discord",
    Icon = "message-square"
})

DiscordTab:Button({
    Title = "Copy Discord Invite Link",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/yourinvite")
            WindUI:Notify({
                Title = "Discord",
                Content = "Discord invite link copied!",
                Duration = 3
            })
        end)
    end
})

-- ========================================================
-- [ OWNER TAB ]
-- ========================================================
local OwnerTab = Window:Tab({
    Title = "Owner",
    Icon = "user"
})

OwnerTab:Paragraph({
    Title = "Hub Information",
    Content = "Hub Name: LATINA HUB\nOwner / Creator: UNKNOWN"
})

WindUI:Notify({
    Title = "LATINA HUB",
    Content = "Loaded successfully!",
    Duration = 3
})
