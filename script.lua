-- ==========================================
-- [ MAMAAAA HUB - CUSTOM ISAGI & DISCORD UI ]
-- ==========================================

-- YOUR ISAGI IMAGE ASSET ID
local CUSTOM_IMAGE_ID = "rbxassetid://114769678924669"

-- [ EXECUTION INTRO IMAGE POPUP ANIMATION ]
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
        
        -- Pop-up Image Frame in the center of the screen
        local IntroImage = Instance.new("ImageLabel")
        IntroImage.Parent = IntroGui
        IntroImage.AnchorPoint = Vector2.new(0.5, 0.5)
        IntroImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        IntroImage.Size = UDim2.new(0, 0, 0, 0) -- Starts small for zoom-in effect
        IntroImage.BackgroundTransparency = 1
        IntroImage.Image = CUSTOM_IMAGE_ID
        
        -- Make the intro image rounded
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.1, 0)
        UICorner.Parent = IntroImage
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = IntroImage
        UIStroke.Color = Color3.fromRGB(255, 0, 0)
        UIStroke.Thickness = 3
        
        -- Zoom In Animation
        local zoomIn = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        TweenService:Create(IntroImage, zoomIn, {Size = UDim2.new(0, 250, 0, 250)}):Play()
        
        -- Hold, then Zoom Out and Destroy
        task.delay(2, function()
            local zoomOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local tweenOut = TweenService:Create(IntroImage, zoomOut, {Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1})
            tweenOut:Play()
            
            tweenOut.Completed:Connect(function()
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
-- [ CREATING THE FLOATING CIRCLE BUTTON WITH ISAGI ]
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
    
    local CircleButton = Instance.new("ImageButton")
    CircleButton.Name = "ToggleCircle"
    CircleButton.Parent = ScreenGui
    CircleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CircleButton.BorderSizePixel = 0
    CircleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    CircleButton.Size = UDim2.new(0, 50, 0, 50)
    CircleButton.Image = CUSTOM_IMAGE_ID -- Uses your Isagi image as the circle icon!
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0) -- Perfect Circle
    UICorner.Parent = CircleButton
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = CircleButton
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Thickness = 2
    
    local isOpen = true
    
    CircleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Window:Toggle(isOpen)
    end)
    
    local dragging, dragStart, startPos
    
    CircleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = CircleButton.Position
            
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
            CircleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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
            setclipboard("https://discord.gg/yourinvite") -- Ilisi lang ni sa imong saktong Discord link kung naa na
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
    Content = "Loaded successfully with Isagi & Discord!",
    Duration = 3
})
