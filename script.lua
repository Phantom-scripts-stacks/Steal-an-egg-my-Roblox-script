-- ==========================================
-- [ MAMAAAA HUB - SECURE FLOATING CIRCLE UI ]
-- ==========================================

-- Load the UI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ EXECUTION SOUND EFFECT (FIXED) ]
task.spawn(function()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://4590657391" -- Standard Roblox UI sound
        sound.Volume = 2 -- Increased volume so it's clearly heard
        sound.Parent = game:GetService("CoreGui")
        sound:Play()
        
        -- Automatically clean up the sound after it plays to prevent memory leaks
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
-- [ CREATING THE FLOATING CIRCLE BUTTON ]
-- ==========================================
pcall(function()
    local CoreGui = game:GetService("CoreGui")
    
    -- Remove old circle if it exists
    if CoreGui:FindFirstChild("MAMAAAA_FloatingCircle") then
        CoreGui.MAMAAAA_FloatingCircle:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MAMAAAA_FloatingCircle"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- The Floating Circle Button itself
    local CircleButton = Instance.new("ImageButton")
    CircleButton.Name = "ToggleCircle"
    CircleButton.Parent = ScreenGui
    CircleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CircleButton.BorderSizePixel = 0
    CircleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    CircleButton.Size = UDim2.new(0, 50, 0, 50)
    CircleButton.Image = "rbxassetid://6034287515"
    CircleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Make it a circle
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = CircleButton
    
    -- Border outline style
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = CircleButton
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Thickness = 2
    
    -- Toggle state
    local isOpen = true
    
    -- Click to open/close the hub window
    CircleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Window:Toggle(isOpen)
    end)
    
    -- Make the circle draggable (Mobile friendly)
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
    Content = "Loaded successfully with Audio!",
    Duration = 3
})
