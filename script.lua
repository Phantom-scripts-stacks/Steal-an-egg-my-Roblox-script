-- ========================================================
-- [ LATINA HUB - 100% WORKING & EXECUTABLE VERSION ]
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

-- [ 1. SAFE INTRO BANNER ]
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
        Backdrop.BackgroundTransparency = 0.5
        
        local IntroImage = Instance.new("ImageLabel")
        IntroImage.Parent = IntroGui
        IntroImage.AnchorPoint = Vector2.new(0.5, 0.5)
        IntroImage.Position = UDim2.new(0.5, 0, 0.43, 0)
        IntroImage.Size = UDim2.new(0, 300, 0, 300)
        IntroImage.BackgroundTransparency = 1
        IntroImage.Image = CUSTOM_IMAGE_ID
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.15, 0)
        UICorner.Parent = IntroImage
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = IntroImage
        UIStroke.Color = Color3.fromRGB(255, 50, 50)
        UIStroke.Thickness = 4
        
        task.delay(3, function()
            pcall(function()
                IntroGui:Destroy()
            end)
        end)
    end)
end)

-- [ 2. LOAD UI ]
task.spawn(function()
    local success, Fluent = pcall(function()
        return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    end)

    if not success or not Fluent then
        warn("Failed to load Fluent library.")
        return
    end

    local Window = Fluent:CreateWindow({
        Title = "LATINA HUB",
        SubTitle = "by UNKNOWN",
        TabWidth = 130,
        Size = UDim2.fromOffset(480, 340),
        Acrylic = false,
        Theme = "Darker",
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

    for i = 1, 5 do
        Tabs.Main:AddButton({
            Title = "Slot " .. i,
            Description = "Execute keyless script.",
            Callback = function()
                pcall(function()
                    -- Ibutang ang imong script dinhi kung naa na
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

    local function isStrictEgg(model)
        if not model:IsA("Model") then return false end
        local name = string.lower(model.Name)
        if name:find("egg") and not name:find("pet") and not name:find("player") then
            return true
        end
        return false
    end

    Tabs.Visuals:AddToggle("WorldEggESP", {
        Title = "World Eggs ESP",
        Description = "Limpyo nga ESP para sa mga itlog ra",
        Default = false,
        Callback = function(State)
            pcall(function()
                if State then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if isStrictEgg(obj) then
                            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            if primary and not primary:FindFirstChild("LATINA_CleanWorldEgg") then
                                local bg = Instance.new("BillboardGui")
                                bg.Name = "LATINA_CleanWorldEgg"
                                bg.Size = UDim2.new(0, 120, 0, 40)
                                bg.StudsOffset = Vector3.new(0, 2, 0)
                                bg.AlwaysOnTop = true
                                bg.Parent = primary
                                
                                local txt = Instance.new("TextLabel")
                                txt.Size = UDim2.new(1, 0, 1, 0)
                                txt.BackgroundTransparency = 1
                                txt.TextColor3 = Color3.fromRGB(255, 220, 50)
                                txt.TextStrokeTransparency = 0
                                txt.Font = Enum.Font.GothamBold
                                txt.TextSize = 11
                                txt.Text = string.format("🥚 %s", obj.Name)
                                txt.Parent = bg
                            end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "World Eggs ESP On", Duration = 2 })
                else
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") then
                            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            if primary and primary:FindFirstChild("LATINA_CleanWorldEgg") then
                                primary.LATINA_CleanWorldEgg:Destroy()
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
        Description = "I-track ang mga itlog sa mga plot",
        Default = false,
        Callback = function(State)
            pcall(function()
                if State then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if isStrictEgg(obj) then
                            local parentName = string.lower(obj.Parent.Name)
                            if parentName:find("plot") or parentName:find("base") or parentName:find("slot") then
                                if not obj:FindFirstChild("LATINA_PlotHighlight") then
                                    local hl = Instance.new("Highlight")
                                    hl.Name = "LATINA_PlotHighlight"
                                    hl.FillColor = Color3.fromRGB(0, 255, 128)
                                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    hl.Parent = obj
                                end
                            end
                        end
                    end
                    Fluent:Notify({ Title = "ESP", Content = "Plot Eggs ESP On", Duration = 2 })
                else
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") then
                            if obj:FindFirstChild("LATINA_PlotHighlight") then 
                                obj.LATINA_PlotHighlight:Destroy() 
                            end
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
    local fpsConnection = nil
    Tabs.Utilities:AddButton({
        Title = "Toggle Draggable FPS / MS Counter",
        Description = "I-pakita ug i-drag ang performance hud",
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
                    StatsGui.ResetOnSpawn = false
                    
                    local StatsFrame = Instance.new("Frame")
                    StatsFrame.Parent = StatsGui
                    StatsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    StatsFrame.BorderSizePixel = 0
                    StatsFrame.Position = UDim2.new(0.02, 0, 0.05, 0)
                    StatsFrame.Size = UDim2.new(0, 160, 0, 40)
                    StatsFrame.Active = true
                    StatsFrame.Draggable = true
                    
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
                    
                    Fluent:Notify({ Title = "HUD", Content = "Draggable Counter gi-on.", Duration = 2 })
                end
            end)
        end
    })

    Tabs.Utilities:AddButton({
        Title = "🚀 Ultimate FPS Booster",
        Description = "Hugot nga pag-optimize sa Roblox performance",
        Callback = function()
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                        v.Material = Enum.Material.SmoothPlastic
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v.Transparency = 1
                    end
                end
                Fluent:Notify({ Title = "FPS Booster", Content = "Na-boost na ang dula!", Duration = 3 })
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
    -- [ OWNER TAB ]
    -- ========================================================
    Tabs.Owner:AddParagraph({
        Title = "Hub Information",
        Content = "Hub Name: LATINA HUB\nCreator: UNKNOWN\nStatus: Optimized & Fully Executable"
    })

    -- [ 3. FLOATING TOGGLE BUTTON ]
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

            ToggleBtn.MouseButton1Click:Connect(function()
                Window:Minimize()
            end)
        end)
    end)

    Fluent:Notify({
        Title = "LATINA HUB",
        Content = "Na-execute na gyud successfully, boss!",
        Duration = 3
    })
end)
