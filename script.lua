-- ========================================================
-- [ LATINA HUB - ULTIMATE SOUND EDITION (PART 1) ]
-- ========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("LatinaRayfieldStyle") then
    PlayerGui.LatinaRayfieldStyle:Destroy()
end

local CUSTOM_IMAGE_ID = "rbxassetid://100104680190424"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LatinaRayfieldStyle"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local ClickSound = Instance.new("Sound")
ClickSound.Name = "ClickSoundEffect"
ClickSound.SoundId = "rbxassetid://906107293"
ClickSound.Volume = 0.7
ClickSound.Parent = ScreenGui

local function PlayClick()
    pcall(function()
        ClickSound:Play()
    end)
end

local function ShowNotification(text)
    task.spawn(function()
        pcall(function()
            local NotifFrame = Instance.new("Frame", ScreenGui)
            NotifFrame.Size = UDim2.new(0, 260, 0, 45)
            NotifFrame.Position = UDim2.new(0.5, -130, 0, -60)
            NotifFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            NotifFrame.ZIndex = 99999
            
            local NotifCorner = Instance.new("UICorner", NotifFrame)
            NotifCorner.CornerRadius = UDim.new(0, 8)
            
            local NotifStroke = Instance.new("UIStroke", NotifFrame)
            NotifStroke.Color = Color3.fromRGB(114, 137, 218)
            NotifStroke.Thickness = 1.5
            
            local NotifText = Instance.new("TextLabel", NotifFrame)
            NotifText.Size = UDim2.new(1, 0, 1, 0)
            NotifText.BackgroundTransparency = 1
            NotifText.Text = text
            NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
            NotifText.TextSize = 12
            NotifText.Font = Enum.Font.GothamBold
            NotifText.ZIndex = 100000

            TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -130, 0, 20)
            }):Play()

            task.wait(3)

            local fadeOut = TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -130, 0, -60)
            })
            fadeOut:Play()
            fadeOut.Completed:Wait()
            NotifFrame:Destroy()
        end)
    end)
end

local Themes = {
    ["Dark Purple"] = {
        MainBg = Color3.fromRGB(18, 18, 24),
        TopBar = Color3.fromRGB(24, 24, 32),
        ElementBg = Color3.fromRGB(24, 24, 32),
        TextMain = Color3.fromRGB(240, 240, 255),
        TextDim = Color3.fromRGB(170, 170, 190)
    },
    ["Midnight Blue"] = {
        MainBg = Color3.fromRGB(10, 15, 25),
        TopBar = Color3.fromRGB(15, 22, 36),
        ElementBg = Color3.fromRGB(15, 22, 36),
        TextMain = Color3.fromRGB(230, 240, 255),
        TextDim = Color3.fromRGB(140, 160, 190)
    },
    ["Crimson Red"] = {
        MainBg = Color3.fromRGB(20, 12, 14),
        TopBar = Color3.fromRGB(28, 16, 19),
        ElementBg = Color3.fromRGB(28, 16, 19),
        TextMain = Color3.fromRGB(255, 230, 230),
        TextDim = Color3.fromRGB(190, 150, 150)
    },
    ["Emerald Green"] = {
        MainBg = Color3.fromRGB(12, 20, 16),
        TopBar = Color3.fromRGB(16, 28, 22),
        ElementBg = Color3.fromRGB(16, 28, 22),
        TextMain = Color3.fromRGB(230, 255, 240),
        TextDim = Color3.fromRGB(150, 190, 170)
    },
    ["Sunset Orange"] = {
        MainBg = Color3.fromRGB(22, 15, 12),
        TopBar = Color3.fromRGB(33, 22, 16),
        ElementBg = Color3.fromRGB(33, 22, 16),
        TextMain = Color3.fromRGB(255, 235, 220),
        TextDim = Color3.fromRGB(190, 160, 140)
    },
    ["Neon Cyberpunk"] = {
        MainBg = Color3.fromRGB(13, 13, 18),
        TopBar = Color3.fromRGB(20, 20, 28),
        ElementBg = Color3.fromRGB(20, 20, 28),
        TextMain = Color3.fromRGB(0, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 180)
    },
    ["Rose Pink"] = {
        MainBg = Color3.fromRGB(22, 14, 18),
        TopBar = Color3.fromRGB(32, 20, 26),
        ElementBg = Color3.fromRGB(32, 20, 26),
        TextMain = Color3.fromRGB(255, 220, 235),
        TextDim = Color3.fromRGB(190, 150, 170)
    },
    ["Toxic Lime"] = {
        MainBg = Color3.fromRGB(14, 20, 12),
        TopBar = Color3.fromRGB(20, 30, 16),
        ElementBg = Color3.fromRGB(20, 30, 16),
        TextMain = Color3.fromRGB(200, 255, 120),
        TextDim = Color3.fromRGB(150, 180, 130)
    },
    ["Matrix Code"] = {
        MainBg = Color3.fromRGB(8, 12, 8),
        TopBar = Color3.fromRGB(12, 20, 12),
        ElementBg = Color3.fromRGB(12, 20, 12),
        TextMain = Color3.fromRGB(50, 255, 50),
        TextDim = Color3.fromRGB(100, 180, 100)
    },
    ["Golden Luxury"] = {
        MainBg = Color3.fromRGB(20, 18, 12),
        TopBar = Color3.fromRGB(30, 26, 16),
        ElementBg = Color3.fromRGB(30, 26, 16),
        TextMain = Color3.fromRGB(255, 223, 128),
        TextDim = Color3.fromRGB(180, 160, 120)
    }
}

