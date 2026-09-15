-- ==========================================
-- SCRIPT TITLE : Latina Master Hub (Full - Part 1)
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("LatinaMasterHub") then PlayerGui.LatinaMasterHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "LatinaMasterHub"
ScreenGui.ResetOnSpawn = false

local Themes = {
    ["Dark Purple (Default)"] = {MainBg = Color3.fromRGB(18, 18, 24), TopBar = Color3.fromRGB(24, 24, 32), ElementBg = Color3.fromRGB(28, 28, 38), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(170, 170, 190)},
    ["Midnight Blue"] = {MainBg = Color3.fromRGB(13, 17, 23), TopBar = Color3.fromRGB(22, 27, 34), ElementBg = Color3.fromRGB(33, 38, 45), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(139, 148, 158)},
    ["Crimson Red"] = {MainBg = Color3.fromRGB(20, 12, 12), TopBar = Color3.fromRGB(30, 18, 18), ElementBg = Color3.fromRGB(42, 24, 24), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(190, 170, 170)},
    ["Emerald Green"] = {MainBg = Color3.fromRGB(12, 20, 15), TopBar = Color3.fromRGB(18, 30, 22), ElementBg = Color3.fromRGB(24, 42, 30), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(170, 190, 175)},
    ["Sunset Orange"] = {MainBg = Color3.fromRGB(22, 16, 12), TopBar = Color3.fromRGB(32, 24, 18), ElementBg = Color3.fromRGB(44, 32, 24), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(190, 175, 170)},
    ["Neon Cyberpunk"] = {MainBg = Color3.fromRGB(10, 10, 18), TopBar = Color3.fromRGB(18, 18, 30), ElementBg = Color3.fromRGB(26, 26, 45), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(160, 210, 255)},
    ["Rose Pink"] = {MainBg = Color3.fromRGB(22, 12, 18), TopBar = Color3.fromRGB(32, 18, 26), ElementBg = Color3.fromRGB(45, 24, 36), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(190, 170, 180)},
    ["Toxic Lime"] = {MainBg = Color3.fromRGB(12, 22, 12), TopBar = Color3.fromRGB(18, 32, 18), ElementBg = Color3.fromRGB(24, 45, 24), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(170, 190, 170)},
    ["Matrix Code"] = {MainBg = Color3.fromRGB(5, 15, 8), TopBar = Color3.fromRGB(10, 25, 14), ElementBg = Color3.fromRGB(15, 38, 20), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(100, 220, 130)},
    ["Golden Luxury"] = {MainBg = Color3.fromRGB(20, 18, 10), TopBar = Color3.fromRGB(30, 26, 15), ElementBg = Color3.fromRGB(42, 36, 20), TextMain = Color3.new(1,1,1), TextDim = Color3.fromRGB(210, 195, 150)}
}

local CurrentTheme = Themes["Dark Purple (Default)"]

local function ShowNotification(text)
    task.spawn(function()
        local notifFrame = Instance.new("Frame", ScreenGui)
        notifFrame.Size = UDim2.new(0, 260, 0, 40)
        notifFrame.Position = UDim2.new(0.5, -130, 0, -50)
        notifFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        notifFrame.ZIndex = 99999
        Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 8)
        
        local l = Instance.new("TextLabel", notifFrame)
        l.Size = UDim2.new(1, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.new(1, 1, 1)
        l.TextSize = 12
        l.Font = Enum.Font.GothamBold
        l.ZIndex = 100000
        
        TweenService:Create(notifFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 0, 20)}):Play()
        task.wait(2.5)
        TweenService:Create(notifFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 0, -50)}):Play()
        task.wait(0.3)
        notifFrame:Destroy()
    end)
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = CurrentTheme.MainBg
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = CurrentTheme.TopBar
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "LATINA HUB : FREEMIUM"
Title.TextColor3 = CurrentTheme.TextMain
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 102

local StatsLabel = Instance.new("TextLabel", TopBar)
StatsLabel.Size = UDim2.new(0, 80, 1, 0)
StatsLabel.Position = UDim2.new(1, -110, 0, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "FPS: 0 | MS: 0"
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
StatsLabel.TextSize = 10
StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
StatsLabel.ZIndex = 102

local lastTick = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - lastTick >= 1 then
        local fps = frameCount
        local ping = math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        StatsLabel.Text = "FPS: " .. fps .. " | MS: " .. ping
        frameCount = 0
        lastTick = tick()
    end
end)
-- ==========================================
-- SCRIPT TITLE : Latina Master Hub (Full - Part 2)
-- ==========================================
local ConfirmOverlay = Instance.new("Frame", MainFrame)
ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
ConfirmOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
ConfirmOverlay.BackgroundTransparency = 0.5
ConfirmOverlay.Visible = false
ConfirmOverlay.ZIndex = 500

