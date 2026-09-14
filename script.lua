-- ==========================================
-- [ MAMAAAA HUB - FLOATING CIRCLE UI ]
-- ==========================================

-- Load the UI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ EXECUTION SOUND EFFECT ]
pcall(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590657391"
    sound.Volume = 1
    sound.Parent = game:GetService("CoreGui")
    sound:Play()
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
    local TweenService = game:GetService("TweenService")
    
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
    CircleButton.Position = UDim2.new(0.05, 0, 0.4, 0) -- Position on the side
    CircleButton.Size = UDim2.new(0, 50, 0, 50)
    CircleButton.Image = "rbxassetid://6034287515" -- Clean icon
    CircleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Make it a circle
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = CircleButton
    
    -- Border outline style
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = CircleButton
    UIStroke.Color = Color3.fromRGB(255, 0, 0) -- Red outline
    UIStroke.Thickness = 2
    
    -- Toggle state
    local isOpen = true
    
    -- Click to open/close the hub window
    CircleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Window:Toggle(isOpen)
    end)
    
    -- Make the circle draggable (Mobile friendly)
    local dragging, dragInput, dragStart, startPos
    
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
    Title = "Steal an Egg Script 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/eiltrunduhub/loader/main/stealeggs"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonscripts/lennonstubs2/refs/heads/main/stealeggs"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 3",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/55bf341d087ba3acd5190a5d6d4d9824.lua"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 4",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 5",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 6",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 7",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 8",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 9",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 10",
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
    Content = "Hub Name: MAMAAAA Hub\nOwner / Creator: UNKNOWN\nStatus: Active & Working"
})

WindUI:Notify({
    Title = "MAMAAAA Hub",
    Content = "Loaded successfully with Custom Floating Circle!",
    Duration = 3
})