local CurrentTheme = Themes["Dark Purple"]

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.015, 0, 0.12, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.BackgroundTransparency = 0.1
ToggleBtn.Image = CUSTOM_IMAGE_ID
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = true
ToggleBtn.ZIndex = 99999
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 3.5

task.spawn(function()
    local hue = 0
    while ToggleBtn and ToggleBtn.Parent do
        hue = (hue + 0.005) % 1
        ToggleStroke.Color = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

local function PlayIntro(onComplete)
    task.spawn(function()
        pcall(function()
            local Backdrop = Instance.new("Frame", ScreenGui)
            Backdrop.Size = UDim2.new(1, 0, 1, 0)
            Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Backdrop.BackgroundTransparency = 1
            Backdrop.ZIndex = 5000

            local IntroImage = Instance.new("ImageLabel", ScreenGui)
            IntroImage.AnchorPoint = Vector2.new(0.5, 0.5)
            IntroImage.Position = UDim2.new(0.5, 0, 0.5, 0)
            IntroImage.Size = UDim2.new(0, 0, 0, 0)
            IntroImage.BackgroundTransparency = 1
            IntroImage.Image = CUSTOM_IMAGE_ID
            IntroImage.ZIndex = 5001

            local UICorner = Instance.new("UICorner", IntroImage)
            UICorner.CornerRadius = UDim.new(0.15, 0)

            local UIStroke = Instance.new("UIStroke", IntroImage)
            UIStroke.Color = Color3.fromRGB(114, 137, 218)
            UIStroke.Thickness = 4
            UIStroke.Transparency = 1

            TweenService:Create(Backdrop, TweenInfo.new(0.4), {BackgroundTransparency = 0.4}):Play()
            TweenService:Create(IntroImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 300)}):Play()
            TweenService:Create(UIStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()

            task.wait(2.2)

            TweenService:Create(Backdrop, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            local fadeOutImg = TweenService:Create(IntroImage, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            fadeOutImg:Play()
            
            fadeOutImg.Completed:Wait()
            Backdrop:Destroy()
            IntroImage:Destroy()
            if onComplete then onComplete() end
        end)
    end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = CurrentTheme.MainBg
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.ZIndex = 100
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
task.spawn(function()
    local hue = 0
    while MainFrame and MainFrame.Parent do
        hue = (hue + 0.003) % 1
        MainStroke.Color = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = CurrentTheme.TopBar
TopBar.ZIndex = 101
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 10)

local CoverFix = Instance.new("Frame")
CoverFix.Size = UDim2.new(1, 0, 0, 10)
CoverFix.Position = UDim2.new(0, 0, 1, -10)
CoverFix.BackgroundColor3 = CurrentTheme.TopBar
CoverFix.BorderSizePixel = 0
CoverFix.ZIndex = 101
CoverFix.Parent = TopBar

local CloseXBtn = Instance.new("TextButton")
CloseXBtn.Size = UDim2.new(0, 26, 0, 26)
CloseXBtn.Position = UDim2.new(1, -32, 0.5, -13)
CloseXBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
CloseXBtn.Text = "✕"
CloseXBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseXBtn.TextSize = 13
CloseXBtn.Font = Enum.Font.GothamBold
CloseXBtn.ZIndex = 105
CloseXBtn.Parent = TopBar

local CloseXCorner = Instance.new("UICorner", CloseXBtn)
CloseXCorner.CornerRadius = UDim.new(0, 6)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.55, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "LATINA HUB | FREEMIUM"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 12
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 102
TitleLabel.Parent = TopBar

task.spawn(function()
    local hue = 0
    while TitleLabel and TitleLabel.Parent do
        hue = (hue + 0.005) % 1
        TitleLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(0, 120, 1, 0)
StatsLabel.Position = UDim2.new(1, -158, 0, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "FPS: 0 | MS: 0"
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
StatsLabel.TextSize = 10
StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
StatsLabel.ZIndex = 102
StatsLabel.Parent = TopBar

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

local ConfirmOverlay = Instance.new("Frame")
ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConfirmOverlay.BackgroundTransparency = 0.5
ConfirmOverlay.Visible = false
ConfirmOverlay.ZIndex = 500
ConfirmOverlay.Parent = MainFrame

local ConfirmBox = Instance.new("Frame")
ConfirmBox.Size = UDim2.new(0, 280, 0, 130)
ConfirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmBox.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
ConfirmBox.ZIndex = 501
ConfirmBox.Parent = ConfirmOverlay

local ConfirmBoxCorner = Instance.new("UICorner", ConfirmBox)
ConfirmBoxCorner.CornerRadius = UDim.new(0, 8)

local ConfirmBoxStroke = Instance.new("UIStroke", ConfirmBox)
ConfirmBoxStroke.Color = Color3.fromRGB(50, 50, 70)
ConfirmBoxStroke.Thickness = 1.5

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size = UDim2.new(1, -20, 0, 50)
ConfirmText.Position = UDim2.new(0, 10, 0, 15)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Are you sure you want to close this hub?"
ConfirmText.TextColor3 = Color3.fromRGB(240, 240, 255)
ConfirmText.TextSize = 12
ConfirmText.Font = Enum.Font.GothamSemibold
ConfirmText.TextWrapped = true
ConfirmText.ZIndex = 502
ConfirmText.Parent = ConfirmBox

local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0, 120, 0, 32)
CancelBtn.Position = UDim2.new(0, 15, 1, -45)
CancelBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
CancelBtn.Text = "Cancel"
CancelBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CancelBtn.TextSize = 11
CancelBtn.Font = Enum.Font.GothamBold
CancelBtn.ZIndex = 502
CancelBtn.Parent = ConfirmBox

local CancelCorner = Instance.new("UICorner", CancelBtn)
CancelCorner.CornerRadius = UDim.new(0, 6)

local CloseWindowBtn = Instance.new("TextButton")
CloseWindowBtn.Size = UDim2.new(0, 120, 0, 32)
CloseWindowBtn.Position = UDim2.new(1, -135, 1, -45)
CloseWindowBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseWindowBtn.Text = "Close Window"
CloseWindowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseWindowBtn.TextSize = 11
CloseWindowBtn.Font = Enum.Font.GothamBold
CloseWindowBtn.ZIndex = 502
CloseWindowBtn.Parent = ConfirmBox

local CloseWindowCorner = Instance.new("UICorner", CloseWindowBtn)
CloseWindowCorner.CornerRadius = UDim.new(0, 6)

local isOpen = true
local function ToggleWindow()
    PlayClick()
    isOpen = not isOpen
    ConfirmOverlay.Visible = false
    if isOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.BackgroundTransparency = 1
        
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 480, 0, 320),
            Position = UDim2.new(0.5, -240, 0.5, -160),
            BackgroundTransparency = 0
        }):Play()
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Wait()
        if not isOpen then MainFrame.Visible = false end
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleWindow)
CloseXBtn.MouseButton1Click:Connect(function() PlayClick() ConfirmOverlay.Visible = true end)
CancelBtn.MouseButton1Click:Connect(function() PlayClick() ConfirmOverlay.Visible = false end)
CloseWindowBtn.MouseButton1Click:Connect(function() PlayClick() ScreenGui:Destroy() end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightShift then
            ToggleWindow()
            if isOpen then
                ShowNotification("LATINA HUB: Opened")
            else
                ShowNotification("LATINA HUB: Minimized")
            end
        end
    end
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 125, 1, -48)
Sidebar.Position = UDim2.new(0, 6, 0, 42)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 300)
Sidebar.ScrollBarThickness = 2
Sidebar.ZIndex = 102
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 5)