local ConfirmBox = Instance.new("Frame", ConfirmOverlay)
ConfirmBox.Size = UDim2.new(0, 280, 0, 130)
ConfirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmBox.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmBox.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
ConfirmBox.ZIndex = 501
Instance.new("UICorner", ConfirmBox).CornerRadius = UDim.new(0, 8)

local ConfirmText = Instance.new("TextLabel", ConfirmBox)
ConfirmText.Size = UDim2.new(1, -20, 0, 50)
ConfirmText.Position = UDim2.new(0, 10, 0, 15)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Are you sure you want to close this hub?"
ConfirmText.TextColor3 = Color3.fromRGB(240, 240, 255)
ConfirmText.TextSize = 12
ConfirmText.Font = Enum.Font.GothamSemibold
ConfirmText.TextWrapped = true
ConfirmText.ZIndex = 502

local CancelBtn = Instance.new("TextButton", ConfirmBox)
CancelBtn.Size = UDim2.new(0, 120, 0, 32)
CancelBtn.Position = UDim2.new(0, 15, 1, -45)
CancelBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
CancelBtn.Text = "Cancel"
CancelBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CancelBtn.TextSize = 11
CancelBtn.Font = Enum.Font.GothamBold
CancelBtn.ZIndex = 502
Instance.new("UICorner", CancelBtn).CornerRadius = UDim.new(0, 6)

local CloseWindowBtn = Instance.new("TextButton", ConfirmBox)
CloseWindowBtn.Size = UDim2.new(0, 120, 0, 32)
CloseWindowBtn.Position = UDim2.new(1, -135, 1, -45)
CloseWindowBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseWindowBtn.Text = "Close Window"
CloseWindowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseWindowBtn.TextSize = 11
CloseWindowBtn.Font = Enum.Font.GothamBold
CloseWindowBtn.ZIndex = 502
Instance.new("UICorner", CloseWindowBtn).CornerRadius = UDim.new(0, 6)

local isOpen = true
local function ToggleWindow()
    isOpen = not isOpen
    ConfirmOverlay.Visible = false
    if isOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.BackgroundTransparency = 1
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 480, 0, 320),
            Position = UDim2.new(0.5, -240, 0.5, -160),
            BackgroundTransparency = 0
        })
        tw:Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        tw:Play()
        tw.Completed:Wait()
        MainFrame.Visible = false
    end
end

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextSize = 12
CloseBtn.ZIndex = 102
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = true
end)
CancelBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = false
end)
CloseWindowBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        ToggleWindow()
        if isOpen then ShowNotification("LATINA HUB: Opened") else ShowNotification("LATINA HUB: Minimized") end
    end
end)

local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Size = UDim2.new(0, 125, 1, -48)
Sidebar.Position = UDim2.new(0, 3, 0, 42)
Sidebar.BackgroundTransparency = 1
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 300)
Sidebar.ScrollBarThickness = 2
Sidebar.ZIndex = 102
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

local PagesContainer = Instance.new("Frame", MainFrame)
PagesContainer.Size = UDim2.new(1, -135, 1, -48)
PagesContainer.Position = UDim2.new(0, 130, 0, 42)
PagesContainer.BackgroundTransparency = 1
PagesContainer.ZIndex = 102

local activeTabButton = nil
local allTabButtons = {}
local allPages = {}

local function CreateTab(title)
    local tabIndex = #allTabButtons + 1
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = CurrentTheme.TopBar
    TabBtn.Text = "  " .. title
    TabBtn.TextColor3 = CurrentTheme.TextDim
    TabBtn.TextSize = 11
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.ZIndex = 103
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame", PagesContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 3
    Page.ZIndex = 103
    local pl = Instance.new("UIListLayout", Page)
    pl.Padding = UDim.new(0, 6)
    pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, pl.AbsoluteContentSize.Y + 10)
    end)

    table.insert(allTabButtons, {Button = TabBtn, Page = Page})
    table.insert(allPages, Page)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in ipairs(allPages) do p.Visible = false end
        for _, t in ipairs(allTabButtons) do
            t.Button.BackgroundColor3 = CurrentTheme.TopBar
            t.Button.TextColor3 = CurrentTheme.TextDim
        end
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
        activeTabButton = TabBtn
    end)

    if tabIndex == 1 then
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
        activeTabButton = TabBtn
    end
    return Page
