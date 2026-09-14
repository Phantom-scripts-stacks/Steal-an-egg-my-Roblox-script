-- ========================================================
-- [ LATINA HUB - OPTIMIZED & BIGGER INTRO ]
-- ========================================================

local CUSTOM_IMAGE_ID = "rbxassetid://100104680190424"

-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- [ 3.5 SECONDS EXACT BIGGER INTRO ANIMATION ]
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
        IntroImage.Position = UDim2.new(0.5, 0, 0.5, 0)
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
        
        -- Gi-padako ang size ngadto sa 380x380 (mas dako na kaayo)
        local introTween = TweenService:Create(IntroImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 380, 0, 380),
            ImageTransparency = 0
        })
        introTween:Play()
        
        -- Exact 3.5 seconds delay before fade out
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

-- Load the UI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ EXECUTION SOUND EFFECT ]
task.spawn(function()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://4590657391"
        sound.Volume = 2
        sound.Parent = CoreGui
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end)

-- Create the Main Window
local Window = WindUI:CreateWindow({
    Title = "LATINA HUB",
    Icon = "shield",
    Author = "UNKNOWN",
    Folder = "LATINAHub",
    Size = UDim2.fromOffset(500, 360),
    Theme = "Dark",
    Acrylic = false
})

Window:ToggleTransparency(false)

-- ========================================================
-- [ FLOATING CIRCLE BUTTON (SYNCED WITH WINDOW CLOSE) ]
-- ========================================================
local ScreenGui, CircleFrame
pcall(function()
    if CoreGui:FindFirstChild("LATINA_FloatingCircle") then
        CoreGui.LATINA_FloatingCircle:Destroy()
    end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LATINA_FloatingCircle"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    CircleFrame = Instance.new("Frame")
    CircleFrame.Name = "ToggleCircle"
    CircleFrame.Parent = ScreenGui
    CircleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CircleFrame.BorderSizePixel = 0
    CircleFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
    CircleFrame.Size = UDim2.new(0, 55, 0, 55)
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(1, 0)
    FrameCorner.Parent = CircleFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = CircleFrame
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Thickness = 3
    
    -- Optimized Glowing Border Loop
    task.spawn(function()
        while CircleFrame and CircleFrame.Parent do
            TweenService:Create(UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(255, 100, 100)}):Play()
            task.wait(0.8)
            if not CircleFrame or not CircleFrame.Parent then break end
            TweenService:Create(UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(200, 0, 0)}):Play()
            task.wait(0.8)
        end
    end)
    
    local IsagiImage = Instance.new("ImageLabel")
    IsagiImage.Parent = CircleFrame
    IsagiImage.BackgroundTransparency = 1
    IsagiImage.Size = UDim2.new(1, -6, 1, -6)
    IsagiImage.Position = UDim2.new(0, 3, 0, 3)
    IsagiImage.Image = CUSTOM_IMAGE_ID
    
    local ImageCorner = Instance.new("UICorner")
    ImageCorner.CornerRadius = UDim.new(1, 0)
    ImageCorner.Parent = IsagiImage
    
    local ClickButton = Instance.new("TextButton")
    ClickButton.Parent = CircleFrame
    ClickButton.BackgroundTransparency = 1
    ClickButton.Size = UDim2.new(1, 0, 1, 0)
    ClickButton.Text = ""
    
    local isOpen = true
    
    -- Function to Toggle UI and Icon state accurately
    local function ToggleUI(state)
        isOpen = state
        Window:Toggle(isOpen)
        if ScreenGui then
            ScreenGui.Enabled = isOpen
        end
    end
    
    ClickButton.MouseButton1Click:Connect(function()
        ToggleUI(not isOpen)
        
        -- Animation feedback
        TweenService:Create(CircleFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 48, 0, 48)}):Play()
        task.wait(0.1)
        if CircleFrame then
            TweenService:Create(CircleFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 55, 0, 55)}):Play()
        end
    end)
    
    -- Smooth Mobile Dragging Support
    local dragging, dragStart, startPos
    ClickButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = CircleFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            CircleFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)

-- ========================================================
-- [ MAIN TAB: STEAL AN EGG (KEYLESS & KEY SYSTEM SEPARATED) ]
-- ========================================================
local MainTab = Window:Tab({
    Title = "Steal an Egg",
    Icon = "home"
})

MainTab:Paragraph({
    Title = "Steal an Egg Hub",
    Content = "Select scripts from Keyless or Key System categories below."
})

-- KEYLESS SECTION
MainTab:Paragraph({
    Title = "🔓 Keyless Scripts",
    Content = "Direct execution scripts (No Key required)."
})

MainTab:Button({
    Title = "Keyless Script Slot 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your keyless script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Keyless Script Slot 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your keyless script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Keyless Script Slot 3",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your keyless script here)"))()
        end)
    end
})

-- KEY SYSTEM SECTION
MainTab:Paragraph({
    Title = "🔑 Key System Scripts",
    Content = "Scripts that require a secure verification key."
})

MainTab:Button({
    Title = "Key System Script Slot 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your key system script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Key System Script Slot 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your key system script here)"))()
        end)
    end
})

-- ========================================================
-- [ UTILITIES TAB: FPS BOOSTER, SERVER FINDER, ANTI AFK ]
-- ========================================================
local UtilsTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench"
})

UtilsTab:Paragraph({
    Title = "Performance & Tools",
    Content = "Optimize your game performance and server utilities."
})

UtilsTab:Button({
    Title = "⚡ FPS Booster / Optimizer",
    Callback = function()
        pcall(function()
            local Terrain = workspace:FindFirstChildOfClass("Terrain")
            if Terrain then
                Terrain.WaterTransparency = 1
                Terrain.WaterWaveSize = 0
            end
            
            for _, v in ipairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.CastShadow = false
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
                    v.Enabled = false
                end
            end
            
            UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualityLevel.Level1
            
            WindUI:Notify({
                Title = "FPS Booster",
                Content = "Game optimized successfully for maximum FPS!",
                Duration = 3
            })
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
    Title = "Anti AFK",
    Callback = function()
        pcall(function()
            local vu = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
            WindUI:Notify({
                Title = "Anti AFK",
                Content = "Anti AFK is now Active!",
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

DiscordTab:Paragraph({
    Title = "Community Discord",
    Content = "Join our Discord server for updates, scripts, and support!"
})

DiscordTab:Button({
    Title = "Copy Discord Invite Link",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/yourinvite")
            WindUI:Notify({
                Title = "Discord",
                Content = "Discord invite link copied to clipboard!",
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
    Content = "Hub Name: LATINA HUB\nOwner / Creator: UNKNOWN\nStatus: 100x Optimized & Secure"
})

-- Final Success Notification
WindUI:Notify({
    Title = "LATINA HUB",
    Content = "Successfully loaded with Bigger Intro & FPS Booster!",
    Duration = 3
})