local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -142, 1, -48)
PagesContainer.Position = UDim2.new(0, 136, 0, 42)
PagesContainer.BackgroundTransparency = 1
PagesContainer.ZIndex = 102
PagesContainer.Parent = MainFrame

local activeTabButton = nil
local allTabButtons = {}
local allPages = {}

local function CreateTab(title)
    local tabIndex = #allTabButtons + 1
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = CurrentTheme.TopBar
    TabBtn.Text = "  " .. title
    TabBtn.TextColor3 = CurrentTheme.TextDim
    TabBtn.TextSize = 11
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.ZIndex = 103
    TabBtn.Parent = Sidebar
    
    local TabCorner = Instance.new("UICorner", TabBtn)
    TabCorner.CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollBarThickness = 3
    Page.Visible = false
    Page.ZIndex = 103
    Page.Parent = PagesContainer

    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    table.insert(allTabButtons, {Button = TabBtn, Page = Page})
    table.insert(allPages, Page)

    TabBtn.MouseButton1Click:Connect(function()
        PlayClick()
        for _, p in ipairs(allPages) do p.Visible = false end
        for _, t in ipairs(allTabButtons) do 
            t.Button.BackgroundColor3 = CurrentTheme.TopBar
            t.Button.TextColor3 = CurrentTheme.TextDim
        end
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeTabButton = TabBtn
    end)

    if tabIndex == 1 then
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeTabButton = TabBtn
    end

    return Page
