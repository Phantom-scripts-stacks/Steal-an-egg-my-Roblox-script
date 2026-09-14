-- ========================================================
-- [ LATINA HUB - THEME SELECTOR & OPTIMIZED VERSION ]
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

local Fluent, Window

-- [ 1. INTRO BANNER ]
task.spawn(function()
    task.wait(0.05)
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
        
        task.delay(3.5, function()
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

-- [ 2. LOAD UI AFTER INTRO ]
task.spawn(function()
    task.wait(3.5)

    Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

    Window = Fluent:CreateWindow({
        Title = "LATINA HUB",
        SubTitle = "by UNKNOWN",
        TabWidth = 130,
        Size = UDim2.fromOffset(480, 340),
        Acrylic = false,
        Theme = "Darker", -- Default set to Darker (Dark Ocean style)
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "Steal Egg", Icon = "target" }),
        Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
        Utilities = Window:AddTab({ Title = "Utilities", Icon = "tool" }),
        Discord = Window:AddTab({ Title = "Discord", Icon = "message-square" }),
        Owner = Window:AddTab({ Title = "Owner", Icon = "user" })
    }

    -- ========================================================
    -- [ MAIN TAB ]
    -- ========================================================
    Tabs.Main:AddParagraph({
        Title = "Keyless Scripts",
        Content = "Pilia ang slot sa ubos para ma-execute."
    })

    for i = 1, 10 do
        Tabs.Main:AddButton({
            Title = "Slot " .. i,
            Description = "Execute keyless script.",
            Callback = function()
                pcall(function()
                    loadstring(game:HttpGet("(put script here)"))()
                end)
            end
        })
    end

    Tabs.Main:AddParagraph({
        Title = "Key System Scripts",
        Content = "Pilia ang slot sa ubos nga naay key system."
    })

    for i = 1, 10 do
        Tabs.Main:AddButton({
            Title = "Key Slot " .. i,
            Description = "Execute key system script.",
            Callback = function()
                pcall(function()
                    loadstring(game:HttpGet("(put script here)"))()
                end)
            end
        })
    end

    -- ========================================================
    -- [ VISUALS TAB ]
    -- ========================================================
    local FovSlider = Tabs.Visuals:AddSlider("FOVSetting", {
        Title = "FOV Slider",
        Description = "I-adjust ang field of view",
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

    Tabs.Visuals:AddInput("FOVInput", {
        Title = "Custom FOV",
        Description = "I-type ang numero (70-120)",
        Default = "70",
        Placeholder = "Pananglitan: 90",
        Numeric = true,
        Finished = true,
        Callback = function(Value)
            pcall(function()
                local num = tonumber(Value)
                if num then
                    num = math.clamp(num, 10, 120)
                    Camera.FieldOfView = num
                    FovSlider:SetValue(num)
                    Fluent:Notify({ Title = "FOV", Content = "Gibag-o sa: " .. num, Duration = 2 })
                end
            end)
        end
    })

    Tabs.Visuals:AddButton({
        Title = "Reset FOV",
        Description = "Ibalik sa normal (70)",
        Callback = function()
            pcall(function()
                Camera.FieldOfView = 70
                FovSlider:SetValue(70)
                Fluent:Notify({ Title = "FOV", Content = "Na-reset sa 70.", Duration = 2 })
            end)
        end
    })

    Tabs.Visuals:AddButton({
        Title = "Fullbright",
        Description = "Pangtangtang sa kadulom sa kalibutan",
        Callback = function()
            pcall(function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Fluent:Notify({ Title = "Visuals", Content = "Fullbright Na-enable!", Duration = 2 })
            end)
        end
    })

    Tabs.Visuals:AddToggle("WorldEggESP", {
        Title = "World Eggs ESP",
        Description = "I-on/Off ang Mutation ug Rate sa World Eggs",
        Default = false,
        Callback = function(State)
            pcall(function()
                if State then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if (obj:IsA("BasePart") or obj:IsA("Model")) and string.lower(obj.Name):find("egg") then
                            local targetPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                            if targetPart and not targetPart:FindFirstChild("MutationEggESP") then
                                local bg = Instance.new("BillboardGui")
                                bg.Name = "MutationEggESP"
                                bg.Size = UDim2.new(0, 130, 0, 45)
                                bg.StudsOffset = Vector3.new(0, 2.5, 0)
                                bg.AlwaysOnTop = true
                                bg.Parent = targetPart
                                
                                local txt = Instance.new("TextLabel")
                                txt.Size = UDim2.new(1, 0, 1, 0)
                                txt.BackgroundTransparency = 1
                                txt.TextColor3 = Color3.fromRGB(255, 200, 0)
                                txt.TextStrokeTransparency = 0
                                txt.Font = Enum.Font.GothamBold
                                txt.TextSize = 10
                                
                                local mutation = obj:GetAttribute("Mutation") or "Normal"
                                local perSec = obj:GetAttribute("PerSec") or obj:GetAttribute("ValuePerSec") or "0"
                                
                                txt.Text = string.format("%s\nMut: %s | +%s/s", obj.Name, tostring(mutation), tostring(perSec))
                                txt.Parent = bg
                            end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "World Eggs ESP On", Duration = 2 })
                else
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("Model") then
                            local targetPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                            if targetPart and targetPart:FindFirstChild("MutationEggESP") then
                                targetPart.MutationEggESP:Destroy()
                            end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "World Eggs ESP Off", Duration = 2 })
                end
            end)
        end
    })

    Tabs.Visuals:AddToggle("PlotEggESP", {
        Title = "Plot Eggs ESP",
        Description = "I-on/Off ang Mutation ug Rate sa Plot Eggs",
        Default = false,
        Callback = function(State)
            pcall(function()
                if State then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and (string.lower(obj.Name):find("egg") or string.lower(obj.Name):find("plot") or string.lower(obj.Name):find("base")) then
                            if not obj:FindFirstChild("PlotEggMutationESP") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "PlotEggMutationESP"
                                hl.FillColor = Color3.fromRGB(0, 255, 128)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.Parent = obj
                                
                                local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if primary and not primary:FindFirstChild("PlotTag") then
                                    local bg = Instance.new("BillboardGui")
                                    bg.Name = "PlotTag"
                                    bg.Size = UDim2.new(0, 130, 0, 45)
                                    bg.StudsOffset = Vector3.new(0, 3, 0)
                                    bg.AlwaysOnTop = true
                                    bg.Parent = primary
                                    
                                    local txt = Instance.new("TextLabel")
                                    txt.Size = UDim2.new(1, 0, 1, 0)
                                    txt.BackgroundTransparency = 1
                                    txt.TextColor3 = Color3.fromRGB(0, 255, 255)
                                    txt.TextStrokeTransparency = 0
                                    txt.Font = Enum.Font.GothamBold
                                    txt.TextSize = 10
                                    
                                    local mutation = obj:GetAttribute("Mutation") or "Placed"
                                    local perSec = obj:GetAttribute("PerSec") or obj:GetAttribute("ValuePerSec") or "0"
                                    
                                    txt.Text = string.format("Plot\nMut: %s | +%s/s", tostring(mutation), tostring(perSec))
                                    txt.Parent = bg
                                end
                            end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "Plot Eggs ESP On", Duration = 2 })
                else
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") then
                            if obj:FindFirstChild("PlotEggMutationESP") then obj.PlotEggMutationESP:Destroy() end
                            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            if primary and primary:FindFirstChild("PlotTag") then primary.PlotTag:Destroy() end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "Plot Eggs ESP Off", Duration = 2 })
                end
            end)
        end
    })

    -- ========================================================
    -- [ UTILITIES TAB ]
    -- ========================================================
    
    -- Theme Selector Dropdown
    Tabs.Utilities:AddDropdown("ThemeDropdown", {
        Title = "UI Theme Selector",
        Description = "Pilia ang gusto nimong tema",
        Values = {"Darker", "Dark", "Light", "Aqua", "Amethyst", "Rose"},
        Default = 1,
        Callback = function(Value)
            pcall(function()
                Fluent:SetTheme(Value)
                Fluent:Notify({ Title = "Theme", Content = "Gibag-o sa: " .. Value, Duration = 2 })
            end)
        end
    })

    local fpsConnection = nil
    Tabs.Utilities:AddButton({
        Title = "Toggle FPS / MS Counter",
        Description = "I-pakita ang performance sa screen",
        Callback = function()
            pcall(function()
                if CoreGui:FindFirstChild("LATINA_FPS_MS") then
                    if fpsConnection then fpsConnection:Disconnect() end
                    CoreGui.LATINA_FPS_MS:Destroy()
                    Fluent:Notify({ Title = "HUD", Content = "Counter gitago.", Duration = 2 })
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
                    StatsText.TextSize = 12
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
                    
                    Fluent:Notify({ Title = "HUD", Content = "Counter gi-on.", Duration = 2 })
                end
            end)
        end
    })

    Tabs.Utilities:AddButton({
        Title = "Rejoin Server",
        Description = "Balik sa parehong server",
        Callback = function()
            pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
        end
    })

    Tabs.Utilities:AddButton({
        Title = "Low Server Finder",
        Description = "Pangita og server nga gamay ra ang tawo",
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Low-Server-Finder-GUI-30660"))()
            end)
        end
    })

    Tabs.Utilities:AddButton({
        Title = "Safe Anti AFK",
        Description = "Dili ka ma-kick tungod sa dugay nga pag-idle",
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
                Fluent:Notify({ Title = "Anti AFK", Content = "Na-enable na!", Duration = 3 })
            end)
        end
    })

    -- ========================================================
    -- [ DISCORD TAB ]
    -- ========================================================
    Tabs.Discord:AddButton({
        Title = "Copy Discord Link",
        Description = "Kopyaha ang invite link sa clipboard",
        Callback = function()
            pcall(function()
                setclipboard("https://discord.gg/yourinvite")
                Fluent:Notify({ Title = "Discord", Content = "Na-kopya na ang link!", Duration = 3 })
            end)
        end
    })

    -- ========================================================
    -- [
