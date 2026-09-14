-- ==========================================
-- [ MAMAAAA HUB - 2.5s INTRO & 10X ANIMATIONS ]
-- ==========================================

local CUSTOM_IMAGE_ID = "rbxassetid://114769678924669"

-- [ 2.5 SECONDS EXACT INTRO ANIMATION ]
task.spawn(function()
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local TweenService = game:GetService("TweenService")
        
        if CoreGui:FindFirstChild("MAMAAAA_IntroBanner") then
            CoreGui.MAMAAAA_IntroBanner:Destroy()
        end
        
        local IntroGui = Instance.new("ScreenGui")
        IntroGui.Name = "MAMAAAA_IntroBanner"
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
        
        -- Fade in backdrop and zoom in image
        TweenService:Create(Backdrop, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.5}):Play()
        
        local introTween = TweenService:Create(IntroImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 280),
            ImageTransparency = 0
        })
        introTween:Play()
        
        -- Exact 2.5 seconds total display time before fade out
        task.delay(2.5, function()
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
        sound.Parent = game:GetService("CoreGui")
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end)

-- Create the Main Window
local Window = WindUI:CreateWindow({
    Title = "MAMAAAA Hub",
    Icon = "shield",
    Author = "UNKNOWN",
    Folder = "MAMAAAAHub",
    Size = UDim2.fromOffset(500, 350),
    Theme = "Dark",
    Acrylic = false
})

Window:ToggleTransparency(false)

-- ==========================================
-- [ 10X GLOWING FLOATING CIRCLE BUTTON ]
-- ==========================================
pcall(function()
    local CoreGui = game:GetService("CoreGui")
    
    if CoreGui:FindFirstChild("MAMAAAA_FloatingCircle") then
        CoreGui.MAMAAAA_FloatingCircle:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MAMAAAA_FloatingCircle"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local CircleFrame = Instance.new("Frame")
    CircleFrame.Name = "ToggleCircle"
    CircleFrame.Parent = ScreenGui
    CircleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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
    
    task.spawn(function()
        while CircleFrame and CircleFrame.Parent do
            local TweenService = game:GetService("TweenService")
            TweenService:Create(UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(255, 100, 100)}):Play()
            task.wait(0.8)
            TweenService:Create(UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(200, 0, 0)}):Play()
            task.wait(0.8)
        end
    end)
    
    local IsagiImage = Instance.new("ImageLabel")
    IsagiImage.Parent = CircleFrame
    IsagiImage.BackgroundTransparency = 1
    IsagiImage.Size = UDim2.new(1, 0, 1, 0)
    IsagiImage.Image = CUSTOM_IMAGE_ID
    
    local ImageCorner = Instance.new("UICorner")
    ImageCorner.CornerRadius = UDim.new(1, 0)
    ImageCorner.Parent = IsagiImage
    
    local ClickButton = Instance.new("TextButton")
    ClickButton.Parent = CircleFrame
    ClickButton.BackgroundTransparency = 1
    ClickButton.Size = UDim2.new(1, 1, 1, 1)
    ClickButton.Text = ""
    
    local isOpen = true
    
    ClickButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Window:Toggle(isOpen)
        local TweenService = game:GetService("TweenService")
        TweenService:Create(CircleFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 48, 0, 48)}):Play()
        task.wait(0.1)
        TweenService:Create(CircleFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    end)
    
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
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            CircleFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)

-- ==========================================
-- [ MAIN TAB: STEAL AN EGG SCRIPTS ]
-- ==========================================
local MainTab = Window:Tab({
    Title = "Steal an Egg",
    Icon = "home"
})

MainTab:Button({
    Title = "Safe Script Slot 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your clean script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Safe Script Slot 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your clean script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Safe Script Slot 3",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your clean script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Safe Script Slot 4",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Safe Script Slot 5",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

-- ==========================================
-- [ UTILITIES TAB: SERVER FINDER & ANTI AFK ]
-- ==========================================
local UtilsTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench"
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
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
            WindUI:Notify({ Title = "Anti AFK", Content = "Anti AFK is now Active!", Duration = 3 })
        end)
    end
})

-- ==========================================
-- [ DISCORD TAB ]
-- ==========================================
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

-- ==========================================
-- [ OWNER TAB: CREDITS ]
-- ==========================================
local OwnerTab = Window:Tab({
    Title = "Owner",
    Icon = "user"
})

OwnerTab:Paragraph({
    Title = "Hub Information",
    Content = "Hub Name: MAMAAAA Hub\nOwner / Creator: UNKNOWN\nStatus: Secure & Clean"
})

WindUI:Notify({
    Title = "MAMAAAA Hub",
    Content = "Loaded with 2.5s Intro duration!",
    Duration = 3
})