end

local allElementButtons = {}
local function AddButtonToPage(page, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -4, 0, 34)
    Btn.BackgroundColor3 = CurrentTheme.ElementBg
    Btn.Text = "  " .. name
    Btn.TextColor3 = CurrentTheme.TextMain
    Btn.TextSize = 11
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.ZIndex = 104
    Btn.Parent = page

    local Corner = Instance.new("UICorner", Btn)
    Corner.CornerRadius = UDim.new(0, 6)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(45, 45, 60)
    Stroke.Thickness = 1

    table.insert(allElementButtons, {Btn = Btn, Stroke = Stroke})
    Btn.MouseButton1Click:Connect(function()
        PlayClick()
        callback()
    end)
end

local function ApplyTheme(themeName)
    CurrentTheme = Themes[themeName]
    MainFrame.BackgroundColor3 = CurrentTheme.MainBg
    TopBar.BackgroundColor3 = CurrentTheme.TopBar
    CoverFix.BackgroundColor3 = CurrentTheme.TopBar

    for _, t in ipairs(allTabButtons) do
        if t.Button == activeTabButton then
            t.Button.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
            t.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            t.Button.BackgroundColor3 = CurrentTheme.TopBar
            t.Button.TextColor3 = CurrentTheme.TextDim
        end
    end

    for _, el in ipairs(allElementButtons) do
        el.Btn.BackgroundColor3 = CurrentTheme.ElementBg
        el.Btn.TextColor3 = CurrentTheme.TextMain
    end
end