end

local allElementButtons = {}
local function AddButtonToPage(page, name, callback)
    local Btn = Instance.new("TextButton", page)
    Btn.Size = UDim2.new(1, -4, 0, 34)
    Btn.BackgroundColor3 = CurrentTheme.ElementBg
    Btn.Text = "  " .. name
    Btn.TextColor3 = CurrentTheme.TextMain
    Btn.TextSize = 11
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.ZIndex = 104
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", Btn).Color = Color3.fromRGB(45, 45, 60)

    table.insert(allElementButtons, Btn)
    Btn.MouseButton1Click:Connect(callback)
end
-- ==========================================
-- SCRIPT TITLE : Latina Master Hub (Full - Part 3)
-- ==========================================
local function ApplyTheme(themeName)
    CurrentTheme = Themes[themeName]
    MainFrame.BackgroundColor3 = CurrentTheme.MainBg
    TopBar.BackgroundColor3 = CurrentTheme.TopBar
    for _, t in ipairs(allTabButtons) do
        if t.Button == activeTabButton then
            t.Button.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
            t.Button.TextColor3 = Color3.new(1, 1, 1)
        else
            t.Button.BackgroundColor3 = CurrentTheme.TopBar
            t.Button.TextColor3 = CurrentTheme.TextDim
        end
    end
    for _, ui in ipairs(allElementButtons) do
        ui.BackgroundColor3 = CurrentTheme.ElementBg
        ui.TextColor3 = CurrentTheme.TextMain
    end
    ShowNotification("Theme applied: " .. themeName)
end

-- Main Tab
local MainTab = CreateTab("Main")
AddButtonToPage(MainTab, "💡 Fullbright", function()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
    end)
    ShowNotification("Fullbright Enabled!")
end)
AddButtonToPage(MainTab, "🔄 Rejoin Server", function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end)

-- Scripts Tab
local ScriptsTab = CreateTab("Scripts")
local savedScripts = {
    {Name = "Skibidi", Link = ""}, {Name = "ON hub", Link = ""}, {Name = "Horizon", Link = ""},
    {Name = "Nisi hub", Link = ""}, {Name = "Lennon", Link = ""}, {Name = "Miranda", Link = ""},
    {Name = "Lkz", Link = ""}, {Name = "Zeroin", Link = ""}, {Name = "Decode", Link = ""},
    {Name = "Blyko hub", Link = ""}, {Name = "Hoshi hub", Link = ""}, {Name = "Script 12", Link = ""},
    {Name = "Script 13", Link = ""}, {Name = "Script 14", Link = ""}, {Name = "Script 15", Link = ""},
    {Name = "Script 16", Link = ""}, {Name = "Script 17", Link = ""}, {Name = "Script 18", Link = ""},
    {Name = "Script 19", Link = ""}, {Name = "Script 20", Link = ""}, {Name = "Script 21", Link = ""},
    {Name = "Script 22", Link = ""}, {Name = "Script 23", Link = ""}, {Name = "Script 24", Link = ""},
    {Name = "Script 25", Link = ""}
}
for _, scriptData in ipairs(savedScripts) do
    AddButtonToPage(ScriptsTab, "⚡ " .. scriptData.Name, function()
        ShowNotification(scriptData.Name .. " Executed!")
    end)
end

-- FPS Boost Tab
local FpsTab = CreateTab("FPS Boost")
AddButtonToPage(FpsTab, "⚡ Low Graphics / Boost FPS", function()
    pcall(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
    end)
    ShowNotification("FPS Boost Applied!")
end)

-- Themes Tab
local ThemeTab = CreateTab("Themes")
for themeName, _ in pairs(Themes) do
    AddButtonToPage(ThemeTab, "🎨 " .. themeName, function()
        ApplyTheme(themeName)
    end)
end

-- Settings Tab
local SettingsTab = CreateTab("Settings")
AddButtonToPage(SettingsTab, "⚙️ Toggle Keybind Info", function()
    ShowNotification("Press Right Shift to Hide/Show Hub")
end)

-- Owner Tab
local OwnerTab = CreateTab("Owner")
AddButtonToPage(OwnerTab, "👑 Owner: ANONYMOUS", function()
    ShowNotification("Latina Hub created successfully!")
end)

-- Finalize Introduction
MainFrame.Visible = true
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundTransparency = 1

TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 480, 0, 320),
    Position = UDim2.new(0.5, -240, 0.5, -160),
    BackgroundTransparency = 0
}):Play()

ShowNotification("LATINA SUCCESSFULLY LOADED")

