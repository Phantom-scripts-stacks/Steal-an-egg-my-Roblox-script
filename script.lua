local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if PG:FindFirstChild("LatinaMasterHub") then PG.LatinaMasterHub:Destroy() end

local SG = Instance.new("ScreenGui", PG)
SG.Name = "LatinaMasterHub"
SG.ResetOnSpawn = false

local function Notif(txt)
    task.spawn(function()
        local f = Instance.new("Frame", SG)
        f.Size = UDim2.new(0, 260, 0, 40)
        f.Position = UDim2.new(0.5, -130, 0, -50)
        f.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        f.ZIndex = 99999
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        local l = Instance.new("TextLabel", f)
        l.Size = UDim2.new(1,0,1,0) l.BackgroundTransparency = 1 l.Text = txt
        l.TextColor3 = Color3.new(1,1,1) l.TextSize = 12 l.Font = Enum.Font.GothamBold l.ZIndex = 100000
        TS:Create(f, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 0, 20)}):Play()
        task.wait(2.5)
        TS:Create(f, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 0, -50)}):Play()
        task.wait(0.3) f:Destroy()
    end)
end

local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 480, 0, 320)
MF.Position = UDim2.new(0.5, -240, 0.5, -160)
MF.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MF.Active = true MF.Draggable = true MF.Visible = false
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 10)

local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 35)
TB.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TB)
Title.Size = UDim2.new(1, -40, 1, 0) Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1 Title.Text = "LATINA HUB : FREEMIUM"
Title.TextColor3 = Color3.new(1,1,1) Title.TextSize = 12 Title.Font = Enum.Font.GothamBold Title.TextXAlignment = 0

local CloseBtn = Instance.new("TextButton", TB)
CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48) CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50) CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

local SB = Instance.new("ScrollingFrame", MF)
SB.Size = UDim2.new(0, 125, 1, -45) SB.Position = UDim2.new(0, 5, 0, 40)
SB.BackgroundTransparency = 1 SB.CanvasSize = UDim2.new(0, 0, 0, 350) SB.ScrollBarThickness = 2
local SBL = Instance.new("UIListLayout", SB) SBL.Padding = UDim.new(0, 5)

local PC = Instance.new("Frame", MF)
PC.Size = UDim2.new(1, -135, 1, -45) PC.Position = UDim2.new(0, 132, 0, 40)
PC.BackgroundTransparency = 1

local tabs, pages = {}, {}
local function CreateTab(name)
    local btn = Instance.new("TextButton", SB)
    btn.Size = UDim2.new(1, 0, 0, 30) btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    btn.Text = "  " .. name btn.TextColor3 = Color3.fromRGB(170, 170, 190)
    btn.TextSize = 11 btn.Font = Enum.Font.GothamSemibold btn.TextXAlignment = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame", PC)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.Visible = false page.ScrollBarThickness = 3
    local pl = Instance.new("UIListLayout", page) pl.Padding = UDim.new(0, 5)
    pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, pl.AbsoluteContentSize.Y + 10)
    end)
    
    table.insert(tabs, {Btn = btn, Page = page})
    table.insert(pages, page)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(pages) do p.Visible = false end
        for _, t in ipairs(tabs) do t.Btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32) end
        page.Visible = true btn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
    end)
    
    if #tabs == 1 then page.Visible = true btn.BackgroundColor3 = Color3.fromRGB(114, 137, 218) end
    return page
end

local function AddBtn(page, name, cb)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(1, -4, 0, 32) b.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    b.Text = "  " .. name b.TextColor3 = Color3.new(1,1,1) b.TextSize = 11 b.Font = Enum.Font.GothamSemibold b.TextXAlignment = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

-- TABS
local MainTab = CreateTab("Main")
AddBtn(MainTab, "💡 Fullbright", function() Lighting.Brightness = 2 Lighting.GlobalShadows = false end)
AddBtn(MainTab, "🔄 Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)

local ScriptsTab = CreateTab("Scripts")
local sList = {"Skibidi", "ON hub", "Horizon", "Nisi hub", "Lennon", "Miranda", "Lkz", "Zeroin", "Decode", "Blyko hub", "Hoshi hub", "Script 12", "Script 13", "Script 14", "Script 15", "Script 16", "Script 17", "Script 18", "Script 19", "Script 20", "Script 21", "Script 22", "Script 23", "Script 24", "Script 25"}
for _, sName in ipairs(sList) do
    AddBtn(ScriptsTab, "⚡ " .. sName, function() Notif(sName .. " Executed!") end)
end

local FpsTab = CreateTab("FPS Boost")
AddBtn(FpsTab, "⚡ Low Graphics", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0
        elseif v:IsA("Decal") then v.Transparency = 1 end
    end
end)

MF.Visible = true
Notif("LATINA SUCCESSFULLY LOADED")