local MainTab = CreateTab("Main")
AddButtonToPage(MainTab, "💡 Feature 1 (Fullbright)", function()
    pcall(function()
        Lighting.Brightness = Lighting.Brightness == 1 and 2 or 1
        Lighting.GlobalShadows = not Lighting.GlobalShadows
    end)
end)
AddButtonToPage(MainTab, "🔄 Rejoin Server", function()
    pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
end)

local ScriptsList = {
    {Name = "ON Hub", Link = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua"},
    {Name = "Horizon", Link = "script_key = https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"}
    {Name = "Nisi Hub", Link = ""},
    {Name = "Lennon", Link = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/refs/heads/main/stealaneggv2"},
    {Name = "Miranda", Link = "https://raw.githubusercontent.com/miirandahub/loader/main/stealaeggs"},
    {Name = "Lkz", Link = ""},
    {Name = "Zeroin", Link = ""},
    {Name = "Decode", Link = ""},
    {Name = "Blyko Hub", Link = ""},
    {Name = "Hoshi Hub", Link = ""}, 
    {Name = "Script 12", Link = ""},
    {Name = "Script 13", Link = ""},
    {Name = "Script 14", Link = ""},
    {Name = "Script 15", Link = ""},
    {Name = "Script 16", Link = ""},
    {Name = "Script 17", Link = ""},
    {Name = "Script 18", Link = ""},
    {Name = "Script 19", Link = ""},
    {Name = "Script 20", Link = ""},
    {Name = "Script 21", Link = ""},
    {Name = "Script 22", Link = ""},
    {Name = "Script 23", Link = ""},
    {Name = "Script 24", Link = ""},
    {Name = "Script 25", Link = ""}
}

local EggTab = CreateTab("Steal an Egg")
for _, scriptData in ipairs(ScriptsList) do
    AddButtonToPage(EggTab, "🥚 " .. scriptData.Name, function()
        pcall(function()
            if scriptData.Link ~= "" then
                loadstring(game:HttpGet(scriptData.Link))()
            else
                ShowNotification("No link set for " .. scriptData.Name)
            end
        end)
    end)
end

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
end)
AddButtonToPage(FpsTab, "🌫️ Remove Fog & Shadows", function()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
    end)
end)

local ThemeTab = CreateTab("Themes")
AddButtonToPage(ThemeTab, "🎨 Dark Purple (Default)", function() ApplyTheme("Dark Purple") end)
AddButtonToPage(ThemeTab, "🎨 Midnight Blue", function() ApplyTheme("Midnight Blue") end)
AddButtonToPage(ThemeTab, "🎨 Crimson Red", function() ApplyTheme("Crimson Red") end)
AddButtonToPage(ThemeTab, "🎨 Emerald Green", function() ApplyTheme("Emerald Green") end)
AddButtonToPage(ThemeTab, "🎨 Sunset Orange", function() ApplyTheme("Sunset Orange") end)
AddButtonToPage(ThemeTab, "🎨 Neon Cyberpunk", function() ApplyTheme("Neon Cyberpunk") end)
AddButtonToPage(ThemeTab, "🎨 Rose Pink", function() ApplyTheme("Rose Pink") end)
AddButtonToPage(ThemeTab, "🎨 Toxic Lime", function() ApplyTheme("Toxic Lime") end)
AddButtonToPage(ThemeTab, "🎨 Matrix Code", function() ApplyTheme("Matrix Code") end)
AddButtonToPage(ThemeTab, "🎨 Golden Luxury", function() ApplyTheme("Golden Luxury") end)

local SettingsTab = CreateTab("Settings")
AddButtonToPage(SettingsTab, "⚙️ Toggle Keybind Info", function()
    ShowNotification("Press Right Shift to Hide/Show Hub")
end)

local DiscordTab = CreateTab("Discord")
AddButtonToPage(DiscordTab, "📋 Copy Discord Invite", function()
    pcall(function()
        if setclipboard then setclipboard("https://discord.gg/yourinvite") end
    end)
end)

local OwnerTab = CreateTab("Owner")
AddButtonToPage(OwnerTab, "👑 Owner: ANONYMOUS", function() end)

PlayIntro(function()
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
end)
