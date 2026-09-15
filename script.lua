-- ========================================================
-- [ LATINA HUB - NATIVE GUI (100% NO LOAD ERROR) ]
-- ========================================================

pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("LATINA_NATIVE_HUB") then
        game:GetService("CoreGui").LATINA_NATIVE_HUB:Destroy()
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LATINA_NATIVE_HUB"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 2

-- Title Bar
local TitleBar = Instance.new("TextLabel")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.Text = "  LATINA HUB - Fixed Version"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.TextSize = 14
TitleBar.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Scrolling Frame for Buttons
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Active = true
Scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
Scroll.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Scroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Helper to create buttons
local function addButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Scroll
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. World Eggs ESP
local worldEspActive = false
addButton("Toggle World Eggs ESP", function()
    worldEspActive = not worldEspActive
    pcall(function()
        if worldEspActive then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and string.lower(obj.Name):find("egg") and not string.lower(obj.Name):find("pet") then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary and not primary:FindFirstChild("NativeWorldEgg") then
                        local bg = Instance.new("BillboardGui")
                        bg.Name = "NativeWorldEgg"
                        bg.Size = UDim2.new(0, 100, 0, 30)
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
                        txt.Text = "🥚 " .. obj.Name
                        txt.Parent = bg
                    end
                end
            end
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary and primary:FindFirstChild("NativeWorldEgg") then
                        primary.NativeWorldEgg:Destroy()
                    end
                end
            end
        end
    end)
end)

-- 2. Plot Eggs ESP
local plotEspActive = false
addButton("Toggle Plot Eggs ESP", function()
    plotEspActive = not plotEspActive
    pcall(function()
        if plotEspActive then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and string.lower(obj.Name):find("egg") then
                    local pName = string.lower(obj.Parent.Name)
                    if pName:find("plot") or pName:find("base") or pName:find("slot") then
                        if not obj:FindFirstChild("NativePlotHL") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "NativePlotHL"
                            hl.FillColor = Color3.fromRGB(0, 255, 128)
                            hl.Parent = obj
                        end
                    end
                end
            end
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("NativePlotHL") then
                    obj.NativePlotHL:Destroy()
                end
            end
        end
    end)
end)

-- 3. FPS / MS Counter
local fpsGuiActive = false
addButton("Toggle FPS / MS Counter", function()
    fpsGuiActive = not fpsGuiActive
    pcall(function()
        if fpsGuiActive then
            local statsGui = Instance.new("ScreenGui")
            statsGui.Name = "NativeStats"
            statsGui.Parent = game:GetService("CoreGui")
            
            local lbl = Instance.new("TextLabel")
            lbl.Name = "StatsLbl"
            lbl.Parent = statsGui
            lbl.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            lbl.Position = UDim2.new(0.02, 0, 0.02, 0)
            lbl.Size = UDim2.new(0, 140, 0, 35)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextColor3 = Color3.fromRGB(0, 255, 128)
            lbl.TextSize = 12
            lbl.Text = "FPS: 0 | MS: 0ms"
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = lbl
            
            local lastUpdate = tick()
            local frames = 0
            RunService.RenderStepped:Connect(function()
                frames = frames + 1
                local now = tick()
                if now - lastUpdate >= 1 then
                    local fps = math.floor(frames / (now - lastUpdate))
                    frames = 0
                    lastUpdate = now
                    local ping = 0
                    pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
                    if lbl and lbl.Parent then
                        lbl.Text = string.format("FPS: %d | MS: %dms", fps, ping)
                    end
                end
            end)
        else
            if game:GetService("CoreGui"):FindFirstChild("NativeStats") then
                game:GetService("CoreGui").NativeStats:Destroy()
            end
        end
    end)
end)

-- 4. Ultimate FPS Booster
addButton("🚀 Ultimate FPS Booster", function()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end)
end)

-- 5. Fullbright
addButton("Toggle Fullbright", function()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end)
end)

-- 6. Rejoin Server
addButton("Rejoin Server", function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end)

print("LATINA HUB NATIVE LOADED SUCCESSFULLY!")
