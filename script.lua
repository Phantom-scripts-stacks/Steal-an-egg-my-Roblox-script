repeat 
    local success = pcall(function()
        return game:IsLoaded()
    end)
    if success and game:IsLoaded() then 
        break 
    end
    task.wait(0.5)
until false

task.wait(1)

local P = game:GetService("Players")
local LP = P.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local TS = game:GetService("TweenService")
local TPS = game:GetService("TeleportService")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local HS = game:GetService("HttpService")
local LT = game:GetService("Lighting")
local ST = game:GetService("Stats")
local MPS = game:GetService("MarketplaceService")

for _, n in ipairs({"LatinaHubV6", "LatinaTopLabel"}) do 
    if PG:FindFirstChild(n) then PG[n]:Destroy() end 
end
if LT:FindFirstChild("LatinaBlur") then LT.LatinaBlur:Destroy() end

local CF = "latina_hub_config.json"
local function svC(t) pcall(function() if writefile then writefile(CF, HS:JSONEncode(t)) end end) end
local function ldC()
    local ok, d = pcall(function() if readfile and isfile and isfile(CF) then return HS:JSONDecode(readfile(CF)) end end)
    return (ok and d) or {}
end

local Config = ldC()
Config.Theme = Config.Theme or "Default"
Config.Toggles = Config.Toggles or {}

local ACC = Color3.fromRGB(130,140,255)
local ACG = Color3.fromRGB(110,220,150)
local ACR = Color3.fromRGB(255,95,110)
local ACY = Color3.fromRGB(255,200,100)

local Themes = {
    Default = {MainBg=Color3.fromRGB(18,18,26), MainBg2=Color3.fromRGB(24,24,34), TopBar=Color3.fromRGB(28,28,40), Element=Color3.fromRGB(30,30,44), ElementHover=Color3.fromRGB(42,42,60), Border=Color3.fromRGB(48,48,68), Accent=Color3.fromRGB(130,140,255), Text=Color3.fromRGB(235,235,250), TextDim=Color3.fromRGB(150,150,175)},
    Cyberpunk = {MainBg=Color3.fromRGB(14,10,22), MainBg2=Color3.fromRGB(22,14,34), TopBar=Color3.fromRGB(26,16,40), Element=Color3.fromRGB(32,20,48), ElementHover=Color3.fromRGB(44,28,64), Border=Color3.fromRGB(60,36,84), Accent=Color3.fromRGB(255,90,200), Text=Color3.fromRGB(240,230,255), TextDim=Color3.fromRGB(180,150,210)},
    Emerald = {MainBg=Color3.fromRGB(12,20,18), MainBg2=Color3.fromRGB(18,28,24), TopBar=Color3.fromRGB(20,32,28), Element=Color3.fromRGB(26,42,36), ElementHover=Color3.fromRGB(36,56,48), Border=Color3.fromRGB(48,76,64), Accent=Color3.fromRGB(90,220,160), Text=Color3.fromRGB(230,250,240), TextDim=Color3.fromRGB(150,200,175)},
    Ruby = {MainBg=Color3.fromRGB(24,14,16), MainBg2=Color3.fromRGB(32,18,22), TopBar=Color3.fromRGB(38,22,26), Element=Color3.fromRGB(48,28,34), ElementHover=Color3.fromRGB(64,38,46), Border=Color3.fromRGB(84,50,60), Accent=Color3.fromRGB(255,100,120), Text=Color3.fromRGB(250,230,235), TextDim=Color3.fromRGB(200,160,170)},
    Midnight = {MainBg=Color3.fromRGB(10,14,22), MainBg2=Color3.fromRGB(16,20,30), TopBar=Color3.fromRGB(20,26,40), Element=Color3.fromRGB(24,32,48), ElementHover=Color3.fromRGB(34,44,64), Border=Color3.fromRGB(48,62,88), Accent=Color3.fromRGB(120,170,255), Text=Color3.fromRGB(230,240,255), TextDim=Color3.fromRGB(150,170,200)},
    Sunset = {MainBg=Color3.fromRGB(24,18,16), MainBg2=Color3.fromRGB(32,24,20), TopBar=Color3.fromRGB(40,30,26), Element=Color3.fromRGB(50,38,32), ElementHover=Color3.fromRGB(66,50,42), Border=Color3.fromRGB(88,66,56), Accent=Color3.fromRGB(255,160,90), Text=Color3.fromRGB(250,235,225), TextDim=Color3.fromRGB(200,175,160)},
    Mono = {MainBg=Color3.fromRGB(16,16,16), MainBg2=Color3.fromRGB(22,22,22), TopBar=Color3.fromRGB(28,28,28), Element=Color3.fromRGB(34,34,34), ElementHover=Color3.fromRGB(46,46,46), Border=Color3.fromRGB(60,60,60), Accent=Color3.fromRGB(220,220,220), Text=Color3.fromRGB(240,240,240), TextDim=Color3.fromRGB(150,150,150)}
}

