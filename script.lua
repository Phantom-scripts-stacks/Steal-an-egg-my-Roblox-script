-- ========================================================
-- [ LATINA HUB - FINAL POLISHED VERSION ]
-- ========================================================

local CUSTOM_IMAGE_ID = "rbxassetid://100104680190424"

-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- [ 3.5 SECONDS INTRO: CENTERED & SLIGHTLY UP ]
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

-- Load the UI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ EXECUTION SOUND EFFECT (UPDATED ID & VOLUME 3.5) ]
task.spawn(function()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://70687053615562"
        sound.Volume = 3.5
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
-- [ MAIN TAB: STEAL AN EGG (10 KEYLESS & 10 KEY SYSTEM) ]
-- ========================================================
local MainTab = Window:Tab({
    Title = "Steal an Egg",
    Icon = "home"
})

MainTab:Paragraph({
    Title = "Steal an Egg Hub",
    Content = "Select scripts from Keyless or Key System categories below."
})

-- KEYLESS SECTION (10 Slots)
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

-- KEY SYSTEM SECTION (10 Slots)
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
-- [ UTILITIES TAB: FIXED FPS BOOSTER + LIVE FPS/MS COUNTER ]
-- ========================================================
local UtilsTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench"
})

UtilsTab:Paragraph({
    Title = "Performance & Tools",
    Content = "Click FPS booster to optimize game and display live FPS/MS."
})

local fpsConnection = nil
UtilsTab:Button({
    Title = "⚡ FPS Booster & Show FPS/MS",
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

            if CoreGui:FindFirstChild("LATINA_FPS_MS") then
                CoreGui.LATINA_FPS_MS:Destroy()
            end
            
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
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0.2, 0)
            Corner.Parent = StatsFrame
            
            local Stroke = Instance.new("UIStroke")
            Stroke.Parent = StatsFrame
            Stroke.Color = Color3.fromRGB(255, 0, 0)
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
            
            if fpsConnection then fpsConnection:Disconnect() end
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
                Title = "FPS Booster & HUD",
                Content = "Boosted successfully! Live FPS & MS counter is now visible.",
                Duration = 3
                            