local SG = Instance.new("ScreenGui")
SG.Name = "LatinaHubV6"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true
SG.Parent = PG

local BL = Instance.new("BlurEffect", LT)
BL.Name = "LatinaBlur"
BL.Size = 0

local CS = Instance.new("Sound", SG) CS.SoundId = "rbxassetid://906107293" CS.Volume = 0.4
local ES = Instance.new("Sound", SG) ES.SoundId = "rbxassetid://6026984224" ES.Volume = 0.5
local SS = Instance.new("Sound", SG) SS.SoundId = "rbxassetid://6536419944" SS.Volume = 0.4
local IS = Instance.new("Sound", SG) IS.SoundId = "rbxassetid://130788815" IS.Volume = 0.6

local function pC() pcall(function() CS:Play() end) end
local function pE() pcall(function() ES:Play() end) end
local function pS() pcall(function() SS:Play() end) end
local function cor(p, r) local c = Instance.new("UICorner", p) c.CornerRadius = UDim.new(0, r or 8) return c end
local function str(p, c, t, tr) local s = Instance.new("UIStroke", p) s.Color = c or Color3.fromRGB(70,70,90) s.Thickness = t or 1 s.Transparency = tr or 0.5 s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border return s end
local function gr(p, c1, c2, r) local g = Instance.new("UIGradient", p) g.Rotation = r or 90 g.Color = ColorSequence.new(c1, c2) return g end
local NQ, NB = {}, false
local NH = {}
local function showN(t, k)
    table.insert(NH, {text=t, kind=k or "info", time=os.time()})
    if #NH > 50 then table.remove(NH, 1) end
    table.insert(NQ, {text=t, kind=k or "info"})
    if NB then return end
    NB = true
    task.spawn(function()
        while #NQ > 0 do
            local e = table.remove(NQ, 1)
            pcall(function()
                local bc = ACC
                if e.kind == "success" then bc = ACG elseif e.kind == "error" then bc = ACR end
                local F = Instance.new("Frame", SG)
                F.Size = UDim2.new(0, 280, 0, 44)
                F.Position = UDim2.new(0.5, -140, 1, 20)
                F.BackgroundColor3 = Themes[Config.Theme].TopBar
                F.BackgroundTransparency = 0.35
                F.ZIndex = 99999
                cor(F, 10)
                str(F, Themes[Config.Theme].Border, 1, 0.7)
                gr(F, Themes[Config.Theme].TopBar, Themes[Config.Theme].MainBg)
                local b = Instance.new("Frame", F)
                b.Size = UDim2.new(0, 3, 1, -14)
                b.Position = UDim2.new(0, 8, 0, 7)
                b.BackgroundColor3 = bc
                b.BackgroundTransparency = 0.3
                b.BorderSizePixel = 0
                b.ZIndex = 100001
                cor(b, 2)
                local T = Instance.new("TextLabel", F)
                T.Size = UDim2.new(1, -28, 1, 0)
                T.Position = UDim2.new(0, 20, 0, 0)
                T.BackgroundTransparency = 1
                T.Text = e.text
                T.TextColor3 = Themes[Config.Theme].Text
                T.TextTransparency = 0.1
                T.TextSize = 11
                T.Font = Enum.Font.GothamMedium
                T.TextWrapped = true
                T.TextXAlignment = Enum.TextXAlignment.Left
                T.ZIndex = 100000
                TS:Create(F, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position=UDim2.new(0.5, -140, 1, -60)}):Play()
                task.wait(2.4)
                local out = TS:Create(F, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position=UDim2.new(0.5, -140, 1, 20), BackgroundTransparency=1})
                TS:Create(T, TweenInfo.new(0.3), {TextTransparency=1}):Play()
                out:Play() out.Completed:Wait()
                F:Destroy()
            end)
            task.wait(0.12)
        end
        NB = false
    end)
end

local TB = Instance.new("ImageButton", SG)
TB.Name = "FloatingToggle"
TB.Size = UDim2.new(0, 52, 0, 52)
TB.Position = UDim2.new(0, 18, 1, -100)
TB.AnchorPoint = Vector2.new(0, 1)
TB.BackgroundColor3 = Themes[Config.Theme].TopBar
TB.Image = "rbxassetid://100104680190424"
TB.AutoButtonColor = false
TB.Active = true
TB.Draggable = true
TB.ZIndex = 99999
cor(TB, 999)
local TBS = str(TB, ACC, 2, 0)

local MF = Instance.new("Frame", SG)
MF.Name = "MainWindow"
MF.Size = UDim2.new(0, 380, 0, 310)
MF.Position = UDim2.new(0.5, -190, 0, 80)
MF.BackgroundColor3 = Themes[Config.Theme].MainBg
MF.Active = true
MF.Visible = true
MF.ZIndex = 100
cor(MF, 14)

showN("LATINA HUB V1 — Loaded Successfully", "success")
